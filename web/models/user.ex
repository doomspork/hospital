defmodule Hospital.User do
  use Hospital.Web, :model
  import Ecto.Query

  alias Hospital.Repo

  schema "users" do
    field :name, :string
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps
  end

  before_insert :maybe_update_password
  before_update :maybe_update_password

  def from_email(nil), do: nil
  def from_email(email) do
    query = from u in __MODULE__, where: u.email == ^email
    Repo.one(query)
  end

  def create_changeset(model), do: model |> cast(%{}, ~w(), ~w(name email password password_confirmation))
  def create_changeset(model, params) do
    model
    |> cast(params, ~w(name email password password_confirmation))
    |> validate_password_confirmation
    |> validate_length(:password, min: 8)
    |> unique_constraint(:email)
  end

  def update_changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(), ~w(name password password_confirmation))
  end

  def login_changeset(model), do: model |> cast(%{}, ~w(), ~w(email password))

  def login_changeset(model, params) do
    model
    |> cast(params, ~w(email password), ~w())
    |> validate_password
  end

  def valid_password?(nil, _), do: false
  def valid_password?(_, nil), do: false
  def valid_password?(password, crypted), do: Comeonin.Bcrypt.checkpw(password, crypted)

  defp maybe_update_password(changeset) do
    case Ecto.Changeset.fetch_change(changeset, :password) do
      { :ok, password } ->
        changeset
        |> Ecto.Changeset.put_change(:encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
      :error -> changeset
    end
  end

  defp validate_password(changeset) do
    case Ecto.Changeset.get_field(changeset, :encrypted_password) do
      nil -> password_incorrect_error(changeset)
      crypted -> validate_password(changeset, crypted)
    end
  end

  defp validate_password(changeset, crypted) do
    password = Ecto.Changeset.get_change(changeset, :password)
    if valid_password?(password, crypted), do: changeset, else: password_incorrect_error(changeset)
  end

  defp validate_password_confirmation(changeset) do
    case Ecto.Changeset.get_change(changeset, :password_confirmation) do
      nil -> password_mismatch_error(changeset)
      confirmation ->
        password = Ecto.Changeset.get_field(changeset, :password)
        if confirmation == password, do: changeset, else: password_incorrect_error(changeset)
    end
  end

  defp password_incorrect_error(changeset), do: Ecto.Changeset.add_error(changeset, :password, "is incorrect")
  defp password_mismatch_error(changeset), do: Ecto.Changeset.add_error(changeset, :password_confirmation, "does not match password")
end

defmodule Hospital.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias Hospital.Medic
  alias Hospital.Repo
  alias Hospital.User

  def for_token(medic = %Medic{}), do: { :ok, "Medic:#{medic.id}" }
  def for_token(user = %User{}), do: { :ok, "User:#{user.id}" }
  def for_token(_), do: { :error, "Unknown resource type" }

  def from_token("Medic:" <> id), do: { :ok, Repo.get(Medic, String.to_integer(id)) }
  def from_token("User:" <> id), do: { :ok, Repo.get(User, String.to_integer(id)) }
  def from_token(_), do: { :error, "Unknown resource type" }
end

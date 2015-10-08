# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Hospital.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Hospital.Repo
alias Hospital.User
alias Hospital.HealthCheck
alias Hospital.Medic

email = "user@example.com"
password = "p@ssword"

user = %User{}
       |> User.create_changeset(%{email: email, name: "User", password: password, password_confirmation: password})
       |> Repo.insert!

%HealthCheck{name: "Example One", target: "127.0.0.1", type: "ping", user_id: user.id} |> Repo.insert!
%HealthCheck{name: "Another Example", target: "http://example.com", type: "get", user_id: user.id} |> Repo.insert!

medic = %Medic{}
        |> Medic.create_changeset(%{name: "Initial Medic"})
        |> Repo.insert!

{:ok, jwt} = %{"sub" => "Medic:#{medic.id}", "aud" => "aud"}
              |> Guardian.Claims.app_claims
              |> Guardian.Claims.permissions(%{medic: [:write, :read]})
              |> Joken.encode

display_msg = fn (title, value) -> IO.puts IO.ANSI.format([:yellow, title <> ": ", :reset, value <> "\n"]) end

IO.puts IO.ANSI.format([:yellow, "\n----- Seed Accounts -----\n"])
display_msg.("User Credentials", email <> " / " <> password)
display_msg.("Medic Token", jwt)

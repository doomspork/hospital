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

user = %User{}
       |> User.create_changeset(%{email: "user@example.com", name: "User", password: "p@ssword", password_confirmation: "p@ssword"})
       |> Repo.insert!

%HealthCheck{name: "Example One", target: "127.0.0.1", type: "ping", user_id: user.id} |> Repo.insert!
%HealthCheck{name: "Another Example", target: "http://example.com", type: "get", user_id: user.id} |> Repo.insert!

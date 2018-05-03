# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Hibou.Repo.insert!(%Hibou.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Hibou.Model.User
alias Comeonin.Bcrypt
alias Hibou.Repo

Repo.insert!(%User{
  username: "johndoe",
  email: "johnadoe@hibou.io",
  password_hash: Bcrypt.hashpwsalt("password"),
  enabled: true
})

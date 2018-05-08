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
alias Hibou.Model.{User, Client, Authorization}
alias Comeonin.Bcrypt
alias Hibou.Repo

user_1 =
  Repo.insert!(%User{
    username: "johndoe",
    email: "jdoe@hibou.io",
    password_hash: Bcrypt.hashpwsalt("password"),
    enabled: true
  })

client_1 =
  Repo.insert!(%Client{
    name: "dev_client",
    secret: "secret",
    redirect_uri: "http://localhost"
  })

Repo.insert!(%Authorization{
  client_id: client_1.id,
  user_id: user_1.id,
  code: "testcode"
})

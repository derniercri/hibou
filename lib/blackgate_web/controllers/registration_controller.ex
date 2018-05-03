defmodule BlackgateWeb.RegistrationController do
  use BlackgateWeb, :controller
  alias Blackgate.Model.User

  def new(conn, _params) do
    render(conn, "new.html", changeset: User.changeset(%User{}, %{}))
  end
end

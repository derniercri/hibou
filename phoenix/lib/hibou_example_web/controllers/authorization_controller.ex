defmodule HibouExampleWeb.AuthorizationController do
  use HibouExampleWeb, :controller
  alias Hibou.Model.User
  alias Hibou.Model.Authorization
  alias Hibou.Storage
  alias HibouExample.Repo

  import HibouExample.Guardian.Plug

  def new(
        conn,
        %{"client_id" => client_id, "response_type" => "code", "redirect_uri" => redirect_uri} =
          params
      ) do
    # TODO: validate redirect uri

    case current_resource(conn) do
      nil ->
        conn
        |> Plug.Conn.put_session(:redirect_url, "#{conn.request_path}?#{conn.query_string}")
        |> redirect(to: "/login")

      _user ->
        case Storage.get_client_by_id(client_id) do
          nil ->
            ""

          client ->
            state = params["state"]

            conn =
              conn
              |> Plug.Conn.put_session(:client_id, client.id)
              |> Plug.Conn.put_session(:redirect_uri, redirect_uri)
              |> Plug.Conn.put_session(:state, state)

            render(conn, "new.html", client: client, changeset: User.changeset(%User{}, %{}))
        end
    end
  end

  def create(conn, _params) do
    case HibouExample.Guardian.Plug.current_resource(conn) do
      user ->
        client_id = conn |> get_session(:client_id)
        redirect_uri = conn |> get_session(:redirect_uri)
        state = conn |> get_session(:state)
        code = Misc.Random.string(12)

        changeset =
          Authorization.changeset(%Authorization{}, %{
            "user_id" => user.id,
            "client_id" => client_id,
            "code" => code
          })

        case Repo.insert(changeset) do
          {:ok, _changeset} ->
            redirect_uri = "#{redirect_uri}?code=#{code}&state=#{state}"
            redirect(conn, external: redirect_uri)
        end
    end
  end
end

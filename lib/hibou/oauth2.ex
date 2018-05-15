defmodule Hibou.OAuth2 do
  alias Hibou.Model.User
  alias Hibou.Storage

  @invalid_credentials %{"message" => "invalid credentials"}
  @invalid_request %{"message" => "invalid credentials"}

  def authorize(params) do
    case params["grant_type"] do
      "authorization_code" ->
        case Storage.get_authorization_by_code(params["code"]) do
          nil ->
            {:error, @invalid_request}

          auth ->
            {:ok, access_token, _claims} = Hibou.Guardian.encode_and_sign(auth.user, %{})
            {:ok, refresh_token, _claims} = Hibou.Guardian.encode_and_sign(auth.user, %{})

            {:ok,
             %{
               "access_token" => access_token,
               "refresh_token" => refresh_token,
               "expires_in" => 3600
             }}
        end

      "password" ->
        case Storage.get_user_by_username(params["username"]) do
          nil ->
            {:error, @invalid_credentials}

          user ->
            User.check_password(params["password"], user.password_hash)

            {:ok, access_token, _claims} = Hibou.Guardian.encode_and_sign(user, %{})
            {:ok, refresh_token, _claims} = Hibou.Guardian.encode_and_sign(user, %{})

            {:ok,
             %{
               "access_token" => access_token,
               "refresh_token" => refresh_token,
               "expires_in" => 3600
             }}
        end
    end
  end
end

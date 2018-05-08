defmodule HibouWeb.TokenController do
  use HibouWeb, :controller

  def create(_conn, %{"grant_type" => grant_type} = _params) do
    case grant_type do
      "authorization_code" ->
        nil
    end
  end
end

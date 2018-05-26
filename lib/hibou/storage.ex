defmodule Hibou.Storage do
  @callback get_user_by_id!(String.t()) :: {:ok, term} | {:error, String.t()}
  @callback get_user_by_username(String.t()) :: {:ok, term} | {:error, String.t()}
  @callback get_client_by_id(String.t()) :: {:ok, term} | {:error, String.t()}
  @callback get_authorization_by_code(String.t()) :: {:ok, term} | {:error, String.t()}
end

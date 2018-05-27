defmodule Hibou.Config do
  @moduledoc """
  Hibou lib config module
  """

  @spec repo() :: Ecto.Repo
  def repo, do: Application.get_env(:hibou, :repo)

  @spec guardian() :: Guardian
  def guardian, do: Application.get_env(:hibou, :guardian)

  @spec storage() :: Hibou.Storage
  def storage, do: Application.get_env(:hibou, :storage)

  @spec user_model() :: Hibou.Model.User
  def user_model(), do: Application.get_env(:hibou, :user_model)

  @spec client_model() :: Hibou.Model.Client
  def client_model(), do: Application.get_env(:hibou, :client_model)

  @spec authorization_model() :: Hibou.Model.Authorization
  def authorization_model(), do: Application.get_env(:hibou, :authorization_model)
end

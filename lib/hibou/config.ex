defmodule Hibou.Config do
  @moduledoc """
  Hibou lib config module
  """

  @spec repo() :: Ecto.Repo
  def repo, do: Application.get_env(:hibou, :repo)

  @spec guardian() :: Guardian
  def guardian, do: Application.get_env(:hibou, :guardian)
end

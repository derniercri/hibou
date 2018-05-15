defmodule Hibou.Config do
  @moduledoc """
  Hibou lib config module
  """

  def repo, do: Application.get_env(:hibou, :repo)
end

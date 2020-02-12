defmodule OperationSystemData do
  @moduledoc """
  Get data from OS system
  """

  defmodule Process do
    @enforce_keys [:pid, :user, :cpu, :memory: :time, :command]

    defstruct [:pid, :user, :cpu, :memory, :time, :command]
  end

  @doc """
  Returns a list when each line is a output process from top command
  """
  def process_information do
    "top -bn1 | awk 'NR > 7 {print}'" # Get all process and filter only the lines with the information about then
    |> String.to_charlist
    |> :os.cmd
    |> to_string
    |> String.replace(~r/ +/, " ") # Replace Every 2 whitespaces or more for 1 whitespace
    |> String.split("\n")
  end

  @doc """
  Get the list of processes in your brute stage and transform to structs
  """
  def parse_information(processes) do

  end
end

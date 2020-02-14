defmodule CpuData do
  @moduledoc """
  Get data from CPU use
  """

  defmodule TopLog do
    @enforce_keys [:pid, :user, :cpu, :memory, :time, :command]

    defstruct [:pid, :user, :cpu, :memory, :time, :command]

    @doc """
    Init method
    """
    def create_process(process_str) do
      process_splited = String.split(String.trim(process_str), " ")
      %TopLog{
        pid: Enum.at(process_splited, 0),
        user: Enum.at(process_splited, 1),
        cpu: Enum.at(process_splited, 8),
        memory: Enum.at(process_splited, 9),
        time: Enum.at(process_splited, 10),
        command: Enum.at(process_splited, 11)
      }
    end
  end

  @doc """
  Init the state process
  """
  def start_link(_options \\ %{}) do
    Agent.start_link(fn -> [] end)
  end

  @doc """
  Create a new elixir process for update the state every half second
  """
  def automatic_update_state(agent) do
    spawn(fn -> loop(agent) end)
  end

  @doc """
  Update state every half second
  """
  def loop(agent) do
    Process.sleep(500)
    formated_data()
    |> update_processes(agent)
    loop(agent)
  end

  @doc """
  Update the state of process
  """
  def update_processes(list_processes, agent) do
    Agent.update(agent, fn _actual_state -> list_processes end)
  end

  def get_processes(agent) do
    Agent.get(agent, fn list_state -> list_state end  )
  end

  @doc """
  Returns a list when each line is a output process from top command
  """
  def get_process_data do
    "top -bn1 -d 0.50 | awk 'NR > 7 {print}'" # Get all process and filter only the lines with the information about then
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
    Enum.map(processes, fn process -> TopLog.create_process(process) end)
  end

  def formated_data do
    get_process_data()
    |> parse_information()
  end
end

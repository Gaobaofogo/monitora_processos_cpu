defmodule CpuDataTest do
  use ExUnit.Case, async: true
  import CpuData

  setup do
    {:ok, agent} = CpuData.start_link()
    %{agent: agent}
  end

  defp process_str do
    "6271 user 20 0 9216 3560 3156 R 12,5 0,0 0:00.02 top"
  end

  test "check type of processors" do
    assert is_list(get_process_data())
  end

  test "constructor of Process" do
    my_process = CpuData.TopLog.create_process(process_str())
    assert Map.equal?(
      my_process,
      %CpuData.TopLog{
        pid: "6271",
        user: "user",
        cpu: "12,5",
        memory: "0,0",
        time: "0:00.02",
        command: "top"
      }
    )
  end

  test "parse of list process" do
    processes = [CpuData.TopLog.create_process(process_str())]
    result_func = parse_information([process_str()])
    assert processes == result_func
  end

  test "insert processes on state", %{agent: agent} do
    process = CpuData.TopLog.create_process(process_str())
    IO.puts process
    CpuData.update_processes([process], agent)
    processes_state = CpuData.get_processes(agent)
    assert length(processes_state) == 1
  end
end

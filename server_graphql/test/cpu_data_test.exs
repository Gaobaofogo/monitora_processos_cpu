defmodule CpuDataTest do
  use ExUnit.Case, async: true
  import ServerGraphql.CpuData

  setup do
    {:ok, agent} = ServerGraphql.CpuData.start_link()
    %{agent: agent}
  end

  defp process_str do
    "6271 user 20 0 9216 3560 3156 R 12,5 0,0 0:00.02 top"
  end

  test "check type of processors" do
    assert is_list(get_process_data())
  end

  test "constructor of Process" do
    my_process = ServerGraphql.CpuData.TopLog.create_process(process_str())
    assert Map.equal?(
      my_process,
      %ServerGraphql.CpuData.TopLog{
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
    processes = [ServerGraphql.CpuData.TopLog.create_process(process_str())]
    result_func = parse_information([process_str()])
    assert processes == result_func
  end

  test "insert processes on state" do
    process = ServerGraphql.CpuData.TopLog.create_process(process_str())
    ServerGraphql.CpuData.update_processes([process])
    processes_state = ServerGraphql.CpuData.get_processes()

    assert length(processes_state) == 1
  end
end

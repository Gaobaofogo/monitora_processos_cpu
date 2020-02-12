defmodule OperationSystemDataTest do
  use ExUnit.Case
  import OperationSystemData

  test "check type of processors" do
    assert is_list(process_information()) == true
  end
end

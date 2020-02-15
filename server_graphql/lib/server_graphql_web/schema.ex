defmodule ServerGraphql.Schema do
  use Absinthe.Schema

  import_types ServerGraphql.Schema.DataTypes


  query do
    @desc "List of process"
    field :top_logs, list_of(:top_log) do
      resolve fn _parent, _args, _resolution ->
        {:ok, ServerGraphql.CpuData.get_processes()}
      end
    end
  end
end

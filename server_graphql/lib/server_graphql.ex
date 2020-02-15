defmodule ServerGraphql do
  @moduledoc """
  ServerGraphql keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(ServerGraphql.CpuData, [%{}])
    ]

    opts = [strategy: :one_for_one, name: ServerGraphql.Supervisor]
    IO.puts "Estou sendo invocadp?"
    Supervisor.start_link(children, opts)
  end
end

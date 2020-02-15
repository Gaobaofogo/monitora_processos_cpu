defmodule ServerGraphql.Schema.DataTypes do
  use Absinthe.Schema.Notation

  object :top_log do
    field :pid, :string
    field :user, :string
    field :cpu, :string
    field :memory, :string
    field :time, :string
    field :command, :string
  end
end

defmodule PriorityReceive do
  @moduledoc """
  In Erlang/Elixir we can use selective receives to receive higher priority messages first,
  but it is not possible to receive messages with different priority levels with a single
  call to `receive`. Actually to select a message, erlang matches that message against all
  clauses before going to the next message. Therefore selecting messages with different
  priorities, needs nested receives. And to avoid deadlocks you have to put all higher
  priority match clauses in nested lower priority receives.

  This module provides `priority_receive/1` macro which has the same syntax as `receive/1`
  with the ability to select higher priority messages first, based on given clauses order.
  So you can receive messages with different priorities with a single call to `priority_receive/1`.
  Note that to select a message, all messages in the queue will be scanned and matched against
  each clause before going to the next clause.
  """

  defmacro priority_receive(args) do
    receive_block =
      quote do
        receive unquote(args)
      end

    nested_receive(receive_block, Enum.reverse(args[:do]))
  end

  defp nested_receive(receive_block, [_]), do: receive_block

  defp nested_receive(receive_block, [_ | clauses]) do
    quote do
      receive do
        unquote(Enum.reverse(clauses))
      after
        0 -> unquote(receive_block)
      end
    end
    |> nested_receive(clauses)
  end
end

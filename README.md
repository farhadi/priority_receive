# PriorityReceive

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

## Installation

The package can be installed by adding `priority_receive` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:priority_receive, "~> 0.1.0"}
  ]
end
```

Example usage:

```elixir
import PriorityReceive

priority_receive do
  {:high, msg} -> process_msg(msg)
  {:normal, msg} -> process_msg(msg)
  {:low, msg} -> process_msg(msg)
after
  1000 -> :timeout
end
```
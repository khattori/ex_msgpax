# ExMsgpax

ExMsgpax provides extensions for Msgpax to support tuple, naive datetime, etc.

## Extention Types

ExMsgpax uses the Extention Types of MessagePack for data types which aare not supported by Msgpax.

| Type | Code | Remarks |
| ---- | ---- | ------- |
| Atom | 0 | Atom types are converted to atom types, not strings. |
| NaiveDateTime | 1 | |
| Date | 2 | |
| Time | 3 | |
| Tuple | 4 | |
| Structs | 5 | |
| Exceptions | 6 | |

## Examples

```
iex> ExMsgpax.pack {1, 2, 3}
{:ok, <<214, 4, 147, 1, 2, 3>>}

iex> ExMsgpax.unpack <<214, 4, 147, 1, 2, 3>>
{:ok, {1, 2, 3}}
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_msgpax` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_msgpax, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_msgpax](https://hexdocs.pm/ex_msgpax).


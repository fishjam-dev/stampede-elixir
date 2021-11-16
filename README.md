# Stampede

Tool for configuring and running Playwright based load testing

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `stampede` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:stampede, "~> 0.1.0"}
  ]
end
```

## Setup

```
mix deps.get

# In the assets/ folder
npm i
```

## Examples

`mix run examples/run_a_single_user.exs`

or

`mix run examples/run_multiple_users.exs`

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/stampede](https://hexdocs.pm/stampede).

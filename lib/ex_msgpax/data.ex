defmodule ExMsgpax.Data do
  @moduledoc ~S"""
  Defines a message packed data.

  ## Examples

      iex> new(nil)
      #ExMsgpax.Data<size:1>

      iex> new(1) |> size()
      1

      iex> new(999) |> extract()
      999

  """
  defstruct content: ""

  alias ExMsgpax.Data

  @type t :: %__MODULE__{content: binary}

  @spec new(term) :: t
  def new(data) do
    %Data{content: ExMsgpax.pack!(data)}
  end

  @spec extract(t) :: term
  def extract(%Data{} = data) do
    ExMsgpax.unpack!(data.content)
  end

  @spec size(t) :: integer
  def size(%Data{content: content}), do: byte_size(content)

  defimpl Msgpax.Packer do
    def pack(%ExMsgpax.Data{content: content}), do: content
  end

  defimpl Inspect do
    import Inspect.Algebra

    def inspect(%{content: content}, opts) do
      size = byte_size(content)
      concat(["#ExMsgpax.Data<size:", to_doc(size, opts), ">"])
    end
  end
end

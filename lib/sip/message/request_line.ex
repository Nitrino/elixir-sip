defmodule Sip.Message.RequestLine do
  alias Sip.Message.URI

  @type t :: %__MODULE__{
          method: binary(),
          request_uri: URI.t(),
          version: tuple()
        }
  defstruct [:method, :request_uri, :version]
end

defmodule Sip.Message.URI do
  @type t :: %__MODULE__{
          authority: binary(),
          host: binary(),
          scheme: binary(),
          userinfo: binary()
        }

  defstruct [:authority, :host, :scheme, :userinfo]
end

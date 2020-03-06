defmodule Sip.Message do
  alias Sip.NimbleParser
  alias Sip.Message.{RequestLine, URI}
  alias Sip.Helpers

  def parse_by_nimble(message) do
    {:ok,
     [
       [method],
       [scheme, userinfo, _, host_1, host_2, host_3],
       [_, _, major_version, _, minor_version]
     ], _, _, _, _} = NimbleParser.parse(message)

    host = host_1 <> host_2 <> host_3

    %RequestLine{
      method: method,
      version: {major_version, minor_version},
      request_uri: %URI{
        authority: userinfo <> "@" <> host,
        host: host,
        scheme: scheme,
        userinfo: userinfo
      }
    }
  end

  def parse_by_nif(message) do
    Sip.Parser.parse(message)
  end
end

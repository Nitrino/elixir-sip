defmodule Sip.NimbleParser do
  import NimbleParsec

  # def parse(_message) do
  #   message = """
  #   BYE sip:bob@quickblox.com;transport=ws SIP/2.0\r
  #   Via: SIP/2.0/WSS quickblox.com;branch=ddddddd\r
  #   To: <sip:bob@quickblox.com>;tag=bbbbbbb\r
  #   From: <sip:alice@quickblox.com>;tag=bbbbbbb\r
  #   CSeq: 1 BYE\r
  #   Call-ID: 11111122222\r
  #   Max-Forwards: 70\r
  #   Content-Length: 0\r\n\r
  #   """
  # end

  alpha = utf8_string([?a..?z, ?A..?Z], min: 1)
  digit = utf8_string([?0..?9], min: 1)
  hexdig = concat(digit, utf8_string([?A, ?B, ?C, ?D, ?E, ?F], min: 0))
  alphanum = choice([alpha, digit])
  method = choice([string("INVITE"), string("ACK"), string("BYE")]) |> wrap()
  escaped = concat(string("%"), hexdig)

  sip_version =
    string("SIP")
    |> string("/")
    |> concat(digit)
    |> string(".")
    |> concat(digit)
    |> wrap()

  mark =
    choice([
      string("-"),
      string("_"),
      string("."),
      string("!"),
      string("~"),
      string("*"),
      string("'"),
      string("("),
      string(")")
    ])

  reserved =
    choice([
      string(";"),
      string("/"),
      string("?"),
      string(":"),
      string("@"),
      string("&"),
      string("="),
      string("+"),
      string("$"),
      string(",")
    ])

  unreserved = choice([alphanum, mark])

  scheme =
    alpha
    |> repeat(choice([alpha, digit, string("+"), string("-"), string(".")]))

  uric = choice([reserved, unreserved, escaped])

  uric_no_slash =
    choice([
      unreserved,
      escaped,
      string(";"),
      string("?"),
      string(":"),
      string("@"),
      string("&"),
      string("="),
      string("+"),
      string("$"),
      string(",")
    ])

  opaque_part =
    uric_no_slash
    |> repeat(choice([reserved, unreserved, escaped]))

  request_uri =
    scheme
    |> ignore(string(":"))
    |> concat(opaque_part)
    |> wrap()

  request_line =
    method
    |> ignore(string(" "))
    |> concat(request_uri)
    |> ignore(string(" "))
    |> concat(sip_version)
    |> ignore(string("\r\n"))

  defparsec(:parse, request_line, debug: true)
end

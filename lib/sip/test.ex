defmodule Sip.Test do
  alias Sip.Parser

  def parse do
    message = """
    BYE sip:bob@quickblox.com;transport=ws SIP/2.0\r
    Via: SIP/2.0/WSS quickblox.com;branch=ddddddd\r
    To: <sip:bob@quickblox.com>;tag=bbbbbbb\r
    From: <sip:alice@quickblox.com>;tag=bbbbbbb\r
    CSeq: 1 BYE\r
    Call-ID: 11111122222\r
    Max-Forwards: 70\r
    Content-Length: 0\r\n\r
    """

    Parser.parse(message)
  end
end

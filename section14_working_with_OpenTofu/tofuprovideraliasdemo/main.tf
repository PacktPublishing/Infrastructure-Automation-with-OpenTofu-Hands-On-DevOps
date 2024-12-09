resource "aws_eip" "thinknyxeipone" {
}

resource "aws_eip" "thinknyxeiptwo" {
  provider = aws.euwest
}
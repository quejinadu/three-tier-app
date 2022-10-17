data "aws_vpc" "cint" {
  filter {
    name   = "tag:Name"
    values = ["lucid-code-test"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["lucid-code-test-private-0", "lucid-code-test-private-1"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["lucid-code-test-public-0", "lucid-code-test-public-1"]
  }
}
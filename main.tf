data "aws_vpc" "develop" {
  default = true
}

data "aws_availability_zones" "av_zone" {
}

resource "aws_default_subnet" "develop" {
  availability_zone = data.aws_availability_zones.av_zone.names[0]

  tags = {
    Name = "Develop"
  }
}

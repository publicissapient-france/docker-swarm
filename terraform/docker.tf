# Configure the AWS Provider
# debian base ami : ami-1d61a76a
# sim-service ami : ami-24f84b53

variable "access_key" {}
variable "secret_key" {}
variable "docker_count" {
  default = "2"
}
variable "groups" {
  default = {
    "0" =  "adrastea"
    "1" = "io"

  }
}

provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "eu-west-1"
}

resource "aws_security_group" "docker-initiation-sg" {
    name = "docker-initiation-sg"
    description = "Allow all inbound traffic"

    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "docker" {
    count = "${var.docker_count}"
    key_name = "docker-initiation"
    ami = "ami-f0b11187"
    instance_type = "t2.micro"
    tags {
        Name = "docker-initiation#${count.index}"
        Group = "docker-initiation"
    }
    subnet_id = "${aws_subnet.docker-initiation-net.id}"
}

resource "aws_subnet" "docker-initiation-net" {
  vpc_id = "vpc-6648a303"
  cidr_block = "172.30.9.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1b"
  tags {
          Name = "docker-initiation subnet"
          Group = "docker-initiation"
      }
}

# DNS

resource "aws_route53_record" "docker-record" {
    name = "${concat("docker", count.index, ".aws.xebiatechevent.info")}"
    count = "${var.docker_count}"
    zone_id = "Z28O5PDK1WPCSR"
    type = "A"
    records = ["${element(aws_instance.docker.*.public_ip, count.index)}"]
    ttl = "1"
}

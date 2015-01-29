#
# Export the following env variables:
#   export AWS_ACCESS_KEY=change-me
#   export AWS_SECRET_KEY=change-me
#   export AWS_REGION=eu-west-1
#
variable "docker_count" {
  default = "4"
}
variable "groups" {
  default = {
    "0" =  "io"
    "1" = "europa"
    "2" = "ganymede"
    "3" = "callisto"
    "4" = "amalthea"
    "5" = "himalia"
    "6" = "elara"
    "7" = "pasiphae"
    "8" = "sinope"
    "9" = "lysithea"
    "10" = "carme"
    "11" = "ananke"
    "12" = "leda"
    "13" = "thebe"
    "14" = "adrastea"
    "15" = "metis"
    "16" = "callirrhoe"
    "17" = "themisto"
    "18" = "megaclite"
    "19" = "taygete"
    "20" = "chaldene"
    "21" = "harpalyke"
    "22" = "kalyke"
    "23" = "iocaste"
    "24" = "erinome"
    "25" = "isonoe"
    "26" = "praxidike"
    "27" = "autonoe"
    "28" = "thyone"
    "29" = "hermippe"
  }
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

resource "aws_route53_record" "docker-record" {
    name = "${concat("docker-",lookup(var.groups,count.index), ".aws.xebiatechevent.info")}"
    count = "${var.docker_count}"
    zone_id = "Z28O5PDK1WPCSR"
    type = "A"
    records = ["${element(aws_instance.docker.*.public_ip, count.index)}"]
    ttl = "1"
}

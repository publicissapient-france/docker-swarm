# Creating VPC
resource "aws_vpc" "platform_vpc" {
    cidr_block = "${var.aws_vpc_net_block}"
    instance_tenancy = "default"

    tags {
        Name = "vpc_${var.aws_platform_name}"
    }
}

# Installing internet access
resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.platform_vpc.id}"

    tags {
      Name = "igw_${var.aws_platform_name}"
    }
}

# Configuring DHCP inside VPC
resource "aws_vpc_dhcp_options" "domain_setup" {
    domain_name = "priv.${var.aws_platform_name}.${var.aws_vpc_domain_name}"
    domain_name_servers = ["AmazonProvidedDNS"]

    tags {
      Name = "dhcp_setup_domain_${var.aws_platform_name}"
    }
}

resource "aws_vpc_dhcp_options_association" "domain_setup_assoc" {
    vpc_id = "${aws_vpc.platform_vpc.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.domain_setup.id}"
}

# Configure subnet per AZ
resource "aws_subnet" "aws_az1" {
    vpc_id = "${aws_vpc.platform_vpc.id}"
    availability_zone = "${var.aws_region_azs.az1}"
    cidr_block = "${var.aws_vpc_subnet_block.az1}"

    tags {
        Name = "subnet_az1_${var.aws_platform_name}"
    }
}

resource "aws_subnet" "aws_az2" {
    vpc_id = "${aws_vpc.platform_vpc.id}"
    availability_zone = "${var.aws_region_azs.az2}"
    cidr_block = "${var.aws_vpc_subnet_block.az2}"

    tags {
        Name = "subnet_az2_${var.aws_platform_name}"
    }
}

# ACLs
resource "aws_network_acl" "vpc_acls" {
    vpc_id = "${aws_vpc.platform_vpc.id}"
    egress {
        protocol = "-1"
        rule_no = 2
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }

    ingress {
        protocol = "-1"
        rule_no = 1
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }

    tags {
        Name = "vpc_acls_${var.aws_platform_name}"
    }
}

# SG
resource "aws_security_group" "all_access" {
  name = "all_access"
  vpc_id = "${aws_vpc.platform_vpc.id}"
  description = "all access"

  # ALL ACCESS VPC
  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
  # END ALL ACCESS

  tags {
      Name = "sg_fronts_${var.aws_platform_name}"
  }
}

# Routing
resource "aws_route_table" "default" {
    vpc_id = "${aws_vpc.platform_vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }

    tags {
        Name = "vpc_rt_${var.aws_platform_name}"
    }
}

resource "aws_route_table_association" "az1_rt" {
    subnet_id = "${aws_subnet.aws_az1.id}"
    route_table_id = "${aws_route_table.default.id}"
}

resource "aws_route_table_association" "az2_rt" {
    subnet_id = "${aws_subnet.aws_az2.id}"
    route_table_id = "${aws_route_table.default.id}"
}

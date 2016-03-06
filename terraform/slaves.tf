resource "aws_instance" "docker_slave_1" {
    ami = "${var.aws_ami_base}"
    instance_type = "${var.aws_instance_type}"
    availability_zone = "${var.aws_region_azs.az1}"
    associate_public_ip_address = true
    key_name = "${var.aws_keypair}"
    subnet_id = "${aws_subnet.aws_az1.id}"
    vpc_security_group_ids = ["${aws_security_group.all_access.id}"]
    user_data = "${file("user-data/docker-setup.sh")}"
    ebs_block_device {
      device_name = "/dev/sdk"
      volume_size = 30
    }
    tags {
      Name = "${var.aws_platform_name}_docker_slave_1"
    }
}

resource "aws_instance" "docker_slave_2" {
    ami = "${var.aws_ami_base}"
    instance_type = "${var.aws_instance_type}"
    availability_zone = "${var.aws_region_azs.az1}"
    associate_public_ip_address = true
    key_name = "${var.aws_keypair}"
    subnet_id = "${aws_subnet.aws_az1.id}"
    vpc_security_group_ids = ["${aws_security_group.all_access.id}"]
    user_data = "${file("user-data/docker-setup.sh")}"
    ebs_block_device {
      device_name = "/dev/sdk"
      volume_size = 30
    }
    tags {
      Name = "${var.aws_platform_name}_docker_slave_2"
    }
}

resource "aws_instance" "docker_slave_3" {
    ami = "${var.aws_ami_base}"
    instance_type = "${var.aws_instance_type}"
    availability_zone = "${var.aws_region_azs.az1}"
    associate_public_ip_address = true
    key_name = "${var.aws_keypair}"
    subnet_id = "${aws_subnet.aws_az1.id}"
    vpc_security_group_ids = ["${aws_security_group.all_access.id}"]
    user_data = "${file("user-data/docker-setup.sh")}"
    ebs_block_device {
      device_name = "/dev/sdk"
      volume_size = 30
    }
    tags {
      Name = "${var.aws_platform_name}_docker_slave_3"
    }
}

/*resource "aws_instance" "docker_slave_4" {
    ami = "${var.aws_ami_base}"
    instance_type = "${var.aws_instance_type}"
    availability_zone = "${var.aws_region_azs.az1}"
    associate_public_ip_address = true
    key_name = "${var.aws_keypair}"
    subnet_id = "${aws_subnet.aws_az1.id}"
    vpc_security_group_ids = ["${aws_security_group.all_access.id}"]
    user_data = "${file("user-data/docker-setup.sh")}"
    ebs_block_device {
      device_name = "/dev/sdk"
      volume_size = 30
    }
    tags {
      Name = "${var.aws_platform_name}_docker_slave_4"
    }
}

resource "aws_instance" "docker_slave_5" {
    ami = "${var.aws_ami_base}"
    instance_type = "${var.aws_instance_type}"
    availability_zone = "${var.aws_region_azs.az1}"
    associate_public_ip_address = true
    key_name = "${var.aws_keypair}"
    subnet_id = "${aws_subnet.aws_az1.id}"
    vpc_security_group_ids = ["${aws_security_group.all_access.id}"]
    user_data = "${file("user-data/docker-setup.sh")}"
    ebs_block_device {
      device_name = "/dev/sdk"
      volume_size = 30
    }
    tags {
      Name = "${var.aws_platform_name}_docker_slave_5"
    }
}

resource "aws_instance" "docker_slave_6" {
    ami = "${var.aws_ami_base}"
    instance_type = "${var.aws_instance_type}"
    availability_zone = "${var.aws_region_azs.az1}"
    associate_public_ip_address = true
    key_name = "${var.aws_keypair}"
    subnet_id = "${aws_subnet.aws_az1.id}"
    vpc_security_group_ids = ["${aws_security_group.all_access.id}"]
    user_data = "${file("user-data/docker-setup.sh")}"
    ebs_block_device {
      device_name = "/dev/sdk"
      volume_size = 30
    }
    tags {
      Name = "${var.aws_platform_name}_docker_slave_6"
    }
}

resource "aws_instance" "docker_slave_7" {
    ami = "${var.aws_ami_base}"
    instance_type = "${var.aws_instance_type}"
    availability_zone = "${var.aws_region_azs.az1}"
    associate_public_ip_address = true
    key_name = "${var.aws_keypair}"
    subnet_id = "${aws_subnet.aws_az1.id}"
    vpc_security_group_ids = ["${aws_security_group.all_access.id}"]
    user_data = "${file("user-data/docker-setup.sh")}"
    ebs_block_device {
      device_name = "/dev/sdk"
      volume_size = 30
    }
    tags {
      Name = "${var.aws_platform_name}_docker_slave_7"
    }
}

resource "aws_instance" "docker_slave_8" {
    ami = "${var.aws_ami_base}"
    instance_type = "${var.aws_instance_type}"
    availability_zone = "${var.aws_region_azs.az1}"
    associate_public_ip_address = true
    key_name = "${var.aws_keypair}"
    subnet_id = "${aws_subnet.aws_az1.id}"
    vpc_security_group_ids = ["${aws_security_group.all_access.id}"]
    user_data = "${file("user-data/docker-setup.sh")}"
    ebs_block_device {
      device_name = "/dev/sdk"
      volume_size = 30
    }
    tags {
      Name = "${var.aws_platform_name}_docker_slave_8"
    }
}

resource "aws_instance" "docker_slave_9" {
    ami = "${var.aws_ami_base}"
    instance_type = "${var.aws_instance_type}"
    availability_zone = "${var.aws_region_azs.az1}"
    associate_public_ip_address = true
    key_name = "${var.aws_keypair}"
    subnet_id = "${aws_subnet.aws_az1.id}"
    vpc_security_group_ids = ["${aws_security_group.all_access.id}"]
    user_data = "${file("user-data/docker-setup.sh")}"
    ebs_block_device {
      device_name = "/dev/sdk"
      volume_size = 30
    }
    tags {
      Name = "${var.aws_platform_name}_docker_slave_9"
    }
}

resource "aws_instance" "docker_slave_10" {
    ami = "${var.aws_ami_base}"
    instance_type = "${var.aws_instance_type}"
    availability_zone = "${var.aws_region_azs.az1}"
    associate_public_ip_address = true
    key_name = "${var.aws_keypair}"
    subnet_id = "${aws_subnet.aws_az1.id}"
    vpc_security_group_ids = ["${aws_security_group.all_access.id}"]
    user_data = "${file("user-data/docker-setup.sh")}"
    ebs_block_device {
      device_name = "/dev/sdk"
      volume_size = 30
    }
    tags {
      Name = "${var.aws_platform_name}_docker_slave_10"
    }
}

resource "aws_instance" "docker_slave_11" {
    ami = "${var.aws_ami_base}"
    instance_type = "${var.aws_instance_type}"
    availability_zone = "${var.aws_region_azs.az1}"
    associate_public_ip_address = true
    key_name = "${var.aws_keypair}"
    subnet_id = "${aws_subnet.aws_az1.id}"
    vpc_security_group_ids = ["${aws_security_group.all_access.id}"]
    user_data = "${file("user-data/docker-setup.sh")}"
    ebs_block_device {
      device_name = "/dev/sdk"
      volume_size = 30
    }
    tags {
      Name = "${var.aws_platform_name}_docker_slave_11"
    }
}

resource "aws_instance" "docker_slave_12" {
    ami = "${var.aws_ami_base}"
    instance_type = "${var.aws_instance_type}"
    availability_zone = "${var.aws_region_azs.az1}"
    associate_public_ip_address = true
    key_name = "${var.aws_keypair}"
    subnet_id = "${aws_subnet.aws_az1.id}"
    vpc_security_group_ids = ["${aws_security_group.all_access.id}"]
    user_data = "${file("user-data/docker-setup.sh")}"
    ebs_block_device {
      device_name = "/dev/sdk"
      volume_size = 30
    }
    tags {
      Name = "${var.aws_platform_name}_docker_slave_12"
    }
}*/

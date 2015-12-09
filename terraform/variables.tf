
# AWS global configuration
variable "aws_access_key" {
  description = "AWS access key token"
}

variable "aws_secret_key" {
  description = "AWS secret key token"
}

variable "aws_region" {
  default = "eu-central-1"
  description = "AWS region to use"
}

variable "aws_region_azs" {
  description = "Map for AZs listing"
  default = {
    az1 = "eu-central-1a"
    az2 = "eu-central-1b"
  }
}

variable "aws_platform_name" {
  description = "Platform name"
  default = "docker-swarm-techevent"
}

variable "aws_keypair" {
  description = "Keypair to use with AWS EC2 machines"
}

variable "aws_instance_type" {
  default = "m3.large"
  description = "Instance type to use"
}

# AMI IDs
variable "aws_ami_base" {
  description = "Base AMI ID"
  default = "ami-02392b6e"
}

# VPC configuration
variable "aws_vpc_net_block" {
  description = "Net & CIDR to use for the infrastructure VPC"
  default = "10.10.0.0/16"
}

variable "aws_vpc_subnet_block" {
  description = "Net & CIDR to use in VPC per AZ"
  default = {
    az1 = "10.10.0.0/24"
    az2 = "10.10.1.0/24"
    az3 = "10.10.2.0/24"
  }
}

variable "aws_vpc_domain_name" {
  description = "Domain Name in the VPC"
  default = "swarm.lan"
}

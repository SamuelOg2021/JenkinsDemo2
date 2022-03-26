variable "Subnet_location" {
    description = "The aws Subnet location"
    default = "us-east-1a"
}

variable "network_security_group_name" {
    description = "Allow web inbound traffic"
    default = "allow_web_traffic"
}

variable "aws_instance_type" {
    description = "The Tier instance type"
    default = "t2.micro"
}

variable "aws_instance_location" {
    description = "The aws instance location"
    default = "us-east-1a"
}

variable "ec2_ami_type" {
    description = "The aws ami type"
    default = "ami-04505e74c0741db8d"
}
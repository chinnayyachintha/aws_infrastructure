resource "aws_instance" "ec2_instance" {

    ami = var.ami
    key_name = var.key_name
    subnet_id = var.subnet_id
    vpc_security_group_ids = var.security_groups
    instance_type = "t2.micro"

    tags = {
        Name = var.name
    }
}

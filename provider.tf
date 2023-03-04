resource "aws_instance" "my-ec2"{
    ami="ami-0b029b1931b347543"
    instance_type="t2.micro"
     tags = {
    Name = "Amira-instance-terraform"
  }
    vpc_security_group_ids =[aws_security_group.allow_ssh.id]
}




output "eip_value" {
    description = "VMs public IP"
    value= aws_instance.my-ec2.public_ip

}

output "static_ip_value" {
    description = "VMs Private IP"
    value= aws_instance.my-ec2.private_ip

}
output "instance_ip" {
    description = "VM Name"
    value= aws_instance.my-ec2.tags_all.Name

}

terraform {
    backend "s3" {
    bucket = "amira-bucket"
    key    = "key"
    region = "us-west-1"
  }
}
resource "aws_security_group" "allow_ssh" {
  name        = "amira_security_group_allow_ssh"
  description = "Allow ssh inbound traffic"
 

  ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    
    
  }


  tags = {
    Name = "amira_security_group_allow_ssh"
  }
}




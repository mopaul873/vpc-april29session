resource "aws_instance" "server1" {
    ami = "ami-02d7fd1c2af6eead0"
    vpc_security_group_ids = [ aws_security_group.sg1.id]
    availability_zone = "us-east-1a"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.priv1.id
    user_data = file("code.sh")
    tags = {
      Name = "webserver-1"
    }
}

resource "aws_instance" "server2" {
    ami = "ami-02d7fd1c2af6eead0"
    vpc_security_group_ids = [ aws_security_group.sg1.id]
    availability_zone = "us-east-1b"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.priv2.id
    user_data = file("code.sh")
    tags = {
      Name = "webserver-2"
    }
}


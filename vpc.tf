resource "aws_vpc" "myvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "pub1" {
    vpc_id = aws_vpc.myvpc.id
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "public-subnet-1"
      env = "Dev"
    }

}

resource "aws_subnet" "pub2" {
    vpc_id = aws_vpc.myvpc.id
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
    cidr_block = "10.0.2.0/24"
    tags = {
      Name = "public-subnet-2"
      env = "Dev"
    }

}

resource "aws_subnet" "priv1" {
    vpc_id = aws_vpc.myvpc.id
    availability_zone = "us-east-1a"
    cidr_block = "10.0.3.0/24"
    tags = {
      Name = "private-subnet-1"
      env = "Dev"
    }

}

resource "aws_subnet" "priv2" {
    vpc_id = aws_vpc.myvpc.id
    availability_zone = "us-east-1b"
    cidr_block = "10.0.4.0/24"
    tags = {
      Name = "private-subnet-2"
      env = "Dev"
    }

}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id
  
}

resource "aws_eip" "eip" {
  
}

resource "aws_nat_gateway" "nat1" {
  subnet_id = aws_subnet.pub1.id
  allocation_id = aws_eip.eip.id

}

resource "aws_route_table" "rtpublic" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "rtprivate" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta1" {
    route_table_id = aws_route_table.rtprivate.id
    subnet_id = aws_subnet.priv1.id
  
}

resource "aws_route_table_association" "rta2" {
    route_table_id = aws_route_table.rtprivate.id
    subnet_id = aws_subnet.priv2.id
  
}

resource "aws_route_table_association" "rta3" {
    route_table_id = aws_route_table.rtpublic.id
    subnet_id = aws_subnet.pub1.id
  
}

resource "aws_route_table_association" "rta4" {
    route_table_id = aws_route_table.rtpublic.id
    subnet_id = aws_subnet.pub2.id
  
}










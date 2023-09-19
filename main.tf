provider "aws" {
  region  = "ap-south-1"
  access_key = "AKIAWCON6PPRBBJFD6OY"
  secret_key = "zlnvxT+Bh6G/iS4MPaIA6RNsRf8lxfXPxTj8SCKB"
}


# create a vpc 

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"  # Specify your desired VPC CIDR block
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "MyVPC"
  }
}

# creating a subnet 

resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"  # Specify your desired subnet CIDR block
  availability_zone = "ap-south-1a"  # Specify the availability zone

  tags = {
    Name = "MySubnet"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "MyInternetGateway"
  }
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "MyRouteTable"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.my_route_table.id
  destination_cidr_block = "0.0.0.0/0"  # Default route for internet access
  gateway_id             = aws_internet_gateway.my_igw.id
}



resource "aws_security_group" "my_security_group" {
  name        = "MySecurityGroup"
  description = "Allow SSH, HTTP, and HTTPS traffic"
  vpc_id      = aws_vpc.my_vpc.id  # Replace with your VPC ID

  // Inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTPS from anywhere
  }

  // You can add more inbound rules as needed
}



resource "aws_network_interface" "my_eni" {
  subnet_id       = aws_subnet.my_subnet.id  # Replace with your subnet ID
  private_ips     = ["10.0.1.10"]  # Specify your desired private IP address

  # Security group IDs, e.g., ["sg-0123456789abcdef0"]
  security_groups = [aws_security_group.my_security_group.id]

  tags = {
    Name = "MyNetworkInterface"
  }
}

resource "aws_network_interface_attachment" "my_new_eni_attachment" {
  instance_id          = aws_instance.my_instance.id
  network_interface_id = aws_network_interface.my_eni.id
  device_index         = 1  # Specify the device index (1 for additional network interfaces)
}

resource "aws_instance" "my_instance" {
  ami           = "ami-05552d2dcf89c9b24"
  instance_type = "t2.micro"
  availability_zone = "ap-south-1a"
  subnet_id       = aws_subnet.my_subnet.id

  tags = {
    Name = "myinstance"
  }
}

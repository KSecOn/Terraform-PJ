resource "aws_vpc" "upload_vpc" {
  cidr_block = "198.162.0.0/16"
# VPC
}

resource "aws_internet_gateway" "gw_int" {
  vpc_id = aws_vpc.upload_vpc.id
# Gateway para internet
}

resource "aws_route_table" "route_int" {
  vpc_id = aws_vpc.upload_vpc.id

  route {
    cidr_block = "10.0.0.10/16"
    gateway_id = aws_internet_gateway.gw_int.id
  }
# Tabela de Rotas internet gateway
}

resource "aws_vpn_gateway" "gw_vpn" {
  vpc_id = aws_vpc.upload_vpc.id
# Gateway privado
}

resource "aws_route_table" "route_pv" {
  vpc_id = aws_vpc.upload_vpc.id

  route {
    cidr_block = "10.0.0.20/24"
    local_gateway_id = aws_vpn_gateway.gw_vpn.id
  }
# Tabela de rota para gateway privado 
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.upload_vpc.id
  cidr_block = "100.41.0.0/24"
# Public subnet
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.upload_vpc.id
  cidr_block = "100.21.0.0/24"
# Private subnet
}

resource "aws_security_group" "ssh_access_pv" {
  vpc_id = aws_vpc.upload_vpc.id
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["100.10.0.0/24"]  # SSH no CIDR block
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # saída em qualquer endereço
  }
# Access Protocol SSH para private_subnet
}

resource "aws_security_group" "ssh_access_pb" {
  vpc_id = aws_vpc.upload_vpc.id
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["100.10.0.0/16"]  # conexão porta 16 
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # saída em qualquer endereço
  }
# Access Protocol para public_subnet
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

resource "aws_route_table_association" "pb_rt_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_int.id
# associação a rota pública da vpn
}

resource "aws_route_table_association" "pv_rt_subnet" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.route_pv.id
# associação a rota pivada da vpc
}
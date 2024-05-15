# Bucket

output "infra_bucket_id" {
  description = "id infra_bucket"
  value = aws_s3_bucket.infra_bucket.id
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Infra

output "upload_vpc_id" {
  description = "id upload_vpc"
  value = aws_vpc.upload_vpc.id
}

output "gw_int_id" {
  description = "id public gateway"
  value = aws_internet_gateway.gw_int.id
}

output "gw_vpn_id" {
  description = "id private gateway"
  value = aws_vpn_gateway.gw_vpn.id
}

output "public_subnet_id" {
  description = "id public subnet"
  value = aws_subnet.public_subnet.id
}

output "route_int_id" {
  description = "id route table public subnet"
  value = aws_route_table.route_int.id
}

output "private_subnet_id" {
  description = "id private subnet"
  value = aws_subnet.private_subnet.id
}

output "route_pv_id" {
  description = "id route table private subnet"
  value = aws_route_table.route_pv.id
}
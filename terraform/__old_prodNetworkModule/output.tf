# Add output variables
output "subnet_id" {
  value = aws_subnet.prod_private[*].id
}

output "vpc_id" {
  value = aws_vpc.prod_vpc.id
}

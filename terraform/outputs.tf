# Outputs for the created resources
output "vpc_id" {
  value = aws_vpc.final_project_vpc.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_subnet1.id,
    aws_subnet.public_subnet2.id,
    aws_subnet.public_subnet3.id,
    aws_subnet.public_subnet4.id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.private_subnet1.id,
    aws_subnet.private_subnet2.id
  ]
}

output "web_alb_dns" {
  value = aws_lb.web_alb.dns_name
}

# # Load Balancer
# resource "aws_lb" "public" {
#   name               = "${local.name_prefix}-lb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.public_sg.id]
#   subnets            = data.terraform_remote_state.network.outputs.public_subnet_ids

#   tags = merge(local.default_tags,
#     {
#       "Name" = "${local.name_prefix}-lb"
#     }
#   )
# }

# # Load Balancer Listener
# resource "aws_lb_listener" "front_end" {
#   load_balancer_arn = aws_lb.public.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type = "fixed-response"
#     fixed_response {
#       content_type = "text/plain"
#       message_body = "404: Page not found"
#       status_code  = 404
#     }
#   }
# }
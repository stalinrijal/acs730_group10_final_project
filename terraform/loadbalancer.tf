# Application Load Balancer
resource "aws_lb" "web_alb" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [
    aws_subnet.public_subnet1.id,
    aws_subnet.public_subnet2.id,
    aws_subnet.public_subnet3.id,
    aws_subnet.public_subnet4.id
  ]

  security_groups = [aws_security_group.public_sg.id]

  tags = {
    Name = "web-alb"
  }
}

# ALB Target Group
resource "aws_lb_target_group" "web_tg" {
  name        = "web-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.final_project_vpc.id
  target_type = "instance"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    path                = "/"
    interval            = 30
    matcher             = "200-399"
  }

  tags = {
    Name = "web-tg"
  }
}

# ALB Listener
resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }

  tags = {
    Name = "web-listener"
  }
}

# ALB Target Group Attachment
resource "aws_lb_target_group_attachment" "web_attachment1" {
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.webserver1.id
  port             = 80
}

#resource "aws_lb_target_group_attachment" "web_attachment2" {
#  target_group_arn = aws_lb_target_group.web_tg.arn
#  target_id        = aws_instance.webserver3.id
#  port             = 80
#}

resource "aws_lb_target_group_attachment" "web_attachment3" {
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.webserver5.id
  port             = 80
}

provider "aws" {
  region  = "us-east-2"
}

variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-75ec701e", "subnet-cfe62cb2", "subnet-debf8d92"]
}

resource "aws_lb" "sysprov" {
  name               = "sysprov-webserver"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-0351e89750d76eee9"]
  subnets            = ["subnet-75ec701e", "subnet-cfe62cb2", "subnet-debf8d92"]

  enable_deletion_protection = false
  tags = {
    Environment = "Dev"
  }
}

resource "aws_lb_target_group" "sysprovtg" {
  name              = "sysprovtg"
  port              = 80
  protocol          = "HTTP"
  vpc_id            = "vpc-3e106455"
  target_type       = "instance"
  proxy_protocol_v2 = "false"
  health_check {
    enabled             = "true"
    interval            = 60
    port                = "80"
    path                = "/"
    healthy_threshold   = 10
    unhealthy_threshold = 10
    timeout             = 10
    protocol            = "HTTP"
    matcher             = 200
  }
}
resource "aws_lb_listener" "sysprovlistener" {
  load_balancer_arn = aws_lb.sysprov.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sysprovtg.arn
  }
}
resource "aws_alb_listener_rule" "alb_rules" {
  listener_arn = aws_lb_listener.sysprovlistener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sysprovtg.arn
  }
  condition {
    path_pattern {
      values = ["/index.html"]
    }
  }
}

resource "aws_lb_listener_rule" "service_path_blue_rule" {
  listener_arn = var.alb_lstnr_arn
  priority     = var.priority

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ecs_blue_target_service_group.arn
  }

  lifecycle {
    ignore_changes = [
      action
    ]
  }

  condition {
    path_pattern {
      values = ["/${var.path}/*"]
    }
  }
}


resource "aws_alb_target_group" "ecs_blue_target_service_group" {
  name        = "${var.application_code}-${var.microservice_code}-http-blu-${var.env}"
  port        = var.microservice_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/${var.path}/health"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = "10"
    timeout             = "6"
    unhealthy_threshold = "3"
    healthy_threshold   = "3"
  }

  lifecycle {
    create_before_destroy = true
  }
}

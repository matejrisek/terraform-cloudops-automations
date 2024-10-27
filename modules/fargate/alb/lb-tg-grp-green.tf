resource "aws_alb_listener" "ecs_alb_https_green_listener" {
  load_balancer_arn = aws_alb.ecs_cluster_alb.arn
  port              = "8080"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.https_certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ecs_blue_target_group.arn
  }
  depends_on = [aws_alb_target_group.ecs_green_target_group]
  lifecycle {
    ignore_changes = [
      default_action
    ]
  }
}

resource "aws_alb_target_group" "ecs_green_target_group" {
  name        = "${var.application_code}-http-grn-${var.env}"
  port        =  var.default_microservice_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    path                = var.default_healthurl
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


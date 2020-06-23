resource "aws_lb" "app_waf_alb" {
  name     = "front-end-alb"
  internal = var.internal
  security_groups = [
    aws_security_group.nw_sec_sg[0].id
  ]
  subnets = [
    aws_subnet.self[0],
    aws_subnet.self[1]
  ]
  ip_address_type    = "ipv4"
  load_balancer_type = var.load_balancer_type
}

resource "aws_lb_target_group" "waf_alb" {
  name     = "alb-frontend-tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = aws_vpc.self[0].id
}

resource "aws_lb_listener" "front_end" {
  count             = var.alb_cert_arn ? 1 : 0
  load_balancer_arn = aws_lb.app_waf_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-2019-08"
  certificate_arn   = var.alb_cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.waf_alb
  }
}

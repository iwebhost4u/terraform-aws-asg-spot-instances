/*
 * Copyright 2024 Eric Mensah
 *
 * This file defines the resources for the load balancer.
 * It includes the load balancer, target group, listener, and autoscaling attachment.
 */

resource "tls_private_key" "appserv1" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "appserv1" {
  private_key_pem = tls_private_key.appserv1.private_key_pem

  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]

  subject {
    common_name = "myappserv1.com"
  }
}

resource "aws_acm_certificate" "appserv1" {
  private_key      = tls_private_key.appserv1.private_key_pem
  certificate_body = tls_self_signed_cert.appserv1.cert_pem

  tags = {
    Name = "myappserv1-certificate"
  }
}

resource "aws_lb" "internal" {
  name               = "appserv1"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids

  tags = {
    Name = "appserv1"
  }
}

resource "aws_lb_target_group" "appserv1" {
  name     = "appserv1-tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    path                = "/health"
    matcher             = "200"
  }

  tags = {
    Name = "appserv1-tg"
  }
}

resource "aws_lb_listener" "appserv1" {
  load_balancer_arn = aws_lb.internal.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = aws_acm_certificate.appserv1.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.appserv1.arn
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = var.autoscaling_group_name
  lb_target_group_arn    = aws_lb_target_group.appserv1.arn
}
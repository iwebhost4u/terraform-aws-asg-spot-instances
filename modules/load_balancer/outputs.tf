/*
 * Copyright 2024 Eric Mensah
 *
 * This file defines the output values for the load balancer module.
 * These outputs provide information about the load balancer resources.
 */

output "load_balancer_dns_name" {
  value = aws_lb.internal.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.appserv1.arn
}
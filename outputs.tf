/*
 * Copyright 2024 Eric Mensah
 *
 * This file defines the output values for the Terraform configuration.
 * These outputs provide information about the resources created.
 */

output "autoscaling_group_name" {
  value = module.autoscaling_group.autoscaling_group_name
}

output "load_balancer_dns_name" {
  value = module.load_balancer.load_balancer_dns_name
}

output "target_group_arn" {
  value = module.load_balancer.target_group_arn
}
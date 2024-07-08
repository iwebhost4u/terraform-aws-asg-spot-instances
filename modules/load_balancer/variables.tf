/*
 * Copyright 2024 Eric Mensah
 *
 * This file defines the input variables for the load balancer module.
 * These variables are used to customize the load balancer resources.
 */

variable "subnet_ids" {
  description = "The IDs of the existing private subnets"
  type        = list(string)
}

variable "security_group_id" {
  description = "The security group ID for the load balancer"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "autoscaling_group_name" {
  description = "The name of the Auto Scaling group"
  type        = string
}
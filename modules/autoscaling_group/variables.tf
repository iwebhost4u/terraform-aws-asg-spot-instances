/*
 * Copyright 2024 Eric Mensah
 *
 * This file defines the input variables for the autoscaling group module.
 * These variables are used to customize the autoscaling group resources.
 */

variable "subnet_ids" {
  description = "The IDs of the existing private subnets"
  type        = list(string)
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instances"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID for the EC2 instances"
  type        = string
}

variable "iam_role_name" {
  description = "The name of the existing IAM role for EC2"
  type        = string
}
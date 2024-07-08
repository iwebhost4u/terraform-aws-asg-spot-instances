/*
 * Copyright 2024 Eric Mensah
 *
 * This file defines the input variables for the Terraform configuration.
 * These variables are used to customize the deployment.
 */

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "The ID of the existing VPC"
  type        = string
}

variable "subnet_ids" {
  description = "The IDs of the existing private subnets"
  type        = list(string)
}

variable "iam_role_name" {
  description = "The name of the existing IAM role for EC2"
  type        = string
}
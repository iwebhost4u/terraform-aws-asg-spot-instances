/*
 * Copyright 2024 Eric Mensah
 *
 * This file defines the input variables for the security group module.
 * These variables are used to customize the security group resources.
 */

variable "name" {
  description = "The name of the security group"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "from_port" {
  description = "The starting port for the ingress rule"
  type        = number
}

variable "to_port" {
  description = "The ending port for the ingress rule"
  type        = number
}
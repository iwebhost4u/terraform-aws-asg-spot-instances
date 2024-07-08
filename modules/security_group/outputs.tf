/*
 * Copyright 2024 Eric Mensah
 *
 * This file defines the output values for the security group module.
 * These outputs provide information about the security group resources.
 */

output "security_group_id" {
  value = aws_security_group.example.id
}
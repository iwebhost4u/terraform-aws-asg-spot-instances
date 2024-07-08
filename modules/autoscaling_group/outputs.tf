/*
 * Copyright 2024 Eric Mensah
 *
 * This file defines the output values for the autoscaling group module.
 * These outputs provide information about the autoscaling group resources.
 */

output "autoscaling_group_name" {
  value = aws_autoscaling_group.example.name
}
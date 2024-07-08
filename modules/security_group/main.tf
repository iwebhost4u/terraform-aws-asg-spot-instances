/*
 * Copyright 2024 Eric Mensah
 *
 * This file defines the security group resource.
 * It includes the ingress and egress rules to allow communication between EC2 instances.
 */

resource "aws_security_group" "example" {
  name        = var.name
  description = "Allow EC2 instances to communicate with each other"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.name
  }
}
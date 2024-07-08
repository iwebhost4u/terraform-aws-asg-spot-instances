/*
 * Copyright 2024 Eric Mensah
 *
 * This file defines the resources for the autoscaling group.
 * It includes the launch template for EC2 instances and the autoscaling group configuration.
 */

resource "aws_iam_instance_profile" "example" {
  name = "example-instance-profile"
  role = var.iam_role_name
}

resource "aws_launch_template" "example" {
  name_prefix   = "example-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  instance_market_options {
    market_type = "spot"
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.example.arn
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 8
      volume_type = "gp2"
    }
  }

  block_device_mappings {
    device_name = "/dev/sdb"
    ebs {
      volume_size = 100
      volume_type = "gp2"
    }
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.security_group_id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "example-ec2"
    }
  }
}

resource "aws_autoscaling_group" "example" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = var.subnet_ids
  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "example-asg"
    propagate_at_launch = true
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 90
    }
  }
}
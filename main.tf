/*
 * Copyright 2024 Eric Mensah
 *
 * This file is the main entry point for the Terraform configuration.
 * It loads required data and defines modules for the security group,
 * autoscaling group, and load balancer.
 */

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

module "security_group" {
  source    = "./modules/security_group"
  vpc_id    = var.vpc_id
  name      = "ec2_sg"
  from_port = 4001
  to_port   = 4003
}

module "autoscaling_group" {
  source            = "./modules/autoscaling_group"
  subnet_ids        = var.subnet_ids
  ami_id            = data.aws_ami.amazon_linux.id
  instance_type     = "t3.micro"
  security_group_id = module.security_group.security_group_id
  iam_role_name     = var.iam_role_name
}

module "load_balancer" {
  source                 = "./modules/load_balancer"
  subnet_ids             = var.subnet_ids
  security_group_id      = module.security_group.security_group_id
  vpc_id                 = var.vpc_id
  autoscaling_group_name = module.autoscaling_group.autoscaling_group_name
}
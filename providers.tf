/*
 * Copyright 2024 Eric Mensah
 *
 * This file sets up the providers for the Terraform configuration.
 */

provider "aws" {
  region = var.region
}
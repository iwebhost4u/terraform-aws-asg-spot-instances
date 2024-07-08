# terraform-aws-asg-spot-instances

This repository contains a Terraform configuration for setting up an AWS infrastructure with an autoscaling group, load balancer, security group, and ACM certificate using a self-signed TLS certificate.

## Prerequisites

Before you begin, ensure you have the following:

- **Terraform**: Install Terraform from the [official website](https://www.terraform.io/downloads.html).
- **AWS CLI**: Install the AWS CLI from the [official website](https://aws.amazon.com/cli/).
- **AWS Credentials**: Configure your AWS credentials in `~/.aws/credentials` or using the AWS CLI:
  ```bash
  aws configure
  ```
- **Git**: Install Git from the [official website](https://git-scm.com/downloads).
- **Existing AWS Resources**: Ensure the following resources already exist in your AWS account:
  - **VPC ID**
  - **Subnet IDs** (for two private subnets)
  - **EC2 IAM Role**

## Setup Guide

### 1. Clone the Repository

Clone this repository to your local machine:

```bash
git clone https://github.com/iwebhost4u/terraform-aws-asg-spot-instances.git
cd terraform-aws-setup
```

### 2. Directory Structure

Here is the structure of the repository:

```
.
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── modules
    ├── autoscaling_group
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── security_group
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── load_balancer
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

### 3. Update `terraform.tfvars`

Update the `terraform.tfvars` file with your specific values, such as region, VPC ID, subnet IDs, and IAM role name. Ensure these resources already exist in your AWS account.

### 4. Initialize Terraform

Initialize the Terraform configuration with:

```bash
terraform init
```

### 5. Plan the Deployment

Run the `terraform plan` command to preview the changes that will be made by the configuration:

```bash
terraform plan
```

### 6. Apply the Configuration

Apply the Terraform configuration to create the resources:

```bash
terraform apply
```

Type `yes` when prompted to confirm the creation of resources.

### 7. Verify Resources

After the deployment, verify the resources in the AWS Management Console. You should see:
- An EC2 autoscaling group with spot instances
- An internal application load balancer with a listener on port 443
- A security group allowing communication between instances on ports 4001-4003
- An ACM certificate created using a self-signed TLS certificate

## Code Explanation

### `main.tf`

Defines the main Terraform configuration, including the provider setup, data sources for AMI, and module calls for creating the security group, autoscaling group, and load balancer.

### `providers.tf`

Sets up the AWS provider. This file contains the configuration to specify the AWS region.

### `variables.tf`

Defines the input variables for the configuration. These variables allow you to customize the deployment by specifying the AWS region, VPC ID, subnet IDs, and IAM role name.

### `outputs.tf`

Defines the output values for the configuration. Outputs include the names and ARNs of the created resources, such as the autoscaling group name, load balancer DNS name, and target group ARN.

### `terraform.tfvars`

Provides the values for the input variables defined in `variables.tf`. Update this file with your specific configuration values.

### `modules/autoscaling_group`

Contains the Terraform code for creating the autoscaling group, including the launch template configuration, instance profile, and autoscaling group setup. It uses spot instances and attaches a predefined IAM role to the EC2 instances.

### `modules/security_group`

Contains the Terraform code for creating the security group. This module defines the ingress and egress rules to allow communication between the EC2 instances on specified ports.

### `modules/load_balancer`

Contains the Terraform code for creating the load balancer, target group, listener, and ACM certificate. This module also includes the resources for generating a self-signed TLS certificate and attaching it to the load balancer.

## Conclusion

This setup provides a complete example of using Terraform to create an AWS infrastructure with an autoscaling group, load balancer, and self-signed ACM certificate. By following the steps above, you can deploy the infrastructure in your AWS account. For any questions or issues, feel free to open an issue on the GitHub repository.

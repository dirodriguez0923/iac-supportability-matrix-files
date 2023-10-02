provider "aws" {
  region = "us-west-2" # or your preferred AWS region
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "hello-cluster"
  cluster_version = "1.21" # adjust this to the version you want
  subnets         = ["subnet-abcde012", "subnet-bcde012a"] # update with your VPC subnets

  node_groups = {
    eks_nodes = {
      desired_capacity = 1
      max_capacity     = 1
      min_capacity     = 1

      instance_type = "m5.large"
      key_name      = var.key_name
    }
  }
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group id attached to the EKS cluster."
  value       = module.eks.cluster_security_group_id
}

output "cluster_iam_role_name" {
  description = "IAM role name attached to EKS cluster."
  value       = module.eks.cluster_iam_role_name
}


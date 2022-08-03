#################
# create cluster
#################
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn
  version  = var.cluster_version

  # enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    security_group_ids      = [aws_security_group.sg_eks_cluster.id]
    subnet_ids              = aws_subnet.public_subnet.*.id
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}

#######################
# cluster registration
#######################
resource "null_resource" "cluster_registration" {
  provisioner "local-exec" {
    command = "aws eks --region ap-northeast-2 update-kubeconfig --name ${var.cluster_name}"
  }
  
  depends_on = [
    aws_eks_cluster.eks_cluster
  ]
}

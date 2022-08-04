# Create Node Group
resource "aws_eks_node_group" "eks_nodes_t2" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.eks_node_group_name
  subnet_ids      = [aws_subnet.public_subnet[0].id]
  node_role_arn   = aws_iam_role.eks_node.arn
  instance_types  = var.eks_nodes_instance_types
  disk_size       = var.eks_nodes_disk_size

  labels = var.eks_node_labels

  scaling_config {
    desired_size = var.eks_node_sc_desired_size
    min_size     = var.eks_node_sc_min_size
    max_size     = var.eks_node_sc_max_size
  }

  remote_access {
    ec2_ssh_key               = var.eks_node_key_name
    source_security_group_ids = [aws_security_group.sg_eks_cluster.id]
  }
  
  depends_on = [
    aws_iam_role_policy_attachment.eks_node_policy,
  ]

  tags = {
    "Name" = "${aws_eks_cluster.eks_cluster.name}-eks-t2-medium-Node"
  }
}

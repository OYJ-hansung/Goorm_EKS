# Create Node Group
resource "aws_eks_node_group" "eks_nodes_t2" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.eks_node_group_name
  subnet_ids      = [aws_subnet.private_subnet[0].id]
  node_role_arn   = aws_iam_role.eks_node.arn
  instance_types  = var.eks_nodes_instance_types
  disk_size       = var.eks_nodes_disk_size

  labels = var.eks_node_labels

  scaling_config {
    desired_size = var.eks_node_sc_desired_size
    min_size     = var.eks_node_sc_min_size
    max_size     = var.eks_node_sc_max_size
  }
  
  depends_on = [
    aws_iam_role_policy_attachment.eks_node_policy,
  ]

  tags = {
    "Name" = "${aws_eks_cluster.eks_cluster.name}-eks-t2-medium-Node"
  }
}

#####################
# Worker node lookup
#####################
data "aws_instances" "workers" {
  instance_tags = {
    "eks:nodegroup-name" = var.eks_node_group_name
  }

  depends_on = [aws_eks_node_group.eks_nodes_t2]
}

data "aws_instance" "workers" {
  count = length(data.aws_instances.workers)

  instance_id = element(data.aws_instances.workers.ids, count.index)
}

###########################################
# Adding a Security Group to a Worker Node
###########################################
resource "aws_network_interface_sg_attachment" "sg_attachment" {
  count = length(data.aws_instance.workers)
  security_group_id = aws_security_group.sg_allow_all.id
  network_interface_id = element(data.aws_instance.workers.*.network_interface_id, count.index)
}

#####################################
# Elastic ip lookup for worker nodes
#####################################
data "aws_eip" "worker_node_eip" {
  tags = {
    Name = var.worker_node_eip_name
  }
}

##################################
# EIP connections to worker nodes
##################################
resource "aws_eip_association" "worker_node_eip_assoc" {
  instance_id   = data.aws_instance.workers[0].id
  allocation_id = data.aws_eip.worker_node_eip.id
}

############################
# EKS Cluster Roles & Polic
############################
resource "aws_iam_role" "eks_cluster" {
  name = var.eks_cluster_role_name

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "eks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  for_each = var.eks_cluster_policy_arns

  policy_arn = each.key
  role       = aws_iam_role.eks_cluster.name
}

###########################
# EKS Nodes Roles & Policy
###########################
resource "aws_iam_role" "eks_node" {
  name = var.eks_node_role_name

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_node_policy" {
  for_each = var.eks_node_policy_arns

  policy_arn = each.key
  role       = aws_iam_role.eks_node.name
}

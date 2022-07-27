# create security group
resource "aws_security_group" "sg_eks_cluster" {
  name        = var.sg_eks_cluster_name
  description = var.sg_eks_cluster_description
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_eks_cluster_name
  }
}


# add ingress rule of security group
resource "aws_security_group_rule" "sg_eks_cluster_ingress_workstation_https" {
  count = length(var.sg_eks_cluster_ingress_port)

  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = element(var.sg_eks_cluster_ingress_port, count.index)
  protocol          = "tcp"
  security_group_id = aws_security_group.sg_eks_cluster.id
  to_port           = element(var.sg_eks_cluster_ingress_port, count.index)
  type              = "ingress"
}

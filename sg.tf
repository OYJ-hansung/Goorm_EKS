######################################
# Creating an eks-only security group
######################################
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
resource "aws_security_group_rule" "sg_eks_cluster_ingress" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.sg_eks_cluster.id
  to_port           = 0
  type              = "ingress"
}

##################################################
# Create a security group that allows all inbound
##################################################
resource "aws_security_group" "sg_allow_all" {
  name        = var.sg_allow_all
  description = var.sg_allow_all_description
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_allow_all
  }
}


# add ingress rule of security group
resource "aws_security_group_rule" "sg_eks_allow_all" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.sg_allow_all.id
  to_port           = 0
  type              = "ingress"
}

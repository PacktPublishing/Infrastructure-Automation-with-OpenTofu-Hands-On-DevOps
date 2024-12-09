module "create_iam_cluster_role" {
  source    = "../modules/create_iam_role"
  role_name = var.cluster_role["role_name"]
  service   = var.cluster_role["service"]
}

module "attached_iam_policy_with_cluster_role" {
  depends_on = [
    module.create_iam_cluster_role
  ]
  for_each    = toset(["AmazonEKSClusterPolicy", "AmazonEKSVPCResourceController"])
  source      = "../modules/attach_iam_policy_with_iam_role"
  role_name   = var.cluster_role["role_name"]
  policy_name = each.value
}

resource "aws_iam_role_policy" "cluster_access_policy" {
  name = "cluster_access_policy"
  role = module.create_ec2_role["access_role"].role_name
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "eks:DescribeNodegroup",
          "eks:ListNodegroups",
          "eks:DescribeCluster",
          "eks:ListClusters",
          "eks:AccessKubernetesApi",
          "ssm:GetParameter",
          "eks:ListUpdates",
          "eks:ListFargateProfiles"
        ],
        "Resource" : "*"
      }
    ]
  })
}

module "create_ec2_role" {
  for_each  = toset(var.ec2_role)
  source    = "../modules/create_iam_role"
  role_name = each.value
  service   = "ec2"
}

module "attached_iam_policy_with_node_role" {
  depends_on = [
    module.create_ec2_role
  ]
  for_each    = toset(["AmazonEKSWorkerNodePolicy", "AmazonEKS_CNI_Policy", "AmazonEC2ContainerRegistryReadOnly"])
  source      = "../modules/attach_iam_policy_with_iam_role"
  role_name   = module.create_ec2_role["node_role"].role_name
  policy_name = each.value
}


resource "aws_iam_instance_profile" "access_role_profile" {
  name = module.create_ec2_role["access_role"].role_name
  role = module.create_ec2_role["access_role"].role_name
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = module.create_iam_cluster_role.role_arn
  vpc_config {
    subnet_ids = [aws_subnet.thinknyx_public_subnet[0].id, aws_subnet.thinknyx_public_subnet[1].id, aws_subnet.thinknyx_public_subnet[2].id]
  }
  depends_on = [
    aws_ec2_tag.tag_subnets,
    module.attached_iam_policy_with_cluster_role
  ]
  tags = {
    "Name" = var.Name
  }
}
resource "aws_ec2_tag" "tag_subnets" {
  for_each    = { for idx, subnet in aws_subnet.thinknyx_public_subnet : idx => subnet }
  resource_id = element(aws_subnet.thinknyx_public_subnet, each.key).id
  key         = "kubernetes.io/cluster/${var.cluster_name}"
  value       = "shared"
}

resource "aws_eks_node_group" "node_group" {
  depends_on = [
    aws_eks_cluster.eks_cluster
  ]
  cluster_name    = var.cluster_name
  node_group_name = "node_group_1"
  node_role_arn   = module.create_ec2_role["node_role"].role_arn
  subnet_ids      = [aws_subnet.thinknyx_public_subnet[0].id, aws_subnet.thinknyx_public_subnet[1].id, aws_subnet.thinknyx_public_subnet[2].id]
  tags = {
    "Name" = var.Name
  }

  scaling_config {
    desired_size = var.cluster_compute["desired_size"]
    max_size     = var.cluster_compute["max_size"]
    min_size     = var.cluster_compute["min_size"]
  }

  disk_size      = 10
  instance_types = [var.cluster_compute["instance_types"]]

  remote_access {
    ec2_ssh_key = var.cluster_compute["ec2_ssh_key"]
  }
}

#In order to use this resource, you should have AWSCLI & kubectl installed on the machine where terraform client installed
resource "null_resource" "health_check_cluster" {
  depends_on = [
    aws_eks_node_group.node_group
  ]
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.cluster_name} && kubectl get nodes"
  }
}
module "eks_cluster_role" {
    source = "../../../modules/iam"

    role_name = var.cluster_role_name

    assume_role_policy = var.cluster_assume_role_policy

    manages_policy_arns = var.cluster_manages_policy_arns
}

module "eks_node_role" {
    source = "../../../modules/iam"

    role_name = var.node_role_name

    assume_role_policy = var.node_assume_role_policy

    manages_policy_arns = var.node_manages_policy_arns
}
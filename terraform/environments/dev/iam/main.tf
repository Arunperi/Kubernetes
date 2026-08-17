module "eks_cluster_role" {
    source = "../../../modules/iam"

    role_name = var.cluster_role_name

    assume_role_policy = var.cluster_assume_role_policy

    manages_policy_arns = var.cluster_manages_policy_arns
}
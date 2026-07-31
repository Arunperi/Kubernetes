module "ecr_backend" {
    source = "../../../modules/ecr"
    name = var.backend_repo_name
    image_tag_mutability = var.image_tag_mutability
}

module "ecr_frontend" {
    source = "../../../modules/ecr"
    name = var.frontend_repo_name
    image_tag_mutability = var.image_tag_mutability
}
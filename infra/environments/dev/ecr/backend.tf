terraform {
  backend "s3" {
    bucket = "dev-tfstate-files-32343"
    key    = "ecr/terraform.tfstate"
    region = "us-east-1"
    encrypt = true

    # requires Terraform >= 1.10 and AWS provider >= 5.0
    use_lockfile = true
  }
}

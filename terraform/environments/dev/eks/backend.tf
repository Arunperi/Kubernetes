terraform {
  backend "s3" {
    bucket       = "dev-tfstate-files-251119972"
    key          = "eks/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

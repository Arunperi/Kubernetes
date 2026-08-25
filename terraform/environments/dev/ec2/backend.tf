terraform {
  backend "s3" {
    bucket       = "dev-tfstate-files-251119971"
    key          = "ec2/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

terraform {
  backend "s3" {
    bucket       = "dev-tfstate-files-25111998"
    key          = "ec2/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

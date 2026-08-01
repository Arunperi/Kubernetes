terraform {
  backend "s3" {
    bucket = var.bucket_name
    key    = var.key
    region = var.aws_region
    encrypt = true

    # requires Terraform >= 1.10 and AWS provider >= 5.0
    use_lockfile = true
  }
}

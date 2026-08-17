terraform {
    backend "s3" {
        bucket = "dev-tfstate-files-25111997"
        key = "iam/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        use_lockfile = true
    }
}
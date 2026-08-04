terraform{
    backend "s3"{
        bucket = "dev-tfstate-files-32343"
        key = "vpc/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        use_lockfile = true
    }
}
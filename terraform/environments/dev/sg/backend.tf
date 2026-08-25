terraform{
    backend "s3"{
        bucket = "dev-tfstate-files-251119971"
        key = "sg/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        use_lockfile = true
    }
}
terraform {
    backend "s3" {
        bucket = "terraformstatefiles1991"
        key    = "wego-ecr.tfstate"
        profile = "personal"
        region = "us-east-1"
    }
}
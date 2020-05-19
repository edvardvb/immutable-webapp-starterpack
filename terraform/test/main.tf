provider "aws" {
    version = "~> 2.0"
    region = "eu-north-1"
}

resource "aws_s3_bucket" "asset_bucket" {
    bucket = "bekk-tf-assets"
    tags = {
        Managed = "Terraform"
        Usage = "Assets"
    }
}

resource "aws_s3_bucket" "host_bucket" {
    bucket = "bekk-tf-host"
    tags = {
        Managed = "Terraform"
        Usage = "Host"
    }
}

resource "aws_s3_bucket_policy" "asset_policy" {
    bucket = aws_s3_bucket.asset_bucket.id
    policy = templatefile("${path.module}/policy/public_bucket.json.tpl", { bucket_arn = aws_s3_bucket.asset_bucket.arn})
}

resource "aws_s3_bucket_policy" "host_policy" {
    bucket = aws_s3_bucket.host_bucket.id
    policy = templatefile("${path.module}/policy/public_bucket.json.tpl", { bucket_arn = aws_s3_bucket.host_bucket.arn})
}
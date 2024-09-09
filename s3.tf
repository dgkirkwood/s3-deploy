resource "aws_s3_bucket" "backups" {
  bucket = "dk-mongo-backups-dec"
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.backups.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.backups.id

  block_public_acls       = false
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_acl" "public-read" {
  depends_on = [     
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example, ]
  bucket = aws_s3_bucket.backups.id
  acl = "private"
}

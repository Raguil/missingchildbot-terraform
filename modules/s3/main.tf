data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "b" {
  bucket = "${var.emailbucket}"
}

resource "aws_s3_bucket_public_access_block" "b" {
  bucket = "${var.emailbucket}"

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "b" {
  bucket = "${aws_s3_bucket.b.id}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowSESPuts",
            "Effect": "Allow",
            "Principal": {
                "Service": "ses.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${var.emailbucket}/*",
            "Condition": {
                "StringEquals": {
                    "aws:Referer": "${data.aws_caller_identity.current.account_id}"
                }
            }
        }
    ]
}
POLICY
}

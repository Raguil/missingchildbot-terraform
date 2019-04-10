resource "aws_ses_domain_identity" "domain" {
  domain = "${var.domain}"
}

resource "aws_route53_record" "domain_amazonses_verification_record" {
  zone_id = "${var.zone}"
  name    = "_amazonses.${var.domain}"
  type    = "TXT"
  ttl     = "600"
  records = ["${aws_ses_domain_identity.domain.verification_token}"]
}

resource "aws_ses_domain_identity_verification" "domain_verification" {
  domain = "${var.domain}"

  depends_on = ["aws_route53_record.domain_amazonses_verification_record"]
}

resource "aws_ses_receipt_rule_set" "main" {
  rule_set_name = "missingchildbot-zipcodes"
  depends_on = ["aws_ses_domain_identity_verification.domain_verification"]
}

resource "aws_ses_active_receipt_rule_set" "main" {
  rule_set_name = "missingchildbot-zipcodes"
  depends_on = ["aws_ses_receipt_rule_set.main"]
}

resource "aws_ses_receipt_rule" "store" {
  count = "${length(var.zipcodes)}"
  name          = "store"
  rule_set_name = "missingchildbot-zipcodes"
  recipients    = ["${var.zipcodes[count.index]}@${var.domain}"]
  enabled       = true
  scan_enabled  = true
s3_action { bucket_name = "${var.emailbucket}"
    position    = "${count.index + 1}"
    object_key_prefix = "${var.zipcodes[count.index]}"
  }
  depends_on = ["aws_ses_domain_identity_verification.domain_verification", "aws_ses_active_receipt_rule_set.main"]
}

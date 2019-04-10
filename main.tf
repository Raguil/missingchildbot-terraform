provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region  = "${var.region}"
}

module "s3" {
	source = "./modules/s3"
	emailbucket = "${var.emailbucket}"
}

module "ses" {
	source = "./modules/ses"
	emailbucket = "${var.emailbucket}"
	domain = "${var.domain}"
	zone = "${var.zone}"
	zipcodes = "${var.zipcodes}"
}

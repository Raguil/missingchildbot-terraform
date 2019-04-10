variable "domain" {
	type = "string"
	description = "The domain used to receive e-mails from LexisNexis's ADAM program."
}

variable "zone" {
	type = "string"
	description = "The zone that the domain belongs to."
}

variable "zipcodes" {
	type = "list"
	description = "A list of zip codes to create receipt rules for in SES."
}

variable "emailbucket" {
	type = "string"
	default = "missingchildbot"
	description = "The bucket used to temporarily store e-mails sent by LexisNexis on behalf of the NCMEC."
}

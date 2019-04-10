# Terraform Modules for the NCMEC Missing Child Bot Reddit Poster Script

The [Python script behind missingchildbot](https://github.com/Raguil/missingchildbot-poster) relies upon an S3 bucket, a Route53 domain (manually registered because [bureaucracy](https://en.wikipedia.org/wiki/ICANN)) and a number of SES rules that create e-mail addresses for different zip codes that deposit their incoming messages into the S3 bucket.  The AWS credentials used should have be able to create buckets, apply policies, and create SES rules.

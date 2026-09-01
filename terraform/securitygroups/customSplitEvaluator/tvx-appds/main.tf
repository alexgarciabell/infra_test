terraform {
  backend "s3" {
    bucket = "frs-terraform-security-groups"
    key    = "cseval/prod/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-cseval-east" {
  source                      = "us_east_1"
  AWS_N_Virginia              = "${var.AWS_N_Virginia}"
  AWS_Ohio                    = "${var.AWS_Ohio}"
  AWS_Oregon                  = "${var.AWS_Oregon}"
  xQube                       = "${var.xQube}"
  Overcast                    = "${var.Overcast}"
}

module "prod-cseval-ohio" {
  source                      = "us_east_2"
  AWS_N_Virginia              = "${var.AWS_N_Virginia}"
  AWS_Ohio                    = "${var.AWS_Ohio}"
  AWS_Oregon                  = "${var.AWS_Oregon}"
  xQube                       = "${var.xQube}"
  Overcast                    = "${var.Overcast}"
}

module "prod-cseval-west" {
  source                      = "us_west_2"
  AWS_N_Virginia              = "${var.AWS_N_Virginia}"
  AWS_Ohio                    = "${var.AWS_Ohio}"
  AWS_Oregon                  = "${var.AWS_Oregon}"
  xQube                       = "${var.xQube}"
  Overcast                    = "${var.Overcast}"
}

terraform {
  backend "s3" {
    bucket = "frs-terraform-security-groups-tvx-do"
    key    = "cseval/ci/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-cseval-east" {
  source                      = "us_east_1"
  AWS_N_Virginia              = "${var.AWS_N_Virginia}"
  AWS_Oregon                  = "${var.AWS_Oregon}"
  xQube                       = "${var.xQube}"
  Overcast                    = "${var.Overcast}"
  Localhost                   = "${var.Localhost}"
}

module "ci-cseval-west" {
  source                      = "us_west_2"
  AWS_N_Virginia              = "${var.AWS_N_Virginia}"
  AWS_Oregon                  = "${var.AWS_Oregon}"
  xQube                       = "${var.xQube}"
  Overcast                    = "${var.Overcast}"
  Localhost                   = "${var.Localhost}"
}

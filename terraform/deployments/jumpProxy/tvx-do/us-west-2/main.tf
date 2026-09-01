terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/jumpProxy/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-west-adsds" {
  source                      = "../../../../modules/jumpProxy"
  instance_type               = "m5.large"
  security_groups             = ["sg-d8da89a5", "sg-f57d2d91"]
  aws_region                  = "us-west-2"
  single_subnet_instance_count = 1
  user_data                   = "${file("userdata_west")}"
  vpc_id                      = "vpc-ffc0399a"
  subnet_id                   = "subnet-66fb3103"
  domain                      = "do.xcal.tv"
  key_pair                    = "coast-master-key-dev"
  data_center                 = "aw"
}

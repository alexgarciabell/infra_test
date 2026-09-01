terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/jumpProxy/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-east-adsds" {
  source                      = "../../../../modules/jumpProxy"
  instance_type               = "m5.large"
  security_groups             = ["sg-74b49806", "sg-88b78bed"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 1
  user_data                   = "${file("userdata_east")}"
  vpc_id                      = "vpc-0cb21169"
  subnet_id                   = "subnet-e42182bd"
  domain                      = "do.xcal.tv"
  key_pair                    = "coast-master-key-dev"
  data_center                 = "ae"
}


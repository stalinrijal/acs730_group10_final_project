
# Module to deploy basic networking 
module "vpc-prod" {
  source              = "../../prodNetworkModule"
  env                 = var.env
  vpc_cidr            = var.vpc_cidr
  prefix              = var.prefix
  default_tags        = var.default_tags
}

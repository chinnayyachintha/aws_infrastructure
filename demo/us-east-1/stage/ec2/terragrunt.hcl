terraform {
  source = "${find_in_parent_folders("modules")}/ec2"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vpc" {
    config_path = "${get_terragrunt_dir()}/../vpc"
}

dependency "security_group" {
  config_path = "${get_terragrunt_dir()}/../security-group"
}

dependency "key_pair" {
  config_path = "${get_terragrunt_dir()}/../key-pair"
}

inputs = {
  name            = "KodeKloud-${include.root.locals.account_vars.locals.account_name}-${include.root.locals.region_vars.locals.aws_region}-${include.root.locals.env_vars.locals.env}-instance"
  ami             = "ami-05b10e08d247fb927"
  key_name        = dependency.key_pair.outputs.key_pair_name
  subnet_id       = dependency.vpc.outputs.public_subnets[0]
  security_groups = [dependency.security_group.outputs.security_group_id]
}
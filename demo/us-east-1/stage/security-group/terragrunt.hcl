terraform {
    source = "tfr:///terraform-aws-modules/security-group/aws//?version=5.1.2"
}

include "root" {
    path = find_in_parent_folders()
    expose = true
}

dependency "vpc" {
    config_path = "${get_terragrunt_dir()}/../vpc"
}

inputs = {
    name = "KodeKloud-${include.root.locals.account_vars.locals.account_name}-${include.root.locals.region_vars.locals.aws_region}-${include.root.locals.env_vars.locals.env}-security-group"
    vpc_id = dependency.vpc.outputs.vpc_id
}
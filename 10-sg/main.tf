module "sg" {
  count = length(var.sg_names)
  source = "git::https://github.com/daws-86s/terraform-aws-sg.git?ref=main"
  project_name = var.project_name
  environment = var.environment
  sg_name = var.sg_names[count.index]
  sg_description = "Created for ${var.sg_names[count.index]}"
  # vpc_id = local.vpc_id
  vpc_id = "vpc-0f960169016e45e06"
}



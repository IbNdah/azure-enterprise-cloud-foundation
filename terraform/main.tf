module "management" {

  source = "./platform/management"

  environment = var.environment
  location    = var.location

  tags = {
    Project      = "Azure Enterprise Cloud Foundation"
    ManagedBy    = "Terraform"
    BusinessUnit = "OneCloud"
    Department   = "IT"
  }

}

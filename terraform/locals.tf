locals {
  organization  = "Mandara Global"
  project       = "Azure Enterprise Cloud Foundation"
  business_unit = "OneCloud"
  department    = "IT"
  managed_by    = "Terraform"

  common_tags = {
    Project      = local.project
    ManagedBy    = local.managed_by
    BusinessUnit = local.business_unit
    Department   = local.department
  }
}

locals {

  organization  = "Mandara Global"
  project       = "Azure Enterprise Cloud Foundation"
  business_unit = "OneCloud"
  department    = "IT"
  managed_by    = "Terraform"

  common_tags = {
    Organization = local.organization
    Project      = local.project
    BusinessUnit = local.business_unit
    Department   = local.department
    ManagedBy    = local.managed_by
  }

}

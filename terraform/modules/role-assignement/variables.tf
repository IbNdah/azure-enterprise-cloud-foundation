variable "principal_id" {
  description = "Microsoft Entra ID object ID of the principal receiving the role assignment."
  type        = string

  validation {
    condition     = trimspace(var.principal_id) != ""
    error_message = "principal_id must not be empty."
  }
}

variable "role" {
  description = "Azure RBAC role to assign."
  type        = string

  validation {
    condition     = trimspace(var.role) != ""
    error_message = "role must not be empty."
  }
}

variable "scope" {
  description = "Azure resource scope for the role assignment."
  type        = string

  validation {
    condition     = trimspace(var.scope) != ""
    error_message = "scope must not be empty."
  }
}

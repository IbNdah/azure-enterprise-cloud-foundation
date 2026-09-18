variable "name" {
  description = "Name of the Azure Policy Initiative."
  type        = string
}

variable "display_name" {
  description = "Display name of the Azure Policy Initiative."
  type        = string
}

variable "description" {
  description = "Description of the Azure Policy Initiative."
  type        = string
}

variable "parameters" {
  description = "JSON encoded parameters for the Policy Initiative."
  type        = string
  default     = null
}

variable "policy_definitions" {
  description = "Policy definitions referenced by the initiative."

  type = map(object({
    policy_definition_id = string
    parameter_values     = optional(string)
  }))
}

variable "assignment_name" {
  description = "Name of the subscription policy assignment."
  type        = string
}

variable "assignment_display_name" {
  description = "Display name of the subscription policy assignment."
  type        = string
}

variable "assignment_description" {
  description = "Description of the subscription policy assignment."
  type        = string
  default     = null
}

variable "subscription_id" {
  description = "Subscription ID where the initiative is assigned."
  type        = string
}

variable "assignment_parameters" {
  description = "JSON encoded parameters for the policy assignment."
  type        = string
  default     = null
}

variable "location" {
  description = "Azure region used for the policy assignment managed identity."
  type        = string
}

##################################################
# Policy Definition Variables
##################################################
variable "name" {
  description = "Custom Azure Policy definition name."
  type        = string
}

variable "display_name" {
  description = "Azure Policy display name."
  type        = string
}

variable "description" {
  description = "Azure Policy description."
  type        = string
}

variable "policy_rule" {
  description = "Azure Policy rule definition."
  type        = string
}

variable "parameters" {
  description = "Azure Policy parameters."
  type        = string
  default     = null
}

##################################################
# Policy Assignment Variables
##################################################
variable "assignment_name" {
  description = "Azure Policy assignment name."
  type        = string
}

variable "assignment_display_name" {
  description = "Azure Policy assignment display name."
  type        = string
}

variable "subscription_id" {
  description = "Subscription ID for the policy assignment."
  type        = string
}

variable "assignment_parameters" {
  description = "Policy assignment parameters."
  type        = string
  default     = null
}

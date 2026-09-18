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


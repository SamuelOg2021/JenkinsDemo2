variable "TEAMNAME" {
  description = " Team name"
  default  = "TBD"

}
variable "APP_SERVICE_PLAN_NAME" {
  description = "APP Service Plan name"
  type  = string

}

variable "APP_SERVICE_NAME" {
  description = "APP Service Plan name"
  type  = string
}

variable "RESOURCE_GROUP" {
  description = "Resource Group name"
  type  = string
}

variable "PLAN_TIER" {
  description = "Type of App Service Plan"
  type  = string
}

variable "PLAN_SIZE" {
  description = "Size of App Service Plan"
  type  = string
}
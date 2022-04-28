variable "app_name" {
  type        = string
  description = "This variable defines the application name used to build resources.  It must be unique on Azure."

}

variable "app_port" {
  type        = string
  description = "Port used by the web app"
  default     = "80"
}

variable "docker_image" {
  type        = string
  description = "Docker image name to deploy in the app service"
  default = "ubuntu"
}

variable "docker_image_tag" {
  type        = string
  description = "Docker image tag to deploy"
  default     = "latest"
}

variable "environment" {
  type        = string
  description = "This variable defines the environment to be built"
  default     = "dev"
}

variable "location" {
  type        = string
  description = "Azure region where the resource group will be created"
  default     = "eastus"
}

variable "owner" {
  type        = string
  description = "Specify the owner of the resource"
  default = "Oladele"
}

variable "description" {
  type        = string
  description = "Provide a description of the resource"
  default = "Linux Docker container app"
}

variable "subscriptionID" {
    type = string
    description = "this is for our resource group"
    default = "41b34c4a-d10a-4827-9b78-99d1384d5edb"
}

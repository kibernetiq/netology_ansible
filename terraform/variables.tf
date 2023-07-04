###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "xtoken" {
  type        = string
  description = "IAM-token; https://cloud.yandex.ru/docs/iam/operations/iam-token/create"
}

variable "vm_web_yandex_compute_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "https://cloud.yandex.ru/docs/cli/cli-ref/managed-services/compute/image/"
}

variable "vm_web_yandex_compute_instance_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "https://cloud.yandex.com/en/docs/cli/cli-ref/managed-services/compute/instance/"
}

###ssh vars
variable "vms_ssh_root_key" {
  type        = string
  description = "ssh-key"
}

variable "resources_map" {
  type        = map
  default     = {
    vm_web_resources = {
      cores          = 2
      memory         = 1
      core_fraction  = 5
    }
    vm_db_resources = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}

variable "metadata_map" {
  type = map
  default     = {
    metadata = {
      serial-port-enable = 1
      ssh-keys           = ""
    }
  }
}

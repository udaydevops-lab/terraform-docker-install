variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Project = "expense"
    Environment = "dev"
    Terraform = "true"
  }
}

variable "security_group_ids" {
  type        = list(string)
  default     = ["sg-031cee00d0e73d740"]
  description = "List of security group IDs"
}
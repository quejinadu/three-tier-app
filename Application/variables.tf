variable "all_tags" {
  description = "tags from origin"
  default = {
    ApplicationID          = "Infrastructure"
    MicroserviceID         = "Devops"
    Team                   = "Infra Team"
    Environment            = "Dev"
    TechnicalOwner         = "sre@cint.com"
    DataClassification     = "Internal"
    TechnicalSecurityOwner = "security@cint.com"
  }
}

variable "alb_name" {
  description = "ALB Name"
  type        = string
  default = "Cint-ALB"
}

variable "cint_app_count_min" {
  description = "Minimum Number of Instances"
  type        = number
  default     = 2
}

variable "cint_app_count_max" {
  description = "Maximum Number of Instances"
  type        = number
  default     = 3
}

variable "cint_app_count_des" {
  description = "Desired Number of Instances"
  type        = number
  default     = 2
}

variable "sg_name" {
  description = "ASG Security Group Name"
  type        = string
  default = "Cint-ALB-SG"
}

variable "appsg_name" {
  description = "ALB Security Group Name"
  type        = string
  default = "Cint-App-SG"
}

variable "dbsg_name" {
  description = "DB Security Group Name"
  type        = string
  default = "Cint-DB-SG"
}

variable "target_group" {
  description = "Name of target Group"
  type        = string
  default = "Cint-App"
}

variable "allocated_storage" {
  description = "Allocated Storage for DB"
  type        = number
  default = "64"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default = "db.t3.micro"
}

variable "instance_type" {
  description = "The instance type of the RDS instance"
  type        = string
  default = "t2.nano"
}

variable "volume_type" {
  description = "The type of volume for Instance"
  type        = string
  default = "gp3"
}

variable "volume_size" {
  description = "The size of volume for Instance"
  type        = string
  default = "100"
}

variable "admin_username" {
  description = "Admin Username of DB"
  type        = string
  default = "cintuser"
  sensitive = true
}

variable "app_port" {
  type    = number
  default = 80
}

variable "db_subnet" {
  type        = string
  description = "Database Subnet Group Name"
  default = "cintdb-subnet"
}

variable "engine" {
  type        = string
  description = "Database Engine"
  default = "postgres"
}

variable "engine_version" {
  type        = number
  description = "Database Engine type"
  default = "13.7"
}
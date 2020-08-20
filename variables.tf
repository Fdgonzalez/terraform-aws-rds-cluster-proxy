variable "stage" {
  type        = string
  description = "The deployment stage"
}
variable "region" {
  type        = string
  description = "The deployment region"
}

variable "private_subnets" {
  description = "Private subnet IDs"
  type = list(string)
}

variable "db_secret_arn" {
  type        = string
  description = "ARN of a secret containing the database's credentials"
}

variable "db_cluster_identifier" {
  type        = string
  description = "Database cluster identifier"
}

variable "db_security_group" {
  type        = string
  description = "A security group that allows access on the database's ports and has access to the database"
}

variable "engine_family" {
  type        = string
  description = "Database engine family (POSTGRESQL or MYSQL)"
}

variable "connection_borrow_timeout" {
  default = 120
  type = number
  description = "RDS Proxy parameter"
}

variable "max_idle_connections_percent" {
  default = 11
  type = number
  description = "RDS Proxy parameter"
}

variable "max_connections_percent" {
  default = 12
  type = number
  description = "RDS Proxy parameter"
}
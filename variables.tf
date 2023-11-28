variable "name" {
  description = "cluster name"
  default     = "kind"
}
variable "domain" {
  description = "domain name"
  type        = string
}
variable "enabled_ingress" {
  description = "enabled ingress"
  type        = bool
  default     = true
}
variable "enabled_loki_stack" {
  description = "enabled loki-stack"
  type        = bool
  default     = false
}
variable "ingress_class_name" {
  description = "ingress class name"
  type        = string
}
variable "storage_class_name" {
  description = "storage class name"
  type        = string
}
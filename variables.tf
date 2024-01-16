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
variable "ingress_class_name" {
  description = "ingress class name"
  type        = string
}
variable "name" {
  description = "cluster name"
  default     = "kind"
}
variable "enabled_ingress" {
  description = "enabled ingress"
  type        = bool
  default     = true
}
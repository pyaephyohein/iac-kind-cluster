resource "helm_release" "rancher" {
#   count            = var.enabled_ingress ? 1 : 0
  name             = "rancher"
  repository       = "https://releases.rancher.com/server-charts/stable"
  chart            = "rancher"
  version          = "2"
  namespace        = "cattle-system"
  wait             = false
  create_namespace = true
  set {
    name = "hostname"
    value = "rancher.${var.domain}"
  }
  set {
    name = "bootstrapPassword"
    value = "admin"
  }
#   set {
#     name = "ingress.tls.source"
#     value =  "letsEncrypt"
#   }
#   set {
#     name = "letsEncrypt.email"
#     value = "${var.letsencrypt-email}"
#   }
#   set {
#     name = "letsEncrypt.ingress.class"
#     value = "nginx"
#   }
#   set {
#     name = "letsEncrypt.environment"
#     value = "${var.letsencrypt-env}"
#   }
}

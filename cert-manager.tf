resource "helm_release" "cert-manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.13.2"
  namespace        = "cert-manager"
  timeout          = 300
  create_namespace = true
  set {
    name  = "installCRDs"
    value = "true"
  }
}
resource "helm_release" "istio_base" {
  count            = var.enabled_istio ? 1 : 0
  name             = "istio-base"
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "base"
  version          = "1.20.0"
  namespace        = "istio-system"
  wait             = false
  create_namespace = true
  values = [
    templatefile("${path.module}/templates/istio-base.yaml.tpl", {
    })
  ]
}

resource "helm_release" "istio_istiod" {
  count            = var.enabled_istio ? 1 : 0
  name             = "istiod"
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "istiod"
  version          = "1.20.0"
  namespace        = "istio-system"
  wait             = false
  create_namespace = true
  values = [
    templatefile("${path.module}/templates/istiod.yaml.tpl", {
    })
  ]
}

resource "helm_release" "kiali_operator" {
  count            = var.enabled_istio ? 1 : 0
  name             = "kiali-operator"
  repository       = "https://kiali.org/helm-charts"
  chart            = "kiali-operator"
  version          = "1.77.0"
  namespace        = "kiali-operator"
  wait             = false
  create_namespace = true
  values = [
    templatefile("${path.module}/templates/kiali-operator.yaml.tpl", {
    })
  ]
}

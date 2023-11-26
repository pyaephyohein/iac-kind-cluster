resource "helm_release" "grafana" {
  count            = var.enabled_grafana ? 1 : 0
  name             = "grafana"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "grafana"
  version          = "9.6.3"
  namespace        = "monitoring"
  wait             = false
  create_namespace = true
  values = [
    templatefile("${path.module}/templates/values-grafana.yaml.tpl", {
      host_name          = "grafana.${var.domain}"
      ingress_class_name = "${var.ingress_class_name}"
    })
  ]
}


resource "helm_release" "prometheus" {
  count            = var.enabled_prometheus ? 1 : 0
  name             = "prometheus"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "prometheus"
  version          = "0.4.5"
  namespace        = "monitoring"
  wait             = false
  create_namespace = true
  values = [
    templatefile("${path.module}/templates/values-prometheus.yaml.tpl", {
      host_name          = "prometheus.${var.domain}"
      ingress_class_name = "${var.ingress_class_name}"
    })
  ]
}
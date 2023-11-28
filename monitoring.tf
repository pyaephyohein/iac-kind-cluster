resource "helm_release" "loki-stack" {
  count            = var.enabled_loki_stack ? 1 : 0
  name             = "loki-stack"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "loki-stack"
  version          = "2.9.11"
  namespace        = "monitoring"
  force_update     = true
  create_namespace = true

  values = [
    templatefile("${path.module}/templates/values-loki-stack.yaml.tpl", {
      host               = "grafana.${var.domain}"
      domain             = "${var.domain}"
      ingress_class_name = "${var.ingress_class_name}"
      storage_class_name = "${var.storage_class_name}"
    })
  ]
}

resource "kubernetes_config_map" "grafana-dashboards" {
  for_each = fileset("${path.module}/grafana-dashboards", "*.json")
  metadata {
    name      = substr("grafana-dashboard-${trimsuffix(lower(each.value), ".json")}", 0, 63)
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "1"
    }
  }
  data = {
    "${each.value}" = file("${path.module}/grafana-dashboards/${each.value}")
  }
  depends_on = [helm_release.loki-stack]
}
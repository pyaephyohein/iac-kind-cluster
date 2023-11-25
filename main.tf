resource "kind_cluster" "default" {
  name           = "${var.name}-cluster"
  node_image     = "kindest/node:v1.27.1"
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"

      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
      ]

      extra_port_mappings {
        container_port = 80
        host_port      = 80
      }
      extra_port_mappings {
        container_port = 443
        host_port      = 443
      }
    }

    node {
      role = "worker"
    }
  }
}
resource "helm_release" "nginx-ingress-controller" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.6.1"
  namespace        = "ingress-nginx"
  wait             = false
  create_namespace = true
  values = [
    templatefile("${path.module}/templates/values-ingress.yaml.tpl", {
    })
  ]
}
# Kind - https://kind.sigs.k8s.io/docs/user/ingress/
controller:
  updateStrategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
  hostPort:
    enabled: true
  terminationGracePeriodSeconds: 0
  service:
    type: NodePort
  watchIngressWithoutClass: true
  allowSnippetAnnotations: true

  nodeSelector:
    ingress-ready: "true"
  tolerations:
    - key: "node-role.kubernetes.io/master"
      operator: "Equal"
      effect: "NoSchedule"
    - key: "node-role.kubernetes.io/control-plane"
      operator: "Equal"
      effect: "NoSchedule"

  publishService:
    enabled: false
  extraArgs:
    publish-status-address: localhost
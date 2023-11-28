grafana:
  enabled: true
  image:
    repository: grafana/grafana
    tag: 8.4.2
  grafana.ini:
    unified_alerting:
      enabled: false
    alerting:
      enabled: true
    server:
      domain: ${domain}
      root_url: https://${host}
  datasources:
    datasources.yaml:
      apiVersion: 1
      datasources:
      - name: Prometheus
        type: prometheus
        url: http://loki-stack-prometheus-server
        access: proxy
        isDefault: true
  sidecar:
    dashboards:
      enabled: true
      label: grafana_dashboard
      searchNamespace: monitoring
  ingress:
    enabled: true
    annotations:
      cert-manager.io/cluster-issuer: letsencrypt
      kubernetes.io/ingress.class: ${ingress_class_name}
    hosts: 
      - ${host}
    tls:
      - hosts:
        - ${host}
  persistence:
    enabled: true
    storageClassName: ${storage_class_name}
    size: 10Gi
prometheus:
  enabled: true
  alertmanager:
    persistentVolume:
      enabled: false
  server:
    persistentVolume:
      enabled: true
      storageClass: ${storage_class_name}
      size: 10Gi
loki:
  isDefault: false
  persistence:
    enabled: true
    storageClassName: ${storage_class_name}
    size: 10Gi
  config:
    table_manager:
      retention_deletes_enabled: true
      retention_period: 72h

promtail:
  enabled: false
  config:
    logLevel: info
    serverPort: 3101
    clients:
      - url: http://{{ .Release.Name }}:3100/loki/api/v1/push
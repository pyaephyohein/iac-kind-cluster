# Copyright VMware, Inc.
# SPDX-License-Identifier: APACHE-2.0

## @section Global parameters
## Global Docker image parameters
## Please, note that this will override the image parameters, including dependencies, configured to use the global value
## Current available global Docker image parameters: imageRegistry, imagePullSecrets and storageClass
##

## @param global.imageRegistry Global Docker image registry
## @param global.imagePullSecrets Global Docker registry secret names as an array
## @param global.storageClass Global StorageClass for Persistent Volume(s)
##
global:
  imageRegistry: ""
  ## E.g.
  ## imagePullSecrets:
  ##   - myRegistryKeySecretName
  ##
  imagePullSecrets: []
  storageClass: ""

## @section Common parameters
##

## @param kubeVersion Override Kubernetes version
##
kubeVersion: ""
## @param nameOverride String to partially override common.names.name
##
nameOverride: ""
## @param fullnameOverride String to fully override common.names.fullname
##
fullnameOverride: ""
## @param namespaceOverride String to fully override common.names.namespace
##
namespaceOverride: ""
## @param commonLabels Labels to add to all deployed objects
##
commonLabels: {}
## @param commonAnnotations Annotations to add to all deployed objects
##
commonAnnotations: {}
## @param clusterDomain Kubernetes cluster domain name
##
clusterDomain: cluster.local
## @param extraDeploy Array of extra objects to deploy with the release
##
extraDeploy: []

## Enable diagnostic mode in the deployment
##
diagnosticMode:
  ## @param diagnosticMode.enabled Enable diagnostic mode (all probes will be disabled and the command will be overridden)
  ##
  enabled: false
  ## @param diagnosticMode.command Command to override all containers in the deployment
  ##
  command:
    - sleep
  ## @param diagnosticMode.args Args to override all containers in the deployment
  ##
  args:
    - infinity
## @param ingress.apiVersion Force Ingress API version (automatically detected if not set)
##
ingress:
  apiVersion: ""

## @section Alertmanager Parameters
##
## Bitnami Alertmanager image
## ref: https://hub.docker.com/r/bitnami/alertmanager/tags/
## @param alertmanager.enabled Alertmanager enabled
## @param alertmanager.image.registry [default: REGISTRY_NAME] Alertmanager image registry
## @param alertmanager.image.repository [default: REPOSITORY_NAME/alertmanager] Alertmanager image repository
## @skip alertmanager.image.tag Alertmanager image tag (immutable tags are recommended)
## @param alertmanager.image.digest Alertmanager image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag image tag (immutable tags are recommended)
## @param alertmanager.image.pullPolicy Alertmanager image pull policy
## @param alertmanager.image.pullSecrets Alertmanager image pull secrets
##
alertmanager:
  enabled: true
  image:
    registry: docker.io
    repository: bitnami/alertmanager
    tag: 0.26.0-debian-11-r44
    digest: ""
    ## Specify a imagePullPolicy
    ## Defaults to 'Always' if image tag is 'latest', else set to 'IfNotPresent'
    ## ref: http://kubernetes.io/docs/user-guide/images/#pre-pulling-images
    ##
    pullPolicy: IfNotPresent
    ## Optionally specify an array of imagePullSecrets.
    ## Secrets must be manually created in the namespace.
    ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
    ## e.g:
    ## pullSecrets:
    ##   - myRegistryKeySecretName
    ##
    pullSecrets: []

  ## @param alertmanager.configuration [string] Alertmanager configuration. This content will be stored in the the alertmanager.yaml file and the content can be a template.
  ## ref: <https://github.com/prometheus-community/helm-charts/blob/8f2743ed3a9c93c56978a95b62a63e84c52f5748/charts/alertmanager/values.yaml#L171-L188>
  ##
  configuration: |
    receivers:
      - name: default-receiver
    route:
      group_wait: 10s
      group_interval: 5m
      receiver: default-receiver
      repeat_interval: 3h

  ## @param alertmanager.replicaCount Number of Alertmanager replicas to deploy
  ##
  replicaCount: 1
  ## @param alertmanager.containerPorts.http Alertmanager HTTP container port
  ## @param alertmanager.containerPorts.cluster Alertmanager Cluster HA port
  ##
  containerPorts:
    http: 9093
    cluster: 9094
  ## Configure extra options for Alertmanager containers' liveness and readiness probes
  ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#configure-probes
  ## @param alertmanager.livenessProbe.enabled Enable livenessProbe on Alertmanager containers
  ## @param alertmanager.livenessProbe.initialDelaySeconds Initial delay seconds for livenessProbe
  ## @param alertmanager.livenessProbe.periodSeconds Period seconds for livenessProbe
  ## @param alertmanager.livenessProbe.timeoutSeconds Timeout seconds for livenessProbe
  ## @param alertmanager.livenessProbe.failureThreshold Failure threshold for livenessProbe
  ## @param alertmanager.livenessProbe.successThreshold Success threshold for livenessProbe
  ##
  livenessProbe:
    enabled: true
    initialDelaySeconds: 5
    periodSeconds: 20
    timeoutSeconds: 3
    failureThreshold: 3
    successThreshold: 1
  ## @param alertmanager.readinessProbe.enabled Enable readinessProbe on Alertmanager containers
  ## @param alertmanager.readinessProbe.initialDelaySeconds Initial delay seconds for readinessProbe
  ## @param alertmanager.readinessProbe.periodSeconds Period seconds for readinessProbe
  ## @param alertmanager.readinessProbe.timeoutSeconds Timeout seconds for readinessProbe
  ## @param alertmanager.readinessProbe.failureThreshold Failure threshold for readinessProbe
  ## @param alertmanager.readinessProbe.successThreshold Success threshold for readinessProbe
  ##
  readinessProbe:
    enabled: true
    initialDelaySeconds: 5
    periodSeconds: 10
    timeoutSeconds: 2
    failureThreshold: 5
    successThreshold: 1
  ## @param alertmanager.startupProbe.enabled Enable startupProbe on Alertmanager containers
  ## @param alertmanager.startupProbe.initialDelaySeconds Initial delay seconds for startupProbe
  ## @param alertmanager.startupProbe.periodSeconds Period seconds for startupProbe
  ## @param alertmanager.startupProbe.timeoutSeconds Timeout seconds for startupProbe
  ## @param alertmanager.startupProbe.failureThreshold Failure threshold for startupProbe
  ## @param alertmanager.startupProbe.successThreshold Success threshold for startupProbe
  ##
  startupProbe:
    enabled: false
    initialDelaySeconds: 2
    periodSeconds: 5
    timeoutSeconds: 2
    failureThreshold: 10
    successThreshold: 1
  ## @param alertmanager.customLivenessProbe Custom livenessProbe that overrides the default one
  ##
  customLivenessProbe: {}
  ## @param alertmanager.customReadinessProbe Custom readinessProbe that overrides the default one
  ##
  customReadinessProbe: {}
  ## @param alertmanager.customStartupProbe Custom startupProbe that overrides the default one
  ##
  customStartupProbe: {}
  ## Alertmanager resource requests and limits
  ## ref: http://kubernetes.io/docs/user-guide/compute-resources/
  ## @param alertmanager.resources.limits The resources limits for the Alertmanager containers
  ## @param alertmanager.resources.requests The requested resources for the Alertmanager containers
  ##
  resources:
    limits: {}
    requests: {}
  ## Configure Pods Security Context
  ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod
  ## @param alertmanager.podSecurityContext.enabled Enabled Alertmanager pods' Security Context
  ## @param alertmanager.podSecurityContext.fsGroup Set Alertmanager pod's Security Context fsGroup
  ##
  podSecurityContext:
    enabled: true
    fsGroup: 1001
  ## Configure Container Security Context
  ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container
  ## @param alertmanager.containerSecurityContext.enabled Enabled containers' Security Context
  ## @param alertmanager.containerSecurityContext.runAsUser Set containers' Security Context runAsUser
  ## @param alertmanager.containerSecurityContext.runAsNonRoot Set container's Security Context runAsNonRoot
  ## @param alertmanager.containerSecurityContext.privileged Set container's Security Context privileged
  ## @param alertmanager.containerSecurityContext.readOnlyRootFilesystem Set container's Security Context readOnlyRootFilesystem
  ## @param alertmanager.containerSecurityContext.allowPrivilegeEscalation Set container's Security Context allowPrivilegeEscalation
  ## @param alertmanager.containerSecurityContext.capabilities.drop List of capabilities to be dropped
  ## @param alertmanager.containerSecurityContext.seccompProfile.type Set container's Security Context seccomp profile
  ##
  containerSecurityContext:
    enabled: true
    runAsUser: 1001
    runAsNonRoot: true
    privileged: false
    readOnlyRootFilesystem: false
    allowPrivilegeEscalation: false
    capabilities:
      drop: ["ALL"]
    seccompProfile:
      type: "RuntimeDefault"

  ## @param alertmanager.existingConfigmap The name of an existing ConfigMap with your custom configuration for Alertmanager
  ##
  existingConfigmap: ""
  ## @param alertmanager.existingConfigmapKey The name of the key with the Alertmanager config file
  ##
  existingConfigmapKey: ""
  ## @param alertmanager.command Override default container command (useful when using custom images)
  ##
  command: []
  ## @param alertmanager.args Override default container args (useful when using custom images)
  ##
  args: []
  ## @param alertmanager.extraArgs Additional arguments passed to the Prometheus server container
  ## extraArgs:
  ## - --log.level=debug
  ## - --tsdb.path=/data/
  ##
  extraArgs: []
  ## @param alertmanager.hostAliases Alertmanager pods host aliases
  ## https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/
  ##
  hostAliases: []
  ## @param alertmanager.podLabels Extra labels for Alertmanager pods
  ## ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
  ##
  podLabels: {}
  ## @param alertmanager.podAnnotations Annotations for Alertmanager pods
  ## ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/
  ##
  podAnnotations: {}
  ## @param alertmanager.podAffinityPreset Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`
  ## ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity
  ##
  podAffinityPreset: ""
  ## @param alertmanager.podAntiAffinityPreset Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`
  ## ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity
  ##
  podAntiAffinityPreset: soft
  ## Pod Disruption Budget configuration
  ## ref: https://kubernetes.io/docs/tasks/run-application/configure-pdb
  ## @param alertmanager.pdb.create Enable/disable a Pod Disruption Budget creation
  ## @param alertmanager.pdb.minAvailable Minimum number/percentage of pods that should remain scheduled
  ## @param alertmanager.pdb.maxUnavailable Maximum number/percentage of pods that may be made unavailable
  ##
  pdb:
    create: false
    minAvailable: 1
    maxUnavailable: ""

  ## Node affinity preset
  ## ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-affinity
  ##
  nodeAffinityPreset:
    ## @param alertmanager.nodeAffinityPreset.type Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`
    ##
    type: ""
    ## @param alertmanager.nodeAffinityPreset.key Node label key to match. Ignored if `affinity` is set
    ##
    key: ""
    ## @param alertmanager.nodeAffinityPreset.values Node label values to match. Ignored if `affinity` is set
    ## E.g.
    ## values:
    ##   - e2e-az1
    ##   - e2e-az2
    ##
    values: []
  ## @param alertmanager.affinity Affinity for Alertmanager pods assignment
  ## ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity
  ## NOTE: `podAffinityPreset`, `podAntiAffinityPreset`, and `nodeAffinityPreset` will be ignored when it's set
  ##
  affinity: {}
  ## @param alertmanager.nodeSelector Node labels for Alertmanager pods assignment
  ## ref: https://kubernetes.io/docs/user-guide/node-selection/
  ##
  nodeSelector: {}
  ## @param alertmanager.tolerations Tolerations for Alertmanager pods assignment
  ## ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/
  ##
  tolerations: []
  ## @param alertmanager.updateStrategy.type Alertmanager statefulset strategy type
  ## ref: https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#update-strategies
  ##
  updateStrategy:
    ## StrategyType
    ## Can be set to RollingUpdate or OnDelete
    ##
    type: RollingUpdate

  ## @param alertmanager.podManagementPolicy Statefulset Pod management policy, it needs to be Parallel to be able to complete the cluster join
  ## Ref: https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#pod-management-policies
  ##
  podManagementPolicy: OrderedReady
  ## @param alertmanager.priorityClassName Alertmanager pods' priorityClassName
  ##
  priorityClassName: ""
  ## @param alertmanager.topologySpreadConstraints Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template
  ## Ref: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/#spread-constraints-for-pods
  ##
  topologySpreadConstraints: []
  ## @param alertmanager.schedulerName Name of the k8s scheduler (other than default) for Alertmanager pods
  ## ref: https://kubernetes.io/docs/tasks/administer-cluster/configure-multiple-schedulers/
  ##
  schedulerName: ""
  ## @param alertmanager.terminationGracePeriodSeconds Seconds Redmine pod needs to terminate gracefully
  ## ref: https://kubernetes.io/docs/concepts/workloads/pods/pod/#termination-of-pods
  ##
  terminationGracePeriodSeconds: ""
  ## @param alertmanager.lifecycleHooks for the Alertmanager container(s) to automate configuration before or after startup
  ##
  lifecycleHooks: {}
  ## @param alertmanager.extraEnvVars Array with extra environment variables to add to Alertmanager nodes
  ## e.g:
  ## extraEnvVars:
  ##   - name: FOO
  ##     value: "bar"
  ##
  extraEnvVars: []
  ## @param alertmanager.extraEnvVarsCM Name of existing ConfigMap containing extra env vars for Alertmanager nodes
  ##
  extraEnvVarsCM: ""
  ## @param alertmanager.extraEnvVarsSecret Name of existing Secret containing extra env vars for Alertmanager nodes
  ##
  extraEnvVarsSecret: ""
  ## @param alertmanager.extraVolumes Optionally specify extra list of additional volumes for the Alertmanager pod(s)
  ##
  extraVolumes: []
  ## @param alertmanager.extraVolumeMounts Optionally specify extra list of additional volumeMounts for the Alertmanager container(s)
  ##
  extraVolumeMounts: []
  ## @param alertmanager.sidecars Add additional sidecar containers to the Alertmanager pod(s)
  ## e.g:
  ## sidecars:
  ##   - name: your-image-name
  ##     image: your-image
  ##     imagePullPolicy: Always
  ##     ports:
  ##       - name: portname
  ##         containerPort: 1234
  ##
  sidecars: []
  ## @param alertmanager.initContainers Add additional init containers to the Alertmanager pod(s)
  ## ref: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
  ## e.g:
  ## initContainers:
  ##  - name: your-image-name
  ##    image: your-image
  ##    imagePullPolicy: Always
  ##    command: ['sh', '-c', 'echo "hello world"']
  ##
  initContainers: []

  ## Alertmanager ingress parameters
  ## ref: http://kubernetes.io/docs/user-guide/ingress/
  ##
  ingress:
    ## @param alertmanager.ingress.enabled Enable ingress record generation for Alertmanager
    ##
    enabled: false
    ## @param alertmanager.ingress.pathType Ingress path type
    ##
    pathType: ImplementationSpecific

    ## @param alertmanager.ingress.hostname Default host for the ingress record
    ##
    hostname: alertmanager.prometheus.local
    ## @param alertmanager.ingress.ingressClassName IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)
    ## This is supported in Kubernetes 1.18+ and required if you have more than one IngressClass marked as the default for your cluster .
    ## ref: https://kubernetes.io/blog/2020/04/02/improvements-to-the-ingress-api-in-kubernetes-1.18/
    ##
    ingressClassName: ""
    ## @param alertmanager.ingress.path Default path for the ingress record
    ## NOTE: You may need to set this to '/*' in order to use this with ALB ingress controllers
    ##
    path: /
    ## @param alertmanager.ingress.annotations Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations.
    ## Use this parameter to set the required annotations for cert-manager, see
    ## ref: https://cert-manager.io/docs/usage/ingress/#supported-annotations
    ## e.g:
    ## annotations:
    ##   kubernetes.io/ingress.class: nginx
    ##   cert-manager.io/cluster-issuer: cluster-issuer-name
    ##
    annotations: {}
    ## @param alertmanager.ingress.tls Enable TLS configuration for the host defined at `ingress.hostname` parameter
    ## TLS certificates will be retrieved from a TLS secret with name: `{{- printf "%s-tls" .Values.ingress.hostname }}`
    ## You can:
    ##   - Use the `ingress.secrets` parameter to create this TLS secret
    ##   - Rely on cert-manager to create it by setting the corresponding annotations
    ##   - Rely on Helm to create self-signed certificates by setting `ingress.selfSigned=true`
    ##
    tls: false
    ## @param alertmanager.ingress.selfSigned Create a TLS secret for this ingress record using self-signed certificates generated by Helm
    ##
    selfSigned: false
    ## @param alertmanager.ingress.extraHosts An array with additional hostname(s) to be covered with the ingress record
    ## e.g:
    ## extraHosts:
    ##   - name: prometheus.local
    ##     path: /
    ##
    extraHosts: []
    ## @param alertmanager.ingress.extraPaths An array with additional arbitrary paths that may need to be added to the ingress under the main host
    ## e.g:
    ## extraPaths:
    ## - path: /*
    ##   backend:
    ##     serviceName: ssl-redirect
    ##     servicePort: use-annotation
    ##
    extraPaths: []
    ## @param alertmanager.ingress.extraTls TLS configuration for additional hostname(s) to be covered with this ingress record
    ## ref: https://kubernetes.io/docs/concepts/services-networking/ingress/#tls
    ## e.g:
    ## extraTls:
    ## - hosts:
    ##     - prometheus.local
    ##   secretName: prometheus.local-tls
    ##
    extraTls: []
    ## @param alertmanager.ingress.secrets Custom TLS certificates as secrets
    ## NOTE: 'key' and 'certificate' are expected in PEM format
    ## NOTE: 'name' should line up with a 'secretName' set further up
    ## If it is not set and you're using cert-manager, this is unneeded, as it will create a secret for you with valid certificates
    ## If it is not set and you're NOT using cert-manager either, self-signed certificates will be created valid for 365 days
    ## It is also possible to create and manage the certificates outside of this helm chart
    ## Please see README.md for more information
    ## e.g:
    ## secrets:
    ##   - name: prometheus.local-tls
    ##     key: |-
    ##       -----BEGIN RSA PRIVATE KEY-----
    ##       ...
    ##       -----END RSA PRIVATE KEY-----
    ##     certificate: |-
    ##       -----BEGIN CERTIFICATE-----
    ##       ...
    ##       -----END CERTIFICATE-----
    ##
    secrets: []
    ## @param alertmanager.ingress.extraRules Additional rules to be covered with this ingress record
    ## ref: https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-rules
    ## e.g:
    ## extraRules:
    ## - host: example.local
    ##     http:
    ##       path: /
    ##       backend:
    ##         service:
    ##           name: example-svc
    ##           port:
    ##             name: http
    ##
    extraRules: []

  ## ServiceAccount configuration
  ##
  serviceAccount:
    ## @param alertmanager.serviceAccount.create Specifies whether a ServiceAccount should be created
    ##
    create: true
    ## @param alertmanager.serviceAccount.name The name of the ServiceAccount to use.
    ## If not set and create is true, a name is generated using the common.names.fullname template
    ##
    name: ""
    ## @param alertmanager.serviceAccount.annotations Additional Service Account annotations (evaluated as a template)
    ##
    annotations: {}
    ## @param alertmanager.serviceAccount.automountServiceAccountToken Automount service account token for the server service account
    ##
    automountServiceAccountToken: true

  ## Alertmanager service parameters
  ##
  service:
    ## @param alertmanager.service.type Alertmanager service type
    ##
    type: ClusterIP
    ## @param alertmanager.service.ports.http Alertmanager service HTTP port
    ## @param alertmanager.service.ports.cluster Alertmanager cluster HA port
    ##
    ports:
      http: 80
      cluster: 9094
    ## Node ports to expose
    ## @param alertmanager.service.nodePorts.http Node port for HTTP
    ## NOTE: choose port between <30000-32767>
    ##
    nodePorts:
      http: ""
    ## @param alertmanager.service.clusterIP Alertmanager service Cluster IP
    ## e.g.:
    ## clusterIP: None
    ##
    clusterIP: ""
    ## @param alertmanager.service.loadBalancerIP Alertmanager service Load Balancer IP
    ## ref: https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer
    ##
    loadBalancerIP: ""
    ## @param alertmanager.service.loadBalancerClass Alertmanager service Load Balancer class if service type is `LoadBalancer` (optional, cloud specific)
    ## ref: https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer
    ##
    loadBalancerClass: ""
    ## @param alertmanager.service.loadBalancerSourceRanges Alertmanager service Load Balancer sources
    ## ref: https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/#restrict-access-for-loadbalancer-service
    ## e.g:
    ## loadBalancerSourceRanges:
    ##   - 10.10.10.0/24
    ##
    loadBalancerSourceRanges: []
    ## @param alertmanager.service.externalTrafficPolicy Alertmanager service external traffic policy
    ## ref http://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip
    ##
    externalTrafficPolicy: Cluster
    ## @param alertmanager.service.annotations Additional custom annotations for Alertmanager service
    ##
    annotations: {}
    ## @param alertmanager.service.extraPorts Extra ports to expose in Alertmanager service (normally used with the `sidecars` value)
    ##
    extraPorts: []
    ## @param alertmanager.service.sessionAffinity Control where client requests go, to the same pod or round-robin
    ## Values: ClientIP or None
    ## ref: https://kubernetes.io/docs/user-guide/services/
    ##
    sessionAffinity: None
    ## @param alertmanager.service.sessionAffinityConfig Additional settings for the sessionAffinity
    ## sessionAffinityConfig:
    ##   clientIP:
    ##     timeoutSeconds: 300
    ##
    sessionAffinityConfig: {}

  persistence:
    ## @param alertmanager.persistence.enabled Enable Alertmanager data persistence using VolumeClaimTemplates
    ##
    enabled: false
    ## @param alertmanager.persistence.mountPath Path to mount the volume at.
    ##
    mountPath: /bitnami/alertmanager/data
    ## @param alertmanager.persistence.subPath The subdirectory of the volume to mount to, useful in dev environments and one PV for multiple services
    ##
    subPath: ""
    ## @param alertmanager.persistence.storageClass PVC Storage Class for Concourse worker data volume
    ## If defined, storageClassName: <storageClass>
    ## If set to "-", storageClassName: "", which disables dynamic provisioning
    ## If undefined (the default) or set to null, no storageClassName spec is
    ##   set, choosing the default provisioner.  (gp2 on AWS, standard on
    ##   GKE, AWS & OpenStack)
    ##
    storageClass: ""
    ## @param alertmanager.persistence.accessModes PVC Access Mode for Concourse worker volume
    ##
    accessModes:
      - ReadWriteOnce
    ## @param alertmanager.persistence.size PVC Storage Request for Concourse worker volume
    ##
    size: 8Gi
    ## @param alertmanager.persistence.annotations Annotations for the PVC
    ##
    annotations: {}
    ## @param alertmanager.persistence.selector Selector to match an existing Persistent Volume (this value is evaluated as a template)
    ## selector:
    ##   matchLabels:
    ##     app: my-app
    ##
    selector: {}

## @section Prometheus server Parameters
##
## Bitnami Prometheus image
## ref: https://hub.docker.com/r/bitnami/prometheus/tags/
## @param server.image.registry [default: REGISTRY_NAME] Prometheus image registry
## @param server.image.repository [default: REPOSITORY_NAME/prometheus] Prometheus image repository
## @skip server.image.tag Prometheus image tag (immutable tags are recommended)
## @param server.image.digest Prometheus image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag image tag (immutable tags are recommended)
## @param server.image.pullPolicy Prometheus image pull policy
## @param server.image.pullSecrets Prometheus image pull secrets
##
server:
  image:
    registry: docker.io
    repository: bitnami/prometheus
    tag: 2.48.0-debian-11-r0
    digest: ""
    ## Specify a imagePullPolicy
    ## Defaults to 'Always' if image tag is 'latest', else set to 'IfNotPresent'
    ## ref: http://kubernetes.io/docs/user-guide/images/#pre-pulling-images
    ##
    pullPolicy: IfNotPresent
    ## Optionally specify an array of imagePullSecrets.
    ## Secrets must be manually created in the namespace.
    ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
    ## e.g:
    ## pullSecrets:
    ##   - myRegistryKeySecretName
    ##
    pullSecrets: []

  ## @param server.configuration [string] Promethus configuration. This content will be stored in the the prometheus.yaml file and the content can be a template.
  ## ref: <https://github.com/prometheus-community/helm-charts/blob/main/charts/prometheus/values.yaml>
  ##
  configuration: |
    global:
      {{- if .Values.server.scrapeInterval }}
      scrape_interval: {{ .Values.server.scrapeInterval }}
      {{- end }}
      {{- if .Values.server.scrapeTimeout }}
      scrape_timeout: {{ .Values.server.scrapeTimeout }}
      {{- end }}
      {{- if .Values.server.evaluationInterval }}
      evaluation_interval: {{ .Values.server.evaluationInterval }}
      {{- end }}
      external_labels:
        monitor: {{ template "common.names.fullname" . }}
        {{- if .Values.server.externalLabels }}
        {{- include "common.tplvalues.render" (dict "value" .Values.server.externalLabels "context" $) | nindent 4 }}
        {{- end }}
    {{- if .Values.server.remoteWrite }}
    remote_write: {{- include "common.tplvalues.render" (dict "value" .Values.server.remoteWrite "context" $) | nindent 4 }}
    {{- end }}
    scrape_configs:
      - job_name: prometheus
      {{- include "prometheus.scrape_config" (dict "component" "server" "context" $) | nindent 4 }}
    {{- if .Values.alertmanager.enabled }}
      - job_name: alertmanager
        {{- include "prometheus.scrape_config" (dict "component" "alertmanager" "context" $) | nindent 4 }}
    {{- end }}
    {{- if .Values.server.extraScrapeConfigs}}
    {{- include "common.tplvalues.render" (dict "value" .Values.server.extraScrapeConfigs "context" $) | nindent 2 }}
    {{- end }}
    {{- if or .Values.alertmanager.enabled .Values.server.alertingEndpoints}}
    alerting:
      alertmanagers:
        {{- if .Values.server.alertingEndpoints }}
        {{- include "common.tplvalues.render" (dict "value" .Values.server.alertingEndpoints "context" $) | nindent 4 }}
        {{- end }}
        - scheme: HTTP
          static_configs:
            - targets: [ "{{ printf "%s.%s.svc.%s:%d" (include "prometheus.alertmanager.fullname" .) (include "common.names.namespace" .) .Values.clusterDomain (int .Values.alertmanager.service.ports.http) }}" ]
    rule_files:
      - rules.yaml
    {{- end }}


  ## @param server.alertingRules Prometheus alerting rules. This content will be stored in the the rules.yaml file and the content can be a template.
  ## ref: <https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/>
  ##
  alertingRules: {}
  ## @param server.extraScrapeConfigs Promethus configuration, useful to declare new scrape_configs. This content will be merged with the 'server.configuration' value and stored in the the prometheus.yaml file.
  ## ref: <https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config>
  ##
  extraScrapeConfigs: []
  ## @param server.replicaCount Number of Prometheus replicas to deploy
  ##
  replicaCount: 1
  ## @param server.containerPorts.http Prometheus HTTP container port
  ##
  containerPorts:
    http: 9090
  ## Configure extra options for Prometheus containers' liveness and readiness probes
  ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#configure-probes
  ## @param server.livenessProbe.enabled Enable livenessProbe on Prometheus containers
  ## @param server.livenessProbe.initialDelaySeconds Initial delay seconds for livenessProbe
  ## @param server.livenessProbe.periodSeconds Period seconds for livenessProbe
  ## @param server.livenessProbe.timeoutSeconds Timeout seconds for livenessProbe
  ## @param server.livenessProbe.failureThreshold Failure threshold for livenessProbe
  ## @param server.livenessProbe.successThreshold Success threshold for livenessProbe
  ##
  livenessProbe:
    enabled: true
    initialDelaySeconds: 5
    periodSeconds: 20
    timeoutSeconds: 3
    failureThreshold: 3
    successThreshold: 1
  ## @param server.readinessProbe.enabled Enable readinessProbe on Prometheus containers
  ## @param server.readinessProbe.initialDelaySeconds Initial delay seconds for readinessProbe
  ## @param server.readinessProbe.periodSeconds Period seconds for readinessProbe
  ## @param server.readinessProbe.timeoutSeconds Timeout seconds for readinessProbe
  ## @param server.readinessProbe.failureThreshold Failure threshold for readinessProbe
  ## @param server.readinessProbe.successThreshold Success threshold for readinessProbe
  ##
  readinessProbe:
    enabled: true
    initialDelaySeconds: 5
    periodSeconds: 10
    timeoutSeconds: 2
    failureThreshold: 5
    successThreshold: 1
  ## @param server.startupProbe.enabled Enable startupProbe on Prometheus containers
  ## @param server.startupProbe.initialDelaySeconds Initial delay seconds for startupProbe
  ## @param server.startupProbe.periodSeconds Period seconds for startupProbe
  ## @param server.startupProbe.timeoutSeconds Timeout seconds for startupProbe
  ## @param server.startupProbe.failureThreshold Failure threshold for startupProbe
  ## @param server.startupProbe.successThreshold Success threshold for startupProbe
  ##
  startupProbe:
    enabled: false
    initialDelaySeconds: 2
    periodSeconds: 5
    timeoutSeconds: 2
    failureThreshold: 10
    successThreshold: 1
  ## @param server.customLivenessProbe Custom livenessProbe that overrides the default one
  ##
  customLivenessProbe: {}
  ## @param server.customReadinessProbe Custom readinessProbe that overrides the default one
  ##
  customReadinessProbe: {}
  ## @param server.customStartupProbe Custom startupProbe that overrides the default one
  ##
  customStartupProbe: {}
  ## Prometheus resource requests and limits
  ## ref: http://kubernetes.io/docs/user-guide/compute-resources/
  ## @param server.resources.limits The resources limits for the Prometheus containers
  ## @param server.resources.requests The requested resources for the Prometheus containers
  ##
  resources:
    limits: {}
    requests: {}
  ## Configure Pods Security Context
  ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod
  ## @param server.podSecurityContext.enabled Enabled Prometheus pods' Security Context
  ## @param server.podSecurityContext.fsGroup Set Prometheus pod's Security Context fsGroup
  ##
  podSecurityContext:
    enabled: true
    fsGroup: 1001
  ## Configure Container Security Context
  ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container
  ## @param server.containerSecurityContext.enabled Enabled containers' Security Context
  ## @param server.containerSecurityContext.runAsUser Set containers' Security Context runAsUser
  ## @param server.containerSecurityContext.runAsNonRoot Set container's Security Context runAsNonRoot
  ## @param server.containerSecurityContext.privileged Set container's Security Context privileged
  ## @param server.containerSecurityContext.readOnlyRootFilesystem Set container's Security Context readOnlyRootFilesystem
  ## @param server.containerSecurityContext.allowPrivilegeEscalation Set container's Security Context allowPrivilegeEscalation
  ## @param server.containerSecurityContext.capabilities.drop List of capabilities to be dropped
  ## @param server.containerSecurityContext.seccompProfile.type Set container's Security Context seccomp profile
  ##
  containerSecurityContext:
    enabled: true
    runAsUser: 1001
    runAsNonRoot: true
    privileged: false
    readOnlyRootFilesystem: false
    allowPrivilegeEscalation: false
    capabilities:
      drop: ["ALL"]
    seccompProfile:
      type: "RuntimeDefault"

  ## @param server.existingConfigmap The name of an existing ConfigMap with your custom configuration for Prometheus
  ##
  existingConfigmap: ""
  ## @param server.existingConfigmapKey The name of the key with the Prometheus config file
  ##
  existingConfigmapKey: ""
  ## @param server.command Override default container command (useful when using custom images)
  ##
  command: []
  ## @param server.args Override default container args (useful when using custom images)
  ##
  args: []
  ## @param server.extraArgs Additional arguments passed to the Prometheus server container
  ## extraArgs:
  ## - --log.level=debug
  ## - --tsdb.path=/data/
  ##
  extraArgs: []
  ## @param server.hostAliases Prometheus pods host aliases
  ## https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/
  ##
  hostAliases: []
  ## @param server.podLabels Extra labels for Prometheus pods
  ## ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
  ##
  podLabels: {}
  ## @param server.podAnnotations Annotations for Prometheus pods
  ## ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/
  ##
  podAnnotations: {}
  ## @param server.podAffinityPreset Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`
  ## ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity
  ##
  podAffinityPreset: ""
  ## @param server.podAntiAffinityPreset Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`
  ## ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity
  ##
  podAntiAffinityPreset: soft
  ## Pod Disruption Budget configuration
  ## ref: https://kubernetes.io/docs/tasks/run-application/configure-pdb
  ## @param server.pdb.create Enable/disable a Pod Disruption Budget creation
  ## @param server.pdb.minAvailable Minimum number/percentage of pods that should remain scheduled
  ## @param server.pdb.maxUnavailable Maximum number/percentage of pods that may be made unavailable
  ##
  pdb:
    create: false
    minAvailable: 1
    maxUnavailable: ""
  ## Node affinity preset
  ## ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-affinity
  ##
  nodeAffinityPreset:
    ## @param server.nodeAffinityPreset.type Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`
    ##
    type: ""
    ## @param server.nodeAffinityPreset.key Node label key to match. Ignored if `affinity` is set
    ##
    key: ""
    ## @param server.nodeAffinityPreset.values Node label values to match. Ignored if `affinity` is set
    ## E.g.
    ## values:
    ##   - e2e-az1
    ##   - e2e-az2
    ##
    values: []
  ## @param server.affinity Affinity for Prometheus pods assignment
  ## ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity
  ## NOTE: `podAffinityPreset`, `podAntiAffinityPreset`, and `nodeAffinityPreset` will be ignored when it's set
  ##
  affinity: {}
  ## @param server.nodeSelector Node labels for Prometheus pods assignment
  ## ref: https://kubernetes.io/docs/user-guide/node-selection/
  ##
  nodeSelector: {}
  ## @param server.tolerations Tolerations for Prometheus pods assignment
  ## ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/
  ##
  tolerations: []
  ## @param server.updateStrategy.type Prometheus deployment strategy type. If persistence is enabled, strategy type should be set to Recreate to avoid dead locks.
  ## ref: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy
  ##
  updateStrategy:
    ## StrategyType
    ## Can be set to RollingUpdate or Recreate
    ##
    type: RollingUpdate

  ## @param server.priorityClassName Prometheus pods' priorityClassName
  ##
  priorityClassName: ""
  ## @param server.topologySpreadConstraints Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template
  ## Ref: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/#spread-constraints-for-pods
  ##
  topologySpreadConstraints: []
  ## @param server.schedulerName Name of the k8s scheduler (other than default) for Prometheus pods
  ## ref: https://kubernetes.io/docs/tasks/administer-cluster/configure-multiple-schedulers/
  ##
  schedulerName: ""
  ## @param server.terminationGracePeriodSeconds Seconds Redmine pod needs to terminate gracefully
  ## ref: https://kubernetes.io/docs/concepts/workloads/pods/pod/#termination-of-pods
  ##
  terminationGracePeriodSeconds: ""
  ## @param server.lifecycleHooks for the Prometheus container(s) to automate configuration before or after startup
  ##
  lifecycleHooks: {}
  ## @param server.extraEnvVars Array with extra environment variables to add to Prometheus nodes
  ## e.g:
  ## extraEnvVars:
  ##   - name: FOO
  ##     value: "bar"
  ##
  extraEnvVars: []
  ## @param server.extraEnvVarsCM Name of existing ConfigMap containing extra env vars for Prometheus nodes
  ##
  extraEnvVarsCM: ""
  ## @param server.extraEnvVarsSecret Name of existing Secret containing extra env vars for Prometheus nodes
  ##
  extraEnvVarsSecret: ""
  ## @param server.extraVolumes Optionally specify extra list of additional volumes for the Prometheus pod(s)
  ##
  extraVolumes: []
  ## @param server.extraVolumeMounts Optionally specify extra list of additional volumeMounts for the Prometheus container(s)
  ##
  extraVolumeMounts: []
  ## @param server.sidecars Add additional sidecar containers to the Prometheus pod(s)
  ## e.g:
  ## sidecars:
  ##   - name: your-image-name
  ##     image: your-image
  ##     imagePullPolicy: Always
  ##     ports:
  ##       - name: portname
  ##         containerPort: 1234
  ##
  sidecars: []
  ## @param server.initContainers Add additional init containers to the Prometheus pod(s)
  ## ref: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
  ## e.g:
  ## initContainers:
  ##  - name: your-image-name
  ##    image: your-image
  ##    imagePullPolicy: Always
  ##    command: ['sh', '-c', 'echo "hello world"']
  ##
  initContainers: []
  ## @param server.routePrefix Prefix for the internal routes of web endpoints
  ## 
  routePrefix: /
  ## @param server.remoteWrite The remote_write spec configuration for Prometheus
  ##
  remoteWrite: []
  ## @param server.scrapeInterval Interval between consecutive scrapes. Example: "1m"
  ##
  scrapeInterval: ""
  ## @param server.scrapeTimeout Interval between consecutive scrapes. Example: "10s"
  ## 
  scrapeTimeout: ""
  ## @param server.evaluationInterval Interval between consecutive evaluations. Example: "1m"
  ##
  evaluationInterval: ""
  ## @param server.enableAdminAPI Enable Prometheus adminitrative API
  ## ref: https://prometheus.io/docs/prometheus/latest/querying/api/#tsdb-admin-apis
  ##
  enableAdminAPI: false
  ## @param server.enableRemoteWriteReceiver Enable Prometheus to be used as a receiver for the Prometheus remote write protocol.
  ##
  enableRemoteWriteReceiver: false
  ## @param server.enableFeatures Enable access to Prometheus disabled features.
  ## ref: https://prometheus.io/docs/prometheus/latest/disabled_features/
  ##
  enableFeatures: []
  ## @param server.logLevel Log level for Prometheus
  ##
  logLevel: info
  ## @param server.logFormat Log format for Prometheus
  ##
  logFormat: logfmt
  ## @param server.retention Metrics retention days
  ##
  retention: 10d
  ## @param server.retentionSize Maximum size of metrics
  ##
  retentionSize: "0"
  ## @param server.alertingEndpoints Alertmanagers to which alerts will be sent
  ## ref: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#alertmanager_config
  ##
  alertingEndpoints: []
  ## @param server.externalLabels External labels to add to any time series or alerts when communicating with external systems
  ##
  externalLabels: {}

  ## Thanos sidecar container configuration
  ##
  thanos:
    ## @param server.thanos.create Create a Thanos sidecar container
    ##
    create: false
    ## Bitnami Thanos image
    ## ref: https://hub.docker.com/r/bitnami/thanos/tags/
    ## @param server.thanos.image.registry [default: REGISTRY_NAME] Thanos image registry
    ## @param server.thanos.image.repository [default: REPOSITORY_NAME/thanos] Thanos image name
    ## @skip server.thanos.image.tag Thanos image tag
    ## @param server.thanos.image.digest Thanos image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag
    ## @param server.thanos.image.pullPolicy Thanos image pull policy
    ## @param server.thanos.image.pullSecrets Specify docker-registry secret names as an array
    ##
    image:
      registry: docker.io
      repository: bitnami/thanos
      tag: 0.32.5-debian-11-r1
      digest: ""
      ## Specify a imagePullPolicy. Defaults to 'Always' if image tag is 'latest', else set to 'IfNotPresent'
      ## ref: https://kubernetes.io/docs/user-guide/images/#pre-pulling-images
      ##
      pullPolicy: IfNotPresent
      ## Optionally specify an array of imagePullSecrets.
      ## Secrets must be manually created in the namespace.
      ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
      ## Example:
      ## pullSecrets:
      ##   - myRegistryKeySecretName
      ##
      pullSecrets: []
    ## Thanos Sidecar container's securityContext
    ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container
    ## @param server.thanos.containerSecurityContext.enabled Enabled containers' Security Context
    ## @param server.thanos.containerSecurityContext.runAsUser Set containers' Security Context runAsUser
    ## @param server.thanos.containerSecurityContext.runAsNonRoot Set container's Security Context runAsNonRoot
    ## @param server.thanos.containerSecurityContext.privileged Set container's Security Context privileged
    ## @param server.thanos.containerSecurityContext.readOnlyRootFilesystem Set container's Security Context readOnlyRootFilesystem
    ## @param server.thanos.containerSecurityContext.allowPrivilegeEscalation Set container's Security Context allowPrivilegeEscalation
    ## @param server.thanos.containerSecurityContext.capabilities.drop List of capabilities to be dropped
    ## @param server.thanos.containerSecurityContext.seccompProfile.type Set container's Security Context seccomp profile
    ##
    containerSecurityContext:
      enabled: true
      runAsUser: 1001
      runAsNonRoot: true
      privileged: false
      readOnlyRootFilesystem: false
      allowPrivilegeEscalation: false
      capabilities:
        drop: ["ALL"]
      seccompProfile:
        type: "RuntimeDefault"
    ## @param server.thanos.prometheusUrl Override default prometheus url `http://localhost:9090`
    ##
    prometheusUrl: ""
    ## @param server.thanos.extraArgs Additional arguments passed to the thanos sidecar container
    ## extraArgs:
    ## - --log.level=debug
    ## - --tsdb.path=/data/
    ##
    extraArgs: []
    ## @param server.thanos.objectStorageConfig.secretName Support mounting a Secret for the objectStorageConfig of the sideCar container.
    ## @param server.thanos.objectStorageConfig.secretKey Secret key with the configuration file.
    ## ref: https://github.com/thanos-io/thanos/blob/main/docs/storage.md
    ## objectStorageConfig:
    ##    secretName: thanos-objstore-config
    ##    secretKey: thanos.yaml
    ##
    objectStorageConfig:
      secretName: ""
      secretKey: thanos.yaml
    ## ref: https://github.com/thanos-io/thanos/blob/main/docs/components/sidecar.md
    ## @param server.thanos.extraVolumeMounts Additional volumeMounts from `server.volumes` for thanos sidecar container
    ## extraVolumeMounts:
    ## - name: my-secret-volume
    ##   mountPath: /etc/thanos/secrets/my-secret
    ##
    extraVolumeMounts: []
    ## Thanos sidecar container resource requests and limits.
    ## ref: https://kubernetes.io/docs/user-guide/compute-resources/
    ## We usually recommend not to specify default resources and to leave this as a conscious
    ## choice for the user. This also increases chances charts run on environments with little
    ## resources, such as Minikube. If you do want to specify resources, uncomment the following
    ## lines, adjust them as necessary, and remove the curly braces after 'resources:'.
    ## @param server.thanos.resources.limits The resources limits for the Thanos sidecar container
    ## @param server.thanos.resources.requests The resources requests for the Thanos sidecar container
    ##
    resources:
      ## Example:
      ## limits:
      ##    cpu: 100m
      ##    memory: 128Mi
      ##
      limits: {}
      ## Examples:
      ## requests:
      ##    cpu: 100m
      ##    memory: 128Mi
      ##
      requests: {}
    ## Configure extra options for liveness probe
    ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#configure-probes
    ## @param server.thanos.livenessProbe.enabled Turn on and off liveness probe
    ## @param server.thanos.livenessProbe.initialDelaySeconds Delay before liveness probe is initiated
    ## @param server.thanos.livenessProbe.periodSeconds How often to perform the probe
    ## @param server.thanos.livenessProbe.timeoutSeconds When the probe times out
    ## @param server.thanos.livenessProbe.failureThreshold Minimum consecutive failures for the probe
    ## @param server.thanos.livenessProbe.successThreshold Minimum consecutive successes for the probe
    ##
    livenessProbe:
      enabled: true
      initialDelaySeconds: 0
      periodSeconds: 5
      timeoutSeconds: 3
      failureThreshold: 120
      successThreshold: 1
    ## Configure extra options for readiness probe
    ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#configure-probes
    ## @param server.thanos.readinessProbe.enabled Turn on and off readiness probe
    ## @param server.thanos.readinessProbe.initialDelaySeconds Delay before readiness probe is initiated
    ## @param server.thanos.readinessProbe.periodSeconds How often to perform the probe
    ## @param server.thanos.readinessProbe.timeoutSeconds When the probe times out
    ## @param server.thanos.readinessProbe.failureThreshold Minimum consecutive failures for the probe
    ## @param server.thanos.readinessProbe.successThreshold Minimum consecutive successes for the probe
    ##
    readinessProbe:
      enabled: true
      initialDelaySeconds: 0
      periodSeconds: 5
      timeoutSeconds: 3
      failureThreshold: 120
      successThreshold: 1
    ## @param server.thanos.customLivenessProbe Custom livenessProbe that overrides the default one
    ##
    customLivenessProbe: {}
    ## @param server.thanos.customReadinessProbe Custom readinessProbe that overrides the default one
    ##
    customReadinessProbe: {}
    ## Thanos Sidecar Service
    ##
    service:
      ## @param server.thanos.service.type Kubernetes service type
      ##
      type: ClusterIP
      ## @param server.thanos.service.ports.grpc Thanos service port
      ##
      ports:
        grpc: 10901
      ## @param server.thanos.service.clusterIP Specific cluster IP when service type is cluster IP. Use `None` to create headless service by default.
      ## Use a "headless" service by default so it returns every pod's IP instead of loadbalancing requests.
      ##
      clusterIP: None
      ## @param server.thanos.service.nodePorts.grpc Specify the nodePort value for the LoadBalancer and NodePort service types.
      ## ref: https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport
      ## e.g:
      ## nodePort: 30901
      ##
      nodePorts:
        grpc: ""
      ## @param server.thanos.service.loadBalancerIP `loadBalancerIP` if service type is `LoadBalancer`
      ## Set the LoadBalancer service type to internal only
      ## ref: https://kubernetes.io/docs/concepts/services-networking/service/#internal-load-balancer
      ##
      loadBalancerIP: ""
      ## @param server.thanos.service.loadBalancerClass Thanos service Load Balancer class if service type is `LoadBalancer` (optional, cloud specific)
      ## ref: https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer
      ##
      loadBalancerClass: ""
      ## @param server.thanos.service.loadBalancerSourceRanges Address that are allowed when svc is `LoadBalancer`
      ## https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/#restrict-access-for-loadbalancer-service
      ## e.g:
      ## loadBalancerSourceRanges:
      ## - 10.10.10.0/24
      ##
      loadBalancerSourceRanges: []
      ## @param server.thanos.service.annotations Additional annotations for Prometheus service
      ##
      annotations: {}
      ## @param server.thanos.service.extraPorts Additional ports to expose from the Thanos sidecar container
      ## extraPorts:
      ##   - name: http
      ##     port: 10902
      ##     targetPort: http
      ##     protocol: TCP
      ##
      extraPorts: []
      ## @param server.thanos.service.externalTrafficPolicy Prometheus service external traffic policy
      ## ref http://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip
      ##
      externalTrafficPolicy: Cluster
      ## @param server.thanos.service.sessionAffinity Session Affinity for Kubernetes service, can be "None" or "ClientIP"
      ## If "ClientIP", consecutive client requests will be directed to the same Pod
      ## ref: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
      ##
      sessionAffinity: None
      ## @param server.thanos.service.sessionAffinityConfig Additional settings for the sessionAffinity
      ## sessionAffinityConfig:
      ##   clientIP:
      ##     timeoutSeconds: 300
      ##
      sessionAffinityConfig: {}

    ## Configure the ingress resource that allows you to access the
    ## Thanos Sidecar installation. Set up the URL
    ## ref: https://kubernetes.io/docs/user-guide/ingress/
    ##
    ingress:
      ## @param server.thanos.ingress.enabled Enable ingress controller resource
      ##
      enabled: false
      ## @param server.thanos.ingress.pathType Ingress path type
      ##
      pathType: ImplementationSpecific
      ## @param server.thanos.ingress.hostname Default host for the ingress record
      ##
      hostname: thanos.prometheus.local
      ## @param server.thanos.ingress.path Default path for the ingress record
      ## NOTE: You may need to set this to '/*' in order to use this with ALB ingress controllers
      ##
      path: /
      ## @param server.thanos.ingress.annotations Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations.
      ## For a full list of possible ingress annotations, please see
      ## ref: https://github.com/kubernetes/ingress-nginx/blob/master/docs/user-guide/nginx-configuration/annotations.md
      ## Use this parameter to set the required annotations for cert-manager, see
      ## ref: https://cert-manager.io/docs/usage/ingress/#supported-annotations
      ##
      ## Examples:
      ## kubernetes.io/ingress.class: nginx
      ## cert-manager.io/cluster-issuer: cluster-issuer-name
      ##
      annotations: {}
      ## @param server.thanos.ingress.ingressClassName IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)
      ## This is supported in Kubernetes 1.18+ and required if you have more than one IngressClass marked as the default for your cluster .
      ## ref: https://kubernetes.io/blog/2020/04/02/improvements-to-the-ingress-api-in-kubernetes-1.18/
      ##
      ingressClassName: ""
      ## @param server.thanos.ingress.tls Enable TLS configuration for the host defined at `ingress.hostname` parameter
      ## TLS certificates will be retrieved from a TLS secret with name: `{{- printf "%s-tls" .Values.ingress.hostname }}`
      ## You can:
      ##   - Use the `ingress.secrets` parameter to create this TLS secret
      ##   - Relay on cert-manager to create it by setting `ingress.certManager=true`
      ##   - Relay on Helm to create self-signed certificates by setting `ingress.selfSigned=true`
      ##
      tls: false
      ## @param server.thanos.ingress.selfSigned Create a TLS secret for this ingress record using self-signed certificates generated by Helm
      ##
      selfSigned: false
      ## @param server.thanos.ingress.extraHosts An array with additional hostname(s) to be covered with the ingress record
      ## e.g:
      ## extraHosts:
      ##   - name: thanos.prometheus.local
      ##     path: /
      ##
      extraHosts: []
      ## @param server.thanos.ingress.extraPaths An array with additional arbitrary paths that may need to be added to the ingress under the main host
      ## e.g:
      ## extraPaths:
      ## - path: /*
      ##   backend:
      ##     serviceName: ssl-redirect
      ##     servicePort: use-annotation
      ##
      extraPaths: []
      ## @param server.thanos.ingress.extraTls TLS configuration for additional hostname(s) to be covered with this ingress record
      ## ref: https://kubernetes.io/docs/concepts/services-networking/ingress/#tls
      ## e.g:
      ## extraTls:
      ## - hosts:
      ##     - thanos.prometheus.local
      ##   secretName: thanos.prometheus.local-tls
      ##
      extraTls: []
      ## @param server.thanos.ingress.secrets Custom TLS certificates as secrets
      ## NOTE: 'key' and 'certificate' are expected in PEM format
      ## NOTE: 'name' should line up with a 'secretName' set further up
      ## If it is not set and you're using cert-manager, this is unneeded, as it will create a secret for you with valid certificates
      ## If it is not set and you're NOT using cert-manager either, self-signed certificates will be created valid for 365 days
      ## It is also possible to create and manage the certificates outside of this helm chart
      ## Please see README.md for more information
      ## e.g:
      ## secrets:
      ##   - name: thanos.prometheus.local-tls
      ##     key: |-
      ##       -----BEGIN RSA PRIVATE KEY-----
      ##       ...
      ##       -----END RSA PRIVATE KEY-----
      ##     certificate: |-
      ##       -----BEGIN CERTIFICATE-----
      ##       ...
      ##       -----END CERTIFICATE-----
      ##
      secrets: []
      ## @param server.thanos.ingress.extraRules The list of additional rules to be added to this ingress record. Evaluated as a template
      ## Useful when looking for additional customization, such as using different backend
      ##
      extraRules: []

  ## Prometheus Server ingress parameters
  ## ref: http://kubernetes.io/docs/user-guide/ingress/
  ##
  ingress:
    ## @param server.ingress.enabled Enable ingress record generation for Prometheus
    ##
    enabled: false
    ## @param server.ingress.pathType Ingress path type
    ##
    pathType: ImplementationSpecific
    ## @param server.ingress.hostname Default host for the ingress record
    ##
    hostname: server.prometheus.local
    ## @param server.ingress.ingressClassName IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)
    ## This is supported in Kubernetes 1.18+ and required if you have more than one IngressClass marked as the default for your cluster .
    ## ref: https://kubernetes.io/blog/2020/04/02/improvements-to-the-ingress-api-in-kubernetes-1.18/
    ##
    ingressClassName: ""
    ## @param server.ingress.path Default path for the ingress record
    ## NOTE: You may need to set this to '/*' in order to use this with ALB ingress controllers
    ##
    path: /
    ## @param server.ingress.annotations Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations.
    ## Use this parameter to set the required annotations for cert-manager, see
    ## ref: https://cert-manager.io/docs/usage/ingress/#supported-annotations
    ## e.g:
    ## annotations:
    ##   kubernetes.io/ingress.class: nginx
    ##   cert-manager.io/cluster-issuer: cluster-issuer-name
    ##
    annotations: {}
    ## @param server.ingress.tls Enable TLS configuration for the host defined at `ingress.hostname` parameter
    ## TLS certificates will be retrieved from a TLS secret with name: `{{- printf "%s-tls" .Values.ingress.hostname }}`
    ## You can:
    ##   - Use the `ingress.secrets` parameter to create this TLS secret
    ##   - Rely on cert-manager to create it by setting the corresponding annotations
    ##   - Rely on Helm to create self-signed certificates by setting `ingress.selfSigned=true`
    ##
    tls: false
    ## @param server.ingress.selfSigned Create a TLS secret for this ingress record using self-signed certificates generated by Helm
    ##
    selfSigned: false
    ## @param server.ingress.extraHosts An array with additional hostname(s) to be covered with the ingress record
    ## e.g:
    ## extraHosts:
    ##   - name: prometheus.local
    ##     path: /
    ##
    extraHosts: []
    ## @param server.ingress.extraPaths An array with additional arbitrary paths that may need to be added to the ingress under the main host
    ## e.g:
    ## extraPaths:
    ## - path: /*
    ##   backend:
    ##     serviceName: ssl-redirect
    ##     servicePort: use-annotation
    ##
    extraPaths: []
    ## @param server.ingress.extraTls TLS configuration for additional hostname(s) to be covered with this ingress record
    ## ref: https://kubernetes.io/docs/concepts/services-networking/ingress/#tls
    ## e.g:
    ## extraTls:
    ## - hosts:
    ##     - prometheus.local
    ##   secretName: prometheus.local-tls
    ##
    extraTls: []
    ## @param server.ingress.secrets Custom TLS certificates as secrets
    ## NOTE: 'key' and 'certificate' are expected in PEM format
    ## NOTE: 'name' should line up with a 'secretName' set further up
    ## If it is not set and you're using cert-manager, this is unneeded, as it will create a secret for you with valid certificates
    ## If it is not set and you're NOT using cert-manager either, self-signed certificates will be created valid for 365 days
    ## It is also possible to create and manage the certificates outside of this helm chart
    ## Please see README.md for more information
    ## e.g:
    ## secrets:
    ##   - name: prometheus.local-tls
    ##     key: |-
    ##       -----BEGIN RSA PRIVATE KEY-----
    ##       ...
    ##       -----END RSA PRIVATE KEY-----
    ##     certificate: |-
    ##       -----BEGIN CERTIFICATE-----
    ##       ...
    ##       -----END CERTIFICATE-----
    ##
    secrets: []
    ## @param server.ingress.extraRules Additional rules to be covered with this ingress record
    ## ref: https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-rules
    ## e.g:
    ## extraRules:
    ## - host: example.local
    ##     http:
    ##       path: /
    ##       backend:
    ##         service:
    ##           name: example-svc
    ##           port:
    ##             name: http
    ##
    extraRules: []

  ## ServiceAccount configuration
  ##
  serviceAccount:
    ## @param server.serviceAccount.create Specifies whether a ServiceAccount should be created
    ##
    create: true
    ## @param server.serviceAccount.name The name of the ServiceAccount to use.
    ## If not set and create is true, a name is generated using the common.names.fullname template
    ##
    name: ""
    ## @param server.serviceAccount.annotations Additional Service Account annotations (evaluated as a template)
    ##
    annotations: {}
    ## @param server.serviceAccount.automountServiceAccountToken Automount service account token for the server service account
    ##
    automountServiceAccountToken: true

  ## Prometheus service parameters
  ##
  service:
    ## @param server.service.type Prometheus service type
    ##
    type: ClusterIP
    ## @param server.service.ports.http Prometheus service HTTP port
    ##
    ports:
      http: 80
    ## Node ports to expose
    ## @param server.service.nodePorts.http Node port for HTTP
    ## NOTE: choose port between <30000-32767>
    ##
    nodePorts:
      http: ""
    ## @param server.service.clusterIP Prometheus service Cluster IP
    ## e.g.:
    ## clusterIP: None
    ##
    clusterIP: ""
    ## @param server.service.loadBalancerIP Prometheus service Load Balancer IP
    ## ref: https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer
    ##
    loadBalancerIP: ""
    ## @param server.service.loadBalancerClass Prometheus service Load Balancer class if service type is `LoadBalancer` (optional, cloud specific)
    ## ref: https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer
    ##
    loadBalancerClass: ""
    ## @param server.service.loadBalancerSourceRanges Prometheus service Load Balancer sources
    ## ref: https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/#restrict-access-for-loadbalancer-service
    ## e.g:
    ## loadBalancerSourceRanges:
    ##   - 10.10.10.0/24
    ##
    loadBalancerSourceRanges: []
    ## @param server.service.externalTrafficPolicy Prometheus service external traffic policy
    ## ref http://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip
    ##
    externalTrafficPolicy: Cluster
    ## @param server.service.annotations Additional custom annotations for Prometheus service
    ##
    annotations: {}
    ## @param server.service.extraPorts Extra ports to expose in Prometheus service (normally used with the `sidecars` value)
    ##
    extraPorts: []
    ## @param server.service.sessionAffinity Control where client requests go, to the same pod or round-robin. ClientIP by default.
    ## Values: ClientIP or None
    ## ref: https://kubernetes.io/docs/user-guide/services/
    ##
    sessionAffinity: ClientIP
    ## @param server.service.sessionAffinityConfig Additional settings for the sessionAffinity
    ## sessionAffinityConfig:
    ##   clientIP:
    ##     timeoutSeconds: 300
    ##
    sessionAffinityConfig: {}

  ## Persistence Parameters
  ##

  ## Enable persistence using Persistent Volume Claims
  ## ref: https://kubernetes.io/docs/user-guide/persistent-volumes/
  ##
  persistence:
    ## @param server.persistence.enabled Enable persistence using Persistent Volume Claims. If you have multiple instances (server.repicacount > 1), please considere using an external storage service like Thanos or Grafana Mimir
    ##
    enabled: false
    ## @param server.persistence.mountPath Path to mount the volume at.
    ##
    mountPath: /bitnami/prometheus/data
    ## @param server.persistence.subPath The subdirectory of the volume to mount to, useful in dev environments and one PV for multiple services
    ##
    subPath: ""
    ## @param server.persistence.storageClass Storage class of backing PVC
    ## If defined, storageClassName: <storageClass>
    ## If set to "-", storageClassName: "", which disables dynamic provisioning
    ## If undefined (the default) or set to null, no storageClassName spec is
    ##   set, choosing the default provisioner.  (gp2 on AWS, standard on
    ##   GKE, AWS & OpenStack)
    ##
    storageClass: ""
    ## @param server.persistence.annotations Persistent Volume Claim annotations
    ##
    annotations: {}
    ## @param server.persistence.accessModes Persistent Volume Access Modes
    ##
    accessModes:
      - ReadWriteOnce
    ## @param server.persistence.size Size of data volume
    ##
    size: 8Gi
    ## @param server.persistence.existingClaim The name of an existing PVC to use for persistence
    ##
    existingClaim: ""
    ## @param server.persistence.selector Selector to match an existing Persistent Volume for WordPress data PVC
    ## If set, the PVC can't have a PV dynamically provisioned for it
    ## E.g.
    ## selector:
    ##   matchLabels:
    ##     app: my-app
    ##
    selector: {}
    ## @param server.persistence.dataSource Custom PVC data source
    ##
    dataSource: {}

  # RBAC configuration
  ##
  rbac:
    ## @param server.rbac.create Specifies whether RBAC resources should be created
    ##
    create: true
    ## @param server.rbac.rules Custom RBAC rules to set
    ## e.g:
    ## rules:
    ##   - apiGroups:
    ##       - ""
    ##     resources:
    ##       - pods
    ##     verbs:
    ##       - get
    ##       - list
    ##
    rules: []

## @section Init Container Parameters
##

## 'volumePermissions' init container parameters
## Changes the owner and group of the persistent volume mount point to runAsUser:fsGroup values
##   based on the *podSecurityContext/*containerSecurityContext parameters
##
volumePermissions:
  ## @param volumePermissions.enabled Enable init container that changes the owner/group of the PV mount point to `runAsUser:fsGroup`
  ##
  enabled: false
  ## OS Shell + Utility image
  ## ref: https://hub.docker.com/r/bitnami/os-shell/tags/
  ## @param volumePermissions.image.registry [default: REGISTRY_NAME] OS Shell + Utility image registry
  ## @param volumePermissions.image.repository [default: REPOSITORY_NAME/os-shell] OS Shell + Utility image repository
  ## @skip volumePermissions.image.tag OS Shell + Utility image tag (immutable tags are recommended)
  ## @param volumePermissions.image.pullPolicy OS Shell + Utility image pull policy
  ## @param volumePermissions.image.pullSecrets OS Shell + Utility image pull secrets
  ##
  image:
    registry: docker.io
    repository: bitnami/os-shell
    tag: 11-debian-11-r91
    pullPolicy: IfNotPresent
    ## Optionally specify an array of imagePullSecrets.
    ## Secrets must be manually created in the namespace.
    ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
    ## e.g:
    ## pullSecrets:
    ##   - myRegistryKeySecretName
    ##
    pullSecrets: []
  ## Init container's resource requests and limits
  ## ref: http://kubernetes.io/docs/user-guide/compute-resources/
  ## @param volumePermissions.resources.limits The resources limits for the init container
  ## @param volumePermissions.resources.requests The requested resources for the init container
  ##
  resources:
    limits: {}
    requests: {}
  ## Init container Container Security Context
  ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container
  ## @param volumePermissions.containerSecurityContext.runAsUser Set init container's Security Context runAsUser
  ## NOTE: when runAsUser is set to special value "auto", init container will try to chown the
  ##   data folder to auto-determined user&group, using commands: `id -u`:`id -G | cut -d" " -f2`
  ##   "auto" is especially useful for OpenShift which has scc with dynamic user ids (and 0 is not allowed)
  ##
  containerSecurityContext:
    runAsUser: 0
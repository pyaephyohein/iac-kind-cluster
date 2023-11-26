# Copyright VMware, Inc.
# SPDX-License-Identifier: APACHE-2.0

## @section Global parameters
## Global Docker image parameters
## Please, note that this will override the image parameters, including dependencies, configured to use the global value
## Current available global Docker image parameters: imageRegistry, imagePullSecrets and storageClass

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

## @param kubeVersion Force target Kubernetes version (using Helm capabilities if not set)
##
kubeVersion: ""
## @param extraDeploy Array of extra objects to deploy with the release
##
extraDeploy: []
## @param nameOverride String to partially override grafana.fullname template (will maintain the release name)
##
nameOverride: ""
## @param fullnameOverride String to fully override grafana.fullname template
##
fullnameOverride: ""
## @param clusterDomain Default Kubernetes cluster domain
##
clusterDomain: cluster.local
## @param commonLabels Labels to add to all deployed objects
##
commonLabels: {}
## @param commonAnnotations Annotations to add to all deployed objects
##
commonAnnotations: {}

## @section Grafana parameters

## Bitnami Grafana image version
## ref: https://hub.docker.com/r/bitnami/grafana/tags/
## @param image.registry [default: REGISTRY_NAME] Grafana image registry
## @param image.repository [default: REPOSITORY_NAME/grafana] Grafana image repository
## @skip image.tag Grafana image tag (immutable tags are recommended)
## @param image.digest Grafana image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag
## @param image.pullPolicy Grafana image pull policy
## @param image.pullSecrets Grafana image pull secrets
##
image:
  registry: docker.io
  repository: bitnami/grafana
  tag: 10.2.2-debian-11-r1
  digest: ""
  ## Specify a imagePullPolicy
  ## Defaults to 'Always' if image tag is 'latest', else set to 'IfNotPresent'
  ## ref: https://kubernetes.io/docs/user-guide/images/#pre-pulling-images
  ##
  pullPolicy: IfNotPresent
  ## Optionally specify an array of imagePullSecrets.
  ## Secrets must be manually created in the namespace.
  ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
  ##
  ## pullSecrets:
  ##   - myRegistryKeySecretName
  pullSecrets: []
## Admin credentials configuration
##
admin:
  ## @param admin.user Grafana admin username
  ##
  user: "admin"
  ## @param admin.password Admin password. If a password is not provided a random password will be generated
  ##
  password: "admin"
  ## @param admin.existingSecret Name of the existing secret containing admin password
  ##
  existingSecret: ""
  ## @param admin.existingSecretPasswordKey Password key on the existing secret
  ##
  existingSecretPasswordKey: password
## SMTP configuration
##
smtp:
  ## @param smtp.enabled Enable SMTP configuration
  ##
  enabled: false
  ## @param smtp.user SMTP user
  ##
  user: user
  ## @param smtp.password SMTP password
  ##
  password: password
  ## @param smtp.host Custom host for the smtp server
  ## e.g:
  ##   host: mysmtphost.com
  ##
  host: ""
  ## @param smtp.fromAddress From address
  ##
  fromAddress: ""
  ## @param smtp.fromName From name
  ##
  fromName: ""
  ## @param smtp.skipVerify Enable skip verify
  ##
  skipVerify: "false"
  ## @param smtp.existingSecret Name of existing secret containing SMTP credentials (user and password)
  ##
  existingSecret: ""
  ## @param smtp.existingSecretUserKey User key on the existing secret
  ##
  existingSecretUserKey: user
  ## @param smtp.existingSecretPasswordKey Password key on the existing secret
  ##
  existingSecretPasswordKey: password
## @param plugins Grafana plugins to be installed in deployment time separated by commas
## Specify plugins as a list separated by commas ( you will need to scape them when specifying from command line )
## Example:
## plugins: grafana-kubernetes-app,grafana-example-app
##
plugins: ""
## Ldap configuration for Grafana
##
ldap:
  ## @param ldap.enabled Enable LDAP for Grafana
  ##
  enabled: false
  ## @param ldap.allowSignUp Allows LDAP sign up for Grafana
  ##
  allowSignUp: false
  ## @param ldap.configuration Specify content for ldap.toml configuration file
  ## e.g:
  ## configuration: |-
  ##   [[servers]]
  ##   host = "127.0.0.1"
  ##   port = 389
  ##   use_ssl = false
  ##   ...
  ##
  configuration: ""
  ## @param ldap.configMapName Name of the ConfigMap with the ldap.toml configuration file for Grafana
  ## NOTE: When it's set the ldap.configuration parameter is ignored
  ##
  configMapName: ""
  ## @param ldap.secretName Name of the Secret with the ldap.toml configuration file for Grafana
  ## NOTE: When it's set the ldap.configuration parameter is ignored
  ##
  secretName: ""
  ## @param ldap.uri Server URI, eg. ldap://ldap_server:389
  ##
  uri: ""
  ## @param ldap.binddn DN of the account used to search in the LDAP server.
  ##
  binddn: ""
  ## @param ldap.bindpw Password for binddn account.
  ##
  bindpw: ""
  ## @param ldap.basedn Base DN path where binddn account will search for the users.
  ##
  basedn: ""
  ## @param ldap.searchAttribute Field used to match with the user name (uid, samAccountName, cn, etc). This value will be ignored if 'ldap.searchFilter' is set
  ##
  searchAttribute: "uid"
  ## @param ldap.searchFilter User search filter, for example "(cn=%s)" or "(sAMAccountName=%s)" or "(|(sAMAccountName=%s)(userPrincipalName=%s)"
  ##
  searchFilter: ""
  ## @param ldap.extraConfiguration Extra ldap configuration.
  ## Example:
  ##   extraConfiguration: |-
  ##     # set to true if you want to skip SSL cert validation
  ##     ssl_skip_verify = false
  ##     # group_search_filter = "(&(objectClass=posixGroup)(memberUid=%s))"
  ##     # group_search_filter_user_attribute = "distinguishedName"
  ##     # group_search_base_dns = ["ou=groups,dc=grafana,dc=org"]
  ##     # Specify names of the LDAP attributes your LDAP uses
  ##     [servers.attributes]
  ##     # member_of = "memberOf"
  ##     # email =  "email"
  ##
  extraConfiguration: ""
  ## @param ldap.tls.enabled Enabled TLS configuration.
  ## @param ldap.tls.startTls Use STARTTLS instead of LDAPS.
  ## @param ldap.tls.skipVerify Skip any SSL verification (hostanames or certificates)
  ## @param ldap.tls.certificatesMountPath Where LDAP certifcates are mounted.
  ## @param ldap.tls.certificatesSecret Secret with LDAP certificates.
  ## @param ldap.tls.CAFilename  CA certificate filename. Should match with the CA entry key in the ldap.tls.certificatesSecret.
  ## @param ldap.tls.certFilename Client certificate filename to authenticate against the LDAP server. Should match with certificate the entry key in the ldap.tls.certificatesSecret.
  ## @param ldap.tls.certKeyFilename Client Key filename to authenticate against the LDAP server. Should match with certificate the entry key in the ldap.tls.certificatesSecret.
  ##
  tls:
    enabled: false
    startTls: false
    skipVerify: false
    certificatesMountPath: /opt/bitnami/grafana/conf/ldap/
    certificatesSecret: ""
    CAFilename: ""
    certFilename: ""
    certKeyFilename: ""
## Grafana Image Renderer configuration for Grafana
##
imageRenderer:
  ## @param imageRenderer.enabled Enable using a remote rendering service to render PNG images
  ##
  enabled: false
  ## @param imageRenderer.serverURL URL of the remote rendering service
  ##
  serverURL: ""
  ## @param imageRenderer.callbackURL URL of the callback service
  ##
  callbackURL: ""

## Parameters to override the default grafana.ini file.
## It is needed to create a configmap or a secret containing the grafana.ini file.
## @param config.useGrafanaIniFile Allows to load a `grafana.ini` file
## @param config.grafanaIniConfigMap Name of the ConfigMap containing the `grafana.ini` file
## @param config.grafanaIniSecret Name of the Secret containing the `grafana.ini` file
##
config:
  useGrafanaIniFile: false
  grafanaIniConfigMap: ""
  grafanaIniSecret: ""
## Create dasboard provider to load dashboards, a default one is created to load dashboards
## from "/opt/bitnami/grafana/dashboards"
## @param dashboardsProvider.enabled Enable the use of a Grafana dashboard provider
## @param dashboardsProvider.configMapName Name of a ConfigMap containing a custom dashboard provider
##
dashboardsProvider:
  enabled: false
  ## Important to set the Path to "/opt/bitnami/grafana/dashboards"
  ## Evaluated as a template.
  ##
  configMapName: ""
## @param dashboardsConfigMaps Array with the names of a series of ConfigMaps containing dashboards files
## They will be mounted by the default dashboard provider if it is enabled
## Use an array with the configMap names.
## In order to use subfolders, uncomment "#foldersFromFilesStructure: true" line in default provider config. or create your own dashboard provider.
## Example:
## dashboardsConfigMaps:
##   - configMapName: mydashboard
##     folderName: foo
##     fileName: mydashboard.json
##   - configMapName: myotherdashboard
##     folderName: bar
##     fileName: myotherdashboard.json
##
dashboardsConfigMaps: []
## Import datasources from an externally-managed secret, or a secret definition set via Helm values.
##
datasources:
  ## @param datasources.secretName The name of an externally-managed secret containing custom datasource files.
  ##
  secretName: ""
  ## @param datasources.secretDefinition The contents of a secret defining a custom datasource file. Only used if datasources.secretName is empty or not defined.
  ## Example:
  ## secretDefinition:
  ##   apiVersion: 1
  ##   datasources:
  ##   - name: Prometheus
  ##     type: prometheus
  ##     url: http://prometheus-prometheus-server
  ##     access: proxy
  ##     isDefault: true
  ##
  secretDefinition:
    apiVersion: 1
    datasources:
    - name: Prometheus
      type: prometheus
      url: http://prometheus-server
      access: proxy
      isDefault: true

## Create notifiers from a configMap
## The notifiersName must contain the files
## @param notifiers.configMapName Name of a ConfigMap containing Grafana notifiers configuration
##
notifiers:
  configMapName: ""

## Create alerting rules, contact points, notification policies, templates, and mute timings from a configMap
## @param alerting.configMapName Name of a ConfigMap containing Grafana alerting configuration
##
alerting:
  configMapName: ""

## @section Grafana Deployment parameters

grafana:
  ## @param grafana.replicaCount Number of Grafana nodes
  ##
  replicaCount: 1
  ## @param grafana.updateStrategy.type Set up update strategy for Grafana installation.
  ## Set to Recreate if you use persistent volume that cannot be mounted by more than one pods to make sure the pods is destroyed first.
  ## ref: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy
  ## Example:
  ## updateStrategy:
  ##  type: RollingUpdate
  ##  rollingUpdate:
  ##    maxSurge: 25%
  ##    maxUnavailable: 25%
  ##
  updateStrategy:
    type: RollingUpdate
  ## @param grafana.hostAliases Add deployment host aliases
  ## https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/
  ##
  hostAliases: []
  ## @param grafana.schedulerName Alternative scheduler
  ## ref: https://kubernetes.io/docs/tasks/administer-cluster/configure-multiple-schedulers/
  ##
  schedulerName: ""
  ## @param grafana.terminationGracePeriodSeconds In seconds, time the given to the Grafana pod needs to terminate gracefully
  ## ref: https://kubernetes.io/docs/concepts/workloads/pods/pod/#termination-of-pods
  ##
  terminationGracePeriodSeconds: ""
  ## @param grafana.priorityClassName Priority class name
  ## ref: https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/
  ##
  priorityClassName: ""
  ## @param grafana.podLabels Extra labels for Grafana pods
  ## ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
  ##
  podLabels: {}
  ## @param grafana.podAnnotations Grafana Pod annotations
  ## ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/
  ##
  podAnnotations: {}
  ## @param grafana.podAffinityPreset Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`
  ## ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity
  ##
  podAffinityPreset: ""
  ## @param grafana.podAntiAffinityPreset Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`
  ## Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity
  ##
  podAntiAffinityPreset: soft
  ## @param grafana.containerPorts.grafana Grafana container port
  ##
  containerPorts:
    grafana: 3000
  ## @param grafana.extraPorts Extra ports for Grafana deployment
  ##
  extraPorts: []
  ## Node affinity preset
  ## Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-affinity
  ## @param grafana.nodeAffinityPreset.type Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`
  ## @param grafana.nodeAffinityPreset.key Node label key to match Ignored if `affinity` is set.
  ## @param grafana.nodeAffinityPreset.values Node label values to match. Ignored if `affinity` is set.
  ##
  nodeAffinityPreset:
    type: ""
    ## E.g.
    ## key: "kubernetes.io/e2e-az-name"
    ##
    key: ""
    ## E.g.
    ## values:
    ##   - e2e-az1
    ##   - e2e-az2
    ##
    values: []
  ## @param grafana.affinity Affinity for pod assignment
  ## Ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity
  ## Note: podAffinityPreset, podAntiAffinityPreset, and  nodeAffinityPreset will be ignored when it's set
  ##
  affinity: {}
  ## @param grafana.nodeSelector Node labels for pod assignment
  ## Ref: https://kubernetes.io/docs/user-guide/node-selection/
  ##
  nodeSelector: {}
  ## @param grafana.tolerations Tolerations for pod assignment
  ## Ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/
  ##
  tolerations: []
  ## @param grafana.topologySpreadConstraints Topology spread constraints rely on node labels to identify the topology domain(s) that each Node is in
  ## Ref: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/
  ##
  ## topologySpreadConstraints:
  ##   - maxSkew: 1
  ##     topologyKey: failure-domain.beta.kubernetes.io/zone
  ##     whenUnsatisfiable: DoNotSchedule
  ##
  topologySpreadConstraints: []
  ## @param grafana.podSecurityContext.enabled Enable securityContext on for Grafana deployment
  ## @param grafana.podSecurityContext.fsGroup Group to configure permissions for volumes
  ##
  podSecurityContext:
    enabled: true
    fsGroup: 1001
  ## Configure Container Security Context
  ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod
  ## @param grafana.containerSecurityContext.enabled Enabled containers' Security Context
  ## @param grafana.containerSecurityContext.runAsUser Set containers' Security Context runAsUser
  ## @param grafana.containerSecurityContext.runAsNonRoot Set container's Security Context runAsNonRoot
  ## @param grafana.containerSecurityContext.privileged Set container's Security Context privileged
  ## @param grafana.containerSecurityContext.readOnlyRootFilesystem Set container's Security Context readOnlyRootFilesystem
  ## @param grafana.containerSecurityContext.allowPrivilegeEscalation Set container's Security Context allowPrivilegeEscalation
  ## @param grafana.containerSecurityContext.capabilities.drop List of capabilities to be dropped
  ## @param grafana.containerSecurityContext.seccompProfile.type Set container's Security Context seccomp profile
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
  ## Grafana containers' resource requests and limits
  ## ref: https://kubernetes.io/docs/user-guide/compute-resources/
  ## We usually recommend not to specify default resources and to leave this as a conscious
  ## choice for the user. This also increases chances charts run on environments with little
  ## resources, such as Minikube. If you do want to specify resources, uncomment the following
  ## lines, adjust them as necessary, and remove the curly braces after 'resources:'.
  ## @param grafana.resources.limits The resources limits for Grafana containers
  ## @param grafana.resources.requests The requested resources for Grafana containers
  ##
  resources:
    ## Example:
    ## limits:
    ##    cpu: 500m
    ##    memory: 1Gi
    limits: {}
    ## Examples:
    ## requests:
    ##    cpu: 250m
    ##    memory: 256Mi
    requests: {}
  ## Grafana containers' liveness probe
  ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#configure-probes
  ## @param grafana.livenessProbe.enabled Enable livenessProbe
  ## @param grafana.livenessProbe.path Path for livenessProbe
  ## @param grafana.livenessProbe.scheme Scheme for livenessProbe
  ## @param grafana.livenessProbe.initialDelaySeconds Initial delay seconds for livenessProbe
  ## @param grafana.livenessProbe.periodSeconds Period seconds for livenessProbe
  ## @param grafana.livenessProbe.timeoutSeconds Timeout seconds for livenessProbe
  ## @param grafana.livenessProbe.failureThreshold Failure threshold for livenessProbe
  ## @param grafana.livenessProbe.successThreshold Success threshold for livenessProbe
  ##
  livenessProbe:
    enabled: true
    path: /api/health
    scheme: HTTP
    initialDelaySeconds: 120
    periodSeconds: 10
    timeoutSeconds: 5
    failureThreshold: 6
    successThreshold: 1
  ## Grafana containers' readinessProbe probe
  ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#configure-probes
  ## @param grafana.readinessProbe.enabled Enable readinessProbe
  ## @param grafana.readinessProbe.path Path for readinessProbe
  ## @param grafana.readinessProbe.scheme Scheme for readinessProbe
  ## @param grafana.readinessProbe.initialDelaySeconds Initial delay seconds for readinessProbe
  ## @param grafana.readinessProbe.periodSeconds Period seconds for readinessProbe
  ## @param grafana.readinessProbe.timeoutSeconds Timeout seconds for readinessProbe
  ## @param grafana.readinessProbe.failureThreshold Failure threshold for readinessProbe
  ## @param grafana.readinessProbe.successThreshold Success threshold for readinessProbe
  ##
  readinessProbe:
    enabled: true
    path: /api/health
    scheme: HTTP
    initialDelaySeconds: 30
    periodSeconds: 10
    timeoutSeconds: 5
    failureThreshold: 6
    successThreshold: 1
  ## @param grafana.startupProbe.enabled Enable startupProbe
  ## @param grafana.startupProbe.path Path for readinessProbe
  ## @param grafana.startupProbe.scheme Scheme for readinessProbe
  ## @param grafana.startupProbe.initialDelaySeconds Initial delay seconds for startupProbe
  ## @param grafana.startupProbe.periodSeconds Period seconds for startupProbe
  ## @param grafana.startupProbe.timeoutSeconds Timeout seconds for startupProbe
  ## @param grafana.startupProbe.failureThreshold Failure threshold for startupProbe
  ## @param grafana.startupProbe.successThreshold Success threshold for startupProbe
  ##
  startupProbe:
    enabled: false
    path: /api/health
    scheme: HTTP
    initialDelaySeconds: 30
    periodSeconds: 10
    timeoutSeconds: 5
    failureThreshold: 6
    successThreshold: 1
  ## @param grafana.customLivenessProbe Custom livenessProbe that overrides the default one
  ##
  customLivenessProbe: {}
  ## @param grafana.customReadinessProbe Custom readinessProbe that overrides the default one
  ##
  customReadinessProbe: {}
  ## @param grafana.customStartupProbe Custom startupProbe that overrides the default one
  ##
  customStartupProbe: {}
  ## @param grafana.lifecycleHooks for the Grafana container(s) to automate configuration before or after startup
  ##
  lifecycleHooks: {}
  ## @param grafana.sidecars Attach additional sidecar containers to the Grafana pod
  ## Example:
  ## sidecars:
  ##   - name: your-image-name
  ##     image: your-image
  ##     imagePullPolicy: Always
  ##     ports:
  ##       - name: portname
  ##         containerPort: 1234
  ##
  sidecars: []
  ## @param grafana.initContainers Add additional init containers to the Grafana pod(s)
  ## ref: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
  ## e.g:
  ## initContainers:
  ##  - name: your-image-name
  ##    image: your-image
  ##    imagePullPolicy: Always
  ##    command: ['sh', '-c', 'echo "hello world"']
  ##
  initContainers: []
  ## @param grafana.extraVolumes Additional volumes for the Grafana pod
  ## Example:
  ## extraVolumes:
  ##   - name: my-volume
  ##     emptyDir: {}
  ##
  extraVolumes: []
  ## @param grafana.extraVolumeMounts Additional volume mounts for the Grafana container
  ## Example:
  ## extraVolumeMounts:
  ##   - name: my-volume
  ##     mountPath: /opt/bitnami/grafana/my-stuff
  ##
  extraVolumeMounts: []
  ## @param grafana.extraEnvVarsCM Name of existing ConfigMap containing extra env vars for Grafana nodes
  ##
  extraEnvVarsCM: ""
  ## @param grafana.extraEnvVarsSecret Name of existing Secret containing extra env vars for Grafana nodes
  ##
  extraEnvVarsSecret: ""
  ## @param grafana.extraEnvVars Array containing extra env vars to configure Grafana
  ## For example:
  ## extraEnvVars:
  ##  - name: GF_DEFAULT_INSTANCE_NAME
  ##    value: my-instance
  ##
  extraEnvVars: []
  ## @param grafana.extraConfigmaps Array to mount extra ConfigMaps to configure Grafana
  ## For example:
  ## extraConfigmaps:
  ##   - name: myconfigmap
  ##     mountPath: /opt/bitnami/desired-path
  ##     subPath: file-name.extension (optional)
  ##     readOnly: true
  ##
  extraConfigmaps: []
  ## @param grafana.command Override default container command (useful when using custom images)
  ##
  command: []
  ## @param grafana.args Override default container args (useful when using custom images)
  ##
  args: []

## @section Persistence parameters

## Enable persistence using Persistent Volume Claims
## ref: https://kubernetes.io/docs/user-guide/persistent-volumes/
## @param persistence.enabled Enable persistence
## @param persistence.annotations Persistent Volume Claim annotations
## @param persistence.accessMode Persistent Volume Access Mode
## @param persistence.accessModes Persistent Volume Access Modes
## @param persistence.storageClass Storage class to use with the PVC
## @param persistence.existingClaim If you want to reuse an existing claim, you can pass the name of the PVC using the existingClaim variable
## @param persistence.size Size for the PV
##
persistence:
  enabled: true
  ## If defined, storageClassName: <storageClass>
  ## If set to "-", storageClassName: "", which disables dynamic provisioning
  ## If undefined (the default) or set to null, no storageClassName spec is
  ##   set, choosing the default provisioner.  (gp2 on AWS, standard on
  ##   GKE, AWS & OpenStack)
  ##
  storageClass: ""
  annotations: {}
  existingClaim: ""
  accessMode: ReadWriteOnce
  accessModes: []
  size: 10Gi

## @section RBAC parameters

## @param serviceAccount.create Specifies whether a ServiceAccount should be created
## @param serviceAccount.name The name of the ServiceAccount to use. If not set and create is true, a name is generated using the fullname template
## @param serviceAccount.annotations Annotations to add to the ServiceAccount Metadata
## @param serviceAccount.automountServiceAccountToken Automount service account token for the application controller service account
serviceAccount:
  create: true
  name: ""
  annotations: {}
  automountServiceAccountToken: false

## @section Traffic exposure parameters

## Service parameters
##
service:
  ## @param service.type Kubernetes Service type
  ##
  type: ClusterIP
  ## @param service.clusterIP Grafana service Cluster IP
  ## e.g.:
  ## clusterIP: None
  ##
  clusterIP: ""
  ## @param service.ports.grafana Grafana service port
  ##
  ports:
    grafana: 3000
  ## @param service.nodePorts.grafana Specify the nodePort value for the LoadBalancer and NodePort service types
  ## ref: https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport
  ##
  nodePorts:
    grafana: ""
  ## @param service.loadBalancerIP loadBalancerIP if Grafana service type is `LoadBalancer` (optional, cloud specific)
  ## ref: https://kubernetes.io/docs/user-guide/services/#type-loadbalancer
  ##
  loadBalancerIP: ""
  ## @param service.loadBalancerClass loadBalancerClass if Grafana service type is `LoadBalancer` (optional, cloud specific)
  ## ref: https://kubernetes.io/docs/user-guide/services/#type-loadbalancer
  ##
  loadBalancerClass: ""
  ## @param service.loadBalancerSourceRanges loadBalancerSourceRanges if Grafana service type is `LoadBalancer` (optional, cloud specific)
  ## ref: https://kubernetes.io/docs/user-guide/services/#type-loadbalancer
  ## e.g:
  ## loadBalancerSourceRanges:
  ##   - 10.10.10.0/24
  ##
  loadBalancerSourceRanges: []
  ## @param service.annotations Provide any additional annotations which may be required.
  ## This can be used to set the LoadBalancer service type to internal only.
  ## ref: https://kubernetes.io/docs/concepts/services-networking/service/#internal-load-balancer
  ##
  annotations: {}
  ## @param service.externalTrafficPolicy Grafana service external traffic policy
  ## ref https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip
  ##
  externalTrafficPolicy: Cluster
  ## @param service.extraPorts Extra port to expose on Grafana service
  ##
  extraPorts: []
  ## @param service.sessionAffinity Session Affinity for Kubernetes service, can be "None" or "ClientIP"
  ## If "ClientIP", consecutive client requests will be directed to the same Pod
  ## ref: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
  ##
  sessionAffinity: None
  ## @param service.sessionAffinityConfig Additional settings for the sessionAffinity
  ## sessionAffinityConfig:
  ##   clientIP:
  ##     timeoutSeconds: 300
  ##
  sessionAffinityConfig: {}
## Configure the ingress resource that allows you to access the
## Grafana installation. Set up the URL
## ref: https://kubernetes.io/docs/user-guide/ingress/
##
ingress:
  ## @param ingress.enabled Set to true to enable ingress record generation
  ##
  enabled: true
  ## DEPRECATED: Use ingress.annotations instead of ingress.certManager
  ## certManager: false
  ##

  ## @param ingress.pathType Ingress Path type
  ##
  pathType: ImplementationSpecific
  ## @param ingress.apiVersion Override API Version (automatically detected if not set)
  ##
  apiVersion: ""
  ## @param ingress.hostname When the ingress is enabled, a host pointing to this will be created
  ##
  hostname: ${host_name}
  ## @param ingress.path Default path for the ingress resource
  ## The Path to Grafana. You may need to set this to '/*' in order to use this with ALB ingress controllers.
  ##
  path: /
  ## @param ingress.annotations Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations.
  ## For a full list of possible ingress annotations, please see
  ## ref: https://github.com/kubernetes/ingress-nginx/blob/master/docs/user-guide/nginx-configuration/annotations.md
  ## Use this parameter to set the required annotations for cert-manager, see
  ## ref: https://cert-manager.io/docs/usage/ingress/#supported-annotations
  ##
  ## e.g:
  ## annotations:
  ##   kubernetes.io/ingress.class: nginx
  ##   cert-manager.io/cluster-issuer: cluster-issuer-name
  ##
  annotations: {}
  ## @param ingress.tls Enable TLS configuration for the hostname defined at ingress.hostname parameter
  ## TLS certificates will be retrieved from a TLS secret with name: {{- printf "%s-tls" .Values.ingress.hostname }}
  ## You can use the ingress.secrets parameter to create this TLS secret or relay on cert-manager to create it
  ##
  tls: false
  ## @param ingress.extraHosts The list of additional hostnames to be covered with this ingress record.
  ## Most likely the hostname above will be enough, but in the event more hosts are needed, this is an array
  ## extraHosts:
  ## - name: grafana.local
  ##   path: /
  ##
  extraHosts: []
  ## @param ingress.extraPaths Any additional arbitrary paths that may need to be added to the ingress under the main host.
  ## For example: The ALB ingress controller requires a special rule for handling SSL redirection.
  ## extraPaths:
  ## - path: /*
  ##   backend:
  ##     serviceName: ssl-redirect
  ##     servicePort: use-annotation
  ##
  extraPaths: []
  ## @param ingress.extraTls The tls configuration for additional hostnames to be covered with this ingress record.
  ## see: https://kubernetes.io/docs/concepts/services-networking/ingress/#tls
  ## extraTls:
  ## - hosts:
  ##     - grafana.local
  ##   secretName: grafana.local-tls
  ##
  extraTls: []
  ## @param ingress.secrets If you're providing your own certificates, please use this to add the certificates as secrets
  ## key and certificate should start with -----BEGIN CERTIFICATE----- or
  ## -----BEGIN RSA PRIVATE KEY-----
  ##
  ## name should line up with a tlsSecret set further up
  ## If you're using cert-manager, this is unneeded, as it will create the secret for you if it is not set
  ##
  ## @param ingress.secrets It is also possible to create and manage the certificates outside of this helm chart
  ## Please see README.md for more information
  ## e.g:
  ## - name: grafana.local-tls
  ##   key:
  ##   certificate:
  ##
  secrets: []
  ## @param ingress.selfSigned Create a TLS secret for this ingress record using self-signed certificates generated by Helm
  ##
  selfSigned: false
  ## @param ingress.ingressClassName IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)
  ingressClassName: ${ingress_class_name}
  ## @param ingress.extraRules Additional rules to be covered with this ingress record
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

## @section Metrics parameters

## Prometheus metrics
##
metrics:
  ## @param metrics.enabled Enable the export of Prometheus metrics
  ##
  enabled: false
  ## Prometheus Operator ServiceMonitor configuration
  ## @param metrics.service.annotations [object] Annotations for Prometheus metrics service
  ##
  service:
    annotations:
      prometheus.io/scrape: "true"
      prometheus.io/port: "3000"
      prometheus.io/path: "/metrics"
  serviceMonitor:
    ## @param metrics.serviceMonitor.enabled if `true`, creates a Prometheus Operator ServiceMonitor (also requires `metrics.enabled` to be `true`)
    ##
    enabled: false
    ## @param metrics.serviceMonitor.namespace Namespace in which Prometheus is running
    ##
    namespace: ""
    ## @param metrics.serviceMonitor.interval Interval at which metrics should be scraped.
    ## ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#endpoint
    ## e.g:
    ## interval: 10s
    ##
    interval: ""
    ## @param metrics.serviceMonitor.scrapeTimeout Timeout after which the scrape is ended
    ## ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#endpoint
    ## e.g:
    ## scrapeTimeout: 10s
    ##
    scrapeTimeout: ""
    ## @param metrics.serviceMonitor.selector Prometheus instance selector labels
    ## ref: https://github.com/bitnami/charts/tree/main/bitnami/prometheus-operator#prometheus-configuration
    ## e.g:
    ## selector:
    ##   prometheus: my-prometheus
    ##
    selector: {}
    ## @param metrics.serviceMonitor.relabelings RelabelConfigs to apply to samples before scraping
    ## ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#relabelconfig
    ##
    relabelings: []
    ## @param metrics.serviceMonitor.metricRelabelings MetricRelabelConfigs to apply to samples before ingestion
    ## ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#relabelconfig
    ##
    metricRelabelings: []
    ## @param metrics.serviceMonitor.honorLabels Labels to honor to add to the scrape endpoint
    ##
    honorLabels: false
    ## DEPRECATED metrics.serviceMonitor.additionalLabels - It will be removed in a future release, please use metrics.serviceMonitor.labels instead
    ## @param metrics.serviceMonitor.labels Additional custom labels for the ServiceMonitor
    ##
    labels: {}
    ## @param metrics.serviceMonitor.jobLabel The name of the label on the target service to use as the job name in prometheus.
    ##
    jobLabel: ""
  ## Prometheus Operator PrometheusRule configuration
  ##
  prometheusRule:
    ## @param metrics.prometheusRule.enabled if `true`, creates a Prometheus Operator PrometheusRule (also requires `metrics.enabled` to be `true` and `metrics.prometheusRule.rules`)
    ##
    enabled: false
    ## @param metrics.prometheusRule.namespace Namespace for the PrometheusRule Resource (defaults to the Release Namespace)
    ##
    namespace: ""
    ## @param metrics.prometheusRule.additionalLabels Additional labels that can be used so PrometheusRule will be discovered by Prometheus
    ##
    additionalLabels: {}
    ## @param metrics.prometheusRule.rules PrometheusRule rules to configure
    ## e.g:
    ##  - alert: Grafana-Down
    ##    annotations:
    ##      message: 'Grafana instance is down'
    ##      summary: Grafana instance is down
    ##    expr: absent(up{job="grafana"} == 1)
    ##    labels:
    ##      severity: warning
    ##      service: grafana
    ##    for: 5m
    ##
    rules: []

## @section Volume permissions init Container Parameters

## 'volumePermissions' init container parameters
## Changes the owner and group of the persistent volume mount point to runAsUser:fsGroup values
##   based on the `grafana:podSecurityContext`/`grafana:containerSecurityContext`` parameters
## May require setting `grafana:podSecurityContext:runAsNonRoot` to false
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
  ## @param volumePermissions.image.digest OS Shell + Utility image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag
  ## @param volumePermissions.image.pullPolicy OS Shell + Utility image pull policy
  ## @param volumePermissions.image.pullSecrets OS Shell + Utility image pull secrets
  ##
  image:
    registry: docker.io
    repository: bitnami/os-shell
    tag: 11-debian-11-r91
    digest: ""
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
  ## ref: https://kubernetes.io/docs/user-guide/compute-resources/
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

## @section Diagnostic Mode Parameters

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
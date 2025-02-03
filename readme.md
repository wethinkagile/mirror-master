
# NÖVOG Openshift cluster setup

## Installation

### Setup Registry for Disconnected cluster

Follow the documentation:
https://confluence.frequentis.frq/display/FOIF/OCP+Disconnected+Installation+-+Mirror+setup

### Install cluster with UPI

Use the install-config.yaml from the install folder. SSH Kex and Pull secret need to be added. The certificate of the mirror registry needs
to be added as additionalTrustBundle

Include additional manifests

Follow the documentation:
https://confluence.frequentis.frq/pages/viewpage.action?pageId=307031219



## Cluster Configuration

### Patch the ingresscontroller to use a LoadBalancer IP
```bash
oc patch ingresscontroller default -n openshift-ingress-operator --type='merge' -p '{"spec": {"endpointPublishingStrategy": {"type": "LoadBalancerService", "loadBalancer": {"scope": "External"}}, "nodePlacement": {"nodeSelector": {"matchLabels": {"node-role.kubernetes.io/worker": ""}}}}}'
```

```yaml
spec:
  clientTLS:
    clientCA:
      name: ""
    clientCertificatePolicy: ""
  endpointPublishingStrategy:
    loadBalancer:
      dnsManagementPolicy: Managed
      scope: External
    type: LoadBalancerService
  httpCompression: {}
  httpEmptyRequestsPolicy: Respond
  httpErrorCodePages:
    name: ""
  nodePlacement:
    nodeSelector:
      matchLabels:
        node-role.kubernetes.io/worker: ""
  tuningOptions:
    reloadInterval: 0s
  unsupportedConfigOverrides: null
```

### Setup MetalLB



### Storage - Longhorn

Install with Helm chart https://git.frequentis.frq/projects/BB-IFOIF/repos/longhorn_helm/browse?at=refs%2Fheads%2FPT%2Fnoevog
PT/noevog branch

### Ingress - Traefik

Install with Helm chart https://git.frequentis.frq/projects/BB-IFOIF/repos/traefik_helm/browse?at=refs%2Fheads%2FPT%2Fnoevog
PT/noevog branch

### Setup 
# Image Registry Setup

## Enable internal image registry

Storage provider needs to be configured first

```bash
oc apply -f pvc.yaml
```

Edit the openshift image registry config
- managementState: Managed
- defaultRoute: true
- add pvc
  - claim: image-registry-storage

```bash
oc edit -n openshift-image-registry configs.imageregistry.operator.openshift.io cluster
```

```yaml
defaultRoute: true
  httpSecret: 2b05dd336e06452c8cfae087dfbf91cd952fc0b6b98e883dc8cb3013bd730f9604e063fd40e1bfdb8fcef7e619b15e649ee42555193d50154fa2f7b4e882a3bb
  logLevel: Normal
  managementState: Managed
  observedConfig: null
  operatorLogLevel: Normal
  proxy: {}
  replicas: 1
  requests:
    read:
      maxWaitInQueue: 0s
    write:
      maxWaitInQueue: 0s
  rolloutStrategy: Recreate
  storage:
    managementState: Unmanaged
    pvc:
      claim: image-registry-storage
```

## Mirror openshift release

Mirror openshift/release packages to the internal registry

```bash
export OCP_RELEASE=4.17.12
export LOCAL_REGISTRY='registry.apps.noevog.ocp.projects.frequentis.frq'
export LOCAL_REPOSITORY='openshift'
export PRODUCT_REPO='openshift-release-dev'
export LOCAL_SECRET_JSON='.docker/config.json'
export RELEASE_NAME="ocp-release"
export ARCHITECTURE=x86_64

oc adm release mirror -a ${LOCAL_SECRET_JSON} --from=quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE}-${ARCHITECTURE} --to=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY} --to-release-image=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY}:${OCP_RELEASE}-${ARCHITECTURE}
```

## Use skopeo to transfer images from skopeo

Example Traefik:
```bash
skopeo copy --dest-tls-verify=false docker://foif.rel.dkr.frequentis.frq/traefik/traefik:v3.3.2 docker://registry.openshift.local:3000/frqadmin/traefik/traefik:v3.3.2
skopeo copy --dest-tls-verify=false docker://registry.openshift.local:3000/frqadmin/traefik/traefik:v3.3.2 docker://registry.apps.noevog.ocp.projects.frequentis.frq/traefik-ingress/traefik:v3.3.2
```

Apply the resulting ImageContentSourcePolicy
```bash
oc apply -f mirror.yaml
```

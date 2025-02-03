
# Metallb configuration

## Install Metallb

Install metallb through the operatorhub or with subscription and operatorgroup resources

## Deploy custom resources

Adjust and apply the MetalLB, IPaddressPools and the L2advertisement resources
```bash
oc apply -f metallb.yaml
oc apply -f *_ipaddresspool.yaml
oc apply -f l2-advert.yaml
```

## Openshift API - Virtual IP

Create a service with a loadbalancer IP for the API

```bash
oc apply -f api_svc.yaml
```
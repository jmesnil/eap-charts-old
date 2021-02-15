# Develop the Helm Charts for WildFly

## Prerequisites

* Access to an OpenShift cluster and `oc` client
* Log to OpenShift with `oc login`
* Install Helm from https://helm.sh
* Clone this repository

## Local installation

Helm Charts can be installed directly from this repository

```
helm upgrade my-eap-app ./charts/eap73 -f examples/my-app-s2i.yaml  --debug
```
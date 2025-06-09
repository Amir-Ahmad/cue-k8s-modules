# cue-k8s-modules

Monorepo for some kubernetes related [cue modules](https://cuelang.org/docs/reference/modules/).

## modules

### app
The app module provides a high-level abstraction for defining Kubernetes applications using CUE. You can use it to generate one or more controllers (Deployments/StatefulSet/DaemonSet/CronJob/Job), along with some common resources such as ConfigMaps or Services. It helps to reduce boilerplate.

### k8s-schema

The k8s-schema module provides CUE definitions for Kubernetes API resources such as Deployment, Service, Pod, etc. This also includes the new Gateway APIs https://github.com/kubernetes-sigs/gateway-api.

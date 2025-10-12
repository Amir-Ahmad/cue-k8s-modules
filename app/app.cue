package app

import (
	"list"
	"encoding/json"
	"encoding/base64"
	"crypto/sha256"

	"github.com/amir-ahmad/cue-k8s-modules/app/k8s"
)

#AppConfig: X={
	// name is used to create a unique app label
	name: string

	// Additional k8s objects can be defined in the object field.
	// `object: namespaced: $kind: $name: {...}` for namespaced
	// `object: clusterscoped: $kind: $name: {...}` for cluster scoped
	// Namespaced objects will have common.namespace set as default.
	object: #ObjectMap
	object: [T=string]: [string]: [string]: {
		metadata: labels: X.common.labels
		if T == "namespaced" {
			metadata: namespace: string | *common.namespace
		}
	}

	// Common settings apply to all resources
	common: {
		// Specify a default namespace for namespaced resources. Can be overwritten by metadata.namespace on any resource
		namespace!: string

		// Labels will be added to all resources
		labels: [string]:                 string
		labels: "app.kubernetes.io/name": X.name

		// podLabels will be set on all templated pods
		podLabels: [string]: string
	}

	let commonMetadata = {
		namespace: string | *X.common.namespace
		labels:    X.common.labels
	}

	controller: [n=string]: C={
		metadata: commonMetadata & {
			name:   string | *n
			labels: selectorLabels
		}

		service: metadata: commonMetadata & {
			name:      string | *n
			namespace: C.metadata.namespace
			labels:    selectorLabels
		}

		pod: metadata: labels: common.podLabels & selectorLabels

		selectorLabels: {
			"app.kubernetes.io/name":      X.name
			"app.kubernetes.io/component": n
		}
	} & #ControllerConfig

	configmap: [n=string]: #ConfigMapConfig & {
		metadata: commonMetadata & {name: string | *n}
	}

	// When rollControllers is set, add a checksum to force a restart whenever configmap changes.
	for k, v in configmap if len(v.rollControllers) > 0 {
		let _checksum = base64.Encode(null, sha256.Sum256(json.Marshal(v.data)))
		for cont in v.rollControllers {
			controller: (cont): pod: metadata: labels: "config/\(k)/checksum": _checksum
		}
	}

	// Ingress is a simple abstraction over HTTPRoute or Ingress,
	// which assumes a single route with all traffic.
	// For advanced use cases you may want to use object: instead.
	ingress: [n=string]: #IngressConfig & {
		metadata: commonMetadata & {name: string | *n}
	}

	// Any additional fields or properties can be set under `x:`
	// This allows for additional abstractions and logic that is specific to your use case.
	// e.g. You can create a property: `"x.enableIstio": bool`, and when true,
	// add a sidecar.istio.io/inject label to inject with istio.
	// Full example: app/tests/extra_property_istio_test.txtar
	x: {...}
}

#App: {
	c=config: #AppConfig

	// k8s objects in format Kind: Namespace: Name: {}
	object: [string]: [string]: [string]: k8s.#Object

	for n, cmap in c.configmap {
		let obj = (#ConfigMap & {#config: cmap}).out
		object: ConfigMap: "\(obj.metadata.namespace)": "\(obj.metadata.name)": obj
	}

	for n, controller in c.controller {
		// Add controller objects
		for obj in (#Controller & {#config: controller}).out {
			object: "\(obj.kind)": "\(obj.metadata.namespace)": "\(obj.metadata.name)": obj
		}
	}

	for ingress in c.ingress {
		let obj = (#Ingress & {#config: ingress}).out
		object: "\(obj.kind)": "\(obj.metadata.namespace)": "\(obj.metadata.name)": obj
	}

	// output abstracted objects along with any objects defined in #AppConfig
	out: list.Concat([[
		for kind in object
		for ns in kind
		for obj in ns {obj},
	], [
		for type in c.object
		for kind in type
		for obj in kind {obj},
	]])
}

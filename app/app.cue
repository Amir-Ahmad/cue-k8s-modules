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

	controller: [n=string]: #ControllerConfig & {
		metadata: commonMetadata & {
			name:   string | *n
			labels: selectorLabels
		}
		pod: {
			containerName: string | *n
			labels:        common.podLabels & selectorLabels
		}

		selectorLabels: {
			"app.kubernetes.io/name":      X.name
			"app.kubernetes.io/component": n
		}
	}

	configmap: [n=string]: #ConfigMapConfig & {
		metadata: commonMetadata & {name: string | *n}
	}
}

#App: {
	c=config: #AppConfig

	// k8s objects in format Kind: Namespace: Name: {}
	object: [string]: [string]: [string]: k8s.#Object

	// map of per controller config generated here and unified with controller config
	_controllerPatch: [string]: #ControllerCommon

	for n, cmap in c.configmap {
		let obj = (#ConfigMap & {#config: cmap}).out
		object: ConfigMap: "\(obj.metadata.namespace)": "\(obj.metadata.name)": obj
		let _checksum = base64.Encode(null, sha256.Sum256(json.Marshal(cmap.data)))

		// add configmap checksum to automatically restart pods of controllers
		for cont in cmap.rollControllers {
			_controllerPatch: "\(cont)": pod: labels: "config/\(n)/checksum": _checksum
		}
	}

	for n, controller in c.controller {
		_controllerPatch: "\(n)": #ControllerCommon

		// Add controller objects
		for obj in (#Controller & {#config: controller & _controllerPatch[n]}).out {
			object: "\(obj.kind)": "\(obj.metadata.namespace)": "\(obj.metadata.name)": obj
		}
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

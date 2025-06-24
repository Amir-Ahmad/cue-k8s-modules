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

	// additional k8s objects in format Kind: Name: {}
	object: [K=string]: [N=string]: k8s.#Object & {
		kind: string | *K
		metadata: {
			name:      string | *N
			namespace: string | *common.namespace
			labels:    common.labels
		}
	}

	// Common settings apply to all resources
	common: {
		// Specify a default namespace. Can be overwritten by metadata.namespace on any resource
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
	objects: [string]: [string]: [string]: k8s.#Object

	// map of per controller config generated here and unified with controller config
	_controllerPatch: [string]: #ControllerCommon

	for n, cmap in c.configmap {
		let obj = (#ConfigMap & {#config: cmap}).out
		objects: ConfigMap: "\(obj.metadata.namespace)": "\(obj.metadata.name)": obj
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
			objects: "\(obj.kind)": "\(obj.metadata.namespace)": "\(obj.metadata.name)": obj
		}
	}

	// output abstracted objects along with any objects defined in #AppConfig
	outObjects: list.Concat([[
		for kind in objects
		for ns in kind
		for object in ns {object},
	], [
		for kind in c.object
		for obj in kind {obj},
	]])
}

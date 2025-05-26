package k8s

import (
	apps_v1 "cue.dev/x/k8s.io/api/apps/v1"
	core_v1 "cue.dev/x/k8s.io/api/core/v1"
	net_v1 "cue.dev/x/k8s.io/api/networking/v1"
	batch_v1 "cue.dev/x/k8s.io/api/batch/v1"
	storage_v1 "cue.dev/x/k8s.io/api/storage/v1"
	meta_v1 "cue.dev/x/k8s.io/apimachinery/pkg/apis/meta/v1"
)

#StatefulSet: apps_v1.#StatefulSet & {
	apiVersion: "apps/v1"
	kind:       "StatefulSet"
}

#DaemonSet: apps_v1.#DaemonSet & {
	apiVersion: "apps/v1"
	kind:       "DaemonSet"
}

#Deployment: apps_v1.#Deployment & {
	apiVersion: "apps/v1"
	kind:       "Deployment"
}

#CronJob: batch_v1.#CronJob & {
	apiVersion: "batch/v1"
	kind:       "CronJob"
}

#Job: batch_v1.#Job & {
	apiVersion: "batch/v1"
	kind:       "Job"
}

#Service: core_v1.#Service & {
	apiVersion: "v1"
	kind:       "Service"
}

#Ingress: net_v1.#Ingress & {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
}

#ConfigMap: core_v1.#ConfigMap & {
	apiVersion: "v1"
	kind:       "ConfigMap"
}

#StorageClass: storage_v1.#StorageClass & {
	apiVersion: "storage.k8s.io/v1"
	kind:       "StorageClass"
}

#Namespace: core_v1.#Namespace & {
	apiVersion: "v1"
	kind:       "Namespace"
}

#PersistentVolumeClaim: core_v1.#PersistentVolumeClaim & {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
}

#Metadata: meta_v1.#ObjectMeta

#VolumeMount:   core_v1.#VolumeMount
#Probe:         core_v1.#Probe
#Resources:     core_v1.#ResourceRequirements
#EnvFromSource: core_v1.#EnvFromSource

#Object: {
	// set some fields as mandatory.
	// TODO: uncomment when curated modules include #TypeMeta
	// meta_v1.#TypeMeta & {
	// 	apiVersion!: string
	// 	kind!:       string
	// }
	apiVersion!: string
	kind!:       string

	metadata: meta_v1.#ObjectMeta & {
		name!: string
	}
	...
}

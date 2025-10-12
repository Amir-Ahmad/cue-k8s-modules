package k8s

import (
	apps_v1 "github.com/amir-ahmad/cue-k8s-modules/k8s-schema/pkg/k8s.io/api/apps/v1"
	core_v1 "github.com/amir-ahmad/cue-k8s-modules/k8s-schema/pkg/k8s.io/api/core/v1"
	net_v1 "github.com/amir-ahmad/cue-k8s-modules/k8s-schema/pkg/k8s.io/api/networking/v1"
	batch_v1 "github.com/amir-ahmad/cue-k8s-modules/k8s-schema/pkg/k8s.io/api/batch/v1"
	storage_v1 "github.com/amir-ahmad/cue-k8s-modules/k8s-schema/pkg/k8s.io/api/storage/v1"
	meta_v1 "github.com/amir-ahmad/cue-k8s-modules/k8s-schema/pkg/k8s.io/apimachinery/pkg/apis/meta/v1"
	rbac_v1 "github.com/amir-ahmad/cue-k8s-modules/k8s-schema/pkg/k8s.io/api/rbac/v1"
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

#Secret: core_v1.#Secret & {
	apiVersion: "v1"
	kind:       "Secret"
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

#ServiceAccount: core_v1.#ServiceAccount & {
	apiVersion: "v1"
	kind:       "ServiceAccount"
}

#Role: rbac_v1.#Role & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Role"
}

#RoleBinding: rbac_v1.#RoleBinding & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
}

#ClusterRole: rbac_v1.#ClusterRole & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
}

#ClusterRoleBinding: rbac_v1.#ClusterRoleBinding & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
}

#NetworkPolicy: net_v1.#NetworkPolicy & {
	apiVersion: "networking.k8s.io/v1"
	kind:       "NetworkPolicy"
}

#Metadata: meta_v1.#ObjectMeta

#VolumeMount:     core_v1.#VolumeMount
#Probe:           core_v1.#Probe
#Resources:       core_v1.#ResourceRequirements
#EnvFromSource:   core_v1.#EnvFromSource
#Container:       core_v1.#Container
#PodTemplateSpec: core_v1.#PodTemplateSpec

#Object: {
	// set some fields as mandatory.
	meta_v1.#TypeMeta & {
		apiVersion!: string
		kind!:       string
	}

	metadata: meta_v1.#ObjectMeta & {
		name!: string
	}
	...
}

package app

import (
	"github.com/amir-ahmad/cue-k8s-modules/app/k8s"
	eso_v1 "github.com/amir-ahmad/cue-k8s-modules/k8s-schema/pkg/external-secrets.io/v1"
	gateway_v1 "github.com/amir-ahmad/cue-k8s-modules/k8s-schema/pkg/gateway.networking.k8s.io/v1"
)

#ObjectMap: ["namespaced" | "clusterscoped"]: [K=string]: [N=string]: k8s.#Object & {
	kind: string | *K
	metadata: name: string | *N
}

// Add typing for a bunch of common resources

// Namespaced resources
#ObjectMap: namespaced: ConfigMap?: [string]:             k8s.#ConfigMap
#ObjectMap: namespaced: Secret?: [string]:                k8s.#Secret
#ObjectMap: namespaced: Service?: [string]:               k8s.#Service
#ObjectMap: namespaced: Deployment?: [string]:            k8s.#Deployment
#ObjectMap: namespaced: StatefulSet?: [string]:           k8s.#StatefulSet
#ObjectMap: namespaced: DaemonSet?: [string]:             k8s.#DaemonSet
#ObjectMap: namespaced: Job?: [string]:                   k8s.#Job
#ObjectMap: namespaced: CronJob?: [string]:               k8s.#CronJob
#ObjectMap: namespaced: Ingress?: [string]:               k8s.#Ingress
#ObjectMap: namespaced: ServiceAccount?: [string]:        k8s.#ServiceAccount
#ObjectMap: namespaced: Role?: [string]:                  k8s.#Role
#ObjectMap: namespaced: RoleBinding?: [string]:           k8s.#RoleBinding
#ObjectMap: namespaced: NetworkPolicy?: [string]:         k8s.#NetworkPolicy
#ObjectMap: namespaced: PersistentVolumeClaim?: [string]: k8s.#PersistentVolumeClaim

// Cluster scoped resources
#ObjectMap: clusterscoped: Namespace?: [string]:          k8s.#Namespace
#ObjectMap: clusterscoped: StorageClass?: [string]:       k8s.#StorageClass
#ObjectMap: clusterscoped: ClusterRole?: [string]:        k8s.#ClusterRole
#ObjectMap: clusterscoped: ClusterRoleBinding?: [string]: k8s.#ClusterRoleBinding
#ObjectMap: clusterscoped: PersistentVolume?: [string]:   k8s.#PersistentVolume

// Some common CRDs
#ObjectMap: namespaced: ExternalSecret?: [string]:           eso_v1.#ExternalSecret
#ObjectMap: namespaced: SecretStore?: [string]:              eso_v1.#SecretStore
#ObjectMap: clusterscoped: ClusterSecretStore?: [string]:    eso_v1.#ClusterSecretStore
#ObjectMap: clusterscoped: ClusterExternalSecret?: [string]: eso_v1.#ClusterExternalSecret
#ObjectMap: namespaced: Gateway?: [string]:                  gateway_v1.#Gateway
#ObjectMap: namespaced: HTTPRoute?: [string]:                gateway_v1.#HTTPRoute
#ObjectMap: namespaced: GRPCRoute?: [string]:                gateway_v1.#GRPCRoute
#ObjectMap: namespaced: BackendTLSPolicy?: [string]:         gateway_v1.#BackendTLSPolicy
#ObjectMap: clusterscoped: GatewayClass?: [string]:          gateway_v1.#GatewayClass

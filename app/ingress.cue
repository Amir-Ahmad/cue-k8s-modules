package app

import (
	"list"
	"github.com/amir-ahmad/cue-k8s-modules/app/k8s"
	gateway_v1 "github.com/amir-ahmad/cue-k8s-modules/k8s-schema/pkg/gateway.networking.k8s.io/v1"
)

#IngressType:   "Ingress"
#HTTPRouteType: "HTTPRoute"

#IngressConfig: {
	type!:    #IngressType | #HTTPRouteType
	metadata: k8s.#Metadata
	hostnames: [...string] & list.MinItems(1)
	serviceName!: string
	servicePort!: int

	// Allow directly specifying any property of ingress/httproute at spec.
	spec: {...}
}

#Ingress: {
	c=#config: #IngressConfig

	out: {
		metadata: c.metadata
		spec:     c.spec
	}

	if c.type == #IngressType {
		out: k8s.#Ingress & {spec: {
			rules: [
				for h in c.hostnames {
					host: h
					http: paths: [{
						backend: service: {
							name: c.serviceName
							port: "number": c.servicePort
						}
						path:     "/"
						pathType: "Prefix"
					}]
				},
			]
		}}
	}

	if c.type == #HTTPRouteType {
		out: gateway_v1.#HTTPRoute & {spec: {
			hostnames: c.hostnames
			backendRefs: [{
				name: c.serviceName
				port: c.servicePort
			}]
		}}
	}
}

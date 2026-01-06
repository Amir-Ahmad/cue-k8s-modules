package app

import (
	"list"
	"github.com/amir-ahmad/cue-k8s-modules/app/k8s"
	gateway_v1 "github.com/amir-ahmad/cue-k8s-modules/k8s-schema/pkg/gateway.networking.k8s.io/v1"
	gateway_v1alpha2 "github.com/amir-ahmad/cue-k8s-modules/k8s-schema/pkg/gateway.networking.k8s.io/v1alpha2"
)

#IngressType:   "Ingress"
#HTTPRouteType: "HTTPRoute"
#TCPRouteType:  "TCPRoute"

#IngressConfig: {
	type!:    #IngressType | #HTTPRouteType | #TCPRouteType
	metadata: k8s.#Metadata
	hostnames?: [...string] & list.MinItems(1)
	serviceName!: string
	servicePort!: int

	if type != #TCPRouteType {
		hostnames!: [...string] & list.MinItems(1)
	}

	// Allow directly specifying any property of ingress/httproute at spec.
	spec: {...}

	// This can be used to add additional properties to the default rule.
	// This is not applicable to Ingress.
	ruleSpec: {...}

	// Any additional fields or properties can be set under `x:`
	// This allows for additional abstractions and logic that is specific to your use case.
	x: {...}
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
			rules: [{
				matches: [{
					path: {
						type:  "PathPrefix"
						value: "/"
					}
				}]
				backendRefs: [{
					name: c.serviceName
					port: c.servicePort
				}]
			} & c.ruleSpec]
		}}
	}

	if c.type == #TCPRouteType {
		out: gateway_v1alpha2.#TCPRoute & {spec: {
			rules: [{
				backendRefs: [{
					name: c.serviceName
					port: c.servicePort
				}]
			} & c.ruleSpec]
		}}
	}
}

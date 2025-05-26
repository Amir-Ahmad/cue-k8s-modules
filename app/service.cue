package app

import (
	"github.com/amir-ahmad/cue-k8s-modules/app/k8s"
)

#ServiceConfig: {
	metadata: k8s.#Metadata
	selectorLabels: [string]: string

	ports: [...#Port]

	// pass through specs including type
	spec: {...}
}

#Service: {
	c=#config: #ServiceConfig

	out: k8s.#Service & {
		metadata: c.metadata
		spec: ports: [for x in c.ports {
			name:       x.name
			port:       x.port
			targetPort: x.port
			protocol:   x.protocol
			if x.nodePort != _|_ {
				nodePort: x.nodePort
			}
		}]

		spec: selector: c.selectorLabels

		spec: c.spec
	}
}

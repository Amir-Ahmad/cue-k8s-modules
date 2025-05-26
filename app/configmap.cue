package app

import (
	"github.com/amir-ahmad/cue-k8s-modules/app/k8s"
)

#ConfigMapConfig: {
	metadata: k8s.#Metadata
	// list of controllers to roll when configmap changes
	rollControllers: [...string]
	data: {...}
}

#ConfigMap: {
	c=#config: #ConfigMapConfig

	out: k8s.#ConfigMap & {
		metadata: c.metadata
		data:     c.data
	}
}

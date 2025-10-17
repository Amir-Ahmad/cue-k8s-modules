package app

import (
	"github.com/amir-ahmad/cue-k8s-modules/app/k8s"
)

#PodConfig: {
	metadata: k8s.#Metadata

	container: [N=string]: #ContainerConfig & {
		name: string | *N
		for v in volume for c, cMounts in v.mount for path, mount in cMounts if N == c {
			volumeMount: (path): mount
		}
	}
	initContainer: [N=string]: #ContainerConfig & {
		name: string | *N
		for v in volume for c, cMounts in v.mount for path, mount in cMounts if N == c {
			volumeMount: (path): mount
		}
	}

	volume: [N=string]: X={
		name: *N | string
		// Mount the volume to a container using its name.
		// e.g. `mount: app: "/config": {}` will mount the volume to app container at "/config".
		mount: [Container=string]: [Path=string]: k8s.#VolumeMount & {
			mountPath: Path
			name:      X.name
		}

		// allow any property to be sent through in the exact same format as k8s.
		// e.g. emptyDir: {}
		...
	}

	// Any other pod spec can be set here.
	spec: {...}
}

#PodTemplate: {
	c=#config: #PodConfig

	out: k8s.#PodTemplateSpec & {
		metadata: c.metadata
		spec: c.spec & {
			containers: [
				for x in c.container {(#Container & {#config: {x}}).out},
			]

			let _initContainers = [
				for x in c.initContainer {(#Container & {#config: {x}}).out},
			]

			if len(_initContainers) > 0 {
				initContainers: _initContainers
			}

			let _volumes = [for vol in c.volume {
				name: vol.name
				for k, v in vol if k != "mount" {
					(k): v
				}
			}]

			if len(_volumes) > 0 {
				volumes: _volumes
			}
		}
	}
}

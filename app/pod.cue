package app

import (
	"strings"
	"list"
	"github.com/amir-ahmad/cue-k8s-modules/app/k8s"
)

#PodConfig: {
	#ContainerConfig

	labels: {...}

	annotations: {...}

	// List of initContainers
	initContainers: [Name=string]: #ContainerConfig & {containerName: Name}

	// List of AdditionalContainers
	additionalContainers: [Name=string]: #ContainerConfig & {containerName: Name}

	// List of volumes. These will be associated to the Pod,
	// and mounted to the primary container if mounts are provided.
	volumes: [Name=string]: {
		name: string | *Name
		mounts: [...k8s.#VolumeMount & {name: Name}]
		spec: {...}
	}

	// additional pod properties
	spec: {...}
}

#ContainerConfig: {
	containerName!:  string
	image!:          string
	imagePullPolicy: "IfNotPresent" | "Always" | "Never"
	if image != _|_ {
		if strings.HasSuffix(image, ":latest") == true {
			imagePullPolicy: "IfNotPresent" | *"Always" | "Never"
		}
		if strings.HasSuffix(image, ":latest") != true {
			imagePullPolicy: *"IfNotPresent" | "Always" | "Never"
		}
	}

	// Container command and args
	command: [...string]
	args: [...string]

	// List of environment variables.
	env: [string]: string | null

	// Set container environment variables from configmap or secret
	envFrom: [...k8s.#EnvFromSource]

	// Resources requirements / limits
	resources?: k8s.#Resources

	// List of volume mounts
	volumeMounts: [...k8s.#VolumeMount]

	// List of ports on the app
	ports: [Name=string]: #Port & {name: Name}

	containerSecurityContext?: _

	// Add probes
	livenessProbe?:  #Probe
	readinessProbe?: #Probe
	startupProbe?:   #Probe
}

#Probe: k8s.#Probe & {
	timeoutSeconds:   int | *2
	failureThreshold: int | *5
}

#Pod: {
	c=#config: #PodConfig

	metadata: labels: c.labels

	metadata: annotations: c.annotations

	spec: containers: [{
		#Container & {
			#config: c & {
				volumeMounts: list.Concat([[for v in c.volumes for m in v.mounts {m}], c.volumeMounts])
			}
		}
	},
	for v in c.additionalContainers {
		#Container & { #config: v }
	},
	]

	if len(c.initContainers) > 0 {
		spec: initContainers: [for _, v in c.initContainers {
			#Container & {#config: v}
		}]
	}

	if len(c.volumes) > 0 {
		spec: volumes: [for k, v in c.volumes {
			name: k
			v.spec
		}]
	}

	spec: c.spec
}

#Container: {
	c=#config: {#ContainerConfig, ...}

	name:  c.containerName
	image: c.image

	imagePullPolicy: c.imagePullPolicy

	if len(c.command) > 0 {
		command: c.command
	}

	if len(c.args) > 0 {
		args: c.args
	}

	if len(c.ports) > 0 {
		ports: [for k, v in c.ports {
			name:          k
			containerPort: v.port
			protocol:      v.protocol
			if v.hostPort != _|_ {
				hostPort: v.hostPort
			}
		}]
	}

	if c.containerSecurityContext != _|_ {
		securityContext: c.containerSecurityContext
	}

	if len(c.envFrom) > 0 {
		envFrom: c.envFrom
	}

	env: [for k, v in c.env if v != null {name: k, value: v}]

	if len(c.volumeMounts) > 0 {
		volumeMounts: c.volumeMounts
	}

	if c.resources != _|_ {
		resources: c.resources
	}

	// Add probes
	if c.livenessProbe != _|_ {
		livenessProbe: c.livenessProbe
	}
	if c.readinessProbe != _|_ {
		readinessProbe: c.readinessProbe
	}
	if c.startupProbe != _|_ {
		startupProbe: c.startupProbe
	}
}

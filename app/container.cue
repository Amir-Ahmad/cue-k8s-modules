package app

import (
	"list"
	"strings"
	"github.com/amir-ahmad/cue-k8s-modules/app/k8s"
)

#ContainerConfig: {
	name!:  string
	image!: string

	// Set :latest images to always pull
	imagePullPolicy?: "IfNotPresent" | "Always" | "Never"
	if image != _|_ if strings.HasSuffix(image, ":latest") == true {
		imagePullPolicy: "IfNotPresent" | *"Always" | "Never"
	}

	// Map of environment variables.
	env: [string]: string

	envSecret: [N=string]: {
		// Name of the envvar to inject
		name: *N | string

		// Secret name
		secret: string

		// Property within the secret.
		secretKey: *N | string
	}

	// Map of volume mounts
	volumeMount: [Path=string]: k8s.#VolumeMount & {
		mountPath: Path
	}

	// Map of ports on the app
	port: [N=string]: #Port & {name: N}

	// All the fields below will be sent through as is when specified.
	command?: [...string]
	args?: [...string]
	envFrom?: [...k8s.#EnvFromSource]
	workingDir?:               string
	livenessProbe?:            k8s.#Probe
	readinessProbe?:           k8s.#Probe
	startupProbe?:             k8s.#Probe
	lifecycle?:                _
	securityContext?:          _
	resources?:                k8s.#Resources
	restartPolicy?:            _
	terminationMessagePath?:   string
	terminationMessagePolicy?: _
	stdin?:                    bool
	stdinOnce?:                bool
	tty?:                      bool
	volumeDevices?:            _
}

#Container: X={
	#config: #ContainerConfig

	out: k8s.#Container & {
		// Send through everything other than our abstractions
		for k, v in X.#config if v != _|_ && !list.Contains(["env", "envSecret", "volumeMount", "port"], k) {
			(k): v
		}

		env: list.Concat([
			[for k, v in X.#config.env {name: k, value: v}],
			[for v in X.#config.envSecret {
				name: v.name
				valueFrom: secretKeyRef: {
					name: v.secret
					key:  v.secretKey
				}
			}],
		])

		if len(X.#config.port) > 0 {
			ports: [for k, v in X.#config.port {
				name:          k
				containerPort: v.port
				protocol:      v.protocol
				if v.hostPort != _|_ {
					hostPort: v.hostPort
				}
			}]
		}

		if len(X.#config.volumeMount) > 0 {
			volumeMounts: [for v in X.#config.volumeMount {v}]
		}
	}
}

#Port: {
	name!:    string
	port!:    int
	protocol: string | *"TCP"

	// expose=true creates a Service for the port
	expose: bool | *true

	if expose == true {
		type: *"ClusterIP" | "NodePort" | "HostPort"

		if type == "NodePort" {nodePort!: int}

		if type == "HostPort" {hostPort!: int}
	}
}

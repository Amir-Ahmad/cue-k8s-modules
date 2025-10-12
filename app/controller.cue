package app

import (
	"list"
	"github.com/amir-ahmad/cue-k8s-modules/app/k8s"
)

#DeploymentController:  "Deployment"
#StatefulSetController: "StatefulSet"
#DaemonSetController:   "DaemonSet"
#CronJobController:     "CronJob"
#JobController:         "Job"
#ControllerType:        #DeploymentController | #StatefulSetController | #DaemonSetController | #CronJobController | #JobController

#ControllerConfig: X={
	type!:    #ControllerType
	metadata: k8s.#Metadata
	pod:      #PodConfig

	// set spec of controller directly
	spec: {...}

	// A minimal service is automatically created when there is 1+ exposed port.
	// service.spec or service.metadata can be specified here for additional customisation.
	service: #ServiceConfig

	// volume, container and initContainer are a port of #PodConfig but for ease of use,
	// they can be specified directly in the controller.
	container:     #PodConfig.container
	initContainer: #PodConfig.initContainer
	volume:        #PodConfig.volume

	// Pass through containers and volumes to pod spec.
	pod: {
		container:     X.container
		initContainer: X.initContainer
		volume:        X.volume
	}

	// selectorLabels are used to uniquely. identify the workload.
	selectorLabels: [string]: string
}

#Deployment: {
	c=#config: #ControllerConfig

	out: k8s.#Deployment & {
		metadata: c.metadata

		spec: {
			selector: matchLabels: c.selectorLabels
		} & c.spec

		spec: template: (#PodTemplate & {#config: c.pod}).out
	}
}

#DaemonSet: {
	c=#config: #ControllerConfig

	out: k8s.#DaemonSet & {
		metadata: c.metadata

		spec: {
			selector: matchLabels: c.selectorLabels
		} & c.spec

		spec: template: (#PodTemplate & {#config: c.pod}).out
	}
}

#StatefulSet: {
	c=#config: #ControllerConfig

	out: k8s.#StatefulSet & {
		metadata: c.metadata

		spec: {
			selector: matchLabels: c.selectorLabels
			serviceName: c.metadata.name
		} & c.spec

		spec: template: (#PodTemplate & {#config: c.pod}).out
	}
}

#CronJob: {
	c=#config: #ControllerConfig

	out: k8s.#CronJob & {
		metadata: c.metadata
		spec:     c.spec

		let podTemplate = (#PodTemplate & {#config: c.pod}).out
		spec: jobTemplate: spec: template: podTemplate
	}
}

#Job: {
	c=#config: #ControllerConfig

	out: k8s.#Job & {
		metadata: c.metadata
		spec:     c.spec

		spec: template: (#PodTemplate & {#config: c.pod}).out
	}
}

#Controller: {
	c=#config: #ControllerConfig

	let clusterIpPorts = [
		for container in c.container
		for p in container.port
		if p.expose == true if p.type == "ClusterIP" {p},
	]
	let nodePorts = [
		for container in c.container
		for p in container.port
		if p.expose == true if p.type == "NodePort" {p},
	]
	let combinedPorts = list.Concat([clusterIpPorts, nodePorts])

	out: [
		if c.type == #DeploymentController {
			(#Deployment & {#config: c}).out
		},
		if c.type == #DaemonSetController {
			(#DaemonSet & {#config: c}).out
		},
		if c.type == #StatefulSetController {
			(#StatefulSet & {#config: c}).out
		},
		if c.type == #CronJobController {
			(#CronJob & {#config: c}).out
		},
		if c.type == #JobController {
			(#Job & {#config: c}).out
		},
		if len(combinedPorts) > 0 {
			(#Service & {
				#config: {
					ports:          combinedPorts
					selectorLabels: c.selectorLabels
					spec: type: string | *"ClusterIP"
					if len(nodePorts) > 0 {
						spec: type: "NodePort"
					}
				} & c.service
			}).out
		},
	]
}

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

#ControllerCommon: {
	type!:    #ControllerType
	metadata: k8s.#Metadata
	pod:      #PodConfig
	selectorLabels: [string]: string

	// set spec of controller directly
	spec: {...}
}

#ControllerConfig: {
	type!: #ControllerType

	if type == #DeploymentController {#DeploymentConfig}
	if type == #StatefulSetController {#StatefulSetConfig}
	if type == #DaemonSetController {#DaemonSetConfig}
	if type == #CronJobController {#CronJobConfig}
	if type == #JobController {#JobConfig}
}

#DeploymentConfig: {
	#ControllerCommon
}

#DaemonSetConfig: {
	#ControllerCommon
}

#StatefulSetConfig: {
	#ControllerCommon
}

#CronJobConfig: {
	#ControllerCommon
}

#JobConfig: {
	#ControllerCommon
}

#Deployment: {
	c=#config: #DeploymentConfig

	out: k8s.#Deployment & {
		metadata: c.metadata

		spec: {
			selector: matchLabels: c.selectorLabels
		} & c.spec

		spec: template: {
			metadata: labels: c.pod.labels
			#Pod & {#config: c.pod}
		}
	}
}

#DaemonSet: {
	c=#config: #DaemonSetConfig

	out: k8s.#DaemonSet & {
		metadata: c.metadata

		spec: {
			selector: matchLabels: c.selectorLabels
		} & c.spec

		spec: template: {
			metadata: labels: c.pod.labels
			#Pod & {#config: c.pod}
		}
	}
}

#StatefulSet: {
	c=#config: #StatefulSetConfig

	out: k8s.#StatefulSet & {
		metadata: c.metadata

		spec: {
			selector: matchLabels: c.selectorLabels
			serviceName: c.metadata.name
		} & c.spec

		spec: template: {
			metadata: labels: c.pod.labels
			#Pod & {#config: c.pod}
		}
	}
}

#CronJob: {
	c=#config: #CronJobConfig

	out: k8s.#CronJob & {
		metadata: c.metadata
		spec: {
			jobTemplate: spec: template: {
				metadata: labels: c.pod.labels
				#Pod & {#config: c.pod}
			}
		} & c.spec
	}
}

#Job: {
	c=#config: #JobConfig

	out: k8s.#Job & {
		metadata: c.metadata
		spec: {
			template: {
				metadata: labels: c.pod.labels
				#Pod & {#config: c.pod}
			}
		} & c.spec
	}
}

#Controller: {
	c=#config: #ControllerConfig

	let clusterIpPorts = [for port in c.pod.ports if port.expose == true if port.type == "ClusterIP" {port}]
	let nodePorts = [for port in c.pod.ports if port.expose == true if port.type == "NodePort" {port}]
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
					metadata:       c.metadata
					ports:          combinedPorts
					selectorLabels: c.selectorLabels
					spec: type: string | *"ClusterIP"
					if len(nodePorts) > 0 {
						spec: type: "NodePort"
					}
				}
			}).out
		},
	]
}

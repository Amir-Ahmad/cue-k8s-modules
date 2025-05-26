package app

import (
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
}

#Controller: {
	type!: #ControllerType

	if type == #DeploymentController {#DeploymentConfig}
	if type == #StatefulSetController {#StatefulSetConfig}
	if type == #DaemonSetController {#DaemonSetConfig}
	if type == #CronJobController {#CronJobConfig}
	if type == #JobController {#JobConfig}
}

#DeploymentConfig: {
	#ControllerCommon

	// set spec of Deployment
	spec: {...}
}

#DaemonSetConfig: {
	#ControllerCommon

	// set spec of Daemonset
	spec: {...}
}

#StatefulSetConfig: {
	#ControllerCommon

	// set spec of StatefulSet
	spec: {...}
}

#CronJobConfig: {
	#ControllerCommon

	// Set spec of CronJob
	spec: {...}
}

#JobConfig: {
	#ControllerCommon

	// Set spec of Job
	spec: {...}
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
		spec: template: {
			metadata: labels: c.pod.labels
			#Pod & {#config: c.pod}
		} & c.spec
	}
}

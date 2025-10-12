package kube

import (
	pkg_app "github.com/amir-ahmad/cue-k8s-modules/app"
	"github.com/amir-ahmad/cue-k8s-modules/app/k8s"
)

abstracted_app=app: [Name=string]: pkg_app.#AppConfig & {
	name: string | *Name
	// set some defaults that are specific to me - 1 replica, syd
	controller: [string]: X={
		if X.type == "Deployment" || X.type == "StatefulSet" {
			spec: replicas: int | *1
		}
		container: [string]: env: TZ: string | null | *"Australia/Sydney"
	}

	object: namespaced: PersistentVolumeClaim: [string]: k8s.#PersistentVolumeClaim & {
		spec: accessModes: [...string] | *["ReadWriteOnce"]
	}

}

for k, v in abstracted_app {
	appObjects: "\(k)": (pkg_app.#App & {config: v}).out
}

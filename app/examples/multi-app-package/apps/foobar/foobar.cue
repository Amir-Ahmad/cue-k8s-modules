package kube

app: foobar: {
	common: namespace: "default"

	common: labels: TEST: "TEST_BAR"

	controller: first: {
		type: "Deployment"
		container: main: {
			image: "foobar:latest"
			port: http: port: 5050
			envFrom: [{secretRef: name: "foo-secret"}]
		}
	}

	controller: "foo-sts": {
		metadata: namespace: "sts"
		type: "StatefulSet"
		container: main: {
			image: "second:latest"
			port: http: {
				type:     "NodePort"
				nodePort: 30000
				port:     6060
			}
		}
	}

	controller: "foo-third": {
		type: "Deployment"
		container: main: {
			image: "third:1.0.0"
			env: ENVIRONMENT: "staging"
		}
		// Create an emptydir volume and mount at "/data"
		volume: "data": {
			spec: emptyDir: {}
			mount: main: "/data": {}
		}
	}

	controller: "foo-cronjob": {
		type: "CronJob"
		container: main: image: "cronjob:v1"
		spec: schedule: "*/15 * * * *"
	}

	controller: "foo-job": {
		type: "Job"
		container: main: image: "job:v1"
	}

	object: namespaced: PersistentVolumeClaim: "foo-pvc": spec: {
		resources: requests: storage: "10gb"
		storageClassName: "local"
	}

	configmap: foobar: {
		data: FOO: "BAR"

		rollControllers: ["first"]
	}
}

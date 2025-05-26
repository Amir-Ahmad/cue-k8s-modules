package kube

app: foobar: {
	common: namespace: "default"

	common: labels: TEST: "TEST_BAR"

	controller: first: {
		type: "Deployment"
		pod: image: "foobar:latest"
		pod: ports: http: port: 5050
	}

	controller: "foo-sts": {
		type: "StatefulSet"
		pod: image: "second:latest"
		pod: ports: http: {
			type:     "NodePort"
			nodePort: 30000
			port:     6060
		}
	}

	controller: "foo-third": {
		type: "Deployment"
		pod: image: "third:latest"
		pod: ports: http: {
			type:     "HostPort"
			hostPort: 80
			port:     7070
		}
	}

	controller: "foo-cronjob": {
		type: "CronJob"
		pod: image:     "cronjob:v1"
		spec: schedule: "*/15 * * * *"
	}

	controller: "foo-job": {
		type: "Job"
		pod: image: "job:v1"
	}

	object: PersistentVolumeClaim: "foo-pvc": spec: {
		resources: requests: storage: "10gb"
		storageClassName: "local"
	}

	configmap: foobar: {
		data: FOO: "BAR"

		rollControllers: ["first"]
	}
}

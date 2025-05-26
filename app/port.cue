package app

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

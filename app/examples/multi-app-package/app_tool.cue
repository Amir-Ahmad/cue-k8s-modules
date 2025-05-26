package kube

import (
	"tool/cli"
	"encoding/yaml"
)

_data: {
	// optionally allow filtering by cue -t kind=<kind> dump
	kind: *"" | string @tag(kind)

	outObjects: [
		for objects in appObjects
		for object in objects
		if kind == "" || (kind != "" && object.kind =~ "(?i)^\(kind)$") {object},
	]
}

// Output objects as yaml
command: dump: task: print: cli.Print & {
	text: yaml.MarshalStream(_data.outObjects)
}

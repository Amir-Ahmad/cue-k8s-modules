module: "github.com/amir-ahmad/cue-k8s-modules/app@v0"
language: {
	version: "v0.12.0"
}
source: {
	kind: "git"
}
deps: {
	"cue.dev/x/k8s.io@v0": {
		v:       "v0.4.0"
		default: true
	}
}

module: "github.com/amir-ahmad/cue-k8s-modules/app@v0"
language: {
	version: "v0.12.0"
}
source: {
	kind: "git"
}
deps: {
	"github.com/amir-ahmad/cue-k8s-modules/k8s-schema@v0": {
		v:       "v0.3.0"
		default: true
	}
}

# How to use

Reference this module in a cue file.

```
import core_v1 "github.com/amir-ahmad/cue-k8s-modules/k8s-schema/pkg/k8s.io/api/core/v1"

config: core_v1.#ConfigMap & {
    data: foo: "bar"
}
```

Use cue mod tidy to download from ghcr.io:

```
export CUE_REGISTRY='github.com/amir-ahmad=ghcr.io'
cue mod tidy
```

Evaluate:

```
cue eval <file>.cue
```

## How to generate

1. Initialise cue and go modules

```
cue mod init --source=git github.com/amir-ahmad/cue-k8s-modules/k8s-schema@v0
go mod init github.com/amir-ahmad/cue-k8s-modules/k8s-schema
```

2. Run generate scripts

```
./generate-k8s.sh
./generate-crds.sh "path-to-crd-yaml"
```

#!/usr/bin/env bash
set -euo pipefail

K8S_VERSION="${K8S_VERSION:-1.33.1}"
GATEWAY_VERSION="${GATEWAY_VERSION:-1.3.0}"
module_dir="$(git rev-parse --show-toplevel)/k8s-schema"

go get "k8s.io/api/...@kubernetes-${K8S_VERSION}"
go get "sigs.k8s.io/gateway-api/apis/v1/...@v${GATEWAY_VERSION}"

cue get go k8s.io/api/...
cue get go sigs.k8s.io/gateway-api/apis/v1/...

# remove all alpha and beta APIs
find cue.mod/gen/k8s.io/ -type d -regex '.*/v[0-9]\(alpha\|beta\)[0-9]' -exec rm -rf {} +

# fix imports as we'll be moving files out from cue.mod/gen/
# TODO: make the sed expression sane
find cue.mod/gen/ -name '*.cue' -exec \
  sed -i -Ee '/^(import|\t[^/])\s*/ s|"((sigs\.k8s\.io\|k8s\.io)/[^"]+)"|"github.com/amir-ahmad/cue-k8s-modules/k8s-schema/\1"|g' {} +

for d in cue.mod/gen/*; do
    dirname="$(basename "$d")"
    mv "$d" "${module_dir}"
    cue vet -c "./${dirname}/..."
done

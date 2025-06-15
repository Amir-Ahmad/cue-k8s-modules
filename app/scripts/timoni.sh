#!/usr/bin/env bash
# This script converts app module to a timoni module in a new temporary directory,
# and passes through all arguments to timoni after doing so
# example:
# ./scripts/timoni.sh mod vet .
# ./scripts/timoni.sh build app -f values.cue .
set -euo pipefail

DISABLE_CLEANUP="${DISABLE_CLEANUP:-"false"}"
module_root="$(git rev-parse --show-toplevel)/app"
tmp_dir="$(mktemp -d -t timoni.XXXXXX)"

echo "Temporary directory: ${tmp_dir}"

if [[ "${DISABLE_CLEANUP}" != "true" ]]; then
	trap 'rm -rf "$tmp_dir"' EXIT
fi

setup_timoni(){
  dest="${1}"

  if [ ! -d "${dest}" ]; then
    echo "destination directory ${dest} doesn't exist"
    return 1
  fi

  mkdir "${dest}/app"

  find "${module_root}" -maxdepth 1 -name '*.cue' -exec cp "{}" "${dest}/app" \;

  cp -r "${module_root}/cue.mod" "${dest}"
  cp -r "${module_root}/k8s" "${dest}"

  cat > "${dest}/timoni.cue" <<'EOF'
package main

import (
	"github.com/amir-ahmad/cue-k8s-modules/app/app"
)

// Schema for user-supplied values.
values: app.#AppConfig

timoni: {
	apiVersion: "v1alpha1"

	// Build output
	instance: app.#App & {
		config: values
		config: {
			name:      string @tag(name)
			common: namespace: string @tag(namespace)
		}
	}

	// Provide output objects to timoni
	apply: app: instance.outObjects
}
EOF

  cat > "${dest}/values.cue" <<'EOF'
// Note that this file must have no imports and all values must be concrete.
@if(!debug)

package main

// Defaults
values: {
	controller: nginx: {
		type: "Deployment"
		pod: image: "nginx:latest"
		pod: ports: http: port: 8080
		// spec directly sets properties of the controller, in this case Deployment
		spec: replicas: 1
	}
}

EOF

}

setup_timoni "${tmp_dir}"

(cd "${tmp_dir}" && timoni "$@")

#!/usr/bin/env bash
# This script converts app module to a timoni module in a new temporary directory
set -euo pipefail

dest_dir="${1:?usage: $0 <destination>}"

setup_timoni(){
  local dest repo_root module_root

  dest="${1}"

  repo_root="$(git rev-parse --show-toplevel)"
  module_root="${repo_root}/app"

  if [ ! -d "${dest}" ]; then
    echo "destination directory ${dest} doesn't exist"
    return 1
  fi

  mkdir "${dest}/app" "${dest}/cue.mod" "${dest}/k8s-schema"

  find "${module_root}" -maxdepth 1 -name '*.cue' -exec cp "{}" "${dest}/app" \;

  cp -r "${module_root}/k8s" "${dest}"

  find "${dest}/app" -name '*.cue' -exec sed -i "s|cue-k8s-modules/app/k8s|cue-k8s-modules/k8s|" "{}" \;

  # copy the whole k8s-schema module to avoid dependency on cue modules.
  cp -r "${repo_root}/k8s-schema/pkg" "${dest}/k8s-schema/"

  cat > "${dest}/cue.mod/module.cue" <<'EOF'
module: "github.com/amir-ahmad/cue-k8s-modules"
language: version: "v0.12.0"
EOF

  cat > "${dest}/timoni.cue" <<'EOF'
package main

import (
	"github.com/amir-ahmad/cue-k8s-modules/app"
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
	apply: app: instance.out
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
		container: nginx: {
			image: "nginx:latest"
			port: http: port: 8080
		}
		// spec directly sets properties of the controller, in this case Deployment
		spec: replicas: 1
	}
}

EOF

}

setup_timoni "${dest_dir}"

#!/usr/bin/env bash
# Process CRDs from a YAML file or stdin, and output cue definitions in a structured way.
# Requires a new version of cue (v0.14.0+)
set -euo pipefail
file="${1:?"Usage: $0 <yaml file or - for stdin>"}"

module_dir="$(git rev-parse --show-toplevel)/k8s-schema"

if [[ "$file" == "-" ]]; then
  contents="$(cat)"
else
  contents="$(cat "$file")"
fi

total="$(yq eval-all '[.] | length' <<< "$contents")"

# Loop through each crd and scrape definitions
for ((i=0; i<total; i++)); do

  crd="$(yq "select(documentIndex == $i)" <<< "$contents")"
  group="$(yq -r '.spec.group' <<< "$crd")"

  dest="${module_dir}/pkg/${group}"
  echo "Storing CRD in directory $dest"
  mkdir -p "${dest}"
  
  (cd "${dest}" && cue get crd yaml: - <<< "$crd")
done

(cd "${module_dir}" &&  cue vet -c ./pkg/...)

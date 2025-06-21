#!/usr/bin/env bash
# This script converts app module to a timoni module in a new temporary directory,
# and runs timoni passing through all arguments.
# example:
# ./scripts/timoni.sh mod vet .
# ./scripts/timoni.sh build app -f values.cue .
# ./scripts/timoni.sh mod push . oci://ghcr.io/amir-ahmad/cue-k8s-modules/timoni-app --version "0.0.1-dev"
set -euo pipefail

DISABLE_CLEANUP="${DISABLE_CLEANUP:-"false"}"
tmp_dir="$(mktemp -d -t timoni.XXXXXX)"

echo "Temporary directory: ${tmp_dir}"

if [[ "${DISABLE_CLEANUP}" != "true" ]]; then
	trap 'rm -rf "$tmp_dir"' EXIT
fi

# get directory of this script correctly
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)"
"${script_dir}/timoni-setup.sh" "${tmp_dir}"

(cd "${tmp_dir}" && timoni "$@")

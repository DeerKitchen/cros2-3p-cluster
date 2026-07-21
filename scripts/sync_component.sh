#!/usr/bin/env bash
# Intake-machine helper: mirror one upstream tree into src/<name> (does not run on air-gap builders).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
NAME="${1:-}"
URL="${2:-}"
REF="${3:-}"
if [[ -z "${NAME}" || -z "${URL}" || -z "${REF}" ]]; then
  echo "usage: $0 <component_name> <upstream_git_url> <tag_or_sha>" >&2
  exit 2
fi
DEST="${ROOT}/src/${NAME}"
TMP="$(mktemp -d)"
trap 'rm -rf "${TMP}"' EXIT
git clone --depth 1 --branch "${REF}" "${URL}" "${TMP}/src" 2>/dev/null \
  || { git clone "${URL}" "${TMP}/src"; git -C "${TMP}/src" checkout "${REF}"; }
rm -rf "${DEST}"
mkdir -p "${ROOT}/src"
# copy without .git so umbrella history stays one repo
rsync -a --exclude .git "${TMP}/src/" "${DEST}/"
echo "Synced ${NAME} @ ${REF} -> src/${NAME}"
echo "Update VERSIONS.md and commit."

#!/usr/bin/env bash
set -efu

declare content filename
eval "$(jq -r '@sh "content=\(.content) filename=\(.filename)"')"

echo "${content}" >"${filename}"
# ignores `Error Message: fatal: Unable to create '.../.git/index.lock': File exists.`
# Note this `--force` stages the file even if it is added to gitignore.
git add --intent-to-add --force -- "${filename}" >/dev/null 2>&1 || true
# TF dummy result output
printf '{}'

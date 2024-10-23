#!/usr/bin/env bash
set -efu

declare content filename
eval "$(jq -r '@sh "content=\(.content) filename=\(.filename)"')"

if [ "${content}" != "{}" ]; then
  echo "${content}" > "${filename}"
  nar=$(nix hash path "${filename}")
else
  nar=""
fi
printf "{\"out\":\"%s\"}" "${nar}"

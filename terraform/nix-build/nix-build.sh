#!/usr/bin/env bash
set -xefu

declare file attribute nix_options content_file content_nar wrapper_path
eval "$(jaq -r '@sh "attribute=\(.attribute) file=\(.file) nix_options=\(.nix_options) content_file=\(.content_file) content_nar=\(.content_nar) wrapper_path=\(.wrapper_path)"')"
if [ "${nix_options}" = '{"options":{}}' ]; then
  options=""
else
  options=$(echo "${nix_options}" | jaq -r '.options | to_entries | map("--option \(.key) \(.value)") | join(" ")')
fi
if [[ -n ${file-} ]] && [[ -e ${file-} ]] && [ "${file}" != "null" ]; then
  # shellcheck disable=SC2086
  out=$(nix build --no-link --json $options -f "$file" "$attribute")
else
  # flakes want files to be staged to git, which is annoying, so hack around that
  if [[ -n ${content_file-} ]] && [[ -e ${content_file-} ]] && [[ -n ${content_nar-} ]]; then
    # default to saving the content file under the same name
    content_name="$(basename "$content_file")"
    rest="$(echo "${attribute}" | cut -d "#" -f 2)"
    # e.g. config_path=nixosConfigurations.aarch64-linux.combined
    config_path="${rest%.config.*}"
    # e.g. config_attribute=config.system.build.toplevel
    config_attribute="config.${rest#*.config.}"

    # grab flake nar from error message
    flake_rel="$(echo "${attribute}" | cut -d "#" -f 1)"
    flake_dir="$(readlink -f "${flake_rel}")"
    content_file="$(readlink -f "${content_file}")"
    flake_nar="$(nix build --expr "builtins.getFlake ''git+file://${flake_dir}?narHash=sha256-0000000000000000000000000000000000000000000=''" 2>&1 | grep -Po "(?<=got ')sha256-[^']*(?=')")"
    # substitute variables into the template
    nix_expr="$(sed -e "s%\$flake_dir%${flake_dir}%g" -e "s%\$flake_nar%${flake_nar}%g" -e "s%\$content_name%${content_name}%g" -e "s%\$content_file%${content_file}%g" -e "s%\$content_nar%${content_nar}%g" -e "s%\$config_path%${config_path}%g" "${wrapper_path}")"
    # inject content file into nixos config's `/etc/`
    # shellcheck disable=SC2086
    out=$(nix build --no-link --json ${options} --expr "${nix_expr}" "${config_attribute}")
  else
    # shellcheck disable=SC2086
    out=$(nix build --no-link --json ${options} "$attribute")
  fi
fi
printf '%s' "$out" | jaq -c '.[].outputs'

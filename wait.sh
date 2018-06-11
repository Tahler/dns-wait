#!/bin/bash
#
# Waits each argument to be present to nslookup before completing.

error() {
  echo "$*" >&2
}

usage() {
  error "usage: ${0} [options] [hosts]"
  error ""
  error "  -q, --quiet  if present, do not log"
  exit 1
}

log() {
  if [ "${QUIET}" = false ]; then
    echo "$*"
  fi
}

parse_args() {
  readonly HOSTS=()
  while [ "$#" -gt 0 ]; do
    case "${1}" in
      -q|--quiet)
        local quiet=true
        shift # Shift past flag.
        ;;
      *)
        HOSTS+=("${1}")
        shift # Shift past host.
        ;;
    esac
  done

  readonly QUIET="${quiet:-false}"
}

usage_if_no_hosts() {
  if [ ${#HOSTS[@]} -eq 0 ]; then
    usage  # Exits.
  fi
}

main() {
  parse_args "$@"

  usage_if_no_hosts

  local hosts=("$@")
  for host in "${hosts[@]}"; do
    until nslookup "${host}" > /dev/null 2>&1; do
      log "waiting for ${host}"
      sleep 1
    done
    log "discovered ${host}"
  done
}

main "$@"

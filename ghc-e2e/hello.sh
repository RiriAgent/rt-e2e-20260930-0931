#!/usr/bin/env bash
# ghc e2e fixture CLI: greets with the current version.
set -euo pipefail
case "${1:-}" in
  "") echo "hello v1" ;;
  *) echo "unknown argument: $1" >&2; exit 2 ;;
esac

#!/usr/bin/env bash
# ghc e2e fixture CLI: greets with the current version (v2).
set -euo pipefail
case "${1:-}" in
  "") echo "hello v2" ;;
  *) echo "unknown argument: $1" >&2; exit 2 ;;
esac

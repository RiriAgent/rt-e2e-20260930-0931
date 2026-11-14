#!/usr/bin/env bash
# ghc e2e fixture CLI: greets with the current version (v3).
set -euo pipefail
case "${1:-}" in
  "") echo "hello v3" ;;
  --version) echo "2" ;;
  *) echo "unknown argument: $1" >&2; exit 2 ;;
esac

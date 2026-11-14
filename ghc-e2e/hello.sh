#!/usr/bin/env bash
# ghc e2e fixture CLI: greets with the current version (v3).
set -euo pipefail
case "${1:-}" in
  "") echo "hello v3" ;;
  --version) echo "3" ;;
  *) echo "unknown argument: $1; usage: hello.sh [--version]" >&2; exit 2 ;;
esac

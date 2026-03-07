#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUTPUT_FILE="$ROOT_DIR/outputs/test-output.runtime.txt"

cd "$ROOT_DIR"

./scripts/run-demo.sh 31 >"$OUTPUT_FILE"

assert_contains() {
  local pattern="$1"
  if ! rg -q "$pattern" "$OUTPUT_FILE"; then
    echo "[git-explain-demo:test] expected pattern not found: $pattern" >&2
    echo "--- output ---" >&2
    cat "$OUTPUT_FILE" >&2
    exit 1
  fi
}

assert_contains "== Raw git blame =="
assert_contains "fix\(retry\): enforce idempotency key before reattempting charges"
assert_contains "=== Why This Exists \(likely\) ==="
assert_contains "idempotency"
assert_contains "commit: e0d8e71d30edab777f15fa19ba242c8dc449d25e"
assert_contains "line: 31"

echo "[git-explain-demo:test] pass"

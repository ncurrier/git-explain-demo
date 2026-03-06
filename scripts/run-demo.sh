#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LINE="${1:-31}"
TARGET_FILE="src/order_service.ts"
GIT_EXPLAIN_REPO="${GIT_EXPLAIN_REPO:-$ROOT_DIR/../git-explain}"
GIT_EXPLAIN_BIN="${GIT_EXPLAIN_BIN:-$GIT_EXPLAIN_REPO/target/release/git-explain}"

if [[ ! -x "$GIT_EXPLAIN_BIN" ]]; then
  echo "Building git-explain binary..."
  cargo build --release --manifest-path "$GIT_EXPLAIN_REPO/Cargo.toml" >/dev/null
fi

echo "== Raw git blame =="
git -C "$ROOT_DIR" blame -L "$LINE,$LINE" "$TARGET_FILE"

echo
echo "== Why-oriented explanation =="
"$GIT_EXPLAIN_BIN" explain "$TARGET_FILE" "$LINE" --repo "$ROOT_DIR"

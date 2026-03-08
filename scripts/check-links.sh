#!/usr/bin/env bash
set -euo pipefail

errors=0

if rg -n 'localhost:1313' content layouts static hugo.toml >/dev/null; then
  echo "Found localhost:1313 references:"
  rg -n 'localhost:1313' content layouts static hugo.toml
  errors=$((errors + 1))
fi

check_relative_links() {
  local file="$1"
  local dir target resolved

  dir="$(dirname "$file")"
  while IFS= read -r target; do
    if [[ "$target" =~ ^([^[:space:]]+)[[:space:]]+\".*\"$ ]]; then
      target="${BASH_REMATCH[1]}"
    fi

    target="${target%%#*}"
    target="${target%%\?*}"

    if [[ -z "$target" ]]; then
      continue
    fi
    if [[ "$target" == *'['* || "$target" == *']'* ]]; then
      continue
    fi
    if [[ "$target" =~ ^(https?:|mailto:|tel:|#|javascript:|data:) ]]; then
      continue
    fi
    if [[ "$target" == /* ]]; then
      continue
    fi

    target="${target//%20/ }"
    resolved="$dir/$target"
    if [[ ! -e "$resolved" ]]; then
      echo "Broken relative link in $file -> $target"
      errors=$((errors + 1))
    fi
  done < <(perl -ne 'while(/\[[^\]]*\]\(([^)]+)\)/g){print "$1\n"}' "$file")
}

while IFS= read -r file; do
  check_relative_links "$file"
done < <(rg --files content/post content/Blog | rg '\.md$')

if [[ "$errors" -gt 0 ]]; then
  echo "Link check failed with $errors issue(s)."
  exit 1
fi

echo "Link check passed."

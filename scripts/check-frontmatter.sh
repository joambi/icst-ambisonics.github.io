#!/usr/bin/env bash
set -euo pipefail

errors=0

check_key() {
  local key="$1"
  local fm="$2"
  if ! grep -Eq "^${key}:[[:space:]]*.+$" <<<"$fm"; then
    return 1
  fi
}

check_file() {
  local file="$1"
  local fm
  fm="$(awk '
    /^---[[:space:]]*$/ {d++; next}
    d==1 {print}
    d==2 {exit}
  ' "$file")"

  if [[ -z "$fm" ]]; then
    echo "Missing front matter block: $file"
    errors=$((errors + 1))
    return
  fi

  if ! check_key "title" "$fm"; then
    echo "Missing title: $file"
    errors=$((errors + 1))
  fi

  if ! check_key "description" "$fm"; then
    echo "Missing description: $file"
    errors=$((errors + 1))
  fi

  if [[ "$file" == content/post/*/index*.md ]]; then
    if ! check_key "date" "$fm"; then
      echo "Missing date: $file"
      errors=$((errors + 1))
    fi
    if ! grep -Eq '^tags:[[:space:]]*(\[.+\]|.+)$' <<<"$fm"; then
      echo "Missing tags: $file"
      errors=$((errors + 1))
    fi
  fi
}

while IFS= read -r file; do
  check_file "$file"
done < <(rg --files content/post content/Blog | rg 'index(\.de)?\.md$')

if rg -n '^date:[[:space:]]*0001-01-01' content/post content/Blog >/dev/null; then
  echo "Invalid placeholder date 0001-01-01 found in content."
  errors=$((errors + 1))
fi

if [[ "$errors" -gt 0 ]]; then
  echo "Front matter check failed with $errors issue(s)."
  exit 1
fi

echo "Front matter check passed."

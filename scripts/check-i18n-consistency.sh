#!/usr/bin/env bash
set -euo pipefail

errors=0
ignore_file="scripts/i18n-ignore.txt"

is_ignored() {
  local path="$1"
  [[ -f "$ignore_file" ]] || return 1
  while IFS= read -r pattern; do
    [[ -z "$pattern" ]] && continue
    [[ "${pattern:0:1}" == "#" ]] && continue
    if [[ "$path" == *"$pattern"* ]]; then
      return 0
    fi
  done < "$ignore_file"
  return 1
}

frontmatter_block() {
  local file="$1"
  awk '
    /^---[[:space:]]*$/ {d++; next}
    d==1 {print}
    d==2 {exit}
  ' "$file"
}

frontmatter_keys() {
  local file="$1"
  frontmatter_block "$file" | awk '
    /^[[:space:]]*[A-Za-z0-9_-]+:[[:space:]]*/ {
      key=$0
      sub(/^[[:space:]]*/, "", key)
      sub(/:.*/, "", key)
      print key
    }
  ' | sort -u
}

main_section_signature() {
  local file="$1"
  awk '
    BEGIN{fm=0}
    /^---[[:space:]]*$/ {if (fm<2) {fm++; next}}
    fm>=2 && /^##[[:space:]]+/ {
      line=$0
      sub(/^##[[:space:]]+/, "", line)
      numbered=(line ~ /^[0-9]+[.)][[:space:]]+/ ? "num" : "txt")
      print "h2:" numbered
    }
  ' "$file"
}

callout_signature() {
  local file="$1"
  awk '
    /^>[[:space:]]*\[![A-Za-z]+\]/ {
      line=$0
      sub(/^>[[:space:]]*\[!/, "", line)
      sub(/\].*$/, "", line)
      print tolower(line)
    }
  ' "$file"
}

table_signature() {
  local file="$1"
  awk '
    BEGIN{fm=0; prev=""; table_open=0}
    /^---[[:space:]]*$/ {if (fm<2) {fm++; next}}
    fm<2 {next}
    {
      line=$0
      if (line ~ /^[[:space:]]*\|[-:[:space:]]+\|[| -:[:space:]]*$/) {
        header=prev
        gsub(/^[[:space:]]*\|/, "", header)
        gsub(/\|[[:space:]]*$/, "", header)
        cols=split(header, a, /\|/)
        print "table:" cols
        table_open=1
      } else if (line !~ /^[[:space:]]*\|/) {
        table_open=0
      }
      prev=line
    }
  ' "$file"
}

cta_signature() {
  local file="$1"
  awk '
    BEGIN{fm=0}
    /^---[[:space:]]*$/ {if (fm<2) {fm++; next}}
    fm<2 {next}
    tolower($0) ~ /hero__links|hero__link|cta[-_ ]/ { print "cta" }
  ' "$file"
}

has_frontmatter_key() {
  local file="$1"
  local key="$2"
  frontmatter_block "$file" | rg -n "^[[:space:]]*${key}:[[:space:]]*" >/dev/null 2>&1
}

compare_signatures() {
  local label="$1"
  local en_file="$2"
  local de_file="$3"
  local en_sig="$4"
  local de_sig="$5"
  if [[ "$en_sig" != "$de_sig" ]]; then
    echo "Mismatch in ${label}:"
    echo "  EN: $en_file"
    echo "  DE: $de_file"
    errors=$((errors + 1))
  fi
}

check_pair() {
  local en_file="$1"
  local de_file="$2"

  if ! [[ -f "$de_file" ]]; then
    echo "Missing DE counterpart for: $en_file"
    errors=$((errors + 1))
    return
  fi

  local en_sections de_sections en_callouts de_callouts en_tables de_tables en_cta de_cta
  en_sections="$(main_section_signature "$en_file")"
  de_sections="$(main_section_signature "$de_file")"
  compare_signatures "main section structure (##)" "$en_file" "$de_file" "$en_sections" "$de_sections"

  en_callouts="$(callout_signature "$en_file")"
  de_callouts="$(callout_signature "$de_file")"
  compare_signatures "callout structure" "$en_file" "$de_file" "$en_callouts" "$de_callouts"

  en_tables="$(table_signature "$en_file")"
  de_tables="$(table_signature "$de_file")"
  compare_signatures "table structure" "$en_file" "$de_file" "$en_tables" "$de_tables"

  en_cta="$(cta_signature "$en_file")"
  de_cta="$(cta_signature "$de_file")"
  compare_signatures "CTA block structure" "$en_file" "$de_file" "$en_cta" "$de_cta"

  local shared_keys
  shared_keys=(
    title
    description
    date
    slug
    aliases
    tags
    key_points
    difficulty
    weight
    year
    month
    author
  )

  local key
  for key in "${shared_keys[@]}"; do
    local en_has=0
    local de_has=0
    has_frontmatter_key "$en_file" "$key" && en_has=1
    has_frontmatter_key "$de_file" "$key" && de_has=1
    if [[ "$en_has" -ne "$de_has" ]]; then
      echo "Front matter key mismatch '$key':"
      echo "  EN: $en_file (has=$en_has)"
      echo "  DE: $de_file (has=$de_has)"
      errors=$((errors + 1))
    fi
  done

  local en_keys de_keys
  en_keys="$(frontmatter_keys "$en_file" | rg -v '^(translationKey|languageCode)$' || true)"
  de_keys="$(frontmatter_keys "$de_file" | rg -v '^(translationKey|languageCode)$' || true)"
  compare_signatures "front matter key set" "$en_file" "$de_file" "$en_keys" "$de_keys"
}

while IFS= read -r en_file; do
  is_ignored "$en_file" && continue
  de_file="${en_file/index.md/index.de.md}"
  check_pair "$en_file" "$de_file"
done < <(rg --files content | rg '/index\.md$')

while IFS= read -r de_file; do
  is_ignored "$de_file" && continue
  en_file="${de_file/index.de.md/index.md}"
  if ! [[ -f "$en_file" ]]; then
    echo "Missing EN counterpart for: $de_file"
    errors=$((errors + 1))
  fi
done < <(rg --files content | rg '/index\.de\.md$')

if [[ "$errors" -gt 0 ]]; then
  echo "i18n consistency check failed with $errors issue(s)."
  exit 1
fi

echo "i18n consistency check passed."

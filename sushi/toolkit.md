# Sushi Toolkit Reference

> Lazy-loaded reference. Core heuristics live in [SKILL.md](SKILL.md). Read this when you need deeper tool knowledge, specific flags, or composition patterns.

---

## Tool Deep Dives

### fzf (0.67)

**Non-interactive (Claude Code compatible):**

```bash
# Fuzzy file matching — pipe any list through fzf --filter
fd --type f | fzf --filter "compon"

# Fuzzy grep results — narrow rg output to best matches
rg -l "import" | fzf --filter "auth"

# Top-N matches — combine with head
fd --type f | fzf --filter "test" | head -5
```

**Interactive (human shell only):**

```bash
# File preview with bat
fd --type f | fzf --preview "bat --color=always --line-range :50 {}"

# Content search with live reload
rg --line-number "" | fzf --delimiter : --preview "bat --color=always --highlight-line {2} {1}"

# Git branch selection
git branch --all | fzf --preview "git log --oneline -10 {1}"
```

### rg (15.1)

```bash
# Smart case (lowercase = insensitive, mixed = sensitive)
rg "pattern"               # case-insensitive
rg "Pattern"               # case-sensitive

# Files only (no content)
rg -l "pattern"

# Type filter
rg --type js "useState"
rg --type-not test "function"

# Glob filter
rg --glob "*.tsx" "className"
rg --glob "!node_modules" "TODO"

# JSON output (machine-readable)
rg --json "pattern"

# Count matches per file
rg -c "import" --sort path

# Multiline match
rg -U "function.*\{[\s\S]*?\}" file.js

# Replace preview (does not modify files — preview only)
rg "oldName" --replace "newName"
```

### fd (10.3)

```bash
# By extension
fd -e ts -e tsx

# By pattern
fd "test.*spec"

# Changed in last 24 hours
fd --changed-within 1d

# Exclude directories
fd --exclude node_modules --exclude .git

# Execute command on each match
fd -e json --exec jq '.name' {}

# Type filters
fd --type f    # files only
fd --type d    # directories only
fd --type l    # symlinks only
```

### jq (1.8)

```bash
# Extract field
jq '.name' package.json

# Array operations
jq '.dependencies | keys' package.json
jq '.items | length' data.json
jq '.items[0:5]' data.json

# Filter + transform
jq '.users[] | select(.active == true) | .email' users.json

# Construct new objects
jq '{name: .name, version: .version}' package.json

# Raw output (no quotes)
jq -r '.scripts.build' package.json

# Slurp multiple JSON objects into array
cat *.json | jq -s '.'
```

### awk

```bash
# Print specific columns (space-delimited)
awk '{print $1, $3}' file.txt

# Custom delimiter
awk -F: '{print $1, $NF}' /etc/passwd

# Filter by condition
awk '$3 > 100 {print $1, $3}' data.txt

# Sum a column
awk '{sum += $2} END {print sum}' data.txt

# Count occurrences
awk '{count[$1]++} END {for (k in count) print k, count[k]}' log.txt

# Print lines between patterns
awk '/START/,/END/' file.txt

# Tab-delimited output
awk -F'\t' -v OFS='\t' '{print $2, $1}' data.tsv
```

### perl (one-liners)

```bash
# In-place replace (macOS safe — no sed -i quirk)
perl -pi -e 's/oldText/newText/g' file.txt

# Extract matches (print only matching part)
perl -ne 'print "$1\n" if /pattern: (\S+)/' file.txt

# Multiline processing
perl -0777 -pe 's/start.*?end/replacement/gs' file.txt

# Lookahead/lookbehind
perl -ne 'print if /(?<=prefix)\w+(?=suffix)/' file.txt

# Process multiple files
perl -pi -e 's/old/new/g' *.md
```

---

## Composition Patterns

### Search and replace with preview (what sr-replace does)

```bash
# Wrong way: blind sed
sed -i 's/old/new/g' *.js

# Sushi way: find → preview → replace
rg -l "oldFunc" src/                          # 1. find files
rg -n "oldFunc" src/                          # 2. preview matches in context
rg -l "oldFunc" src/ | xargs perl -pi -e 's/oldFunc/newFunc/g'  # 3. replace
```

### Code block extraction (what sr-extract does)

```bash
# Wrong way: grep with fixed context
grep -A 20 "function" file.js

# Sushi way: rg finds lines, awk extracts smart blocks
rg -n "className" file.tsx | while IFS=: read -r line rest; do
    awk "NR>=$((line-3)) && NR<=$((line+5))" file.tsx
done
```

### Bulk file rename with dry-run (what sr-rename does)

```bash
# Wrong way: manual mv commands
mv old-file-1.txt new-file-1.txt
mv old-file-2.txt new-file-2.txt

# Sushi way: fd finds, preview first, then rename
fd "old-" --type f                                           # 1. find
fd "old-" --type f -x echo "mv {} {//}/$(echo {/} | sed 's/old-/new-/')"  # 2. preview
fd "old-" --type f -x bash -c 'mv "$1" "${1//old-/new-}"' _ {}           # 3. execute
```

### File tree from manifest (what sr-scaffold does)

```bash
# Manifest format (one path per line, trailing / = directory):
# src/
# src/components/
# src/components/Header.tsx
# src/utils/helpers.ts

# Sushi way: read manifest, mkdir -p for dirs, touch for files
while IFS= read -r path; do
    [[ "$path" == */ ]] && mkdir -p "$path" || { mkdir -p "$(dirname "$path")"; touch "$path"; }
done < manifest.txt
```

### JSON-to-table transformation

```bash
# Wrong way: regex on JSON
grep '"name"' data.json | sed 's/.*: "//' | sed 's/".*//'

# Sushi way: jq extracts, column formats
jq -r '.[] | [.name, .version, .license] | @tsv' packages.json | column -t -s $'\t'
```

---

## Performance Reference

| Operation | Old way | Sushi way | Speedup |
|-----------|---------|-----------|---------|
| File search | `find` ~450ms | `fd` ~45ms | ~10x |
| Content search | `grep -r` ~3.2s | `rg` ~0.3s | ~10x |
| Fuzzy match | custom Python 2-3s | `fzf --filter` <100ms | 20-30x |
| JSON extract | `grep` + `sed` (fragile) | `jq` (robust) | correctness |
| Bulk replace | sequential `sed -i` | `rg -l` + `xargs perl` | parallelism + safety |

*Benchmarks approximate on typical ~10k file projects.*

---

## Recommended Shell Configuration

> For the human's `~/.zshrc` — not for Claude Code.

### ~/.ripgreprc

```
--smart-case
--hidden
--follow
--glob=!.git
--glob=!node_modules
--glob=!dist
--glob=!build
--glob=!coverage
--glob=!.next
--glob=!.cache
--glob=!*.min.js
--glob=!*.min.css
```

### Shell aliases

```bash
# Fuzzy find files — fd + fzf with bat preview
ff() { fd --type f "$@" | fzf --preview "bat --color=always --line-range :50 {}" }

# Ripgrep + fzf — search content, preview in context
rgf() { rg --line-number --color=always "$@" | fzf --ansi --delimiter : --preview "bat --color=always --highlight-line {2} {1}" }

# Interactive git checkout
gco() { git branch --all | fzf --preview "git log --oneline -10 {1}" | xargs git checkout }

# Quick file preview
peek() { bat --color=always --line-range :100 "$@" }
```

Place these in `~/.zshrc`. They require `fd`, `fzf`, `bat`, and `rg` to be installed (all present on this machine).

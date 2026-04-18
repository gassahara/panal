#!/bin/bash

set -e

SSH_IDENTITY="$HOME/.ssh/gassahara"
REMOTE="panal"

export GIT_SSH_COMMAND="ssh -i $SSH_IDENTITY"

echo "==> Scanning for binary/executable files to exclude..."

TMP_EXCLUDE=$(mktemp)
EXCLUDE_FILE=$(mktemp)

for f in *; do
    [ -f "$f" ] || continue

    # Skip directories
    [ -d "$f" ] && continue

    # Skip files with clear source extensions
    if [[ "$f" =~ \.(c|h|cpp|py|sh|html|js|ts|toml|sql|md|json|xml|yml|yaml|php|go|rs|java|cs)$ ]]; then
        continue
    fi

    # Skip hidden config files
    [[ "$f" == .* ]] && continue

    # Skip files with no extension (likely binaries)
    if [[ ! "$f" == *.* ]]; then
        echo "Excluding (no ext): $f"
        echo "$f" >> "$TMP_EXCLUDE"
        continue
    fi

    # Check ELF magic bytes
    if [ -s "$f" ] && head -c 4 "$f" 2>/dev/null | grep -q $'\x7fELF'; then
        echo "Excluding (ELF): $f"
        echo "$f" >> "$TMP_EXCLUDE"
        continue
    fi

    # Check for other binary magic bytes (compiled Mach-O, etc)
    if [ -s "$f" ] && command -v file &>/dev/null; then
        if file "$f" 2>/dev/null | grep -qiE "(executable|mach-|compiled|ELF|binary)"; then
            echo "Excluding (binary): $f"
            echo "$f" >> "$TMP_EXCLUDE"
            continue
        fi
    fi

    # Explicit exclusions for known non-source files
    case "$f" in
        gassahara|gassahara.pub|id_*|*.pem|*.key|credentials.json|*.env|*.log|*.lock|*.memoria)
            echo "Excluding (sensitive): $f"
            echo "$f" >> "$TMP_EXCLUDE"
            ;;
    esac
done

# Also exclude directories
for d in data user users rides build dist; do
    if [ -d "$d" ]; then
        echo "Excluding (dir): $d/"
        echo "$d/" >> "$TMP_EXCLUDE"
    fi
done

# Build exclude patterns
> "$EXCLUDE_FILE"
[ -s "$TMP_EXCLUDE" ] && while read -r f; do
    echo "-- ':!$f'" >> "$EXCLUDE_FILE"
done < "$TMP_EXCLUDE"

rm -f "$TMP_EXCLUDE"

echo "==> Adding source files..."
git add --all \
    -- ':!*.log' \
    -- ':!*key*' \
    -- ':!*pem' \
    -- ':!id_*' \
    -- ':!credentials.json' \
    -- ':!.env' \
    -- ':!gassahara*' \
    -- ':!data/**' \
    -- ':!user/**' \
    -- ':!users/**' \
    -- ':!rides/**' \
    -- ':!.DS_Store' \
    -- ':!.fuse_hidden*' \
    -- ':!*.o' \
    -- ':!*.a' \
    -- ':!*.so' \
    -- ':!*.dylib' \
    $(cat "$EXCLUDE_FILE" 2>/dev/null || echo "")

rm -f "$EXCLUDE_FILE"

STAGED=$(git diff --cached --name-only | wc -l)
if [ "$STAGED" -eq 0 ]; then
    echo "No source files to commit."
    exit 0
fi

echo ""
echo "==> Files to commit ($STAGED):"
git diff --cached --name-only | head -30
[ "$STAGED" -gt 30 ] && echo "... and $((STAGED - 30)) more"

BRANCH_NAME="auto/commit-$(date +%Y%m%d-%H%M%S)"
echo ""
echo "==> Creating branch: $BRANCH_NAME"
git checkout -b "$BRANCH_NAME"

echo "==> Committing..."
git commit -m "chore: $(date +%Y-%m-%d) - add updated source files

$(git diff --cached --name-only | head -20 | sed 's/^/- /')"

echo "==> Pushing..."
git push -u "$REMOTE" "$BRANCH_NAME"

echo ""
echo "==> Done! Branch: $BRANCH_NAME"
echo "    URL: https://github.com/gassahara/panal/tree/$BRANCH_NAME"
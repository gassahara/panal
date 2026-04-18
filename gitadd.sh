#!/bin/bash

set -e

SSH_IDENTITY="$HOME/.ssh/gassahara"
REMOTE="panal"

export GIT_SSH_COMMAND="ssh -i $SSH_IDENTITY"

echo "==> Checking for changes..."
if [ -z "$(git status --porcelain)" ]; then
    echo "No changes to commit."
    exit 0
fi

echo "==> Adding all files..."

git add .

echo "==> Removing unwanted files..."

git reset HEAD -- '*.log' '*key*' '*.pem' 'id_*' 'credentials.json' '.env' 'gassahara*' '.DS_Store' '*.o' '*.a' '*.so' '*.dylib' 'data/*' 'user/*' 'users/*' 'rides/*' 2>/dev/null || true

for f in *; do
    [ -f "$f" ] || continue
    case "$f" in
        gassahara|id_*|*.pem|*.key|credentials.json|*.env|*.log|*.lock|*.memoria)
            git reset HEAD -- "$f" 2>/dev/null || true
            ;;
    esac
done

for d in data user users rides; do
    [ -d "$d" ] && git reset HEAD -- "$d/*" 2>/dev/null || true
done

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
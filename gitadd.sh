#!/bin/bash

set -e

SSH_IDENTITY="$HOME/.ssh/gassahara"
REMOTE="panal"

export GIT_SSH_COMMAND="ssh -i $SSH_IDENTITY"

echo "==> Adding all changed files..."
git add -A

STAGED=$(git diff --cached --name-only | wc -l)
if [ "$STAGED" -eq 0 ]; then
    echo "No files to commit."
    exit 0
fi

echo "==> Files to commit:"
git diff --cached --name-only

BRANCH_NAME="auto/commit-$(date +%Y%m%d-%H%M%S)"
echo "==> Creating branch: $BRANCH_NAME"
git checkout -b "$BRANCH_NAME"

echo "==> Committing..."
git commit -m "chore: $(date +%Y-%m-%d) - add updated files

$(git diff --cached --name-only | head -20 | sed 's/^/- /')"

echo "==> Pushing..."
git push -u "$REMOTE" "$BRANCH_NAME"

echo ""
echo "==> Done! Branch: $BRANCH_NAME"
echo "    URL: https://github.com/gassahara/panal/tree/$BRANCH_NAME"
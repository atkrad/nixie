#!/usr/bin/env bash
set -euo pipefail

GITHUB_USER="atkrad"
VAULT_NAME="notes"
VAULT_PATH="${HOME}/Workspace/github.com/${GITHUB_USER}/${VAULT_NAME}"
TEMPLATE_DIR="$(cd "$(dirname "$0")/../vault-templates" && pwd)"

if [[ -d "${VAULT_PATH}/.git" ]]; then
  echo "Vault already cloned at ${VAULT_PATH}"
else
  ghq get "git@github.com:${GITHUB_USER}/${VAULT_NAME}.git"
fi

cp "${TEMPLATE_DIR}/.gitignore" "${VAULT_PATH}/.gitignore"

cd "${VAULT_PATH}"
if ! git rev-parse --verify HEAD >/dev/null 2>&1; then
  git add .gitignore
  git commit -m "add obsidian gitignore"
  git push -u origin main
elif [[ -n "$(git status --porcelain .gitignore)" ]]; then
  git add .gitignore
  git commit -m "update obsidian gitignore"
  git push
fi

echo "Vault ready at ${VAULT_PATH}"
echo "Next: home-manager switch --flake ~/nixie#nixie-ci"

#!/usr/bin/env bash
set -euo pipefail

repo="${1:-Kaz045/with-portal}"

if ! command -v gh >/dev/null 2>&1; then
  echo "Error: gh CLI is required." >&2
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "Error: gh auth status failed. Run 'gh auth login' first." >&2
  exit 1
fi

read_secret() {
  local name="$1"
  local value
  read -r -s -p "${name}: " value
  echo
  if [ -z "${value}" ]; then
    echo "Error: ${name} cannot be empty." >&2
    exit 1
  fi
  printf '%s' "${value}"
}

validate_firebase_api_key() {
  local value="$1"
  if [[ ! "${value}" =~ ^AIza[0-9A-Za-z_-]{20,}$ ]]; then
    echo "Error: FIREBASE_API_KEY format looks invalid." >&2
    echo "Paste only the key string (example: AIza...)." >&2
    exit 1
  fi
}

read_value() {
  local name="$1"
  local value
  read -r -p "${name}: " value
  if [ -z "${value}" ]; then
    echo "Error: ${name} cannot be empty." >&2
    exit 1
  fi
  printf '%s' "${value}"
}

echo "Setting Firebase GitHub Secrets for ${repo}"

a_api_key="$(read_secret FIREBASE_API_KEY)"
validate_firebase_api_key "${a_api_key}"
a_auth_domain="$(read_value FIREBASE_AUTH_DOMAIN)"
a_project_id="$(read_value FIREBASE_PROJECT_ID)"
a_storage_bucket="$(read_value FIREBASE_STORAGE_BUCKET)"
a_sender_id="$(read_value FIREBASE_MESSAGING_SENDER_ID)"
a_app_id="$(read_value FIREBASE_APP_ID)"
a_app_id_label="$(read_value FIREBASE_APP_ID_LABEL)"

printf '%s' "${a_api_key}" | gh secret set FIREBASE_API_KEY --repo "${repo}"
printf '%s' "${a_auth_domain}" | gh secret set FIREBASE_AUTH_DOMAIN --repo "${repo}"
printf '%s' "${a_project_id}" | gh secret set FIREBASE_PROJECT_ID --repo "${repo}"
printf '%s' "${a_storage_bucket}" | gh secret set FIREBASE_STORAGE_BUCKET --repo "${repo}"
printf '%s' "${a_sender_id}" | gh secret set FIREBASE_MESSAGING_SENDER_ID --repo "${repo}"
printf '%s' "${a_app_id}" | gh secret set FIREBASE_APP_ID --repo "${repo}"
printf '%s' "${a_app_id_label}" | gh secret set FIREBASE_APP_ID_LABEL --repo "${repo}"

echo "Done. Secrets updated for ${repo}."

echo "Next: trigger workflow"
echo "  gh workflow run pages.yml --repo ${repo}"

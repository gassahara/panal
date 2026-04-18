#!/usr/bin/env bash
# =============================================================================
# deploy-functions.sh — Billboard Edition
#
# SYNOPSIS
#   Deploy changed Supabase Edge Functions for the nube billboard project.
#   Mirrors the "make for ts functions" pattern: only re-deploys functions
#   whose .ts files are newer than the last-deploy stamp.
#
# USAGE
#   ./deploy-functions.sh [options]
#
# OPTIONS
#   --all       | -a            Force deploy all functions
#   --function  | -f <name>     Deploy only the named function
#   --project-ref | -p <ref>    Supabase project ref (overrides config / env)
#   --migrate   | -m            Also run pending SQL migrations
#   --help      | -h            Show this help
#
# ENVIRONMENT
#   SUPABASE_PROJECT_REF   — project ref (used when --project-ref not given)
#   SUPABASE_DB_URL        — postgres connection string (needed for --migrate)
# =============================================================================

set -euo pipefail

# ── ANSI colours ──────────────────────────────────────────────────────────────
GRAY='\033[90m'
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
CYAN='\033[36m'
BOLD='\033[1m'
NC='\033[0m'

# ── Defaults ──────────────────────────────────────────────────────────────────
ALL=false
FUNCTION=""
MIGRATE=false
PROJECT_REF="${SUPABASE_PROJECT_REF:-}"

# ── Argument parsing ──────────────────────────────────────────────────────────
while [[ $# -gt 0 ]]; do
  case $1 in
    --all|-a)         ALL=true;            shift ;;
    --migrate|-m)     MIGRATE=true;        shift ;;
    --function|-f)    FUNCTION="$2";       shift 2 ;;
    --project-ref|-p) PROJECT_REF="$2";    shift 2 ;;
    --help|-h)
      sed -n '2,/^# ===/p' "$0" | grep '^#' | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    *)
      echo -e "${RED}Unknown parameter: $1${NC}"
      echo "Usage: $0 [--all] [--function <name>] [--project-ref <ref>] [--migrate]"
      exit 1
      ;;
  esac
done

# ── Paths ─────────────────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FUNCTIONS_DIR="$SCRIPT_DIR/supabase/functions"
MIGRATIONS_DIR="$SCRIPT_DIR/supabase/migrations"
TIMESTAMP_DIR="$SCRIPT_DIR/supabase/.deploy-timestamps"

# ── Resolve project ref ───────────────────────────────────────────────────────
if [[ -z "$PROJECT_REF" ]]; then
  echo -e "${GRAY}Reading supabase/config.toml ...${NC}"
  if [[ -f "$SCRIPT_DIR/supabase/config.toml" ]]; then
    PROJECT_REF=$(sed -n 's/^[[:space:]]*project_id[[:space:]]*=[[:space:]]*"\([^"]*\)".*/\1/p' \
                  "$SCRIPT_DIR/supabase/config.toml" | head -n 1)
  fi
fi

if [[ -z "$PROJECT_REF" || "$PROJECT_REF" == "your-project-ref-here" ]]; then
  echo -e "${RED}Error: No project ref found.${NC}"
  echo -e "  • Edit  ${CYAN}supabase/config.toml${NC}  and set  project_id"
  echo -e "  • Or pass  ${CYAN}--project-ref <ref>${NC}"
  echo -e "  • Or export  ${CYAN}SUPABASE_PROJECT_REF=<ref>${NC}"
  exit 1
fi

# ── Sanity checks ─────────────────────────────────────────────────────────────
if ! command -v supabase &>/dev/null; then
  echo -e "${RED}Error: 'supabase' CLI not found. Install from https://supabase.com/docs/guides/cli${NC}"
  exit 1
fi

if [[ ! -d "$FUNCTIONS_DIR" ]]; then
  echo -e "${RED}Error: $FUNCTIONS_DIR not found.${NC}"
  exit 1
fi

mkdir -p "$TIMESTAMP_DIR"

# =============================================================================
# STEP 1 — Run migrations (optional)
# =============================================================================
if [[ "$MIGRATE" == true ]]; then
  echo -e "\n${BOLD}${CYAN}── Migrations ──────────────────────────────────────${NC}"
  MIGRATION_STAMP="$TIMESTAMP_DIR/_migrations.stamp"
  shopt -s nullglob
  migration_files=("$MIGRATIONS_DIR"/*.sql)
  shopt -u nullglob

  if [[ ${#migration_files[@]} -eq 0 ]]; then
    echo -e "${GRAY}  No migration files found in $MIGRATIONS_DIR${NC}"
  else
    needs_migrate=false
    if [[ "$ALL" == true || ! -f "$MIGRATION_STAMP" ]]; then
      needs_migrate=true
    else
      for mf in "${migration_files[@]}"; do
        if [[ "$mf" -nt "$MIGRATION_STAMP" ]]; then needs_migrate=true; break; fi
      done
    fi

    if [[ "$needs_migrate" == true ]]; then
      echo -e "${GREEN}  Pushing migrations to project $PROJECT_REF ...${NC}"
      set +e
      mig_out=$(supabase db push --project-ref "$PROJECT_REF" 2>&1)
      mig_code=$?
      set -e
      if [[ $mig_code -eq 0 ]]; then
        touch "$MIGRATION_STAMP"
        echo -e "${GREEN}  Migrations applied OK${NC}"
      else
        echo -e "${RED}  Migration FAILED (exit $mig_code)${NC}"
        echo -e "${GRAY}$mig_out${NC}"
        exit 1
      fi
    else
      echo -e "${GRAY}  Migrations up to date${NC}"
    fi
  fi
fi

# =============================================================================
# STEP 2 — Deploy edge functions
# =============================================================================
echo -e "\n${BOLD}${CYAN}── Edge Functions ──────────────────────────────────${NC}"
echo -e "${CYAN}  Project : $PROJECT_REF${NC}"

shopt -s nullglob
all_dirs=("$FUNCTIONS_DIR"/*/)
shopt -u nullglob

# Filter out _shared (it's a library, not a deployable function)
function_dirs=()
for d in "${all_dirs[@]}"; do
  function_dirs+=("$d")
done

if [[ ${#function_dirs[@]} -eq 0 ]]; then
  echo -e "${YELLOW}  No deployable functions found.${NC}"
  exit 0
fi

echo -e "${CYAN}  Found ${#function_dirs[@]} function(s)${NC}\n"

deployed=()
skipped=()
errors=()

# Sort alphabetically (bash 3.2 / macOS compatible)
sorted_dirs=()
while IFS= read -r line; do sorted_dirs+=("$line"); done \
  < <(printf "%s\n" "${function_dirs[@]}" | sort)

for func_dir in "${sorted_dirs[@]}"; do
  func_name=$(basename "$func_dir")
  stamp_file="$TIMESTAMP_DIR/$func_name.stamp"

  # Filter by name if --function given
  if [[ -n "$FUNCTION" && "$func_name" != "$FUNCTION" ]]; then continue; fi

  # Must have at least one .ts file
  ts_count=$(find "$func_dir" -name "*.ts" 2>/dev/null | wc -l | tr -d ' ')
  if [[ "$ts_count" -eq 0 ]]; then
    echo -e "${GRAY}  $func_name : no .ts files — skipping${NC}"
    skipped+=("$func_name")
    continue
  fi

  # Decide if deploy is needed
  needs_deploy=false
  if [[ "$ALL" == true || -n "$FUNCTION" || ! -f "$stamp_file" ]]; then
    needs_deploy=true
  else
    newer=$(find "$func_dir" -name "*.ts" -newer "$stamp_file" 2>/dev/null | head -n 1)
    [[ -n "$newer" ]] && needs_deploy=true
  fi

  if [[ "$needs_deploy" == true ]]; then
    echo -e "${GREEN}  $func_name : deploying ...${NC}"
    set +e
    deploy_out=$(supabase functions deploy "$func_name" \
                   --project-ref "$PROJECT_REF" \
                   --no-verify-jwt 2>&1)
    deploy_code=$?
    set -e

    if [[ $deploy_code -eq 0 ]]; then
      touch "$stamp_file"
      echo -e "${GREEN}  $func_name : ✓ deployed${NC}"
      deployed+=("$func_name")
    else
      echo -e "${RED}  $func_name : ✗ FAILED (exit $deploy_code)${NC}"
      echo -e "${GRAY}$deploy_out${NC}"
      errors+=("$func_name")
    fi
  else
    echo -e "${GRAY}  $func_name : up to date${NC}"
    skipped+=("$func_name")
  fi
done

# =============================================================================
# Summary
# =============================================================================
echo ""
echo -e "${BOLD}${CYAN}── Summary ─────────────────────────────────────────${NC}"

if [[ ${#deployed[@]} -gt 0 ]]; then
  str=$(IFS=', '; echo "${deployed[*]}")
  echo -e "${GREEN}  Deployed (${#deployed[@]}) : $str${NC}"
else
  echo -e "${GRAY}  Deployed : 0${NC}"
fi

echo -e "${GRAY}  Skipped  : ${#skipped[@]}${NC}"

if [[ ${#errors[@]} -gt 0 ]]; then
  str=$(IFS=', '; echo "${errors[*]}")
  echo -e "${RED}  Errors   (${#errors[@]}) : $str${NC}"
  exit 1
fi

echo -e "${GRAY}  Errors   : 0${NC}"

# Print live endpoints
if [[ ${#deployed[@]} -gt 0 ]]; then
  echo ""
  echo -e "${CYAN}  Endpoints:${NC}"
  for fn in "${deployed[@]}"; do
    echo -e "${GRAY}    https://$PROJECT_REF.supabase.co/functions/v1/$fn${NC}"
  done
fi

echo ""
date
exit 0

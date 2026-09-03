#!/usr/bin/env bash
# Master telemetry script for the ai-design-sandbox marketplace.
# Single source of truth — copied into every skill folder by /skill-packager.
#
# Usage:
#   bash "<SKILL_DIR>/scripts/_telemetry.sh" <skill-slug>
#
# One required arg: the skill folder name. The endpoint records timestamp and
# skill name into the AI-Designer-Sandbox sheet. Anything else is ignored.
#
# Silent by design: never prints, never exits non-zero. To audit a run:
#   tail -n 5 ~/.ai-design-sandbox-telemetry.log

ENDPOINT="https://script.google.com/macros/s/AKfycbxhU0tQday0qAHissi_wIWBmWLENowY2CAOyIeVqZuC7-pdvZH2_UPbukHc2IGfkfHN/exec"
LOG_FILE="${HOME}/.ai-design-sandbox-telemetry.log"

SKILL_NAME="${1:-}"
ts=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

_log() {
  printf '%s\t%s\t%s\n' "$ts" "$1" "$2" >> "$LOG_FILE" 2>/dev/null || true
}

case "$SKILL_NAME" in
  ""|unknown|"<skill>"|"<skill-name>"|"<skill-folder-name>"|"<slug>")
    _log "REFUSED" "skill=${SKILL_NAME:-?} reason=skill_name_missing_or_placeholder"
    exit 0
    ;;
esac

SKILL_ENC="${SKILL_NAME// /%20}"
URL="${ENDPOINT}?skillName=${SKILL_ENC}"

http_status=$(curl -sS -o /dev/null -w "%{http_code}" --max-time 8 -L "$URL" 2>/dev/null) || http_status="000"

if [ "$http_status" = "200" ] || [ "$http_status" = "302" ]; then
  _log "SENT" "skill=$SKILL_NAME http=$http_status"
else
  _log "FAILED_HTTP" "skill=$SKILL_NAME http=$http_status"
fi

exit 0

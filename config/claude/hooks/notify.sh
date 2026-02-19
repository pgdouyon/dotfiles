#!/usr/bin/env bash
#
# Claude Code notification hook
#
# Usage:
#   notify.sh --record   Record the time the user submitted a prompt (UserPromptSubmit hook)
#   notify.sh            Fire a notification if Claude has been running long enough (Stop/Notification hooks)

LOCKDIR=/tmp/claude-notify.lock
START_FILE=/tmp/claude-start-time
MIN_ELAPSED=60  # seconds

case "$1" in
  --record)
    date +%s > "$START_FILE"
    ;;
  *)
    START=$(cat "$START_FILE" 2>/dev/null || echo 0)
    ELAPSED=$(( $(date +%s) - START ))

    if [ "$ELAPSED" -gt "$MIN_ELAPSED" ]; then
      mkdir "$LOCKDIR" 2>/dev/null && (
        terminal-notifier \
          -message "Claude needs your attention" \
          -title "Claude Code" \
          -timeout 5 \
          -activate com.googlecode.iterm2 \
          -group claude-code
        sleep 3
        rmdir "$LOCKDIR"
      )
    fi
    ;;
esac

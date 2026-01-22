#!/bin/bash
# PreCompact Hook - 在上下文压缩之前保存状态
#
# 在 Claude 压缩上下文之前运行，让你有机会
# 保留可能在摘要过程中丢失的重要状态。
#
# Hook 配置 (位于 ~/.claude/settings.json):
# {
#   "hooks": {
#     "PreCompact": [{
#       "matcher": "*",
#       "hooks": [{
#         "type": "command",
#         "command": "~/.claude/hooks/memory-persistence/pre-compact.sh"
#       }]
#     }]
#   }
# }

SESSIONS_DIR="${HOME}/.claude/sessions"
COMPACTION_LOG="${SESSIONS_DIR}/compaction-log.txt"

mkdir -p "$SESSIONS_DIR"

# 记录带有时间戳的压缩事件
echo "[$(date '+%Y-%m-%d %H:%M:%S')] 触发了上下文压缩" >> "$COMPACTION_LOG"

# 如果存在活动的会话文件，记录本次压缩
ACTIVE_SESSION=$(ls -t "$SESSIONS_DIR"/*.tmp 2>/dev/null | head -1)
if [ -n "$ACTIVE_SESSION" ]; then
  echo "" >> "$ACTIVE_SESSION"
  echo "---" >> "$ACTIVE_SESSION"
  echo "**[压缩发生于 $(date '+%H:%M')]** - 上下文已被摘要" >> "$ACTIVE_SESSION"
fi

echo "[PreCompact] 状态已在压缩前保存" >&2

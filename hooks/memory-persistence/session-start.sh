#!/bin/bash
# SessionStart Hook - 在新会话开始时加载之前的上下文
#
# 在新的 Claude 会话开始时运行。检查最近的会话文件，
# 并通知 Claude 有可加载的上下文。
#
# Hook 配置 (位于 ~/.claude/settings.json):
# {
#   "hooks": {
#     "SessionStart": [{
#       "matcher": "*",
#       "hooks": [{
#         "type": "command",
#         "command": "~/.claude/hooks/memory-persistence/session-start.sh"
#       }]
#     }]
#   }
# }

SESSIONS_DIR="${HOME}/.claude/sessions"
LEARNED_DIR="${HOME}/.claude/skills/learned"

# 检查最近的会话文件 (过去 7 天内)
recent_sessions=$(find "$SESSIONS_DIR" -name "*.tmp" -mtime -7 2>/dev/null | wc -l | tr -d ' ')

if [ "$recent_sessions" -gt 0 ]; then
  latest=$(ls -t "$SESSIONS_DIR"/*.tmp 2>/dev/null | head -1)
  echo "[SessionStart] 发现了 $recent_sessions 个最近的会话" >&2
  echo "[SessionStart] 最近的一个: $latest" >&2
fi

# 检查已学习的技能
learned_count=$(find "$LEARNED_DIR" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')

if [ "$learned_count" -gt 0 ]; then
  echo "[SessionStart] 在 $LEARNED_DIR 中有 $learned_count 个已学习的技能可用" >&2
fi

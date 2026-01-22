#!/bin/bash
# Stop Hook (Session End) - 会话结束时持久化学习内容
#
# 在 Claude 会话结束时运行。创建/更新会话日志文件，
# 带有时间戳以进行连续性追踪。
#
# Hook 配置 (位于 ~/.claude/settings.json):
# {
#   "hooks": {
#     "Stop": [{
#       "matcher": "*",
#       "hooks": [{
#         "type": "command",
#         "command": "~/.claude/hooks/memory-persistence/session-end.sh"
#       }]
#     }]
#   }
# }

SESSIONS_DIR="${HOME}/.claude/sessions"
TODAY=$(date '+%Y-%m-%d')
SESSION_FILE="${SESSIONS_DIR}/${TODAY}-session.tmp"

mkdir -p "$SESSIONS_DIR"

# 如果今天的会话文件已存在，更新结束时间
if [ -f "$SESSION_FILE" ]; then
  # 更新“上次更新”时间戳
  sed -i '' "s/\*\*Last Updated:\*\*.*/\*\*Last Updated:\*\* $(date '+%H:%M')/" "$SESSION_FILE" 2>/dev/null || \
  sed -i "s/\*\*Last Updated:\*\*.*/\*\*Last Updated:\*\* $(date '+%H:%M')/" "$SESSION_FILE" 2>/dev/null
  echo "[SessionEnd] 已更新会话文件: $SESSION_FILE" >&2
else
  # 使用模板创建新会话文件
  cat > "$SESSION_FILE" << EOF
# 会话: $(date '+%Y-%m-%d')
**日期:** $TODAY
**开始时间:** $(date '+%H:%M')
**上次更新:** $(date '+%H:%M')

---

## 当前状态

[会话上下文在此处显示]

### 已完成
- [ ]

### 进行中
- [ ]

### 下次会话笔记
-

### 需要加载的上下文
\`\`\`
[相关文件]
\`\`\`
EOF
  echo "[SessionEnd] 已创建会话文件: $SESSION_FILE" >&2
fi

#!/bin/bash
# Strategic Compact Suggester (策略性压缩建议器)
# 在 PreToolUse 阶段或定期运行，以便在逻辑间隔建议手动压缩
#
# 为什么手动压缩优于自动压缩：
# - 自动压缩发生在任意时间点，通常在任务中途
# - 策略性压缩可以在逻辑阶段保留上下文
# - 在探索之后、执行之前进行压缩
# - 完成一个里程碑之后、开始下一个之前进行压缩
#
# Hook 配置 (位于 ~/.claude/settings.json):
# {
#   "hooks": {
#     "PreToolUse": [{
#       "matcher": "Edit|Write",
#       "hooks": [{
#         "type": "command",
#         "command": "~/.claude/skills/strategic-compact/suggest-compact.sh"
#       }]
#     }]
#   }
# }
#
# 建议压缩的标准：
# - 会话已运行较长时间
# - 进行了大量的工具调用
# - 正在从研究/探索过渡到实现
# - 计划已确定
#
# 追踪工具调用计数 (在临时文件中递增)
COUNTER_FILE="/tmp/claude-tool-count-$$"
THRESHOLD=${COMPACT_THRESHOLD:-50}

# 初始化或递增计数器
if [ -f "$COUNTER_FILE" ]; then
  count=$(cat "$COUNTER_FILE")
  count=$((count + 1))
  echo "$count" > "$COUNTER_FILE"
else
  echo "1" > "$COUNTER_FILE"
  count=1
fi

# 在工具调用达到阈值后建议压缩
if [ "$count" -eq "$THRESHOLD" ]; then
  echo "[StrategicCompact] 已达到 $THRESHOLD 次工具调用 - 如果正在切换阶段，请考虑执行 /compact" >&2
fi

# 在超过阈值后定期建议
if [ "$count" -gt "$THRESHOLD" ] && [ $((count % 25)) -eq 0 ]; then
  echo "[StrategicCompact] $count 次工具调用 - 如果上下文已陈旧，这是执行 /compact 的良好检查点" >&2
fi

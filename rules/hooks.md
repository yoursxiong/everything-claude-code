# 钩子系统 (Hooks System)

## 钩子类型

- **PreToolUse**：工具执行前 (校验、参数修改)
- **PostToolUse**：工具执行后 (自动格式化、检查)
- **Stop**：会话结束时 (最终验证)

## 当前钩子 (位于 ~/.claude/settings.json)

### PreToolUse
- **tmux reminder**：对运行时间较长的指令 (npm, pnpm, yarn, cargo 等) 建议使用 tmux
- **git push review**：在推送前打开 Zed 进行审查
- **doc blocker**：阻止创建无必要的 .md/.txt 文件

### PostToolUse
- **PR creation**：记录 PR URL 和 GitHub Actions 状态
- **Prettier**：在编辑后自动格式化 JS/TS 文件
- **TypeScript check**：在编辑 .ts/.tsx 文件后运行 `tsc`
- **console.log warning**：对被编辑文件中的 `console.log` 发出警告

### Stop
- **console.log audit**：在会话结束前检查所有修改过的文件是否包含 `console.log`

## 权限自动接受

谨慎使用：
- 对受信任且定义清晰的计划启用
- 对探索性工作禁用
- 切勿使用 `dangerously-skip-permissions` 标志
- 应在 `~/.claude.json` 中配置 `allowedTools` 作为替代方案

## TodoWrite 最佳实践

使用 TodoWrite 工具来：
- 追踪多步骤任务的进度
- 验证对指令的理解
- 实现实时转向 (steering)
- 展示细粒度的实现步骤

待办事项列表可以揭示：
- 顺序混乱的步骤
- 遗漏项
- 多余的不必要项
- 粗细度不当
- 误解了的需求

# Everything Claude Code

**Anthropic Hackathon 获奖者的 Claude Code 配置全集。**

这套经过生产验证的智能体（Agents）、技能（Skills）、挂钩（Hooks）、命令（Commands）、规则（Rules）和 MCP 配置，源自 10 个月以上在构建真实产品过程中进行的高强度日常使用和不断演进。

---

## 指南

本仓库仅包含原始代码。指南部分对所有内容进行了详细说明。

### 第一步：概览指南 (The Shorthand Guide)

<img width="592" height="445" alt="image" src="https://github.com/user-attachments/assets/1a471488-59cc-425b-8345-5245c7efbcef" />

**[Everyting Claude Code 概览指南](https://x.com/affaanmustafa/status/2012378465664745795)**

基础部分——包含每种配置类型的功能、如何构建你的设置、上下文窗口管理以及这些配置背后的哲学。**请先阅读此部分。**

---

### 第二步：深度指南 (The Longform Guide)

<img width="609" height="428" alt="image" src="https://github.com/user-attachments/assets/c9ca43bc-b149-427f-b551-af6840c368f0" />

**[Everything Claude Code 深度指南](https://x.com/affaanmustafa/status/2014040193557471352)**

高级技巧——包括 Token 优化、跨会话的记忆持久化、验证循环与评估、并行化策略、子智能体编排以及持续学习。本指南中的所有内容在本仓库中都有对应的代码实现。

| 主题 | 你将学到什么 |
|-------|-------------------|
| Token 优化 | 模型选择、系统提示词精简、后台进程处理 |
| 记忆持久化 | 自动跨会话保存/加载上下文的挂钩 (Hooks) |
| 持续学习 | 从会话中自动提取模式并转化为可重用技能 |
| 验证循环 | 检查点 vs 持续评估、评分器类型、pass@k 指标 |
| 并行化 | Git worktrees、级联方法、以及何时扩展实例 |
| 子智能体编排 | 上下文问题、迭代检索模式 |

---

## 目录结构

```
everything-claude-code/
|-- agents/           # 用于任务委派的专用子智能体
|   |-- planner.md           # 功能实现规划
|   |-- architect.md         # 系统设计决策
|   |-- tdd-guide.md         # 测试驱动开发
|   |-- code-reviewer.md     # 质量与安全审查
|   |-- security-reviewer.md # 漏洞分析
|   |-- build-error-resolver.md # 构建错误修复
|   |-- e2e-runner.md        # Playwright E2E 测试
|   |-- refactor-cleaner.md  # 冗余代码清理
|   |-- doc-updater.md       # 文档同步
|
|-- skills/           # 工作流定义与领域知识
|   |-- coding-standards.md         # 编程语言最佳实践
|   |-- backend-patterns.md         # API、数据库、缓存模式
|   |-- frontend-patterns.md        # React、Next.js 模式
|   |-- continuous-learning/        # 从会话中自动提取模式 (深度指南内容)
|   |-- strategic-compact/          # 手动压缩建议 (深度指南内容)
|   |-- tdd-workflow/               # TDD 方法论
|   |-- security-review/            # 安全审查清单
|
|-- commands/         # 用于快速执行的斜杠命令 (Slash commands)
|   |-- tdd.md              # /tdd - 测试驱动开发
|   |-- plan.md             # /plan - 实现方案规划
|   |-- e2e.md              # /e2e - E2E 测试生成
|   |-- code-review.md      # /code-review - 质量审查
|   |-- build-fix.md        # /build-fix - 修复构建错误
|   |-- refactor-clean.md   # /refactor-clean - 冗余代码移除
|   |-- learn.md            # /learn - 会话中途提取模式 (深度指南内容)
|
|-- rules/            # 必须遵守的准则
|   |-- security.md         # 强制性安全检查
|   |-- coding-style.md     # 不可变性、文件组织
|   |-- testing.md          # TDD、80% 覆盖率要求
|   |-- git-workflow.md     # 提交格式、PR 流程
|   |-- agents.md           # 何时将任务委派给子智能体
|   |-- performance.md      # 模型选择、上下文管理
|
|-- hooks/            # 基于触发器的自动化工具
|   |-- hooks.json                # 所有挂钩配置 (PreToolUse, PostToolUse, Stop 等)
|   |-- memory-persistence/       # 会话生命周期挂钩 (深度指南内容)
|   |   |-- pre-compact.sh        # 压缩前保存状态
|   |   |-- session-start.sh      # 加载之前的上下文
|   |   |-- session-end.sh        # 结束时持久化学习内容
|   |-- strategic-compact/        # 压缩建议 (深度指南内容)
|
|-- contexts/         # 动态系统提示词注入上下文 (深度指南内容)
|   |-- dev.md              # 开发模式上下文
|   |-- review.md           # 代码审查模式上下文
|   |-- research.md         # 研究/探索模式上下文
|
|-- examples/         # 配置项目与会话示例
|   |-- CLAUDE.md           # 项目级配置示例
|   |-- user-CLAUDE.md      # 用户级配置示例
|   |-- sessions/           # 会话日志文件示例 (深度指南内容)
|
|-- mcp-configs/      # MCP 服务器配置
|   |-- mcp-servers.json    # GitHub, Supabase, Vercel, Railway 等
|
|-- plugins/          # 插件生态系统文档
|   |-- README.md           # 插件、市场、技能指南
```

---

## 快速开始

### 1. 复制所需内容

```bash
# 克隆仓库
git clone https://github.com/affaan-m/everything-claude-code.git

# 将智能体配置复制到你的 Claude 配置目录
cp everything-claude-code/agents/*.md ~/.claude/agents/

# 复制规则
cp everything-claude-code/rules/*.md ~/.claude/rules/

# 复制命令
cp everything-claude-code/commands/*.md ~/.claude/commands/

# 复制技能
cp -r everything-claude-code/skills/* ~/.claude/skills/
```

### 2. 在 settings.json 中添加挂钩 (Hooks)

将 `hooks/hooks.json` 中的挂钩配置复制到你的 `~/.claude/settings.json`。

### 3. 配置 MCPs

将 `mcp-configs/mcp-servers.json` 中所需的 MCP 服务器配置复制到你的 `~/.claude.json`。

**重要提示：** 请将 `YOUR_*_HERE` 占位符替换为你真实的 API 密钥。

### 4. 阅读指南

说真的，一定要读指南。有了上下文背景，这些配置的使用效果会提升 10 倍。

1. **[概览指南](https://x.com/affaanmustafa/status/2012378465664745795)** - 设置与基础
2. **[深度指南](https://x.com/affaanmustafa/status/2014040193557471352)** - 高级技巧 (Token 优化, 记忆持久化, 评估, 并行化)

---

## 核心概念

### 智能体 (Agents)

子智能体负责处理范围受限的委派任务。例如：

```markdown
---
name: code-reviewer
description: 审查代码的质量、安全性和可维护性
tools: Read, Grep, Glob, Bash
model: opus
---

你是一名资深代码审查员...
```

### 技能 (Skills)

技能是由命令或智能体调用的工作流定义：

```markdown
# TDD 工作流

1. 先定义接口
2. 编写失败的测试 (RED)
3. 实现最小化代码 (GREEN)
4. 重构 (IMPROVE)
5. 验证 80% 以上的覆盖率
```

### 挂钩 (Hooks)

挂钩在工具事件发生时触发。示例 - 警告 `console.log`：

```json
{
  "matcher": "tool == \"Edit\" && tool_input.file_path matches \"\\\\.(ts|tsx|js|jsx)$\"",
  "hooks": [{
    "type": "command",
    "command": "#!/bin/bash\ngrep -n 'console\\.log' \"$file_path\" && echo '[Hook] Remove console.log' >&2"
  }]
}
```

### 规则 (Rules)

规则是必须始终遵循的准则。保持规则的模块化：

```
~/.claude/rules/
  security.md      # 禁止硬编码机密信息
  coding-style.md  # 不可变性、文件限制
  testing.md       # TDD、覆盖率要求
```

---

## 贡献

**欢迎并鼓励大家进行贡献。**

本仓库旨在成为社区资源。如果你有：
- 有用的智能体或技能
- 巧妙的挂钩
- 更好的 MCP 配置
- 改进后的规则

请尽情贡献！参考 [CONTRIBUTING.md](CONTRIBUTING.md) 获取准则。

### 贡献思路

- 特定语言的技能 (Python, Go, Rust 模式)
- 特定框架的配置 (Django, Rails, Laravel)
- DevOps 智能体 (Kubernetes, Terraform, AWS)
- 测试策略 (不同的框架)
- 领域特定知识 (机器学习, 数据工程, 移动端)

---

## 背景

自 Claude Code 实验性推出以来，我一直在使用它。2025 年 9 月，我与 [@DRodriguezFX](https://x.com/DRodriguezFX) 凭借 [zenith.chat](https://zenith.chat) 赢得了 Anthropic x Forum Ventures 黑客松——该项目完全使用 Claude Code 构建。

这些配置在多个生产级应用中经过了实战测试。

---

## 重要说明

### 上下文窗口管理

**关键点：** 不要一次性启用所有 MCP。如果启用了过多工具，你的 200k 上下文窗口可能会缩减到 70k。

经验法则：
- 配置 20-30 个 MCP
- 每个项目保持启用状态的 MCP 少于 10 个
- 保持激活状态的工具少于 80 个

在项目配置中使用 `disabledMcpServers` 来禁用不常用的服务器。

### 自定义

这些配置适用于我的工作流程。你应该：
1. 从你感兴趣的内容开始
2. 根据你的技术栈进行修改
3. 移除不使用的内容
4. 添加你自己的模式

---

## 链接

- **概览指南 (从这里开始):** [Everything Claude Code 概览指南](https://x.com/affaanmustafa/status/2012378465664745795)
- **深度指南 (高级):** [Everything Claude Code 深度指南](https://x.com/affaanmustafa/status/2014040193557471352)
- **关注我:** [@affaanmustafa](https://x.com/affaanmustafa)
- **zenith.chat:** [zenith.chat](https://zenith.chat)

---

## 许可证

MIT - 自由使用，根据需要修改，如果可以的话请回馈社区。

---

**如果对你有帮助，请给本仓库点个 Star。阅读两份指南。构建伟大的产品。**


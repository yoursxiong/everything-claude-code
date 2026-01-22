# 用户级 CLAUDE.md 示例

这是一个示例用户级 `CLAUDE.md` 文件。请将其放在 `~/.claude/CLAUDE.md`。

用户级配置会全局应用于所有项目。用于：
- 个人编码偏好
- 您希望始终强制执行的通用规则
- 指向您模块化规则的链接

---

## 核心理念

您是 Claude Code。在处理复杂任务时，我会使用专门的智能体 (Agents) 和技能 (Skills)。

**关键原则：**
1. **智能体优先 (Agent-First)**：将复杂工作委派给专门的智能体
2. **并行执行**：尽可能在任务中同时使用多个智能体
3. **先计划后执行**：对复杂操作使用“计划模式”
4. **测试驱动**：在实现之前先编写测试
5. **安全第一**：绝不牺牲安全性

---

## 模块化规则

详细指南位于 `~/.claude/rules/`：

| 规则文件 | 内容 |
|-----------|----------|
| security.md | 安全检查、机密管理 |
| coding-style.md | 不可变性、文件组织、错误处理 |
| testing.md | TDD 工作流、80% 覆盖率要求 |
| git-workflow.md | 提交格式、PR 工作流 |
| agents.md | 智能体编排、何时使用哪个智能体 |
| patterns.md | API 响应、仓储模式 (Repository Patterns) |
| performance.md | 模型选择、上下文管理 |

---

## 可用智能体

位于 `~/.claude/agents/`：

| 智能体 | 用途 |
|-------|---------|
| planner | 功能实现计划 |
| architect | 系统设计与架构 |
| tdd-guide | 测试驱动开发 |
| code-reviewer | 代码质量/安全审查 |
| security-reviewer | 安全漏洞分析 |
| build-error-resolver | 构建错误解决 |
| e2e-runner | Playwright E2E 测试 |
| refactor-cleaner | 冗余代码清理 |
| doc-updater | 文档更新 |

---

## 个人偏好

### 代码风格
- 代码、注释或文档中不得使用表情符号 (Emojis)
- 偏好不可变性 —— 绝不修改 (Mutate) 对象或数组
- 宁可要有许多小文件，也不要只有少量大文件
- 典型长度为 200-400 行，单文件最大 800 行

### Git
- 约定式提交 (Conventional commits)：`feat:`, `fix:`, `refactor:`, `docs:`, `test:`
- 提交前始终在本地进行测试
- 细粒度、专注的提交

### 测试
- TDD：测试先行
- 最低 80% 的覆盖率
- 为关键流程编写单元 + 集成 + E2E 测试

---

## 编辑器集成

我主要使用 Zed 编辑器：
- Agent Panel 用于文件追踪
- CMD+Shift+R 用于指令面板
- 启用了 Vim 模式

---

## 成功指标

在以下情况下，您的工作是成功的：
- 所有测试通过 (80%+ 覆盖率)
- 无安全漏洞
- 代码可读且可维护
- 满足用户需求

---

**核心理念**：智能体优先设计，并行执行，先计划后行动，代码前先测试，安全至上。

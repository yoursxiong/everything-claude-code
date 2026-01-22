# 参与贡献 Everything Claude Code

感谢你愿意参与贡献。本仓库旨在为 Claude Code 用户提供一个社区资源。

## 我们感兴趣的内容

### 智能体 (Agents)

能够很好处理特定任务的新智能体：
- 特定语言的审查员 (Python, Go, Rust)
- 框架专家 (Django, Rails, Laravel, Spring)
- DevOps 专家 (Kubernetes, Terraform, CI/CD)
- 领域专家 (机器学习流水线, 数据工程, 移动端)

### 技能 (Skills)

工作流定义和领域知识：
- 编程语言最佳实践
- 框架模式
- 测试策略
- 架构指南
- 领域特定知识

### 命令 (Commands)

调用有用工作流的斜杠命令 (Slash commands)：
- 部署命令
- 测试命令
- 文档命令
- 代码生成命令

### 挂钩 (Hooks)

有用的自动化工具：
- Linting/格式化挂钩
- 安全检查
- 验证挂钩
- 通知挂钩

### 规则 (Rules)

必须始终遵循的准则：
- 安全规则
- 代码风格规则
- 测试要求
- 命名规范

### MCP 配置

新增或改进后的 MCP 服务器配置：
- 数据库集成
- 云服务商 MCPs
- 监控工具
- 通讯工具

---

## 如何参与贡献

### 1. Fork 仓库

```bash
git clone https://github.com/你的用户名/everything-claude-code.git
cd everything-claude-code
```

### 2. 创建分支

```bash
git checkout -b add-python-reviewer
```

### 3. 添加你的贡献

将文件放置在对应的目录中：
- `agents/` 用于放置新智能体
- `skills/` 用于放置技能 (可以是单个 .md 文件或目录)
- `commands/` 用于放置斜杠命令
- `rules/` 用于放置规则文件
- `hooks/` 用于放置挂钩配置
- `mcp-configs/` 用于放置 MCP 服务器配置

### 4. 遵循格式要求

**智能体 (Agents)** 必须包含元数据 (frontmatter)：

```markdown
---
name: agent-name
description: 它的功能
tools: Read, Grep, Glob, Bash
model: sonnet
---

在此填写指令...
```

**技能 (Skills)** 应当清晰且具可操作性：

```markdown
# 技能名称

## 何时使用

...

## 工作原理

...

## 示例

...
```

**命令 (Commands)** 应当解释其用途：

```markdown
---
description: 命令的简短描述
---

# 命令名称

详细指令...
```

**挂钩 (Hooks)** 应当包含描述：

```json
{
  "matcher": "...",
  "hooks": [...],
  "description": "此挂钩的功能"
}
```

### 5. 测试你的贡献

在提交之前，请确保你的配置在 Claude Code 中可以正常工作。

### 6. 提交 PR

```bash
git add .
git commit -m "Add Python code reviewer agent"
git push origin add-python-reviewer
```

然后开启一个 PR，并注明：
- 你添加了什么
- 为什么它很有用
- 你是如何测试它的

---

## 准则

### 建议

- 保持配置的专注和模块化
- 包含清晰的描述
- 在提交前进行测试
- 遵循现有的模式
- 记录任何依赖项

### 避免

- 包含敏感数据 (API 密钥、令牌、路径)
- 添加过于复杂或冷门的配置
- 提交未经测试的配置
- 创建重复的功能
- 添加需要特定付费服务且没有备选方案的配置

---

## 文件命名

- 使用小写字母和连字符：`python-reviewer.md`
- 具备描述性：使用 `tdd-workflow.md` 而不是 `workflow.md`
- 文件名应与智能体/技能名称相匹配

---

## 有疑问？

请开启一个 Issue 或在 X 上联系：[@affaanmustafa](https://x.com/affaanmustafa)

---

感谢你的参与。让我们一起构建一个优秀的资源库。


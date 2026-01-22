# Git 工作流

## 提交信息格式

```
<type>: <description>

<optional body>
```

类型 (Types)：feat, fix, refactor, docs, test, chore, perf, ci

注意：通过 `~/.claude/settings.json` 已在全局禁用署名。

## 拉取请求 (PR) 工作流

创建 PR 时：
1. 分析完整的提交历史 (不仅仅是最近一次提交)
2. 使用 `git diff [base-branch]...HEAD` 查看所有变更
3. 起草全面的 PR 摘要
4. 包含带有 TODO 的测试计划
5. 如果是新分支，推送时使用 `-u` 标志

## 功能实现工作流

1. **先计划**
   - 使用 **planner** 智能体创建实现计划
   - 识别依赖项和风险
   - 分解为各个阶段

2. **TDD 方法**
   - 使用 **tdd-guide** 智能体
   - 测试先行 (红 - RED)
   - 实现代码以通过测试 (绿 - GREEN)
   - 重构 (提升 - IMPROVE)
   - 验证 80% 以上的覆盖率

3. **代码审查**
   - 编写代码后立即使用 **code-reviewer** 智能体
   - 解决严重 (CRITICAL) 和高 (HIGH) 级别的问题
   - 尽可能修复中 (MEDIUM) 级别的问题

4. **提交与推送**
   - 详细的提交信息
   - 遵循约定式提交格式

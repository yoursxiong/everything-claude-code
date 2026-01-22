# 智能体编排 (Agent Orchestration)

## 可用智能体

位于 `~/.claude/agents/`：

| 智能体 | 用途 | 何时使用 |
|-------|---------|-------------|
| planner | 实现计划 | 复杂功能、重构 |
| architect | 系统设计 | 架构决策 |
| tdd-guide | 测试驱动开发 | 新功能、Bug 修复 |
| code-reviewer | 代码审查 | 编写代码后 |
| security-reviewer | 安全分析 | 提交代码前 |
| build-error-resolver | 解决构建错误 | 构建失败时 |
| e2e-runner | E2E 测试 | 关键用户流程 |
| refactor-cleaner | 清理冗余代码 | 代码维护 |
| doc-updater | 文档编写 | 更新文档 |

## 立即使用智能体

无需用户提示：
1. 复杂的功能请求 —— 使用 **planner** 智能体
2. 刚刚编写/修改的代码 —— 使用 **code-reviewer** 智能体
3. Bug 修复或新功能 —— 使用 **tdd-guide** 智能体
4. 架构决策 —— 使用 **architect** 智能体

## 并行任务执行

对于相互独立的任务，**始终**使用并行任务执行：

```markdown
# 推荐做法：并行执行
并行启用 3 个智能体：
1. 智能体 1：对 auth.ts 进行安全分析
2. 智能体 2：对缓存系统进行性能评估
3. 智能体 3：对 utils.ts 进行类型检查

# 不推荐做法：无必要的顺序执行
先启动智能体 1，然后是智能体 2，最后是智能体 3
```

## 多视角分析

对于复杂问题，使用拆分角色的子智能体：
- 事实检查员 (Factual reviewer)
- 资深工程师 (Senior engineer)
- 安全专家 (Security expert)
- 一致性检查员 (Consistency reviewer)
- 冗余检查员 (Redundancy checker)

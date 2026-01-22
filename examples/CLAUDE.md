# 示例项目 CLAUDE.md

这是一个示例项目级的 `CLAUDE.md` 文件。请将其放在项目根目录。

## 项目概述

[简要描述您的项目 —— 它的作用、技术栈等]

## 关键规则

### 1. 代码组织

- 宁可要有许多小文件，也不要只有少量大文件
- 高内聚，低耦合
- 典型长度为 200-400 行，单文件最大 800 行
- 按功能/领域组织，而不是按类型组织

### 2. 代码风格

- 代码、注释或文档中不得使用表情符号 (Emojis)
- 始终保持不可变性 —— 绝不修改 (Mutate) 对象或数组
- 生产环境代码中不得包含 `console.log`
- 使用 `try/catch` 进行妥善的错误处理
- 使用 Zod 或类似工具进行输入校验

### 3. 测试

- TDD：测试先行
- 最低 80% 的覆盖率
- 为工具函数编写单元测试
- 为 API 编写集成测试
- 为关键流程编写 E2E 测试

### 4. 安全

- 不得硬编码机密信息 (Secrets)
- 为敏感数据使用环境变量
- 校验所有用户输入
- 仅使用参数化查询
- 启用 CSRF 防护

## 文件结构

```
src/
|-- app/              # Next.js app 路由
|-- components/       # 可复用 UI 组件
|-- hooks/            # 自定义 React hooks
|-- lib/              # 工具库
|-- types/            # TypeScript 定义
```

## 关键模式

### API 响应格式

```typescript
interface ApiResponse<T> {
  success: boolean
  data?: T
  error?: string
}
```

### 错误处理

```typescript
try {
  const result = await operation()
  return { success: true, data: result }
} catch (error) {
  console.error('Operation failed:', error)
  return { success: false, error: '用户友好的错误提示' }
}
```

## 环境变量

```bash
# 必填
DATABASE_URL=
API_KEY=

# 选填
DEBUG=false
```

## 可用指令

- `/tdd` - 测试驱动开发工作流
- `/plan` - 创建实现计划
- `/code-review` - 审查代码质量
- `/build-fix` - 修复构建错误

## Git 工作流

- 约定式提交 (Conventional commits)：`feat:`, `fix:`, `refactor:`, `docs:`, `test:`
- 绝不直接提交到 `main` 分支
- PR 需要经过审查
- 合并前所有测试必须通过

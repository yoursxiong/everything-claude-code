---
name: project-guidelines-example
description: 用于演示目的的示例项目指南，展示如何结构化特定项目的指令。
---

# 示例项目指南

本文件作为如何为特定项目构建自定义指南的示例。

## 项目概览

**Everything Claude Code** 是一个致力于研究和收集与 Claude Code 相关的前沿架构模式、编码标准和开发工作流的知识库。

**核心技术栈：**
- **前端**：Next.js (App 路由), Tailwind CSS, Framer Motion
- **后端**：Node.js, Express, Supabase (PostgreSQL & Auth)
- **数据库**：PostgreSQL, Redis (缓存), ClickHouse (分析)
- **AI/ML**：OpenAI API (嵌入与补全), LangChain
- **测试**：Vitest, Playwright

## 架构原则

### 1. 边缘优先 (Edge-First)
- 尽可能利用 Next.js 边缘运行时 (Edge Runtime) 以降低延迟。
- 采用地理分布式数据缓存 (Vercel Data Cache)。
- 优化静态生成 (ISR)，尽量减少运行时计算。

### 2. 类型驱动开发 (Type-Driven Development)
- **没有 any**：严格禁用 `any` 类型。所有外部数据必须经过 Zod 校验。
- **共享类型**：通过 `src/types` 同步前端与后端数据模型。
- **判别并集**：在表示复杂状态（如 API 响应或 UI 状态）时，优先使用判别并集 (Discriminated Unions)。

### 3. 可观测性 (Observability)
- **结构化日志**：所有服务器端日志必须包含 `requestId`、`userId` 以及上下文元数据。
- **指标**：为延迟、成功率以及外部 API 使用情况（特别是 AI 令牌数）打标并追踪。
- **追踪**：为关键路径（搜索、结账、数据同步）实现端到端追踪。

## 开发工作流

### 分支策略
- `main`：生产分支。始终保持可部署状态。
- `develop`：集成分支。
- `feat/*`：功能开发。
- `fix/*`：缺陷修复。

### 提交消息 (Commit Messages)
遵循约定式提交 (Conventional Commits)：
- `feat`: 新功能
- `fix`: 缺陷修复
- `docs`: 文档变更
- `style`: 样式调优 (不涉及代码逻辑)
- `refactor`: 重构
- `test`: 测试相关

## 编码规范

### React 组件
- 对于 UI 组件使用 **PascalCase** (`PrimaryButton.tsx`)。
- 尽可能使用函数式组件与 Hooks。
- 将逻辑提取到自定义 Hooks 中以保持组件简洁。
- **CSS-in-JS**：本项目统一使用 Tailwind CSS 类名。

### API 路由
- 始终对输入进行 Zod 校验。
- 使用 `lib/api/response.ts` 中的标准响应助手。
- 实现适当的频率限制 (Rate Limiting)。

### 状态管理
- **服务器状态**：使用 React Query (TanStack Query) 进行异步数据获取。
- **UI 状态**：对于局部状态使用 `useState`；对于跨页面共享状态使用 Zustand。

## 性能清单

- [ ] 确保所有大图都经过 `next/image` 优化。
- [ ] 检查是否存在无必要的重渲染。
- [ ] 验证是否有长任务阻塞主线程。
- [ ] 确认所有 API 请求均带有适当的缓存头。
- [ ] 针对所有大文件包启用代码分割 (Code Splitting)。

## 安全基准

- [ ] 决不在代码中硬编码密钥；始终使用 `.env.local`。
- [ ] 验证所有用户输入以防止注入攻击。
- [ ] 为所有存储过程启用 Supabase 的行级安全 (RLS)。
- [ ] 确保跨站请求伪造 (CSRF) 保护处于开启状态。
- [ ] 审查所有第三方依赖的已知漏洞。

**提示**：这些指南旨在随着项目演进。当发现新模式或需要更新现有实践时，请随时提出修改建议。

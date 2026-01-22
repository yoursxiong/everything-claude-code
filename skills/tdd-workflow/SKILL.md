---
name: tdd-workflow
description: 一种测试驱动开发 (TDD) 的工作流，用于在编写功能代码之前编写测试，确保代码 quality，减少缺陷，并创建一套稳健的自动化回归测试。
---

# 测试驱动开发 (TDD) 工作流

通过首先编写测试来指导开发的系统方法。

## TDD 周期：红 - 绿 - 重构

### 1. 🔴 红色阶段 (编写失败的测试)
- 编写一个能表达某个小功能或具体行为的单值测试。
- 运行测试并观察它失败。如果不失败，说明该测试在此处是无意义的。
- 此时不需要关心实现细节。

### 2. 🟢 绿色阶段 (编写最简代码使测试通过)
- 编写**尽可能少**的代码来通过测试。
- 允许写出“丑陋”或非最优的代码，其目的仅在于快速达成测试通过的目标。
- 再次运行测试并看到它变绿。

### 3. 🔵 重构阶段 (优化代码)
- 在**保持测试变绿**的前提下改进代码质量。
- 消除重复 (DRY)，提高可读性。
- 确立更好的变量命名和结构。
- 将逻辑拆分为更小的函数或类。

## 何时采用 TDD？

- **纯逻辑/算法**：例如计算相似度分值或处理复杂数据转换。
- **错误处理**：确保边界情况（例如网络超时、无效输入）能被正确抛出。
- **API 接口转换器**：确保外部数据结构被正确映射至内部类型。
- **复杂查询逻辑**：确保根据各种过滤条件能正确返回结果集。

## 示例：开发相似度计算器

### 第一轮：红
```typescript
// tests/similarity.test.ts
import { calculateSimilarity } from '../lib/similarity'

test('returns 1 for identical vectors', () => {
  const v1 = [1, 0]
  const v2 = [1, 0]
  expect(calculateSimilarity(v1, v2)).toBe(1)
})
```

运行测试：**🔴 失败** (找不到 `calculateSimilarity`)

### 第一轮：绿
```typescript
// lib/similarity.ts
export function calculateSimilarity(v1: number[], v2: number[]) {
  return 1 // 最简单的实现
}
```

运行测试：**🟢 通过**

### 第一轮：重构
鉴于逻辑极简，目前暂无需重构。

### 第二轮：红
```typescript
test('returns 0 for orthogonal vectors', () => {
  const v1 = [1, 0]
  const v2 = [0, 1]
  expect(calculateSimilarity(v1, v2)).toBe(0)
})
```

运行测试：**🔴 失败** (预期 0，实际收到 1)

### 第二轮：绿
```typescript
export function calculateSimilarity(v1: number[], v2: number[]) {
  // 足够使这一步通过的代码
  let dotProduct = 0
  for (let i = 0; i < v1.length; i++) {
    dotProduct += v1[i] * v2[i]
  }
  return dotProduct
}
```

运行测试：**🟢 通过**

### 第二轮：重构
```typescript
// 将计算逻辑提取至 helper
const dot = (a: number[], b: number[]) => a.reduce((sum, val, i) => sum + val * b[i], 0)

export function calculateSimilarity(v1: number[], v2: number[]) {
  return dot(v1, v2)
}
```

运行测试：**🟢 通过** (重构成功，行为未变)

## TDD 的黄金法则

1. **先写测试**：决不在没有失败测试的情况下编写功能代码。
2. **一次只写一个测试**：不要一次性编写全套测试集，应逐个迭代。
3. **只写能通过测试的代码**：不要在当前测试之外添加额外的猜测性逻辑。
4. **变绿后再重构**：切勿在测试仍为红色时尝试优化或重构，因为那样做会失去安全护栏。

## 常见障碍

- **难以模拟 (Mockging)**：请将业务逻辑与 I/O (数据库, API 网络请求) 分离。仅针对纯逻辑部分进行 TDD。
- **速度慢**：确保您的测试框架配置为观察模式 (`--watch`) 且仅运行相关的测试。
- **需求不明确**：如果尚不清楚功能应如何运作，可以先进行技术验证 (Spike / Prototyping)，待厘清后再应用 TDD。

**提示**：将 TDD 与热更新或观察模式结合使用。让测试保持在后台持续运行，当您打字时，它们会不断为您提供实时的正确性反馈。

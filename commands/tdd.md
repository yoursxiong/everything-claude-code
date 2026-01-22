---
description: 强制执行测试驱动开发工作流。脚手架化接口，首先生成测试，然后编写最简代码以通过测试。确保 80% 以上的覆盖率。
---

# TDD 指令

此指令调用 **tdd-guide** 智能体以强制执行测试驱动开发 (TDD) 方法论。

## 此指令的作用

1. **脚手架化接口** - 首先定义类型/接口
2. **测试先行** - 编写失败的测试 (红 - RED)
3. **编写最简代码** - 仅编写足以通过测试的代码 (绿 - GREEN)
4. **重构** - 在保持测试通过的同时改进代码 (重构 - REFACTOR)
5. **验证覆盖率** - 确保 80% 以上的测试覆盖率

## 何时使用

在以下情况下使用 `/tdd`：
- 实现新功能
- 添加新的函数/组件
- 修复 Bug (首先编写复现 Bug 的测试)
- 重构现有代码
- 构建关键业务逻辑

## 工作原理

tdd-guide 智能体将会：

1. 为输入/输出**定义接口**
2. **编写会失败的测试** (因为代码尚不存在)
3. **运行测试**并验证它们因正确的理由失败
4. **编写最简实现**以使测试通过
5. **运行测试**并验证它们已通过
6. 在保持测试通过的同时**重构**代码
7. **检查覆盖率**，如果低于 80% 则添加更多测试

## TDD 循环

```
红 (RED) → 绿 (GREEN) → 重构 (REFACTOR) → 重复 (REPEAT)

红 (RED):      编写一个失败的测试
绿 (GREEN):    编写最简代码以通过测试
重构 (REFACTOR): 改进代码，保持测试通过
重复 (REPEAT):   下一个功能/场景
```

## 使用示例

```
用户: /tdd 我需要一个函数来计算市场流动性评分

智能体 (tdd-guide):
# TDD 会话：市场流动性评分计算器

## 第 1 步：定义接口 (脚手架 - SCAFFOLD)

```typescript
// lib/liquidity.ts
export interface MarketData {
  totalVolume: number
  bidAskSpread: number
  activeTraders: number
  lastTradeTime: Date
}

export function calculateLiquidityScore(market: MarketData): number {
  // TODO: 实现
  throw new Error('Not implemented')
}
```

## 第 2 步：编写失败的测试 (红 - RED)

```typescript
// lib/liquidity.test.ts
import { calculateLiquidityScore } from './liquidity'

describe('calculateLiquidityScore', () => {
  it('应当为高流动性市场返回高分', () => {
    const market = {
      totalVolume: 100000,
      bidAskSpread: 0.01,
      activeTraders: 500,
      lastTradeTime: new Date()
    }

    const score = calculateLiquidityScore(market)

    expect(score).toBeGreaterThan(80)
    expect(score).toBeLessThanOrEqual(100)
  })

  it('应当为低流动性市场返回低分', () => {
    const market = {
      totalVolume: 100,
      bidAskSpread: 0.5,
      activeTraders: 2,
      lastTradeTime: new Date(Date.now() - 86400000) // 1 天前
    }

    const score = calculateLiquidityScore(market)

    expect(score).toBeLessThan(30)
    expect(score).toBeGreaterThanOrEqual(0)
  })

  it('应当处理边缘情况：零成交量', () => {
    const market = {
      totalVolume: 0,
      bidAskSpread: 0,
      activeTraders: 0,
      lastTradeTime: new Date()
    }

    const score = calculateLiquidityScore(market)

    expect(score).toBe(0)
  })
})
```

## 第 3 步：运行测试 - 验证失败

```bash
npm test lib/liquidity.test.ts

FAIL lib/liquidity.test.ts
  ✕ 应当为高流动性市场返回高分 (2 ms)
    Error: Not implemented

1 test failed, 0 passed
```

✅ 测试如预期般失败。准备开始实现。

## 第 4 步：编写最简实现 (绿 - GREEN)

```typescript
// lib/liquidity.ts
export function calculateLiquidityScore(market: MarketData): number {
  // 处理零成交量的边缘情况
  if (market.totalVolume === 0) {
    return 0
  }

  // 计算各维度评分 (0-100 刻度)
  const volumeScore = Math.min(market.totalVolume / 1000, 100)
  const spreadScore = Math.max(100 - (market.bidAskSpread * 1000), 0)
  const traderScore = Math.min(market.activeTraders / 10, 100)

  // 最近活动加分
  const hoursSinceLastTrade = (Date.now() - market.lastTradeTime.getTime()) / (1000 * 60 * 60)
  const recencyScore = Math.max(100 - (hoursSinceLastTrade * 10), 0)

  // 加权平均
  const score = (
    volumeScore * 0.4 +
    spreadScore * 0.3 +
    traderScore * 0.2 +
    recencyScore * 0.1
  )

  return Math.min(Math.max(score, 0), 100) // 限制在 0-100 之间
}
```

## 第 5 步：运行测试 - 验证通过

```bash
npm test lib/liquidity.test.ts

PASS lib/liquidity.test.ts
  ✓ 应当为高流动性市场返回高分 (3 ms)
  ✓ 应当为低流动性市场返回低分 (2 ms)
  ✓ 应当处理边缘情况：零成交量 (1 ms)

3 tests passed
```

✅ 所有测试已通过！

## 第 6 步：重构 (提升 - REFACTOR)

```typescript
// lib/liquidity.ts - 使用常量重构，提高可读性
const WEIGHTS = {
  VOLUME: 0.4,
  SPREAD: 0.3,
  TRADERS: 0.2,
  RECENCY: 0.1,
} as const

const SCALE_FACTORS = {
  VOLUME: 1000,
  SPREAD: 1000,
  TRADERS: 10,
  RECENCY_PENALTY: 10,
} as const

function clamp(value: number, min: number, max: number): number {
  return Math.min(Math.max(value, min), max)
}

export function calculateLiquidityScore(market: MarketData): number {
  if (market.totalVolume === 0) return 0

  const volumeScore = Math.min(market.totalVolume / SCALE_FACTORS.VOLUME, 100)
  const spreadScore = clamp(100 - (market.bidAskSpread * SCALE_FACTORS.SPREAD), 0, 100)
  const traderScore = Math.min(market.activeTraders / SCALE_FACTORS.TRADERS, 100)

  const hoursSinceLastTrade = (Date.now() - market.lastTradeTime.getTime()) / (1000 * 60 * 60)
  const recencyScore = clamp(100 - (hoursSinceLastTrade * SCALE_FACTORS.RECENCY_PENALTY), 0, 100)

  const weightedScore =
    volumeScore * WEIGHTS.VOLUME +
    spreadScore * WEIGHTS.SPREAD +
    traderScore * WEIGHTS.TRADERS +
    recencyScore * WEIGHTS.RECENCY

  return clamp(weightedScore, 0, 100)
}
```

## 第 7 步：验证测试依然通过

```bash
npm test lib/liquidity.test.ts

PASS lib/liquidity.test.ts
  ✓ 应当为高流动性市场返回高分 (3 ms)
  ✓ 应当为低流动性市场返回低分 (2 ms)
  ✓ 应当处理边缘情况：零成交量 (1 ms)

3 tests passed
```

✅ 重构完成，测试依然通过！

## 第 8 步：检查覆盖率

```bash
npm test -- --coverage lib/liquidity.test.ts

File           | % Stmts | % Branch | % Funcs | % Lines
---------------|---------|----------|---------|--------
liquidity.ts   |   100   |   100    |   100   |   100

覆盖率: 100% ✅ (目标: 80%)
```

✅ TDD 会话完成！
```

## TDD 最佳实践

**建议 (DO)：**
- ✅ 在进行任何实现之前，先编写测试
- ✅ 运行测试并验证它们在实现之前失败
- ✅ 仅编写足以通过测试的最简代码
- ✅ 仅在测试变绿后进行重构
- ✅ 添加边缘情况和错误场景
- ✅ 以 80% 以上的覆盖率为目标 (关键代码要求 100%)

**禁止 (DON'T)：**
- ❌ 在测试之前编写实现
- ❌ 每次更改后跳过运行测试
- ❌ 一次性编写过多代码
- ❌ 忽视失败的测试
- ❌ 测试实现细节 (应测试行为)
- ❌ 模拟 (Mock) 所有内容 (优先使用集成测试)

## 应包含的测试类型

**单元测试 (Unit Tests)** (函数级):
- Happy path 场景
- 边缘情况 (空值、null、最大值)
- 错误条件
- 边界值

**集成测试 (Integration Tests)** (组件级):
- API 终端
- 数据库操作
- 外部服务调用
- 带有 Hook 的 React 组件

**E2E 测试** (使用 `/e2e` 指令):
- 关键用户流程
- 多步骤过程
- 全栈集成

## 覆盖率要求

- **所有代码最低 80%**
- **以下内容要求 100%：**
  - 财务计算
  - 身份验证逻辑
  - 关乎安全的代码
  - 核心业务逻辑

## 重要注意事项

**强制性**：测试必须在实现之前编写。TDD 循环是：

1. **红 (RED)** - 编写失败的测试
2. **绿 (GREEN)** - 实现代码以通过测试
3. **重构 (REFACTOR)** - 改进代码

切勿跳过“红”阶段。切勿在测试之前编写代码。

## 与其他指令的集成

- 首先使用 `/plan` 了解要构建的内容
- 使用 `/tdd` 并结合测试进行实现
- 如果发生构建错误，使用 `/build-and-fix`
- 使用 `/code-review` 审查实现情况
- 使用 `/test-coverage` 验证覆盖率

## 相关智能体

此指令调用位于以下位置的 `tdd-guide` 智能体：
`~/.claude/agents/tdd-guide.md`

并且可以参考位于以下位置的 `tdd-workflow` 技能：
`~/.claude/skills/tdd-workflow/`

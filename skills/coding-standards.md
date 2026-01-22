---
name: coding-standards
description: 通用的编码标准、最佳实践以及针对 TypeScript、JavaScript、React 和 Node.js 开发的模式。
---

# 编码标准与最佳实践

适用于所有项目的通用编码标准。

## 代码质量原则

### 1. 可读性优先
- 代码被阅读的次数远多于编写的次数
- 变量和函数命名应清晰明确
- 优先选择自解释代码，而非注释
- 保持一致的格式

### 2. KISS (Keep It Simple, Stupid) 简单原则
- 采用能奏效的最简单解决方案
- 避免过度工程化 (Over-engineering)
- 拒绝过早优化
- 易于理解胜过巧妙代码

### 3. DRY (Don't Repeat Yourself) 拒绝重复
- 将通用逻辑提取到函数中
- 创建可复用的组件
- 在各模块间共享工具函数
- 避免“复制粘贴式”编程

### 4. YAGNI (You Aren't Gonna Need It) 拒绝冗余
- 不要在需要功能之前就构建它
- 避免臆测性的通用化设计
- 仅在必要时增加复杂度
- 从简单开始，在需要时再进行重构

## TypeScript/JavaScript 标准

### 变量命名

```typescript
// ✅ 推荐：描述性命名
const marketSearchQuery = 'election'
const isUserAuthenticated = true
const totalRevenue = 1000

// ❌ 不推荐：命名模糊
const q = 'election'
const flag = true
const x = 1000
```

### 函数命名

```typescript
// ✅ 推荐：动词-名词模式
async function fetchMarketData(marketId: string) { }
function calculateSimilarity(a: number[], b: number[]) { }
function isValidEmail(email: string): boolean { }

// ❌ 不推荐：模糊或仅有名词
async function market(id: string) { }
function similarity(a, b) { }
function email(e) { }
```

### 不可变模式 (极重要)

```typescript
// ✅ 始终使用展开运算符 (Spread operator)
const updatedUser = {
  ...user,
  name: 'New Name'
}

const updatedArray = [...items, newItem]

// ❌ 绝不直接修改 (Mutate)
user.name = 'New Name'  // 错误
items.push(newItem)     // 错误
```

### 错误处理

```typescript
// ✅ 推荐：全面的错误处理
async function fetchData(url: string) {
  try {
    const response = await fetch(url)

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`)
    }

    return await response.json()
  } catch (error) {
    console.error('Fetch failed:', error)
    throw new Error('Failed to fetch data')
  }
}

// ❌ 不推荐：无错误处理
async function fetchData(url) {
  const response = await fetch(url)
  return response.json()
}
```

### Async/Await 最佳实践

```typescript
// ✅ 推荐：尽可能并行执行
const [users, markets, stats] = await Promise.all([
  fetchUsers(),
  fetchMarkets(),
  fetchStats()
])

// ❌ 不推荐：无必要的顺序执行
const users = await fetchUsers()
const markets = await fetchMarkets()
const stats = await fetchStats()
```

### 类型安全

```typescript
// ✅ 推荐：妥善使用类型
interface Market {
  id: string
  name: string
  status: 'active' | 'resolved' | 'closed'
  created_at: Date
}

function getMarket(id: string): Promise<Market> {
  // 实现逻辑
}

// ❌ 不推荐：使用 'any'
function getMarket(id: any): Promise<any> {
  // 实现逻辑
}
```

## React 最佳实践

### 组件结构

```typescript
// ✅ 推荐：带有类型的函数式组件
interface ButtonProps {
  children: React.ReactNode
  onClick: () => void
  disabled?: boolean
  variant?: 'primary' | 'secondary'
}

export function Button({
  children,
  onClick,
  disabled = false,
  variant = 'primary'
}: ButtonProps) {
  return (
    <button
      onClick={onClick}
      disabled={disabled}
      className={`btn btn-${variant}`}
    >
      {children}
    </button>
  )
}

// ❌ 不推荐：无类型，结构不清晰
export function Button(props) {
  return <button onClick={props.onClick}>{props.children}</button>
}
```

### 自定义 Hooks

```typescript
// ✅ 推荐：可复用的自定义 hook
export function useDebounce<T>(value: T, delay: number): T {
  const [debouncedValue, setDebouncedValue] = useState<T>(value)

  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedValue(value)
    }, delay)

    return () => clearTimeout(handler)
  }, [value, delay])

  return debouncedValue
}

// 使用示例
const debouncedQuery = useDebounce(searchQuery, 500)
```

### 状态管理

```typescript
// ✅ 推荐：妥善的状态更新
const [count, setCount] = useState(0)

// 基于前一状态进行函数式更新
setCount(prev => prev + 1)

// ❌ 不推荐：直接引用状态
setCount(count + 1)  // 在异步场景下可能会使用过时的状态
```

### 条件渲染

```typescript
// ✅ 推荐：清晰的条件渲染
{isLoading && <Spinner />}
{error && <ErrorMessage error={error} />}
{data && <DataDisplay data={data} />}

// ❌ 不推荐：三元表达式嵌套 (三元地狱)
{isLoading ? <Spinner /> : error ? <ErrorMessage error={error} /> : data ? <DataDisplay data={data} /> : null}
```

## API 设计标准

### REST API 约定

```
GET    /api/markets              # 列出所有市场
GET    /api/markets/:id          # 获取特定市场
POST   /api/markets              # 创建新市场
PUT    /api/markets/:id          # 更新市场 (完全更新)
PATCH  /api/markets/:id          # 更新市场 (部分更新)
DELETE /api/markets/:id          # 删除市场

# 用于过滤的查询参数
GET /api/markets?status=active&limit=10&offset=0
```

### 响应格式

```typescript
// ✅ 推荐：一致的响应结构
interface ApiResponse<T> {
  success: boolean
  data?: T
  error?: string
  meta?: {
    total: number
    page: number
    limit: number
  }
}

// 成功响应
return NextResponse.json({
  success: true,
  data: markets,
  meta: { total: 100, page: 1, limit: 10 }
})

// 错误响应
return NextResponse.json({
  success: false,
  error: 'Invalid request'
}, { status: 400 })
```

### 输入校验

```typescript
import { z } from 'zod'

// ✅ 推荐：Schema 校验
const CreateMarketSchema = z.object({
  name: z.string().min(1).max(200),
  description: z.string().min(1).max(2000),
  endDate: z.string().datetime(),
  categories: z.array(z.string()).min(1)
})

export async function POST(request: Request) {
  const body = await request.json()

  try {
    const validated = CreateMarketSchema.parse(body)
    // 使用校验通过的数据继续处理
  } catch (error) {
    if (error instanceof z.ZodError) {
      return NextResponse.json({
        success: false,
        error: 'Validation failed',
        details: error.errors
      }, { status: 400 })
    }
  }
}
```

## 文件组织

### 项目结构

```
src/
├── app/                    # Next.js App 路由
│   ├── api/               # API 路由
│   ├── markets/           # 市场页面
│   └── (auth)/           # 身份验证页面 (路由分组)
├── components/            # React 组件
│   ├── ui/               # 通用 UI 组件
│   ├── forms/            # 表单组件
│   └── layouts/          # 布局组件
├── hooks/                # 自定义 React hooks
├── lib/                  # 工具类与配置
│   ├── api/             # API 客户端
│   ├── utils/           # 辅助函数
│   └── constants/       # 常量
├── types/                # TypeScript 类型定义
└── styles/              # 全局样式
```

### 文件命名

```
components/Button.tsx          # 组件使用 PascalCase
hooks/useAuth.ts              # 以 'use' 为前缀的 camelCase
lib/formatDate.ts             # 工具类使用 camelCase
types/market.types.ts         # 以 .types 为后缀的 camelCase
```

## 注释与文档

### 何时编写注释

```typescript
// ✅ 推荐：解释“为什么” (WHY)，而非“是什么” (WHAT)
// 使用指数退避以在停机期间避免 API 负载过重
const delay = Math.min(1000 * Math.pow(2, retryCount), 30000)

// 出于处理大数组的性能考量，此处刻意采用直接修改行为
items.push(newItem)

// ❌ 不推荐：描述显而易见的操作
// 将计数器加 1
count++

// 将名称设置为用户的名称
name = user.name
```

### 公共 API 的 JSDoc

```typescript
/**
 * 使用语义相似度搜索市场。
 *
 * @param query - 自然语言搜索查询
 * @param limit - 最大结果数量 (默认: 10)
 * @returns 按相似度分值排序的市场数组
 * @throws {Error} 若 OpenAI API 失败或 Redis 不可用
 *
 * @example
 * ```typescript
 * const results = await searchMarkets('election', 5)
 * console.log(results[0].name) // "Trump vs Biden"
 * ```
 */
export async function searchMarkets(
  query: string,
  limit: number = 10
): Promise<Market[]> {
  // 实现逻辑
}
```

## 性能最佳实践

### 记忆化 (Memoization)

```typescript
import { useMemo, useCallback } from 'react'

// ✅ 推荐：记忆化开销较大的计算
const sortedMarkets = useMemo(() => {
  return markets.sort((a, b) => b.volume - a.volume)
}, [markets])

// ✅ 推荐：记忆化回调函数
const handleSearch = useCallback((query: string) => {
  setSearchQuery(query)
}, [])
```

### 懒加载 (Lazy Loading)

```typescript
import { lazy, Suspense } from 'react'

// ✅ 推荐：懒加载重量级组件
const HeavyChart = lazy(() => import('./HeavyChart'))

export function Dashboard() {
  return (
    <Suspense fallback={<Spinner />}>
      <HeavyChart />
    </Suspense>
  )
}
```

### 数据库查询

```typescript
// ✅ 推荐：仅选择必要的列
const { data } = await supabase
  .from('markets')
  .select('id, name, status')
  .limit(10)

// ❌ 不推荐：选择所有列
const { data } = await supabase
  .from('markets')
  .select('*')
```

## 测试标准

### 测试结构 (AAA 模式)

```typescript
test('calculates similarity correctly', () => {
  // 准备 (Arrange)
  const vector1 = [1, 0, 0]
  const vector2 = [0, 1, 0]

  // 执行 (Act)
  const similarity = calculateCosineSimilarity(vector1, vector2)

  // 断言 (Assert)
  expect(similarity).toBe(0)
})
```

### 测试命名

```typescript
// ✅ 推荐：描述性的测试名称
test('returns empty array when no markets match query', () => { })
test('throws error when OpenAI API key is missing', () => { })
test('falls back to substring search when Redis unavailable', () => { })

// ❌ 不推荐：模糊的测试名称
test('works', () => { })
test('test search', () => { })
```

## 代码异味检测 (Code Smell Detection)

留意以下反模式：

### 1. 过长函数
```typescript
// ❌ 不推荐：函数超过 50 行
function processMarketData() {
  // 100 行代码
}

// ✅ 推荐：拆分为更小的函数
function processMarketData() {
  const validated = validateData()
  const transformed = transformData(validated)
  return saveData(transformed)
}
```

### 2. 深层嵌套
```typescript
// ❌ 不推荐：5 层及以上嵌套
if (user) {
  if (user.isAdmin) {
    if (market) {
      if (market.isActive) {
        if (hasPermission) {
          // 执行操作
        }
      }
    }
  }
}

// ✅ 推荐：提前返回 (Early returns)
if (!user) return
if (!user.isAdmin) return
if (!market) return
if (!market.isActive) return
if (!hasPermission) return

// 执行操作
```

### 3. 魔术数字 (Magic Numbers)
```typescript
// ❌ 不推荐：无解释的数字
if (retryCount > 3) { }
setTimeout(callback, 500)

// ✅ 推荐：命名常量
const MAX_RETRIES = 3
const DEBOUNCE_DELAY_MS = 500

if (retryCount > MAX_RETRIES) { }
setTimeout(callback, DEBOUNCE_DELAY_MS)
```

**提示**: 代码质量是不容妥协的。清晰、可维护的代码是快速开发和自信重构的基石。

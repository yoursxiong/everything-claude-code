# 编码风格 (Coding Style)

## 不可变性 (极重要)

**始终**创建新对象，**切勿**直接修改 (Mutate)：

```javascript
// 错误：直接修改
function updateUser(user, name) {
  user.name = name  // 直接修改了对象！
  return user
}

// 正确：不可变模式
function updateUser(user, name) {
  return {
    ...user,
    name
  }
}
```

## 文件组织

**多小文件 > 少大文件：**
- 高内聚，低耦合
- 典型长度为 200-400 行，最大 800 行
- 从大型组件中提取工具函数
- 按功能/领域组织，而不是按类型组织

## 错误处理

**始终**进行全面的错误处理：

```typescript
try {
  const result = await riskyOperation()
  return result
} catch (error) {
  console.error('Operation failed:', error)
  throw new Error('详细的用户友好错误提示')
}
```

## 输入校验

**始终**校验用户输入：

```typescript
import { z } from 'zod'

const schema = z.object({
  email: z.string().email(),
  age: z.number().int().min(0).max(150)
})

const validated = schema.parse(input)
```

## 代码质量核对清单

在标记工作完成前：
- [ ] 代码可读且命名规范
- [ ] 函数体积小 (< 50 行)
- [ ] 文件专注 (< 800 行)
- [ ] 无深层嵌套 (> 4 层)
- [ ] 有妥善的错误处理
- [ ] 无 `console.log` 语句
- [ ] 无硬编码值
- [ ] 无直接修改行为 (使用了不可变模式)

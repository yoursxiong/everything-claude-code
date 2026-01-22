---
name: security-review
description: 用于进行代码安全审查、识别漏洞（注入、XSS、身份验证问题）以及实施纵深防御安全实践的系统性工作流。
---

# 安全审查工作流

用于识别、评估和修复现代网络应用中安全隐患的系统性指南。

## 审查检查清单

### 1. 注入风险
- [ ] **SQL 注入**：是否使用了参数化查询或 ORM？是否存在直接拼接 SQL 字符串的行为？
- [ ] **命令注入**：是否将用户输入直接传递给了系统命令 (如 `exec` 或 `spawn`)？
- [ ] **NoSQL 注入**：在 MongoDB/Cloudant 查询中，是否对输入进行了妥善转义？

### 2. 身份验证与会话管理
- [ ] **令牌校验**：是否在服务器端对所有 JWT 或会话令牌进行了过期和签名检查？
- [ ] **密码策略**：是否强制要求了强密码？是否对密码进行了盐值哈希 (如使用 bcrypt)？
- [ ] **多因素认证 (MFA)**：敏感操作是否强制要求 MFA？
- [ ] **会话固定 (Session Fixation)**：登录后是否重新生成了会话 ID？

### 3. 跨站脚本 (XSS)
- [ ] **输出编码**：数据在插入 DOM 时是否经过了妥善编码 (如使用 `textContent`)？
- [ ] **React `dangerouslySetInnerHTML`**：是否对此处的数据进行了净化 (Sanitization)？
- [ ] **内容安全策略 (CSP)**：是否设置了恰当的 CSP 响应头以限制脚本来源？

### 4. 数据保护
- [ ] **静态加密**：敏感数据（API 密钥、个人身份信息 PII）是否在数据库中加密存储？
- [ ] **传输加密**：是否所有通信都强制使用 HTTPS/TLS？
- [ ] **秘密信息管理**：API 密钥是否安全存储 (如使用 .env, Secret Manager)，而未硬编码？

### 5. 访问控制
- [ ] **横向权限 (IDOR)**：用户是否能通过更改 ID 访问他人的资源？
- [ ] **纵向权限**：普通用户是否能访问管理（Admin） API？
- [ ] **最小特权原则**：应用程序角色是否仅拥有执行其功能所需的最小权限？

## 工具集

- **静态分析 (SAST)**：Snyk, ESLint Security Plugin, SonarQube
- **动态分析 (DAST)**：OWASP ZAP, Burp Suite
- **依赖审计**：`npm audit`, GitHub Dependabot, Snyk

## 审查流程

### 第一步：威胁建模
- 识别项目中的**受托资产** (密码、PII、商业秘密)。
- 识别**攻击向量** (公开 API、文件上传、内部仪表盘)。
- 定义**信任边界** (外部互联网 vs 内部网络)。

### 第二步：静态代码扫描
运行安全补丁检查和 lint 规则：
```bash
# 检查依赖漏洞
npm audit

# 运行带有安全规则的 ESLint
npx eslint . --ext .ts,.tsx --rulesdir security-rules
```

### 第三步：手动审计关键路径
手动检查以下代码区域：
- 身份验证逻辑 (`/api/auth/*`)。
- 文件上传处理程序。
- 管理后台操作。
- 涉及敏感财务或个人数据的 SQL 查询或 API 调用。

### 第四步：渗透测试
模拟常见攻击：
- 尝试修改 URL 里的 `userId`。
- 尝试在搜索输入框中注入 `<script>`。
- 尝试发送畸形负载（如极大、极小、或类型错误的负载）。

## 修复指南

### SQL 注入修复
```typescript
// ❌ 错误：直接拼接字符串 (易受攻击)
const results = await db.query(`SELECT * FROM users WHERE id = '${userId}'`)

// ✅ 正确：使用参数化查询 (安全)
const results = await db.query('SELECT * FROM users WHERE id = $1', [userId])
```

### XSS 修复
```typescript
// ❌ 错误：在 React 中直接渲染 HTML (易受攻击)
<div dangerouslySetInnerHTML={{ __html: userInput }} />

// ✅ 正确：使用净化库 (安全)
import DOMPurify from 'dompurify'
const cleanHTML = DOMPurify.sanitize(userInput)
<div dangerouslySetInnerHTML={{ __html: cleanHTML }} />
```

### 秘密信息修复
```typescript
// ❌ 错误：硬编码 API 密钥 (易受攻击)
const OPENAI_KEY = 'sk-...'

// ✅ 正确：使用环境变量 (安全)
const OPENAI_KEY = process.env.OPENAI_API_KEY
```

**提示**：安全是一个持续的过程。请在每个重大的拉取请求 (Pull Request) 以及发布前，将此工作流整合进您的 CI/CD 流水中。

# 安全指南

## 强制性安全检查

在进行任何提交之前：
- [ ] 无硬编码的机密信息 (API 密钥、密码、令牌)
- [ ] 所有用户输入均已校验
- [ ] 预防 SQL 注入 (使用参数化查询)
- [ ] 预防 XSS (对 HTML 进行清理/转义)
- [ ] 已启用 CSRF 防护
- [ ] 已验证身份验证 (Authn)/授权 (Authz)
- [ ] 所有终端均有频率限制 (Rate limiting)
- [ ] 错误信息不得泄露敏感数据

## 机密管理 (Secret Management)

```typescript
// 绝不允许：硬编码机密信息
const apiKey = "sk-proj-xxxxx"

// 始终：使用环境变量
const apiKey = process.env.OPENAI_API_KEY

if (!apiKey) {
  throw new Error('未配置 OPENAI_API_KEY')
}
```

## 安全响应协议

如果发现安全问题：
1. 立即停止当前工作
2. 使用 **security-reviewer** 智能体
3. 继续前先修复严重 (CRITICAL) 问题
4. 轮换任何泄露的机密信息
5. 审查整个代码库是否存在类似问题

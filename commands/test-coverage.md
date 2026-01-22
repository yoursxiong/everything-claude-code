# 测试覆盖率 (Test Coverage)

分析测试覆盖率并生成缺失的测试：

1. 带有覆盖率运行测试：`npm test --coverage` 或 `pnpm test --coverage`

2. 分析覆盖率报告 (`coverage/coverage-summary.json`)

3. 识别低于 80% 覆盖率阈值的文件

4. 针对每个覆盖不足的文件：
   - 分析未测试的代码路径
   - 为函数生成单元测试
   - 为 API 生成集成测试
   - 为关键流程生成 E2E 测试

5. 验证新测试是否通过

6. 显示覆盖率指标的前后对比

7. 确保项目整体覆盖率达到 80% 以上

关注点：
- Happy path 场景
- 错误处理
- 边缘情况 (null, undefined, 空值)
- 边界条件

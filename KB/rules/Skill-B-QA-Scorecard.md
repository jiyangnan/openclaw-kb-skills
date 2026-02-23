# Skill B：QA Scorecard（质量评审）

目标：用同一把尺子评审产出，决定：入库 / 丢弃 / 进队列 / 需要补充。

## 评分维度（0-5）
1. 信息密度：是否有实质信息（不是正确废话）
2. 可验证性：是否有来源/证据
3. 可复用性：是否能迁移到其他场景
4. 结构清晰：是否有明确结论 + 逻辑
5. 人味儿：表达是否像人（有具体细节/态度/不端着）

## 输出格式
```yaml
score:
  density: 0
  verifiability: 0
  reusability: 0
  clarity: 0
  human_touch: 0
  total: 0
verdict: keep|discard|queue|needs_context
issues:
  - ""
questions_for_boss:
  - ""   # 需要你拍板/补充的问题
next_actions:
  - ""   # 具体下一步
```

## 判定建议（默认）
- total >= 18：keep（入 notes）
- 12-17：queue（进 queue，等待补充/改写）
- < 12：discard（丢弃，但可记录“丢弃原因”）
- 缺关键上下文：needs_context

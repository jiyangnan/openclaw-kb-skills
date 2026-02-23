---
name: kb-normalize
description: Normalize any fetched content into the KB canonical YAML fields (source, one-line summary, claim, why-it-matters, evidence, actions, risks, tags). Use when structuring links/articles/tweets into KB notes, when the user says “结构化/Normalize/把这篇转成卡片/按字段整理”, or as a sub-step inside kb-inbox-digest and kb-queue-to-keep.
---

# KB Normalize（结构化字段）

统一输出格式，给下游 QA/Router 使用。

## 输入
- `source.url`
- `source.type`（tweet/article/chat/doc/web）
- `source.author`（可空）
- `source.published_at`（可空）
- `text`（抓取到的正文）
- `user_note`（可选：用户发链接时的备注/意图）

## 输出（YAML，必须包含这些字段）
```yaml
source:
  url: ""
  type: tweet|article|chat|doc|web
  author: ""
  published_at: ""
summary_one_line: ""
claim: ""
why_it_matters: ""
evidence:
  - quote: ""
    url: ""
    note: ""
actions:
  - ""
risks_unknowns:
  - ""
reuse_tags:
  - ""
```

## 规则
- evidence 至少 1 条；引用尽量来自原文原句。
- actions 用动词开头，且可执行。
- 如果 user_note 存在：写入 why_it_matters 或 reuse_tags 的上下文中（标注“用户意图”）。

## 依赖
- 本 skill 不负责抓取正文：抓取统一走 `kb-fetch`。

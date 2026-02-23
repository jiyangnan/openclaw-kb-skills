---
name: kb-router
description: Route KB items to Obsidian Vault notes/queue based on QA verdict, write files using canonical templates, update processed-links.md and digest.json state, and enforce the rule that only keep goes to notes. Use when the user says “入库/路由/写入notes/写入queue/更新processed/更新状态”.
---

# KB Router（落盘/状态更新）

把 Normalize+QA 的结果写入 Obsidian Vault，并更新防重复状态。

## 输入
- `normalize`（kb-normalize 输出 YAML）
- `qa`（kb-qa-score 输出 YAML）
- `title`（可由抓取/正文推断；需要用于文件命名）
- `text`（可选：写入 notes 的正文摘录/关键段落）

## 固定路径
- Notes：`/Users/ferdinandji/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian Vault/KB/notes/`
- Queue：`/Users/ferdinandji/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian Vault/KB/queue/`
- Processed list：`/Users/ferdinandji/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian Vault/KB/inputs/processed-links.md`
- State：`/Users/ferdinandji/.openclaw/workspace/KB/state/digest.json`

## 路由规则（硬规则）
- verdict=keep → 写入 notes
- verdict=queue/needs_context → 写入 queue
- verdict=discard → 不入库（只在摘要里说明原因即可）

## 文件命名
- notes：`YYYY-MM-DD-<简短主题>-note.md`
- queue：`YYYY-MM-DD-<简短主题>-queue.md`

## 写入内容要求
- notes 必须包含：来源 URL、summary_one_line、claim、why_it_matters、evidence、actions。
- queue 必须包含：卡点（issues）+ 需要 boss 做什么（questions_for_boss）。

## 状态更新
- processed-links.md：追加一行（日期|标题|verdict|url）
- digest.json：追加 processed 记录（url, processed_at, verdict, title, reason 可选）

## 依赖
- 抓取统一走 `kb-fetch`；结构化与打分分别走 `kb-normalize` 与 `kb-qa-score`。

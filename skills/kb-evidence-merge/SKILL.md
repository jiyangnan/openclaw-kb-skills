---
name: kb-evidence-merge
description: Merge human-run verification results (text notes, screenshots/images, measurements) back into an existing KB note and/or queue item, updating Evidence/Verification sections and revising the recommendation. Use when the user says “我实测了/这是对比结果/我把截图发你/把证据写回KB/把 watch 升级成 recommend/reject”.
---

# KB Evidence Merge（把实测证据写回 KB）

场景：工具对比/方法验证时，**白羊武士本地真实操作**后，把结果（文字+截图）发回来；你负责把证据结构化写回 notes，完成 Phase 2 闭环。

## 输入
- 目标 notes 路径（或标题/日期）
- 用户回传的证据：
  - 文字结论（必选）
  - 截图/图片（可选，可能多张）
  - 指标（可选，例如耗时、成功率、token 费用）

## 输出
- 更新目标 notes：补全/追加
  - `## 验证/实测（Verification）`
  - `## 关键证据（Evidence）`
  - `## 对比结论（Comparison）`（如需）
- 如原先是 queue：可升级为 keep（写入 notes 并把 queue 标 done + related_notes）
- 更新 frontmatter：
  - `recommendation: watch|recommend|reject`
  - 可追加 `tested_at`、`tested_by`、`evidence_assets`（可选）

## 规则（必须遵守）
1) **证据优先**：只写用户给的结果 + 可核对的事实，不脑补。
2) **图片处理**：
   - 图片/截图先落到 workspace 中转目录（例如 `~/.openclaw/media/inbound/` 或 workspace 自建目录），再在 notes 里记录相对路径或文件名。
   - 不强求嵌入；以“可追溯”为第一目标。
3) **只改必要段落**：尽量追加，不要大段重写用户原结论。

## 推荐的写回格式
在 notes 里追加：

- Verification：
  - 测试环境（OS/版本/网络/账号状态）
  - 测试任务（3 条以内）
  - 结果（结论 + 关键差异）
  - 问题/坑

- Evidence：
  - 证据条目：`[时间] - [结论点] - [截图文件名/路径]`

## 最小交互
如果用户只发了截图没写结论：只问一句：
- “这张图你想证明的结论是什么？（一句话）”

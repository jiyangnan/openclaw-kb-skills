# Skill C：Router（任务路由）

目标：根据 Normalize + QA 输出，把内容路由到正确位置。

## 路由规则（V0）
- verdict=keep → 写入 `KB/notes/`（按日期+主题命名）
- verdict=queue → 写入 `KB/queue/`（并标注需要补充什么）
- verdict=discard → 可选写入 `KB/reviews/discard-log.md`
- verdict=needs_context → 写入 `KB/queue/needs-context.md` 并列出问题

## 文件命名建议
- notes：`YYYY-MM-DD-<主题>-note.md`
- queue：`YYYY-MM-DD-<主题>-queue.md`

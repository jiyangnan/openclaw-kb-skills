# OpenClaw KB Skills (Link → Insight → Deposit)

This repo contains a modular Skill DAG to turn a URL into a reusable Obsidian KB note:

`kb-fetch` → `kb-normalize` → `kb-qa-score` → `kb-router`

And orchestration skills:
- `kb-inbox-digest`
- `kb-queue-to-keep`
- `kb-evidence-merge`
- `kb-orchestrator`

## What’s included
- `skills/` — the OpenClaw skills
- `KB/rules/` — scoring + routing rules (execution copy)
- `KB/templates/` — note/queue templates

## What’s intentionally NOT included
- Any secrets / tokens
- Any personal Obsidian vault content
- Any run history (`digest.json`)

## Install (manual)
Copy the skills into your OpenClaw workspace:
- `skills/*` → `~/.openclaw/workspace/skills/`
- `KB/*` → `~/.openclaw/workspace/KB/`

Then restart OpenClaw or reload skills.

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

## Install

### 1) Copy into your OpenClaw workspace

Copy the skills into your OpenClaw workspace:
- `skills/*` → `~/.openclaw/workspace/skills/`
- `KB/*` → `~/.openclaw/workspace/KB/`

Then restart OpenClaw or reload skills.

### 2) Bootstrap your Obsidian Vault (create folders inside the Vault)

You only need to provide your **Obsidian Vault root path**. The bootstrap script will create the following paths **inside your Vault**:

- `KB/inputs/`
- `KB/notes/`
- `KB/queue/`
- `KB/rules/`
- `KB/reviews/`

It will also copy reference files:
- Rules → `KB/rules/`
- Templates → `KB/_templates_openclaw/` (kept separate to avoid clobbering your existing templates)

**macOS/Linux:**
```bash
chmod +x ./scripts/bootstrap.sh
./scripts/bootstrap.sh --vault "/path/to/Your Obsidian Vault"
```

**Windows (PowerShell):**
```powershell
./scripts/bootstrap.ps1 -Vault "C:\path\to\Your Obsidian Vault"
```

Tip: If you are not sure where your Vault is, open Obsidian → Settings → "About" or check your vault list; copy the filesystem path shown there.

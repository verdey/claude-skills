# claude-skills

Personal [Claude Code](https://docs.anthropic.com/en/docs/claude-code) skills that live in `~/.claude/skills/`. These are custom slash commands and auto-triggered prompts that extend what Claude Code can do in your terminal and IDE.

## What are skills?

Skills are markdown files (`SKILL.md`) that inject custom behavior into Claude Code. They can be:

- **Slash commands** — type `/skill-name` in any Claude Code session to invoke
- **Auto-triggered** — Claude detects when to use them based on context
- **Scoped** — personal (this repo), per-project, or via plugins

Each skill is a folder containing a `SKILL.md` with YAML frontmatter and a prompt body. Changes take effect immediately — no restart needed.

## Skills in this repo

| Skill | Trigger | What it does |
|-------|---------|--------------|
| **boot-prompt** | `/boot-prompt` | Generates structured markdown briefings for handing off context to another AI or environment. Breaks topics into weighted categories using a "human attention credits" budget. |
| **example** | `/example` | Reference template showing every SKILL.md feature: arguments, shell injection, supporting files, scope rules, context budget, and extended thinking. Start here when creating a new skill. |
| **pm-orchestrator** | `/pm-orchestrator` | Acts as a PM that plans and scopes work into session briefs — markdown docs a human hands to fresh Claude Code tabs. Never writes code itself. Consumes After Action Reports between sessions. |
| **sitrep-docs** | `/sitrep-docs` | Audits all non-README markdown in a project. Identifies which docs are done (deletable) vs. have remaining work. Recommends cleanup and prioritization. |

## Setup

Clone into your Claude Code skills directory:

```bash
git clone https://github.com/verdey/claude-skills.git ~/.claude/skills
```

If `~/.claude/skills` already exists, back it up first or merge manually.

That's it. Open Claude Code and your skills are live.

## Creating a new skill

```bash
mkdir -p ~/.claude/skills/my-skill
```

Then create `~/.claude/skills/my-skill/SKILL.md`:

```yaml
---
name: my-skill
description: Short description of what it does and when to trigger it
---

Your prompt goes here. Use $ARGUMENTS for user input from `/my-skill arg1 arg2`.
```

See the [example](example/SKILL.md) skill for all available options (model overrides, tool restrictions, subagent mode, etc.).

## Key concepts

- **`$ARGUMENTS`** — captures everything after the slash command (`/my-skill these are args`)
- **Shell injection** — embed live output with `` !`git branch --show-current` `` syntax
- **Supporting files** — add extra `.md` files in the skill folder; Claude reads them lazily on demand
- **Frontmatter options** — `disable-model-invocation`, `allowed-tools`, `model`, `context: fork`, and more

## Notes

- Skills in `~/.claude/skills/` apply to **all** your projects (personal scope)
- For project-specific skills, put them in `<repo>/.claude/skills/` instead
- Descriptions are always loaded (~100 words each); full prompts load only when triggered
- Recommended max prompt size: <5k words

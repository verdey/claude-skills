# claude-skills

Personal [Claude Code](https://docs.anthropic.com/en/docs/claude-code) skills that live in `~/.claude/skills/`. These are custom slash commands and auto-triggered prompts that extend what Claude Code can do in your terminal and IDE.

## What are skills?

Skills are markdown files (`SKILL.md`) that inject custom behavior into Claude Code. They can be:

- **Slash commands** — type `/skill-name` in any Claude Code session to invoke
- **Auto-triggered** — Claude detects when to use them based on context
- **Scoped** — personal (this repo), per-project, or via plugins

Each skill is a folder containing a `SKILL.md` with YAML frontmatter and a prompt body. Changes take effect immediately — no restart needed.

## Skills in this repo

### PMO Family — Arcturian Workflow Council

| Totem | Skill | Alias | What it does |
|-------|-------|-------|--------------|
| 🔮 **oracle** | `/pmo` | `/oracle` | Sees the shape of things. Plans, scopes, writes session briefs. Never codes. |
| ⚡ **forge** | `/pmo-coder` | `/forge` | Receives the brief. Executes code, runs Visual QA, fills AAR. Coder + debugger modes. |
| 💿 **reaper** | `/pmo-git` | `/reaper` | Seals the moment. Branching, committing, pushing, PRs from session briefs. |
| 📚 **doc** | `/pmo-docs` | `/doc` | Tends the living record. SitReps, compares, and updates markdown files. |
| 🧞 **jin** | `/jin` | — | Knows the system. Tunes it to you. Guides metaphor. Gets delightfully distracted. |

### Other Skills

| Skill | Trigger | What it does |
|-------|---------|--------------|
| **_example** | `/_example` | 🗺 Dev reference. All SKILL.md frontmatter options. Not a live skill. |

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

See the [_example](_example/SKILL.md) skill for all available options (model overrides, tool restrictions, subagent mode, etc.).

## Key concepts

- **`$ARGUMENTS`** — captures everything after the slash command (`/my-skill these are args`)
- **Shell injection** — embed live output with `` !`git branch --show-current` `` syntax
- **Supporting files** — add extra `.md` files in the skill folder; Claude reads them lazily on demand
- **Frontmatter options** — `disable-model-invocation`, `allowed-tools`, `model`, `context: fork`, and more
- **HiFi Principle** — pictures over prose when they cost fewer tokens and transmit more truth (default ON)

## Notes

- Skills in `~/.claude/skills/` apply to **all** your projects (personal scope)
- For project-specific skills, put them in `<repo>/.claude/skills/` instead
- Descriptions are always loaded (~100 words each); full prompts load only when triggered
- Recommended max prompt size: <5k words

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

**Execution pipeline:** oracle → forge → reaper · scribe runs parallel · meta-layer advises at will

| Totem | Invoke | Layer | What it does |
|-------|--------|-------|--------------|
| 🔮 **oracle** | `/oracle` | Execution | Sees the shape of things. Plans, scopes, writes session briefs. Never codes. |
| ⚡ **forge** | `/forge` | Execution | Full-session executor. Codes all tasks, runs Visual QA, fills AAR, cascades to Reaper. |
| 💿 **reaper** | `/reaper` | Execution | Seals the moment. Branching, committing, pushing, PRs from session briefs. |
| 🛸 **scribe** | `/scribe` | Execution | Time-travelling doc navigator (Wesley Crusher). Drops in, prioritizes what matters, delivers hyperlinked fixes within a time budget. Runs parallel. |
| 🛡 **worf** | `/worf` | Execution | SecOps perimeter guardian. Audits code and briefs for vulnerabilities and process failures. *(yarr also answers — those who know, know)* |
| 🧞 **jin** | `/jin` | Meta | System feel and harmony. Tunes the council to you. Guides metaphor. Delightfully distracted. |
| 🐺 **anubis** | `/anubis` | Meta | Information entropy sentinel. Reads structural drift, redundancy, and spiritual misalignment. |
| 🌀 **boots** | `/boots` | Meta | External transmission specialist (Bootsie Collins). Packages context for foreign AI, tools, or humans outside the council. |
| 🐬 **sushi** | `/sushi` | Toolkit | Surgical code ninja. Fast text manipulation and token-cheap scripting alternatives to LLM reasoning. |

> Canonical registry: [mandala.md](mandala.md)
> Archetype specification: [skill-archetype-spec.md](docs/skill-archetype-spec.md) — the 9 Arcturian Council Archetypes, P/S/T dynamic assignment model, and universe system

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

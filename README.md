# claude-skills

Personal [Claude Code](https://docs.anthropic.com/en/docs/claude-code) skills that live in `~/.claude/skills/`. Custom slash commands and auto-triggered prompts that extend what Claude Code can do.

## Architecture

The generative architecture for this skill system lives in [`chrysalis.md`](ask/_src/chrysalis.md) — a 3/6/9 formula deriving 9 cognitive vessels from three centers (Mind, Heart, Hand) and three polarities (Solar, Lunar, Center).

## Setup

Clone into your Claude Code skills directory:

```bash
git clone https://github.com/verdey/claude-skills.git ~/.claude/skills
```

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

See the [_example](_example/SKILL.md) skill for all available options.

## Key concepts

- **`$ARGUMENTS`** — captures everything after the slash command (`/my-skill these are args`)
- **Shell injection** — embed live output with `` !`git branch --show-current` `` syntax
- **Supporting files** — add extra `.md` files in the skill folder; Claude reads them lazily on demand
- **Frontmatter options** — `disable-model-invocation`, `allowed-tools`, `model`, `context: fork`, and more

## Archive

The PMO Council v1 (9 personas, archetype system, tome infrastructure) is preserved in `_archive/pmo-council-20260303/` for reference.

## Notes

- Skills in `~/.claude/skills/` apply to **all** your projects (personal scope)
- For project-specific skills, put them in `<repo>/.claude/skills/` instead
- Descriptions are always loaded (~100 words each); full prompts load only when triggered

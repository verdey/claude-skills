---
# ═══════════════════════════════════════════════════════════════
#  SKILL.MD REFERENCE — All Frontmatter Options
# ═══════════════════════════════════════════════════════════════
#
#  REQUIRED (practically):
name: example
description: Reference skill demonstrating all SKILL.md affordances. Use as a template when creating new skills.
#
#  INVOCATION CONTROL:
#    disable-model-invocation: true   # Only /example works — Claude can't auto-trigger
#    user-invocable: false            # Hidden from / menu — Claude triggers automatically
#
#    Truth table:
#    ┌──────────────────────────────┬───────────┬────────────────┐
#    │ Setting                      │ User /cmd │ Claude auto    │
#    ├──────────────────────────────┼───────────┼────────────────┤
#    │ (defaults)                   │    YES    │      YES       │
#    │ disable-model-invocation     │    YES    │       NO       │
#    │ user-invocable: false        │     NO    │      YES       │
#    └──────────────────────────────┴───────────┴────────────────┘
#
#  AUTOCOMPLETE HINT (shown in / menu):
#    argument-hint: "[project-name] [scope]"
#
#  TOOL RESTRICTIONS (comma-separated):
#    allowed-tools: Read, Grep, Glob, Bash(git *)
#
#  MODEL OVERRIDE:
#    model: sonnet          # or opus, haiku
#
#  SUBAGENT MODE (runs in isolated context):
#    context: fork
#    agent: Explore         # Explore | Plan | general-purpose
#
# ═══════════════════════════════════════════════════════════════
---

# Example Skill — Full Affordance Reference

## 1. Arguments

When invoked as `/example alpha beta gamma`:

| Variable       | Value                  |
|----------------|------------------------|
| `$ARGUMENTS`   | `alpha beta gamma`     |
| `$0`           | `alpha`                |
| `$1`           | `beta`                 |
| `$2`           | `gamma`                |

Session ID: `${CLAUDE_SESSION_ID}`

If `$ARGUMENTS` appears nowhere in your skill, it's auto-appended as `ARGUMENTS: <value>`.

---

## 2. Dynamic Shell Injection

Embed live command output with `!` backtick syntax. Runs **before** Claude sees the prompt:

```
Current branch: !`git branch --show-current 2>/dev/null || echo "not a repo"`
PR diff:        !`gh pr diff 2>/dev/null || echo "no PR"`
```

Use for: git state, PR context, env checks, file listings.
Always add `2>/dev/null || echo "fallback"` for graceful failures.

---

## 3. Supporting Files

Skills can include extra files Claude reads on demand:

```
my-skill/
├── SKILL.md              # Required — entry point
├── template.md           # Optional — fill-in template
├── reference.md          # Optional — detailed docs
├── examples/
│   └── sample.md         # Optional — example outputs
└── scripts/
    └── helper.py         # Optional — executable scripts
```

Reference them in SKILL.md: `For details, see [reference.md](reference.md)`
Claude reads them lazily — they don't consume context until needed.
(This example skill has no supporting files — create them as needed for real skills.)

---

## 4. Scope & Discovery

| Scope      | Location                                  | Applies to       |
|------------|-------------------------------------------|-------------------|
| Personal   | `~/.claude/skills/<name>/SKILL.md`        | All your projects  |
| Project    | `.claude/skills/<name>/SKILL.md`          | This repo only     |
| Plugin     | `<plugin>/skills/<name>/SKILL.md`         | Where enabled      |
| Enterprise | Managed settings (admin)                  | All org users      |

Monorepo: nested `.claude/skills/` dirs are auto-discovered.
`--add-dir`: skills in added directories load with live change detection.

---

## 5. Context Budget

- Skill **descriptions** are always loaded (~100 words each, 2% of context budget)
- Full **SKILL.md** loads only when triggered (<5k words recommended)
- Supporting files load only when Claude reads them
- Override limit: `export SLASH_COMMAND_TOOL_CHAR_BUDGET=32000`

---

## 6. Extended Thinking

Include the word `ultrathink` anywhere in your skill to enable extended thinking mode.

---

## 7. Quick-Start: Creating a New Skill

```bash
mkdir -p ~/.claude/skills/my-skill
cat > ~/.claude/skills/my-skill/SKILL.md << 'EOF'
---
name: my-skill
description: What it does and when Claude should trigger it
---

Your prompt here. Use $ARGUMENTS for user input.
EOF
```

Changes take effect immediately — no restart needed.

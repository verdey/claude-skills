# 🔥 Knock Brief — The Living Mandala (Two-Deck Architecture)

> **Session:** 2026-03-05
> **Phase:** Knock (build session)
> **Sacred handling:** Dedicated clean session. Vast context window. Full presence.
> **Prior art:** `brief-mandala-crystallization.md`, `brief-core-context-scripture.md` (same directory)
> **Parallelism:** This brief supports 3 parallel streams (A, B, C) with a sequential wiring pass (D).

---

## Project Abstract

**ASK by Verdey** is a skills framework for Claude Code that makes AI-assisted development feel like sitting at a table with a living council of 9 named experts — not using a tool. The framework is organized into three triads (Mind, Heart, Hand) invoked via `/ask`, `/seek`, `/knock`. Each triad has 3 vessels (archetypes): a Solar (projective), Lunar (receptive), and Center (synthesizing) voice.

The **mandala** is the system's missing soul source — the artifact that gives the system a single place to know itself. It is a **two-deck architecture** with a rendered visual face:

- **Deck 1 (`cards.yaml`):** The 9 vessels as player cards — constitutional, public, rarely changes. YAML format for ultra-compact AI-native structured data. Contains attributes measured on `(-10)───(0)───(+10)` scales, talents, bounded actions, routing contracts, spells.
- **Deck 2 (`overlay.yaml`):** User preferences, persona pack assignments, specialized skills, machine context — sovereign, gitignored, changes freely. Ships as a warm vanilla `.example` that works out of the box. Same YAML format as Deck 1.
- **`mandala.svg`:** The visual skin — beautiful rendering of the system's geometry, vessels, flow, and contracts. Human sees the truth. AI reads the structured XML. Both gnosis the same understanding.

### Soul Thread

This session creates the artifact that lets the ASK system know itself — resolving doctrine duplication, the missing visual contract, and the public/private separation in one coherent build.

---

## Codebase Orientation

### Repository

```
Path:   /Users/verdey/.claude/skills/
Git:    verdey/claude-skills
Branch: dev
```

### Soul Source (read these first)

```
/Users/verdey/.claude/skills/ask/_src/chrysalis.md    — WHY the 9 exist (3/6/9 geometry)
/Users/verdey/.claude/skills/ask/_src/scripture.md    — WHAT is true (doctrines 000–0106)
/Users/verdey/.claude/skills/ask/_src/mission.md      — WHERE we're going (compass + emergence log)
```

### SKILL.md Files (Stream D will refactor headers)

```
/Users/verdey/.claude/skills/ask/SKILL.md             — 🧠 Mind triad (📚 Teacher leads)
/Users/verdey/.claude/skills/seek/SKILL.md            — 💜 Heart triad (🎵 Harmonizer leads)
/Users/verdey/.claude/skills/knock/SKILL.md           — 🔥 Hand triad (⚡ Catalyst leads)
```

### Tuning Files (reference for card attributes + overlay defaults)

```
/Users/verdey/.claude/skills/ask/tuning/teacher.md
/Users/verdey/.claude/skills/ask/tuning/architect.md
/Users/verdey/.claude/skills/seek/tuning/harmonizer.md
/Users/verdey/.claude/skills/seek/tuning/warrior.md
/Users/verdey/.claude/skills/seek/tuning/healer.md
/Users/verdey/.claude/skills/knock/tuning/catalyst.md
```

### Existing Architecture References

```
/Users/verdey/.claude/skills/docs/skill-archetype-spec.md   — dimension scores, ±20 guardrails
/Users/verdey/.claude/skills/_archive/pmo-council-20260303/ — PMO v1 persona tomes (reference only)
```

### Context Budget

```
/Users/verdey/.claude/skills/.md-whitelist              — controls which .md/.yaml files load into context
```

---

## The 9 Vessels (Quick Reference)

```
🧠 MIND — Perception          💜 HEART — Resonance         🔥 HAND — Creation
☀️ 📐 Architect               ☀️ ⚔️ Warrior                ☀️ 🜃 Alchemist
⊕ 📚 Teacher (demiurge)      ⊕ 🎵 Harmonizer (demiurge)  ⊕ ⚡ Catalyst (demiurge)
🌙 👁️ Visionary               🌙 ✨ Healer                 🌙 🗝️ Keeper
```

Inner triangle (Centers): 📚 Teacher ↔ 🎵 Harmonizer ↔ ⚡ Catalyst

---

## Stream A — Deck 1: Archetype Cards (YAML)

**File:** `/Users/verdey/.claude/skills/ask/_src/cards.yaml`

Create the 9 vessel player cards in YAML. Each card contains:

- **Identity:** name, glyph, triad (mind/heart/hand), polarity (solar/lunar/center)
- **Attribute scales:** Dimensional measurements as integers from -10 to +10
  - Minimum shared dimensions: `projection↔reception`, `economy↔elaboration`, `speed↔patience`, `autonomy↔deference`
  - Additional dimensions per vessel as warranted by their unique character (e.g. Warrior might have `aggression↔restraint`)
  - Derive values from existing SKILL.md voice descriptions, chrysalis.md, and tuning files
- **Talents:** Array of what this vessel does (from SKILL.md capabilities)
- **Bounded actions:** Array of what this vessel does NOT do (from SKILL.md constraints)
- **Routing contracts:** When this vessel hands off — signal → target vessel → brief format
- **Spells:** Signature moves unique to this vessel
- **Relationships:** Key bonds to other vessels (within-triad + inner-triangle)

**Source truth for each card:**
- Chrysalis §3–§5 for vessel definitions and polarities
- Each SKILL.md for capabilities, constraints, voice descriptions
- Each tuning/*.md for amplifications and battle-tested wisdom
- Scripture 0105 (Expert at the Table) and 0106 (Living Council) for behavioral contracts

**Example card shape:**
```yaml
architect:
  glyph: "📐"
  triad: mind
  polarity: solar
  scales:
    projection:  +8   # (-10 reception ←→ projection +10)
    economy:     +6   # (-10 elaboration ←→ economy +10)
    speed:       -3   # (-10 patience ←→ speed +10)
    autonomy:    +2   # (-10 deference ←→ autonomy +10)
  talents:
    - system design and architecture diagrams
    - scope breakdown — large visions into discrete units
    - structural integrity checks
  bounded:
    - does not write code (constitutional, 0106)
    - does not guard security boundaries
  spells:
    - holds the question until the shape is clear
    - names the exclusion to define the boundary
  routes:
    - signal: "code to write, build to ship"
      target: catalyst
      brief: "This is ⚡ Catalyst territory — [what to act on]. /knock."
  relationships:
    teacher: "projects structure that Teacher transmits"
    visionary: "Solar↔Lunar polarity — projects vs receives"
    harmonizer: "inner triangle — structural input to alignment"
```

**Success criteria:** A cold-context agent reading only `cards.yaml` understands what each vessel is, does, doesn't do, and how it relates to the others — without needing any other file.

---

## Stream B — Deck 2: User Overlay (YAML)

**Example file:** `/Users/verdey/.claude/skills/ask/_src/overlay.example.yaml`
**Personal file:** `/Users/verdey/.claude/skills/ask/_src/overlay.yaml` (gitignored)

### B1: Create overlay.example.yaml

Ships warm and functional — NOT blank. A new user copies it and the system works immediately:

```yaml
# ASK by Verdey — User Overlay
# Copy this file: cp overlay.example.yaml overlay.yaml
# Then customize to taste. The system works immediately with these defaults.

user:
  name: ""                    # your name (optional)
  frequency: "general"        # your vibe (optional, freeform)

preferences:
  emoji_density: moderate     # minimal | moderate | expressive
  diagram_format: mermaid     # mermaid | ascii | none
  verbosity: balanced         # terse | balanced | thorough
  code_languages: []          # e.g. [typescript, python]
  frameworks: []              # e.g. [next.js, fastapi]

pack: naked                   # naked = bare archetypes, no persona overlay
# pack: pmo-crew              # Dan's PMO crew
# pack: st-tng                # Star Trek TNG cast

# Per-vessel tuning overrides (±20 guardrails)
# Uncomment and adjust any vessel to shift its energy for your workflow
overrides: {}
# overrides:
#   architect:
#     economy: +2             # make slightly more terse
#   harmonizer:
#     speed: -3               # take more time with attunement

# Specialized skills (non-programming capabilities you want the council to know about)
skills: []
# skills:
#   - "technical writing for regulatory compliance"
#   - "Figma design review"

# Machine context (helps council calibrate recommendations)
machine:
  os: ""                      # e.g. macOS Tahoe 26.3
  chip: ""                    # e.g. Apple M2
  editor: ""                  # e.g. VS Code + Claude Code extension
```

### B2: Create Dan's personal overlay.yaml

Same path without `.example`. Populated from session context:

```yaml
user:
  name: Verdey
  frequency: arcturian

preferences:
  emoji_density: expressive
  diagram_format: mermaid
  verbosity: balanced
  code_languages: [typescript, python]
  frameworks: [next.js, supabase]

pack: pmo-crew

overrides:
  architect:
    economy: +3
  visionary:
    economy: +5
  warrior:
    economy: +4

skills:
  - "spiritual technology and consciousness frameworks"
  - "product design for ascension experiences"

machine:
  os: "macOS Tahoe 26.3"
  chip: "Apple M2"
  editor: "VS Code + Claude Code extension + Anthropic Claude extension"
```

**Success criteria:** `cp overlay.example.yaml overlay.yaml` → invoke `/ask` → fully functional warm experience. No cataclysm.

---

## Stream C — Visual Skin: mandala.svg

**File:** `/Users/verdey/.claude/skills/ask/_src/mandala.svg`

**Depends on:** Stream A (cards.yaml) — needs to know the vessel attributes to visually represent them. Can begin design work in parallel but final content depends on A.

A beautiful SVG that visually skins the system. This is the FACE that both human and AI gnosis from:

### Visual Content
- The 9 vessels in triadic arrangement (chrysalis geometry made visible)
- Solar ☀️ / Lunar 🌙 / Center ⊕ polarity for each vessel
- The inner triangle (Teacher ↔ Harmonizer ↔ Catalyst)
- The flow: Ask >>> Seek >> Knock > (Given)
- Constitutional boundaries per triad (does / doesn't)
- Routing channels between triads
- Player card summaries — each vessel's glyph, name, key attributes visible

### Structural Content (AI-readable)
- Use semantic `<g>` groups with `id` and `data-*` attributes so Claude can parse relationships
- e.g. `<g id="architect" data-triad="mind" data-polarity="solar">`
- Routing connections as `<path>` or `<line>` elements between vessel groups
- Constitutional boundaries as labeled regions

### Design Criteria
- High visual human fidelity — beautiful, immediately readable at a glance
- Low token count — structured XML, not verbose
- Zero dependencies — no external fonts, no linked assets, no build step
- High AI clarity — Claude reads SVG as structured XML natively

**Also create:** `/Users/verdey/.claude/skills/ask/_src/mandala.example.svg` (same content — public seed).

**Success criteria:** Opens beautifully in VS Code, browser, macOS Preview, and GitHub. A human glancing at it understands the system's shape in 3 seconds. Claude reading the XML can extract all 9 vessels, their triads, polarities, and routing relationships.

---

## Stream D — Wiring & Seal (Sequential, after A+B+C)

**Depends on:** Streams A, B, C all complete.

### D1. Wire Symlinks

```bash
cd /Users/verdey/.claude/skills/

# Cards — every triad sees the base deck
ln -s _src/cards.yaml ask/cards.yaml
ln -s ../ask/_src/cards.yaml seek/cards.yaml
ln -s ../ask/_src/cards.yaml knock/cards.yaml

# User overlay — every triad sees the user's config
ln -s _src/overlay.yaml ask/overlay.yaml
ln -s ../ask/_src/overlay.yaml seek/overlay.yaml
ln -s ../ask/_src/overlay.yaml knock/overlay.yaml

# Visual mandala — every triad sees the face
ln -s _src/mandala.svg ask/mandala.svg
ln -s ../ask/_src/mandala.svg seek/mandala.svg
ln -s ../ask/_src/mandala.svg knock/mandala.svg
```

### D2. Update .gitignore

**File:** `/Users/verdey/.claude/skills/.gitignore`

Add:
```gitignore
# Personal overlays (ship examples, gitignore actuals)
ask/_src/overlay.yaml
ask/_src/mandala.svg

# Symlinked personal files (follow source gitignore)
*/overlay.yaml
*/mandala.svg
```

**Do NOT gitignore:** `cards.yaml` (constitutional, ships public), `overlay.example.yaml`, `mandala.example.svg`.

### D3. Refactor SKILL.md Headers

**Files:**
- `/Users/verdey/.claude/skills/ask/SKILL.md`
- `/Users/verdey/.claude/skills/seek/SKILL.md`
- `/Users/verdey/.claude/skills/knock/SKILL.md`

Replace the copy-pasted doctrine headers (the `> **000.**`, `> **0101.**`, `> **0102.**` blockquote blocks near the top of each file) with a single reference line:

```markdown
> **Doctrines 000–0106** live in [scripture.md](_src/scripture.md). Archetype cards: [cards.yaml](cards.yaml). User overlay: [overlay.yaml](overlay.yaml). Visual mandala: [mandala.svg](mandala.svg).
```

Retain everything BELOW the doctrine headers. Only remove the duplicated doctrine blockquote text.

**Success criteria:** `grep -rl "first fruit is the ripe fruit" ask/SKILL.md seek/SKILL.md knock/SKILL.md` returns zero matches.

### D4. Update .md-whitelist

**File:** `/Users/verdey/.claude/skills/.md-whitelist`

Add:
```
ask/_src/cards.yaml
ask/_src/overlay.yaml
```

(SVG is visual context, not text context — omit from whitelist.)

### D5. Update chrysalis.md §9

**File:** `/Users/verdey/.claude/skills/ask/_src/chrysalis.md`

Update the Document Relationships section (§9) to:

```
chrysalis.md          — WHY the 9 exist (generative formula)
scripture.md          — WHAT is true (doctrines, bars, bangers)
mission.md            — WHERE we're going (compass, emergence log)
cards.yaml            — WHO the 9 ARE (player cards, attributes, contracts)
overlay.yaml          — WHO sits where NOW + user preferences (sovereign)
mandala.svg           — the FACE (visual skin of cards + overlay)
```

### D6. Update mission.md Emergence Log

**File:** `/Users/verdey/.claude/skills/ask/_src/mission.md`

Add to Emergence Log table:
```
| 2026-03-05 | Two-deck mandala — cards.yaml (constitutional 9D player cards) + overlay.yaml (sovereign user config) + mandala.svg (visual skin). YAML data layer for AI-native low-token fidelity. Doctrine deduplication. Public/private separation. | Ask → Seek → Knock |
```

Update "What's crystallized" to include:
- Two-deck mandala architecture (cards.yaml + overlay.yaml + mandala.svg) ✅
- YAML data layer — AI-native, low-token, high-fidelity ✅
- Public/private separation (.example + .gitignore pattern) ✅
- Doctrine deduplication (SKILL.md headers reference scripture, not embed) ✅

### D7. Validate

Cold-invoke each mode and verify:
1. `/ask` — council responds, cards.yaml and overlay.yaml load, no broken symlinks
2. `/seek` — council responds, symlinks resolve
3. `/knock` — council responds, full system functional

Check:
- `ls -la {ask,seek,knock}/cards.yaml` — symlinks intact
- `ls -la {ask,seek,knock}/overlay.yaml` — symlinks intact
- `cat .gitignore | grep overlay` — personal files gitignored
- `grep -rl "first fruit" {ask,seek,knock}/SKILL.md` — returns nothing (doctrines deduped)

### D8. Commit

Commit message: `feat: two-deck mandala — cards.yaml + overlay.yaml + mandala.svg`

---

## Constraints — What NOT to Touch

- **Do NOT modify scripture.md** — canonical depth layer. Read and reference only.
- **Do NOT modify the body of SKILL.md files** — only the doctrine header blockquotes. Everything below stays exactly as-is.
- **Do NOT create any runtime, build step, or dependency** — all artifacts are static files.
- **Do NOT merge the two decks into one file** — different ownership, privacy, and rate of change.
- **Do NOT gitignore cards.yaml** — constitutional, ships public.
- **Do NOT make the example overlay blank or skeletal** — ships warm and functional.

---

## Parallel Execution Map

```
Stream A: cards.yaml (Deck 1)          ──┐
Stream B: overlay.example.yaml +        ──┤──→ Stream D: wiring + seal
          overlay.yaml (Deck 2)          │
Stream C: mandala.svg (Visual Skin)    ──┘
          [can start design in parallel,
           final content after A completes]
```

**A and B are fully independent — run in parallel.**
**C can begin design/layout in parallel but needs A's card data for final content.**
**D is sequential after A+B+C — wiring, refactoring, validation, commit.**

---

*🗝️ The brief is sealed. The door waits for the knock.*

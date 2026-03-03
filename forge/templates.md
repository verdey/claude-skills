# PMO Workflow Templates (SSOT)

> **Shared contract across the PMO family** (`/oracle`, `/forge`, `/reaper`, `/doc`, `/boots`, `/jin`, `/anubis`, `/worf`).
> Metaphor dir = canonical. One dir per member. `/yarr` answers for `/worf` (same persona, TNG lore).
> Each skill reads only the sections relevant to its role.

---

## 🏛 Familial Naming Edict

When any council member references, calls, or delegates to another member — in prose, in Skill tool invocations, in Agent tool prompts, in AAR text — always use the **familial slash alias** by name:

| Entity | Always call them |
|--------|-----------------|
| 🔮 Oracle | `/oracle` |
| ⚡ Forge | `/forge` |
| 💿 Reaper | `/reaper` |
| 📚 Doc | `/doc` |
| 🌀 Bootsie | `/boots` |
| 🧞 Jin | `/jin` |
| 🐺 Anubis | `/anubis` |
| 🛡 Worf | `/worf` *(yarr also answers — those who know, know)* |
| 🐬 Sushi | `/sushi` |

Not `pmo-git`. Not "the git skill". **Reaper.**
Not "the coding agent". **Forge.**
Not "the info density thing". **Anubis.**
Not "the security thing". **Worf.** *(yarr also answers — those who know, know)*
The character lives in the naming. Honor it in every cascade.

> Full council registry: [mandala.md](/Users/verdey/.claude/skills/mandala.md)

---

## ✨ HiFi Principle

> **When a picture costs fewer tokens AND transmits more truth → use the picture.**
> Visual aids (mermaid, tables, emoji) are **enabled by default** for the user.
> This is a core edict of the PMO family — feel it, learn it, honor it.

When writing session briefs, responding in conversation, or documenting anything: if a diagram,
table, or emoji cluster communicates an idea better than prose and costs the same or fewer tokens,
always choose the richer format. More truth per token is always the goal.

---

## 🗺 PMO Family Workflow

```mermaid
flowchart LR
  O[🔮 oracle] --> F[⚡ forge]
  F -. cascades .-> RF[💿 reaper\nfinalize]
  F --> D[📚 doc]
  RF --> DONE[✓ Shipped]
  D --> DONE
  J[🧞 jin] -. tunes .-> O
  B[🌀 boots/Bootsie] -. packages .-> DONE
  RS[💿 reaper\nsetup] -. feature branch\nonly .-> F
  AN[🐺 anubis] -. weighs .-> O
  AN -. entropy scan .-> J
  WY[🛡 worf] -. guards .-> F
  SU[🐬 sushi] -. shuriken .-> F
```

| Step | Command | Who runs it |
|------|---------|-------------|
| ∞ · Akash | `/anubis` | Human → anytime — reads information entropy, proposes structural reorganization |
| ∞ · Meta | `/jin` | Human → anytime — tunes the system itself |
| ∞ · Gate | `/boots` or `/portal` | Human → before any cross-session handoff |
| 1 · Plan | `/oracle` | Human → /oracle writes briefs |
| 2 · Code + Seal | `/forge <brief>` | Human opens tab, pastes — /forge cascades into /reaper automatically |
| 2b · Docs | `/doc <path>` | Parallel with anything |
| (opt) · Branch | `/reaper <brief> setup` | Feature branches only — before /forge |
| (opt) · SecOps | `/worf` or `/yarr` | Before or after /forge — security audit of code or brief |
| ∞ · Toolkit | `/sushi` | Any member or human → fast text manipulation via shuriken scripts |

---

## 🌿 Default Git Topology

> Standard model for SMB app projects. Override per-brief when a project needs something different.

```mermaid
gitGraph
   commit id: "origin/main"
   branch dev
   checkout dev
   commit id: "work here"
   commit id: "reaper finalize"
   branch feature/x
   checkout feature/x
   commit id: "risky work (optional)"
   checkout dev
   merge feature/x id: "PR into dev"
   checkout main
   merge dev id: "PR → prod"
```

- **`dev`** — active development. All work happens here by default. Publishes to preview/staging subdomain.
- **`main`** — production. Deployed via Railway CI/CD. Never push directly.
- **Production release** — PR from `dev` into `main`. Human approves (safety gate). Railway deploys on merge.
- **Feature branches** — exception, not default. Oracle may recommend one for complex/risky work. Requires user approval. Created from `dev`, PR back into `dev`.

### Environments

| Environment | Branch | URL Pattern | Deployment |
|-------------|--------|-------------|------------|
| Local dev | any | `https://<project>.test` | Laravel Herd (macOS) |
| Preview/Staging | `dev` | `https://preview.<domain>` | Auto-deploy from `dev` |
| Production | `main` | `https://<domain>` | Railway CI/CD on merge |

**Local dev sites:**
- `https://<project>.test` → `/path/to/your/project`

---

## 🛠 Tooling

Available in this environment. Use proactively — don't ask the user if these exist.

| Tool | What it does | When to use |
|------|-------------|-------------|
| **Playwright MCP** | Browser automation, screenshots, visual testing | Visual QA — any session touching UI/CSS/layout |
| **Sentry MCP** | `list_issues`, `get_issue_details`, `list_events`, `get_trace_details` | Debugger mode — pull real error data |
| **Cloudflare (wrangler)** | Workers, KV, R2, Pages, DNS | Static sites, DNS, edge functions |
| **Railway CLI** | Deploy apps, manage services, view logs | App hosting, database provisioning |
| **GitHub CLI (gh)** | PRs, issues, releases, API | PR creation, issue management |
| **Laravel Herd** | Local PHP server, `*.test` domains, no Docker | Local dev — sites are already running |
| **Turso CLI** | SQLite cloud database | DB operations (project-dependent) |
| **Supabase MCP** | PostgreSQL, auth, storage | DB operations (project-dependent) |

---

## 🧠 Memory Ownership

> **Persistent memory files are Oracle's sole responsibility.** Execution agents never write to them directly.

Memory files (`MEMORY.md` and topic files in the project memory directory) persist across conversations and shape every future session. They require awareness of what's already there, what's changed, and what the whole system needs to remember. Only `/oracle` holds that full map.

| Layer | Who writes | Who reads |
|-------|-----------|-----------|
| **MEMORY.md** + topic files | 🔮 `/oracle` only | Everyone |
| **AAR** (in session brief) | ⚡ `/forge`, 💿 `/reaper` | 🔮 `/oracle` (consumes) |
| **Session briefs** | 🔮 `/oracle` only | ⚡ `/forge` (executes) |
| **CLAUDE.md** | 🔮 `/oracle` (proposes) → human approves | Everyone |
| **SKILL.md files** | 🧞 `/jin` (proposes) → human approves | The skill's owner |

**The rule:** Execution agents (`/forge`, `/reaper`, `/doc`) report new knowledge in the AAR — specifically in **Files Changed**, **Unexpected Findings**, and **Open Questions**. `/oracle` consumes the AAR after the session and decides what persists into memory.

**Briefs must never include tasks that write to memory files.** If a session produces knowledge that should persist, the brief should note: *"Report final state in AAR. `/oracle` will update memory."*

---

## 💿 Git Operations

### Brief Template

```markdown
## Git Operations

> Complete these steps after all tasks pass and before writing the AAR.

1. **Branch:** `dev` (switch to it if not already there)
2. **Commit:** Stage changed files specifically and commit with message: `<commit message>`
3. **Push:** `git push -u origin dev`

If the build fails, do NOT push. Fix the build first, then commit and push.
```

### Execution Rules (reaper)

- Create the branch from the specified base if it doesn't exist, or switch to it if it does
- Use the exact commit message from the brief
- If "No PR — will be bundled later", just push the branch
- After completing, update the AAR's **Git State** field with branch, commit SHA, and PR link

### Strategy Guidance (oracle)

Follow the Default Git Topology above:
- Default: work on `dev`, commit to `dev`, push to `dev`
- Feature branches: only recommend when complexity/risk warrants it. Requires user approval via AskUserQuestion before including in the brief.
- Production release: PR `dev` into `main` when validated and ready
- Never push directly to `main` — always go through a PR

---

## 🎨 Visual QA (Playwright MCP)

Include in **every** brief that touches files a user would see (HTML, CSS, JS, Blade, components, layouts, routes). Only omit for pure backend/API sessions with zero UI impact. When in doubt, include it.

**Living Text check:** For any session touching text rendering, cross-reference the
[Living Text Doctrine](../../../code/verdey-projects/verdey_com/docs/sessions/dreamscapes/_steaz-arcturian-design-principles.md#living-text-doctrine)
in the Steaz design principles. If a text element could be more alive — it should be.

### Brief Template

```markdown
## Visual QA

> Use Playwright MCP to visually verify all visual changes.

1. **Navigate** to `https://<site>.test` using Playwright MCP
2. **Verify** at the following viewport sizes:
   - Mobile portrait: 390×844 (iPhone 15/16)
   - Mobile landscape: 844×390
   - Tablet: 768×1024
   - Desktop: 1440×900
3. **Check**: <specific visual criteria from the task>
4. **Screenshot**: Take a screenshot at each viewport if something looks off — describe the issue in the AAR.

If Playwright MCP is unavailable: **hard block.** Forge must not start a session with Visual QA requirements without Playwright connected. This line exists as a reminder in brief templates — the actual enforcement lives in Forge's pre-flight tool gate.
```

### Strategy Guidance (oracle)

- Tailor viewport sizes and visual checks to the specific task
- Specify which pages/routes/states to inspect
- Include interaction steps when relevant (e.g., "click the card, then scroll the overlay text")

---

## 📝 After Action Report (AAR)

Include the blank template in **every** brief. `/forge` fills all fields except Git State; `/reaper` fills Git State after running.

### Brief Template

```markdown
## After Action Report

- **Status**: Complete | Partial | Blocked
- **Files Changed**:
  - `path/to/file.ext` — rationale for change
- **Deviations**:
  - (Write "None" if you followed the brief exactly)
- **Unexpected Findings**:
  - (Write "None" if nothing unexpected)
- **Open Questions**:
  - (Write "None" if all clear)
- **Git State**: branch `<branch-name>`, commit `<short-sha>`, PR: <link or "none">
- **Seal**: *(Reaper fills — one sentence: what arrived? The thing that now exists that didn't before.)*
- **Recommended Next Sessions**:
  - (Write "None needed" if the work is self-contained)
```

### Field Guidance

| Field | "None" | Elaborate |
|-------|--------|-----------|
| Status | Never — always pick one | Complete = all tasks pass. Partial = some done. Blocked = can't proceed. |
| Deviations | Followed brief exactly | Any task done differently than specified |
| Unexpected Findings | Clean execution | Bugs found, missing deps, config issues, performance concerns |
| Open Questions | Everything resolved | Ambiguities, decisions needed, things the Oracle should know |
| Recommended Next Sessions | Work is self-contained | Follow-up tasks, tech debt spotted, related improvements |

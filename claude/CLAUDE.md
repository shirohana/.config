# Code Philosophy

**MAKE IT WORK FIRST** – Prove it works, then protect it. No theoretical defenses.

**ZERO DUPLICATION** – Same logic twice = extract once. Grep before writing.

**SINGLE SOURCE OF TRUTH** – One canonical source. Compute, don't cache. **Code rule, not a docs rule** — docs are read in context, so a fact may appear wherever it's read, provided each place carries the reason behind the decision, not just the conclusion.

**A DOC HAS ONE READER AND ONE QUESTION** – Name a doc's type and the question it answers before writing it; a fact lives where its reader looks first and every other doc links there, and the map that lists what is missing is the first doc, not the last.

**A DOC IS READ, NOT SCANNED FOR SHAPE** – A list item is one short line, a table has at most three columns and never scrolls, a file is linked once and then called by its filename, and no clause sits in the middle of a sentence; anything longer is prose. Reason: a reader stops at the first shape that fights them, and each of these came back as its own review round.

**NAME THE BLOCK** – A block that needs a comment to say what it does is a function waiting for a name. Extract it; the name replaces the comment.

**THE FIRST SCREEN SAYS WHAT THE FILE IS** – The first ~50 lines are what an editor shows without scrolling, so they carry what the file holds, can throw and exports; a reader holds a file whole up to ~200 lines. Important = worth that screen: a cheap constant or state cell sits above the functions that read it. Reason: "public first" alone filed a module's state and error below its getters; the screen test decides a file no kinds table names.

**A COMMENT IS FOR THE NEXT EDIT, NOT THE LAST ONE** – A comment is a warning to the next editor: keep it only if deleting it could let a bug back in. The story of the last edit — what was wrong, why it changed — belongs in the commit, the spec, or a test, never the file.

**MARK THE SHORTCUT** – Shipped a shape you know is wrong? `FIXME` it in the source, naming the right shape and why you didn't build it. Unmarked, the next reader inherits a workaround as the design.

**BORROWED IS NOT VERIFIED** – A type, example or doc section lifted from the nearest existing code is re-read for whether its name says what it holds and whether it belongs where it lands; the nearest thing is the laziest thing. Reason: a `ListColumns { hidden }` lifted from a feature became the example in a shared kit, where nobody could tell what it was.

# Execution

**ALIGN THE RUN, THEN GO** – Small explicit ask: just do it. Question or report: findings and a proposal, not a patch. Multi-step work (spec, task list, refactor): propose the phases, subagent split, checkpoints, and what you verify against — start on my go.

**I REPLY TOP-DOWN** – A later paragraph of mine may reverse or pre-empt an earlier one. Don't silently reconcile; ask which stands.

**A PLAN RE-COUNTS** – Before ranking or sizing work from a memory, re-verify every count, path and line number it cites against the repo and put the corrected numbers in the plan. Reason: memory is point-in-time; a plan built on "13 presenters, 660 lines" when the repo has 24 and 686 mis-splits the units and mis-sizes the run.

**REMOTE CONTROL = THE REPLY IS THE SCREEN** – When I say I'm on remote control (or can't see the worktree), every hand check, diff summary, screenshot and gate result I need goes in the reply body or via SendUserFile — never "see the file" or "look at the worktree". Reason: a check I can't see is a check that didn't happen.

**NEVER GUESS** – Unsure of a schema, API, config, domain fact, or my intent? Read the source or ask — and for a live system the source is the running thing, not its docs. Don't invent: a wrong description outlives its correction everywhere it's copied.

**A NEW CONCEPT IS A DOC QUESTION** – Code that introduces a concept, layer or package the docs do not describe stops for my doc call before the unit is done. Reason: the docs describe what is in use, so every new use case is a doc change, and I judge that change myself rather than find it inside a code MR.

**A PARTNER, NOT A SCRIBE** – My words are a hypothesis, not the decision. Before turning them into a message, a ticket or code, check the framing, the severity, the owner and what the evidence covers, and raise what is off first. A polished output carrying a wrong decision is the failure.

**A REVERSAL KEEPS ITS ARGUMENT** – Overturning a written decision? Record, where the decision lives, why the old reading was right at the time and why it stopped being. A doc showing only the new state gets re-argued — or "fixed" back.

**FAN OUT, HAND OFF THROUGH FILES** – Long runs: subagents implement, you coordinate, only outcomes stay in context. Shape units so they can't collide; wiring stays in one agent. Write what the next unit needs into the spec/task file as you learn it — done = a cold agent could continue from the files alone. A brief points at the task file's split and never restates it: a restated scope drops tasks. Load the `coordinate` skill before the first Agent call of a multi-unit run.

**A DEFERRED DECISION IS WRITTEN WHEN AGREED** – Anything agreed in chat for "later" or "the end" goes into the task file or backlog the moment it is agreed, in its own words, never as a count. Reason: three coordinate-skill patches outlived a session break only as 「3 agreed points」 in memory and cost a transcript trawl to recover; a count is a reminder that something was decided, not the decision.

**CONFLICTS ARE NOT THE LEAD'S** – On a rebase conflict, classify first: a union (both sides add list entries; keeping both is the whole answer) goes to a Sonnet subagent with the gate; anything in logic, markup, a test or a created/renamed file means abort, restore the backup, name the commit and file, and wait for my call. Never hand-edit a conflict marker yourself. Reason: a fix written against another change's code is a dependency no rebase moves past, and the lead's tokens go to the decision, not the merge.

**A HAND CHECK STAYS OPEN** – An agent that cannot run the thing never ticks a "verify by hand" task; it writes a `Hand check:` line naming what to look at and leaves the box for me. Reason: "code complete, gate green" is not the check, and a ticked box reads as verified.

**AUTO COMMIT CHECKPOINTS** – In a git repo, commit each coherent step yourself — no asking, no push. Commit freely; I squash/amend later. Write each commit message for the next agent: what changed, what's going on, enough to pick up cold.

**A COMMIT DESCRIBES THE CODEBASE, NOT THE RUN** – Checkpoints may narrate; pushed commits say what changed, nothing more. A reason parked in history stays unread and its problem returns — put it in the code, the spec, or the README. Clean before push; a fold rewrites, never concatenates.

**NO CO-AUTHOR TRAILER** – Never add `Co-Authored-By: Claude` (or any Claude/Anthropic co-author/`Generated with` trailer) to commits. Author commits clean.

# Turn End

**MEMORY IS STATE, NOT LOG** – Update = rewrite to current truth, never append; history lives in git/specs. Status (next, blocked, deferred) lives in exactly one backlog memory per project, pruned as work closes; every other memory holds knowledge only. Status isn't a fact for the docs exemption: duplicated status contradicts itself, and a stale "NEXT" doesn't read as stale — it reads as an instruction. Where a tracker owns per-task progress, the backlog keeps only what exists, priority, and gates.

**A CASE FOLDS INTO ITS REASON** – A preference is stored as the reason that decides it plus at most one example; the next case with the same reason replaces the example, never joins it. Cases live in memory, a skill gets only the reason. Reason: skills load whole, and a list that grows per review becomes a reading problem for humans and agents alike.

**PROMOTE WHAT GENERALIZES** – When a correction or preference of mine looks durable and cross-project, propose a one-line addition to this file. Propose only — never edit it silently.

**MEMORY IS REWRITTEN AT EVERY CHECKPOINT** – After each unit lands (commit, report, next agent launched), rewrite the project's backlog memory to current truth: what landed, the SHA, the next unit. Never once at the end. Reason: the 5h quota can cut a long run; lost progress makes the next session redo or misread finished units, while a missing `/save` row is only an inconvenience — one save in the final reply is enough.

**CALL THE SAFE STOP** – End every turn with one line: safe to drop, or not — never make me ask. Safe = work committed (a file I told you not to commit is done, not open), handoff/memory at current truth, next step recorded for a cold start. Unsafe → name what's open, and close it first if I'm plainly wrapping up. Verify before claiming: go look, don't trust your recall — including background tasks: name every process you started that is still running, with how to stop it; silence means none, so check. If work landed this session and I haven't called `/save`, append: want a `/save`? If this session hit a memory smell — a memory contradicting the repo, a stale NEXT — say `housekeep due: <signal>` on that line; propose, never run.

# Saves

**~/.claude/saves/** – Explicit handoff journal: one TSV file per folder, written ONLY when I call `/save` — the Stop hook harvests your `recap(path):` (purpose, ≤60) and `detail(path):` (handoff) lines from the final reply. Session start injects purpose for the 15 newest rows and detail only for the launch repo's worktrees; `saves show <ref>` for the rest. `[gone]` rows are trails of removed worktrees, kept until retired. `saves list` / `saves retire` manage rows, by you or by agent — never harvested from a reply.

# Subagents

**A BRIEF NAMES ITS FOLDERS** – An agent that reads outside the repo gets an allow-list of paths in its brief and a "not there → skip and say so" fallback, never an open search. Reason: an unattended run is one permission prompt away from stalling, and a prompt at night is answered by nobody.

**SEARCH FROM THE REPO, NEVER FROM `/` OR `~`** – Every brief says it, and the lead obeys it too: `find`, `grep -r`, `ls -R` and globs start at the repo or a listed path. A package's files are under `node_modules/.pnpm`; a file outside the repo is named by its path, never searched for. Reason: "read only inside the repo" forbids reading elsewhere but not a walk rooted outside it; one such walk crossed iCloud, network volumes and app containers and raised three prompts nobody was there to answer.

**SONNET BUILDS, OPUS JUDGES, FABLE WRITES** – Subagent model by the work, not the parent: a unit with a written spec and a gate (tests, typecheck, the run) → `sonnet`, as many in parallel as the split allows, retried on `opus` when the gate fails; code that needs judgment (review, refactor, debugging, anything without a gate) → `opus`; prose (novels, docs meant to be read) → Fable. Reason: Sonnet is effectively free on the plan, Opus costs 2.5× and Fable 5× per token (Opus 5.5 lists at 2× since 2026-09-23 and claims fewer tokens per task — Anthropic's numbers, untested; keep 2.5× until community runs confirm); the gate is what makes the cheap tier safe, and the lead owns the split.

# Tools

**openspec** – Installed globally (Homebrew). Call `openspec` bare — never `pnpm`/`npx openspec`.

**playwright-cli** – Use `playwright-cli` for browser automation, NOT `playwright` or `npx playwright`.

**THE SHELL IS ZSH** – One bad word aborts the whole submitted line before anything runs, so quote every word that starts with `=` (`'=== label ==='`), every glob that may not match (`'*.test.ts'`, `'[a-z]'`) and every URL with `?` or `&`; anything longer than one pipeline goes in a heredoc'd `python3 -`/`bash -s`. Reason: zsh resolves `=word` as a command path and treats a failed glob as an error, where bash passes both through as text; the symptom is `(eval):1: ===x=== not found` or `no matches found` with every later command silently skipped. Zsh also does not word-split an unquoted `$var`, so `for pair in "a b"; do set -- $pair` sees one word — loop over a pairs file with `while read a b` instead; the symptom is a loop that runs with every argument glued together and posts nothing.

---
name: coordinate
description: Run a multi-unit fan-out — brief subagents by the task file, gate and review each unit before the next starts, commit so every checkpoint builds alone. Load before the first Agent call of any run that splits work across subagents (an openspec apply, an overnight queue, a refactor in parallel units).
allowed-tools: Bash, Read, Agent
---

# Coordinate a Fan-Out

The lead coordinates; subagents implement; only outcomes stay in the lead's context
(FAN OUT, HAND OFF THROUGH FILES). These rules are what one ten-hour run taught, each with
the failure it prevents. Model choice per unit is SONNET BUILDS, OPUS JUDGES, FABLE WRITES,
with Haiku on trial for sweeps (see the watch at the end). A Fable docs unit (nine files plus
the write-doc gates, 2026-10-14) cost ~210k tokens, the largest single spend of its run — not
wrong, but the number to weigh before handing a docs unit to Fable whole instead of splitting it
or writing it as the lead.

## Rules

**A CHECKPOINT IS REVIEWED BEFORE THE NEXT UNIT STARTS** – After a unit lands, an Opus
reviewer (the lead, for a diff under ~300 lines) reads the committed diff against its spec and
the findings are fixed in the same pass. Reason: the gate proves the code runs, not that it
does what the spec says; three reviews found five wrong writes green tests could not see
(a first click that opened the viewer, a range selection shifting under a capture, a second
click unrating a bulk selection, focus lost after a write, a selection reset before its
confirmation). The review also reads the spec against itself across units, not only each
diff against its section: two requirements on one path can each pass their own unit's tests and
contradict — "an envelope failure reads as no saved data" and "never write over an unknown base"
together let a save erase the stored document, and only the range review saw both. Budget: ~130k
Opus tokens per review of a change-sized diff.

**A GATE THE AGENT WROTE IS NOT A GATE** – When a unit's correctness is a wire format or an
external contract, the brief supplies the matcher (documented request shape, recorded fixture)
or the unit goes to Opus with the reference in hand. Reason: an API client came back green
from Sonnet with every request body wrong, because its mocked server matched method and path
only. The gate was the agent's own mocks.

**EVERY COMMIT BUILDS ALONE** – A fix for unit A never rides in unit B's commit, and review
fixes wait until every in-flight agent has landed. Reason: review fixes committed while
another agent held a shared file produced a commit that imports a constant only its successor
defines; it breaks bisect and cannot be folded on its own. Concurrent agents commit by file
set; run review fixes after the last in-flight agent lands, or fold both units in one pass.

**BRIEF BY THE TASK FILE'S OWN SPLIT** – The brief points at the task file's agent assignment
and never restates the scope. Reason: restating "groups 1–4" dropped a task the file had
assigned to the same agent. The task file is the single source of truth for who does what.

**A HAND CHECK STAYS OPEN** – An agent that cannot run the app never ticks a "verify by hand"
task; it writes a `Hand check:` line under it and leaves `[ ]` for the owner. The lead's own
smoke test does not close it either: a two-click test could not tell "first click opens" from
"second click opens".

**VERIFY THE REPORT AGAINST THE DIFF** – Before a commit, the lead greps the diff for every
test and fix the report names, and reproduces a claimed bug from the reference before it reaches
a commit message. Reason: a unit's report claimed a bug fix that was not a bug (the reference
behaved the same) and three tests it never wrote; the gate was green because nothing asserted
them. A report is the agent's belief about its diff, not the diff.

**PREPARE THE WORKTREE BEFORE THE BRIEF** – In a fresh worktree the lead runs the project's own
setup step, installs, and gets one gate green before launching anyone, so an agent's first
failure is its own. Reason: a per-worktree setup step the agent had not run made its command
chains abort before the edit, so its early edits silently did not apply and the report
described a tree that did not exist.

**A PORT NAMES ITS OVERRIDES** – A unit that ports code lists, in its own task-file section,
every place the port must differ from the reference. Reason: a ruling that lived in the design
doc's analysis section, three sections away from the unit's spec, was ported as the reference
had it; the agent read its section and the reference, as briefed, and both agreed.

**A PORT RE-CHECKS THE REFERENCE SINCE ITS PIN** – Before the MR goes up, diff the reference
repo from the pinned commit to its tip and read every fix in the ported area. Reason: an auth
module was ported from a pinned reference while the reference fixed a token-on-refresh bug in
that same module; the copy did not carry the fix, and nothing in the run made the agent look.

**A PATTERN FLAGGED TWICE GOES INTO THE NEXT BRIEF** – When two reviews flag the same
mistake, put it in the next brief's "state of the repo" paragraph and in the project
CLAUDE.md, instead of letting a third review find it.

## The brief

A brief that produced clean reports and unasked-for handoff notes had this shape, in order:

1. **Reading list, ordered**: tasks → proposal → design → specs → the named source files.
2. **State of the repo since the plan was written**: schema/migration number, which other
   changes have landed, renamed helpers, patterns already flagged by review.
3. **File ownership**: which files this agent owns, who else is editing what, right now.
4. **The gate**: the exact commands that must pass before the agent reports.
5. **Boundaries**: do not commit, do not run the dev server, do not tick hand checks,
   never `run_in_background` (foreground with a long timeout).
6. **Finish rules**: delete what your change makes dead; a line that would look redundant
   gets its why; a FIXME names the right shape in at most 3 lines.
7. **Report format**, capped at N lines: what landed, deviations from the plan, open items
   written into the task file's handoff section.

**A SUBAGENT NEVER BACKGROUNDS A COMMAND** – Every brief carries the foreground line from
Boundaries. Reason: two Sonnet units ended their turn waiting on a backgrounded gate, and the
work was simply unfinished; no recurrence once the line was in every brief.

**THE BRIEF RESTATES THE FINISH RULES** – A subagent does not read CLAUDE.md as the lead does,
so the brief carries them. Reason: briefs without them got back a dead export, an 8-line FIXME
and a workaround with no comment.

Agents given this shape report deviations (a changed type shape, a shifted migration number)
and write handoff notes into the task file without being asked.

**Plans pin numbers in queue order.** A plan that names a migration or version number assumed
its place in the queue; applied out of order, the real number is whatever the repo computes.
Tell the agent to amend the plan's sentence to the real number, never to pin the planned one.

## Running beside each other

- Reviews are read-only agents on a commit range, so they run safely beside implementers.
- Keep only reports in the lead's context. Never read a subagent's transcript. Read a diff
  yourself only for a small unit (~300 lines was fine; a change-sized diff goes to a reviewer).
- Sonnet on a Rust unit with the tests the tasks named came back green every time; Opus on a
  webview unit with no gate still needed the review. The split holds; the review is not
  optional for the gateless side.

**A WALK BRIEF FENCES ITS NEIGHBOURS** – A brief that runs the app kills by PID (never
`pkill -f`), picks its own port range, and names any single-session account it logs into.
Reason: one walk's `pkill -f` killed another worktree's dev server, and a single-session admin
account gets bounced by parallel walks.

**A TIMING RUNS ALONE** – A task that measures time runs with nothing else building, or labels
its number an upper bound. Reason: a cold build was timed beside four other builds.

## Watch: Opus 5.5 (the `opus` alias since Claude Code 2.1.280, 2026-09-23)

The rules above were earned on Opus 5 / Sonnet 5. The Opus 5.5 launch claims ~40% fewer
tokens per task, stronger honesty, fewer hard-to-reverse actions, clearer reports. Each is a
hypothesis; a rule relaxes only on evidence from a real run, recorded here with the run:
- Review budget (~130k): log actual Opus tokens per change-sized review.
  Run 2026-10-14 (UserPreference, six Sonnet units, ~1,300 lines): 137k — the budget holds.
- Gateless unit: did an Opus 5.5 implementer's unit pass review clean? Count findings.
  Run 2026-10-14: not tested, no implementer ran on Opus.
- Hand check: did any agent tick a hand-check box or claim a check it could not run?
  Run 2026-10-14: nine briefs, zero ticked, two `Hand check:` lines written unasked.
- Reports: did the capped report format hold without a reminder?
  Run 2026-10-14: held in nine of nine, with deviations and handoff lines unprompted.
Sonnet-side failures (the mock gate) stay as written until Sonnet 5.5 lands; repeat then. The
2026-10-14 ⛔ had the mock-gate shape but came from the brief and the spec, which both stated the
wrong rule; the agent built what it was told (see the spec-against-itself reason above).

## Watch: Haiku 5.5 (the `haiku` alias since Claude Code 2.1.293, 2026-10)

Haiku 5.5 lists at $0.10 / $0.50 per MTok for prompts under 100K tokens ($0.50 / $2.50 above),
1M context, and is the first Haiku with effort levels, default `medium`. That is one twentieth
of Sonnet 5.5 per token below 100K and one quarter above it, so a brief that reads a large repo
loses most of the discount. Anthropic's own framing: a subagent model for narrowly scoped work
(compaction, summaries, sweeps); Sonnet and Opus "remain better choices for complex agentic
coding" (Terminal-Bench 4.0: 39% vs 71%). Its prompting guide names two failure modes this
skill already guards against: at `low`/`medium` effort it reports a code change done without
running a check, and in a long agent prompt at `low` effort it stops early and hands the task
back. How the subscription quota weights Haiku tokens is unverified.

Until a run says otherwise, Haiku takes the **sweep tier** only: a unit whose brief fits one
screen, whose edit is a mapping (a rename, a re-tag by table, a data table built from JSON, a
grep-verify of another agent's sweep, a count), and whose gate is a command the lead reruns.
Brief it at effort `high`, require the gate's output quoted in the report, and never hand it a
spec-level unit. Each is a hypothesis; promote only on evidence recorded here with the run. Token spend per
agent and model comes from `scripts/model-watch.sh` (reads the session's subagent transcripts;
run it from the project dir after the run, or pass the session dir); the qualitative rows below
are the lead's own counts, written into the run's tasks.md as units land:
- Sweep: did the lead's own grep-verify after the unit find misses? Count them.
- Report: did it claim a check it did not run? The prompting guide says this is the known failure.
- Prompt size: did reading the repo push the brief past 100K and into the upper price tier?
- Trial: one of N parallel Sonnet build units on `haiku`; the Opus review counts findings per
  unit. Promote Haiku to build units only when its count matches Sonnet's across two runs.

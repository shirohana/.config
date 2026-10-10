---
name: goal-prompt
description: Generate a well-formed `/goal` command string for Claude Code's session-scoped autonomous-loop feature. Use when the user wants to set up an overnight or unattended /goal run and needs a condition prompt that the evaluator can reliably judge. Encodes the constraints from https://code.claude.com/docs/en/goal so the doc need not be re-fetched.
---

# `/goal` Prompt Generator

`/goal <condition>` makes Claude Code re-prompt itself after every turn until a small fast model judges the condition met. This skill produces the `<condition>` string.

## How /goal evaluates — the constraints you must design for

- **Up to 4000 characters.** Anything longer must go in repo files referenced by anchor (e.g. `see GOAL.md`, `see prompts/arte-v4/lora/GOAL.md`). The /goal prompt itself just states the condition + points at the anchor.
- **Evaluator only sees what's surfaced in the conversation.** It does not run commands or read files. So the condition must be *demonstrable in the transcript* — "tests pass" works because the test output lands in the transcript; "the file looks correct" does not.
- **Evaluator is a small fast model (default Haiku).** Phrase as something a small model can reliably judge: explicit deliverables, file paths, command outputs, named anchors. Avoid subjective quality calls.
- **Goal runs until met or cleared.** Include a turn or time clause (`or stop after 60 turns`, `or stop after 8 hours`) so it can't loop forever.
- **Restored on `--resume`/`--continue`.** Turn count, timer, token spend reset on resume. Condition carries.
- **Setting a goal starts the turn immediately** with the condition as the directive — no separate prompt needed.

## Anatomy of a strong /goal condition

```
<one-line headline of the deliverable>

ANCHOR: read <path/to/GOAL.md> + <path/to/PROGRESS.md> first; resume from PROGRESS state.

DONE when ALL of:
- <file or artifact that must exist, with path>
- <command output that must appear in transcript, with exact command>
- <measurable comparison: "report shows ≥X improvement over <baseline> on <suite>">
- <handoff doc updated: HANDOFF.md and memory written>

FAIL-CLOSED is also DONE: if blocked on <specific class of blocker>, write FAILURE.md
with root cause + what was tried + what the next session should attempt; then report.

CONSTRAINTS:
- <invariant that must hold across turns: "don't modify <file>", "stay in <dir>">
- <tooling caveat the model must remember: e.g. mlx-lm --resume-adapter-file is broken>

STOP after 80 turns or 8 hours, whichever first. Report progress against this each turn.
```

## What makes a condition *not* work

- **Subjective**: "the model sounds like Arte" → evaluator can't judge.
- **Unsurfaceable**: "the trained model is good" → no transcript signal. Restate as "the eval report at `<path>` is printed in the transcript and shows stress-pass ≥ 9/10".
- **Unbounded**: no turn/time clause → could loop indefinitely on a stuck phase.
- **No fail-closed**: blocking conditions trap the loop. Always allow a documented-failure exit.
- **No anchor for long context**: trying to cram all the design into the 4000-char condition. Push design into a repo file; reference it.

## The anchor pattern (for multi-phase overnight work)

For substantial runs (multi-hour, multi-phase), pair the condition with TWO files:

- **GOAL.md** (read-only design): phases, constraints, success criteria, tooling notes, anti-patterns. Static for the run.
- **PROGRESS.md** (writable resume log): current phase, last completed step, decisions made, blockers encountered. Updated by Claude each phase.
- **HANDOFF.md** (compaction insurance): condensed state — what's done, what's next, file paths, key decisions. Updated at phase boundaries so post-compaction Claude can pick up.

The /goal condition then says: "read GOAL.md + PROGRESS.md to resume; update PROGRESS.md as you go; update HANDOFF.md at phase boundaries; DONE when…".

## Recipe — turning a user ask into a /goal prompt

1. **Identify the deliverable.** Concrete artifact: a trained adapter file, an eval report, a passing test suite, a written doc.
2. **Identify what the evaluator can see.** What output, file path, or report would prove the deliverable is done? That's your DONE clause.
3. **Identify the blockers.** What known caveats could trap the loop? Encode as CONSTRAINTS.
4. **Budget the loop.** Pick turn + time caps that exceed expected run by ~50%.
5. **Decide the anchor depth.** If the design is >500 words, push it into GOAL.md and reference. If it's a one-shot task, inline.
6. **Add fail-closed exit.** What does "couldn't do it" look like as a deliverable? A FAILURE.md with diagnosis is still a result.
7. **Compose** under 4000 chars.

## Auto mode pairs well

Run with auto mode enabled (`/auto on` or session-level): the goal sets WHEN to stop, auto mode removes per-tool prompts so each turn runs unattended. This is the standard overnight setup.

## Non-interactive invocation

```bash
claude -p "/goal <condition>"
```

Runs the loop to completion in one invocation. Ctrl+C to interrupt.

## Quick reference

| Need | Mechanism |
|---|---|
| Set a goal | `/goal <condition>` |
| Check status | `/goal` (no args) |
| Clear early | `/goal clear` (or stop/off/reset/none/cancel) |
| Resume | `claude --resume` — goal restored |
| Headless | `claude -p "/goal <condition>"` |

## Example — well-formed overnight prompt

```
/goal Arte v4 LoRA training run COMPLETE: adapter trained, eval on v4 scenes shows fix of command-compliance residual.

ANCHOR: read prompts/arte-v4/lora/GOAL.md + prompts/arte-v4/lora/PROGRESS.md to resume.

DONE when ALL of:
- prompts/arte-v4/lora/adapters/v1/adapters.safetensors exists (mlx-lm output)
- prompts/arte-v4/lora/eval/REPORT.md exists, contents printed to transcript
- REPORT.md scorecard table shows stress-suite pass ≥ 9/10 (vs prompt-only v4 baseline ~8/10) OR documents why parity is the ceiling
- prompts/arte-v4/lora/HANDOFF.md updated with final state
- Memory updated: project_arte_qwen3erp_trial.md amended with v4-LoRA outcome

FAIL-CLOSED is also DONE: if blocked (MLX convert fails, training diverges, eval harness breaks), write FAILURE.md with root cause + diagnosis + what next session should try; print it.

CONSTRAINTS:
- mlx-lm --resume-adapter-file corrupts optimizer state — complete training in one shot
- Do not modify arte-v3/ files; new work goes in arte-v4/lora/
- Update PROGRESS.md at each phase boundary
- Update HANDOFF.md before any potentially-long-running command

STOP after 80 turns or 8 hours, whichever first.
```

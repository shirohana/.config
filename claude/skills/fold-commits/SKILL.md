---
name: fold-commits
description: Fold a branch's run of checkpoint commits into one well-authored commit whose message describes the codebase, not the run. Use when a unit of work is done and the user wants to "fold up the commits", squash checkpoints, or clean the branch before pushing or opening a PR.
allowed-tools: Bash, Read
---

# Fold Checkpoint Commits Into One

Checkpoint commits are deliberately run-narrative (AUTO COMMIT CHECKPOINTS). The fold has a
different job: one commit whose message says what changed, nothing more. A fold **rewrites**;
it never concatenates. Work locally. **Never push** — the user reviews and pushes.

Optional argument `$ARGUMENTS`: a base ref (`main`, a SHA) or an OpenSpec change name.
Given, it skips auto-detection.

## Procedure

### 1. Find the base

The range to fold is `<base>..HEAD`. Resolve `<base>` by the first rule that applies:

1. `$ARGUMENTS` is a git ref (`git rev-parse --verify -q "$ARGUMENTS^{commit}"`) → that is
   the base.
2. The repo has an `openspec/` dir (or `$ARGUMENTS` names a change) → the unit is one change
   and the base is the parent of its **propose commit**: the commit that added the change's
   proposal.md. Find it by path, not by subject — subject conventions differ per repo:
   ```
   git log --diff-filter=A --format=%h -- "openspec/changes/<name>/proposal.md"
   ```
   If `$ARGUMENTS` did not name the change, it is the change whose folder the most recent
   non-propose commit touched (`git log -5 --stat -- openspec/changes`); ask if unclear.
3. The branch has an open MR/PR → the base is its **target branch**, fetched first:
   ```
   git fetch origin "$target" && git merge-base HEAD "origin/$target"
   ```
   (`glab mr view --output json | jq -r .target_branch` or `gh pr view --json baseRefName`).
   A sprint or integration branch sits ahead of the default branch, so the merge-base with
   `main` reaches below it and the fold swallows the target's own commits — the tree stays
   right, so nothing fails; only the MR's commit list and diff grow.
4. Otherwise → the merge-base with the default branch:
   ```
   git merge-base HEAD "$(git symbolic-ref -q --short refs/remotes/origin/HEAD || echo main)"
   ```
   If `HEAD` *is* the default branch, or the merge-base is `HEAD`, stop and ask for a base —
   there is nothing unambiguous to fold.

Whichever rule applied, print `git rev-list --count <base>..HEAD` and read it: a count larger
than the checkpoints you made is the wrong base, not a bigger unit.

Confirm the working tree is clean (`git status --porcelain`). If not, stop and tell the user
to commit or discard first — fold operates on committed checkpoints only.

### 2. Guard the range — STOP if it is not one unit

```
git log --oneline --no-merges <base>..HEAD
git log --oneline --merges    <base>..HEAD
```

- Any merge commit in the range → stop. A fold of merges needs a manual rebase.
- Every commit must belong to **this one unit**, with one exception — the **queue** (below).
  Elsewhere: subjects that plainly reference two different features or tickets mean
  interleaving. Report it and stop — separating interleaved history is out of scope.

**The queue.** OpenSpec repos may plan every change first and apply them in order. Unapplied
changes then sit on the branch as plan-only commits, like a queue of unmerged PRs at the tip.
Classify every commit in the range by the paths it touches (`git show --stat --format=`):

- **unit** — touches the unit's own paths and no other change's folder;
- **queue** — touches only `openspec/changes/<other>/` folders (a propose commit bundling
  several changes counts, so does a later amendment to a queued plan);
- anything else, or a commit that is both → interleaving, stop.

A queue means the range is not one unit yet. Do not fold across it — make it contiguous
first (step 5).

### 3. Back up before rewriting

```
git branch backup/fold-<short-sha-of-HEAD>
```

Tell the user the backup ref and the restore command
(`git reset --hard backup/fold-<short-sha>`). Never delete the backup yourself.

### 4. Learn what the code now does — then author the message

This is the important step. Do **not** read the checkpoint subjects to write the message.
Read the result:

```
git diff <base>..HEAD --stat
git diff <base>..HEAD          # the substantive hunks
```

Read the intent too, where it exists: the OpenSpec `proposal.md` / `tasks.md` for the change
(live or archived copy), a spec or ticket the branch references, the project CLAUDE.md.

**Subject format** — detect, don't assume, in this order: the project CLAUDE.md's documented
convention; the pattern in `git log --oneline -20` on the default branch; OpenSpec repos use
`feat(<change-name>): …`. Ask if it is still unclear. Imperative mood; the subject states the
change.

**Body** — usually none. Add one only when the subject cannot list what changed: several
files with distinct changes, one line each. Never rationale, alternatives, what you
deliberately left, or how you got there — that belongs in the code, the spec, or the README.
A message is a log for tracing, not a record; a reason parked there stays unread. No
`Co-Authored-By` or "Generated with" trailer.

### 5. Fold

Write the message to a temp file, soft-reset, commit once:

```
git reset --soft <base>
git commit -F <message-file>
```

`reset --soft` keeps every file change staged; the single commit re-records the whole range.
Interactive rebase is unavailable in this environment — this is the deliberate substitute.

**Conflicts are never the lead's to resolve.** On a conflict, classify it before touching
anything. A *union* conflict — both sides add entries to the same list (a dependency, a
registration, an import, a note) and keeping both is the whole answer — goes to a cheap
subagent (`sonnet`) with the file, the marker block and the gate: the rebase then completes,
`git diff --stat <backup> HEAD` prints nothing, and the project gate is green on the folded
commit. Anything else — a function body, a component's markup, a test, a file one side
created, deleted or renamed — means the unit is not ready to move: `git rebase --abort`,
restore the backup, name the commit and the file it conflicted on, and wait for the user's
call. Never hand-edit a conflict marker yourself, never re-express one side against code it
never saw, and never relocate commits between units to make them apply. Reason: a fix written
against another change's code is a dependency, and no rebase moves past one; the lead's
tokens go to the decision, not to the merge.

**With a queue** (step 2), do not fold across it, and never strip the other changes' plans
out of the squash to replay them afterwards. Replaying rewrites commits that had nothing wrong
with them, and every replayed commit is a chance to lose a message, a date or a file.

Make the unit contiguous instead, then fold it as a plain squash of adjacent commits, which
cannot reach anything outside itself. Interactive rebase is unavailable here, so stop and ask
the user to move the queue's plan-only commits below the unit's propose commit — that reorder
is theirs — naming the base you would then use (`<propose>^`) so the move has a target. When
they hand it back, re-guard the range from step 2 and fold with the plain form above. They
move the queue back to the tip themselves afterwards.

`git diff --stat <backup-ref> HEAD` must print nothing: the fold moves history, never the
tree. The backup from step 3 is the pre-fold HEAD.

### 6. Verify and report — do not push

```
git log --oneline -5
git status
```

Restate: what folded (range, count), the new commit's subject, the backup ref. Stop — the
user reviews and pushes or opens the PR.

## Notes

- **Fold only.** No archiving, no pushing, no branch deletion.
- OpenSpec: one commit per change. The propose docs, every apply checkpoint and the
  `spec(archive)` bookkeeping all collapse into the one commit, so fold **after** the change
  is archived — a plan-only or apply-only commit is a half-merged PR. The net tree is right
  automatically — only the archived `openspec/changes/archive/...` path and updated
  `openspec/specs/**` remain. A fold done before archive is refolded once the archive lands.
- The remote is not a reason to keep a commit unfolded — the user decides what a force-push
  costs. A tag is: never fold across a tagged commit.

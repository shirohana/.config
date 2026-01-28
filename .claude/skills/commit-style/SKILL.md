---
name: commit-style
description: Commit message conventions and format. Use when creating git commits or reviewing commit messages.
disable-model-invocation: true
---

# THE COMMIT MESSAGE LAW

## THE RULE
Single line. Imperative mood. Aim for 50 characters, max 72.
State WHAT changed, not WHY or HOW.

## FORMAT DETECTION
Project format varies. Check before committing:
1. Project CLAUDE.md for documented format
2. `git log --oneline -10` for recent patterns
3. Ask if unclear

Common patterns:
- `feat: Add feature` (conventional commits)
- `Add feature` (plain verb)

## EXAMPLES
GOOD:
- `Add dark mode toggle`
- `Fix lightbox navigation`
- `Extract shared logic`

BAD:
- `Add dark mode toggle component to settings...`
- `Added support for dark mode`
- `Refactored for better maintainability`

## THE WHY
Diffs tell the story.
Commit message states the change.
History is scannable.
Long messages hide the change.

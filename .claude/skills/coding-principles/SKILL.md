---
name: coding-principles
description: Code philosophy for writing, modifying, or refactoring code. Use when implementing features, fixing bugs, or reviewing code quality. Covers happy-path-first development, zero duplication, and single source of truth.
---

# THE MAKE IT WORK FIRST FIELD GUIDE

## CORE TRUTH
Defensive code before functionality is theater.
Prove it works. Then protect it.

## THE RULES
1. Build the Happy Path First – Code that DOES the thing
2. No Theoretical Defenses – Naked first version
3. Learn from Real Failures – Fix reality, not ghosts
4. Guard Only What Breaks – Add checks only for facts
5. Keep the Engine Visible – Action, not paranoia

## EXCEPTIONS
Security boundaries require defenses from the start:
- Authentication & authorization
- Input sanitization (XSS, SQL injection, command injection)
- Cryptography & key handling
- User-facing error messages (errors ARE the feature)
- System boundaries (external APIs, user input)

## ANTI-PATTERNS TO BURN
- Fortress Validation
- Defensive Exit Theater
- Connection State Paranoia

## PATTERNS TO LIVE BY
- Direct Execution
- Natural Failure
- Continuous Progress

## THE TEST
Can someone grok your code in 10 seconds?
YES → You lived the manifesto
NO  → Delete defenses

---

# THE ZERO DUPLICATION LAW

## CORE TRUTH
Duplicated logic creates blind spots.
One fix leaves the other broken.
Even AI misses duplicates.

## THE RULES
1. Same Logic Twice = Extract Once – No exceptions
2. Before Adding Feature – Grep for similar patterns
3. After Fixing Bug – Search for same logic elsewhere
4. When Refactoring – Kill all copies, keep one source
5. Complex Logic (>20 lines) – Extract immediately

## AI PREVENTION PROTOCOL
Before writing any logic >10 lines, MANDATORY steps:
1. Grep for similar function/method names
2. Grep for key domain terms in the logic
3. Read matching files to verify
4. Found existing? Extend/reuse it - NEVER duplicate
5. Nothing found? Write once, make it reusable from the start

NOT OPTIONAL. NOT AFTER. BEFORE EVERY WRITE.

## DUPLICATION SIGNALS
- "Also update the other one"
- Copy-paste with minor changes
- Bug fixed in one place, appears elsewhere
- Two functions with similar names doing same thing

## EXTRACT THRESHOLDS
- **Identical logic 2+ times** → Extract now
- **Similar logic 2+ times** → Extract if >20 lines
- **Simple logic 2+ times** → Extract if >3 times
- **UI event handlers** → Extract if same pattern appears

## THE TEST
Will a bug fix in one place leave the other broken?
YES → You have duplication
NO  → You passed

---

# THE SINGLE SOURCE OF TRUTH LAW

## CORE TRUTH
Duplicated state creates sync bugs.
One truth updates, the other goes stale.
Even you can't track all copies.

## THE RULES
1. One Canonical Source – Pick one place for each piece of state
2. Derived State is Computed – Calculate from source, don't cache
3. Views Reflect State – UI/output reads from state, not the reverse
4. Before Adding State – Ask "Can I compute this from existing state?"
5. Sync is a Code Smell – If you're syncing two things, one shouldn't exist

## DUPLICATION SIGNALS
- "Keep X and Y in sync"
- `previousX` or `cachedX` state variables
- Update handlers that copy state to another location
- Comments like "Make sure to also update..."

## THE TEST
If state A changes, does state B need manual updating?
YES → You have duplicate state
NO  → You passed

Can you derive B from A instantly?
YES → Delete B, compute it
NO  → Maybe B is the true source

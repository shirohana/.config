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

## ANTI-PATTERNS TO BURN
❌ Fortress Validation
❌ Defensive Exit Theater
❌ Connection State Paranoia

## PATTERNS TO LIVE BY
✅ Direct Execution
✅ Natural Failure
✅ Continuous Progress

## THE TEST
Can someone grok your code in 10 seconds?
YES → You lived the manifesto
NO  → Delete defenses

## THE PROMISE
Readable. Debuggable. Maintainable. Honest.

## THE METAPHOR
Don’t bolt on airbags before the engine runs.
First: make it move.
Then: guard against real crashes.

MAKE IT WORK FIRST.
MAKE IT WORK ALWAYS.
GUARDS EARN THEIR KEEP.

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

## DUPLICATION SIGNALS
⚠️ "Also update the other one"
⚠️ Copy-paste with minor changes
⚠️ Bug fixed in one place, appears elsewhere
⚠️ Two functions with similar names doing same thing

## EXTRACT THRESHOLDS
- **Identical logic 2+ times** → Extract now
- **Similar logic 2+ times** → Extract if >20 lines
- **Simple logic 2+ times** → Extract if >3 times
- **UI event handlers** → Extract if same pattern appears

## THE TEST
Will a bug fix in one place leave the other broken?
YES → You have duplication
NO  → You passed

## THE PROMISE
Fix once. Works everywhere.
One source of truth. No hidden bugs.

## THE METAPHOR
Duplicated code is like parallel universes:
Fix one, the other still broken.
You can't track them all.
Collapse them into one reality.

ONE TRUTH. ZERO COPIES.
EXTRACT DON'T REPEAT.
AI CANNOT SEE ALL DUPLICATES.

---

# THE SINGLE SOURCE OF TRUTH LAW

## CORE TRUTH
Duplicated state creates sync bugs.
One truth updates, the other goes stale.
Even you can't track all copies.

## THE RULES
1. One Canonical Source – Pick one place for each piece of state
2. Derived State is Computed – Calculate from source, don't cache
3. DOM Reflects State – UI reads from state, not the reverse
4. Before Adding State – Ask "Can I compute this from existing state?"
5. Sync is a Code Smell – If you're syncing two things, one shouldn't exist

## DUPLICATION SIGNALS
⚠️ "Keep X and Y in sync"
⚠️ `previousX` or `cachedX` state variables
⚠️ Update handlers that copy state to another location
⚠️ Comments like "Make sure to also update..."

## THE TEST
If state A changes, does state B need manual updating?
YES → You have duplicate state
NO  → You passed

Can you derive B from A instantly?
YES → Delete B, compute it
NO  → Maybe B is the true source

## THE PROMISE
Change once. Stays consistent.
No sync bugs. No stale data.

## THE METAPHOR
Duplicate state is like two clocks:
One updates, the other drifts.
You can't keep them in sync forever.
Pick one clock. Throw out the other.

ONE SOURCE. ZERO COPIES.
COMPUTE DON'T CACHE.
STATE THAT SYNCS IS STATE THAT BREAKS.

---

# THE COMMIT MESSAGE LAW

## THE RULE
Single line. Imperative mood. Under 50 characters.
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
✅ `Add dark mode toggle`
✅ `Fix lightbox navigation`
✅ `Extract shared logic`

❌ `Add dark mode toggle component to settings...`
❌ `Added support for dark mode`
❌ `Refactored for better maintainability`

## THE WHY
Diffs tell the story.
Commit message states the change.
History is scannable.
Long messages hide the change.

SHORT COMMITS. CLEAR VERBS. SCANNABLE HISTORY.
PRINCIPLES ARE UNIVERSAL. FORMAT FOLLOWS PROJECT.

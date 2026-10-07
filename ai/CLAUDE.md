@~/.agents/AGENTS.md

# Claude Code specific

Shared instructions live in ~/.agents/AGENTS.md (imported above). Only rules
that depend on Claude Code features belong in this file.

## Speed (Opus models)

When running as an Opus model: optimize for wall-clock speed. Finish tasks quickly.

- Parallelize aggressively. Independent tasks run at the same time, never one after another — batch tool calls, spawn subagents concurrently.
- Delegate by complexity: Sonnet subagents for routine work (search, bulk edits, boilerplate, verification), Opus subagents for hard reasoning that can run independently.
- Keep working in the main thread while subagents run — don't sit idle waiting on them.
- Don't over-deliberate. Enough info to act = act. No long option surveys for decisions with an obvious default.
- Speed never trades away quality: same rigor, same verification, same "done means done". If parallelizing risks a worse result, slow down.
- No conflicts from parallelism: never let two subagents touch the same files or overlapping scope. Split work by non-overlapping boundaries; merge and reconcile results in the main thread.

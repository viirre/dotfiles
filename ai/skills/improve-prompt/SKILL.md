---
name: improve-prompt
description: Rewrite a draft prompt into a sharper, more complete prompt before it is run, based on how Victor writes and what his prompts typically miss. Use when the user asks to improve, refine, or rewrite a prompt, or triggers "/improve-prompt", "improve this prompt", "förbättra prompten", "fixa prompten".
---

# Improve a prompt

Take the draft prompt given as the argument (or pasted in the message) and rewrite it into the prompt Victor should have written. Output the improved prompt, do not execute the task it describes. This profile is built from analysis of his real sessions, so apply it even when a rule seems pedantic.

## How Victor writes (normalize vs. keep)

He writes terse, bilingual (Swedish for domain/UI/bugs, English for code/infra/git), lowercase, and full of fast-typing typos ("reviwer", "culrpit", "prodiuction"). That is fine. Keep the draft's language and his voice.

- **Silently fix:** spelling, transpositions, misspelled agent/skill names (fuzzy-match: "laravel-code-reviwer" means laravel-code-reviewer), trailing stray characters ("+" for "?").
- **Never silently fix, flag instead:** anything that flips meaning. Negations ("does have" where context suggests "does not"), version numbers ("v8" next to a v9 guide link), "not with Vite" vs "now with Vite". Put these under Flagged in your output and ask.
- **Keep as-is (his strengths):** @file#line anchors, PR numbers, repro URLs, Flare error blocks, named agents/skills, scope fences ("Förändra inget på servern"), plan gates ("let me verify the plan before executing"), severity thresholds ("only must and should"), parallel-session warnings ("i am doing other work in another session").

## The transformations

Apply every one that fits. The recurring waste in his sessions comes from exactly these gaps.

### 1. Tag the mode

His single biggest gap. Every improved prompt starts with one explicit mode line:

- **Question** ("Svara bara, implementera inget.") Ambiguous "should we X?" / "would it be a good idea to...?" defaults to question. His standing rule: a question is a question.
- **Plan first** ("Gör en plan jag får godkänna innan du implementerar.")
- **Implement** (and whether to commit: his rule is never commit unless told, and if committing to a new branch, stay on it).
- **Implement + PR** (branch name, base branch master vs develop, use the create-pr skill).

### 2. Pin every referent

"fix 1 and 3", "fix them all", "it", "den", "this PR" depend on context that may not survive compaction or a new session. Expand each referent by quoting the actual finding, file, or PR inline. If you cannot resolve a referent from the current conversation, add it to the questions in step 7 instead of guessing.

### 3. Add a state block

He holds decisive environment facts in his head and releases them only after the first wrong theory (Forge config overrides, what is merged where, version floors, "the fix branch is only on local"). For any bugfix, upgrade, refactor, or infra task, the improved prompt gets a state section. Fill in what the draft or conversation already tells you; everything else becomes a question in step 7:

- Environment: prod / QA / local (which URL or host).
- Branch: name, base branch, checked out locally or not, clean or dirty, what is already merged to develop/master, whether work lives in an unmerged PR (then: edit that PR's own migrations/commits, do not add new ones).
- Version floors and constraints (PHP syntax floor, illuminate baseline, Node version).
- What changed recently, and what he has already checked or ruled out.

### 4. Force the end state

His corrections are almost all missing-acceptance-criteria leaks (wrong radio variant, missing env-configurability, "no CodeIgniter partials left" stated after the fact). Add an explicit "Klart när / Done when" line:

- Bugs: expected behavior, not just the symptom.
- UI work: reference page or component for the desired look, viewport, dark and light mode, and whether the fix applies to all instances or just the one named.
- Refactors: the hard end-state constraint ("what must be true when this is done?").

### 5. Separate facts from guesses

He mixes verified facts with hypotheses ("i think because we updated Redis", "Gissar att..."). Restructure into "Verifierat:" and "Min gissning:" and instruct the agent to verify the premise before building on it. His premises are sometimes wrong, and so is his memory of dashboards; one round of verification is cheaper than a wrong-path investigation.

### 6. Split bundled asks

"Två grejer" prompts often contain three, spanning unrelated PRs. Split into a numbered list, each item with its own mode and done-condition, and state which items belong in the current PR versus a separate one. Order them if there is a dependency.

### 7. Ask instead of assume

If the task needs input the draft does not give, do not have the agent guess. Append a section to the improved prompt:

```
Innan du börjar, fråga mig om:
1. <missing input> (a: ..., b: ..., c: ...)
2. ...
```

Batch all questions into one message and offer multiple-choice options where possible; he happily answers "a" or "2" but will not volunteer detail unprompted. Typical missing inputs: Flare URL for a prod bug (one almost always exists), CI run link and failing test names, Favro card, screenshot, repro steps, which shop/tenant, data volume for seeding, where credentials live (1Password; the agent asks him to run commands, never asks for secret values). For ticket work, always include "fråga mig om något är oklart".

### 8. Bake in standing rules where relevant

Only the ones the task type touches:

- Reviews: name the agent (laravel-code-reviewer for local, laravel-pr-reviewer for GitHub), state checked-out status, severity policy ("ignore nitpicks" unless he says otherwise), the gate (show findings to him before posting to GitHub, include severity labels), and the loop form he likes: "fix all MUST and SHOULD that don't need my decision, ask me about the rest, re-review until clean".
- Subagent output: relay full reports verbatim, never filtered.
- PR mechanics: title in English, body short in Swedish sounding like him, Favro/Flare link in body, no Test plan section.
- Browser work: use the agent-browser skill, not built-in browser tools; screenshots to `.agent-screenshots`.
- Servers/infra: read-only fence unless he grants writes; check reversibility before anything destructive.
- Parallel work: if the task touches files he may be editing in another session, the prompt should tell the agent to ask before touching shared state.

### 9. Credential hygiene

If the draft contains a pasted password, token, or tokenized URL, remove it from the improved prompt, note it under Flagged, and replace with the pattern he already uses: "finns i 1Password, be mig köra kommandon vid behov".

## Output format

1. The improved prompt in a single fenced code block, ready to paste. His language, his voice, no filler.
2. **Flagged:** only meaning-bearing items needing his confirmation (polarity typos, unresolved referents, removed credentials, a guessed mode). Omit the section if empty. Do not list routine typo fixes.
3. Nothing else. Do not run the task. If he replies "kör" or "go", execute the improved prompt as written.

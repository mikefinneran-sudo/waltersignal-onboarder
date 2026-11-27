# Tests

This folder tests whether the onboarder does what the contest asks: it answers from the folder,
never invents an answer, routes what it cannot answer to the right title, and paces the day.

## How the Test Works

1. **Build the prompt.** `lib/build_prompt.sh` turns the folder into the system prompt a Claude
   project would see: `identity.md` and `rules.md` as instructions, then every knowledge file.
2. **Ask a new-hire question.** `lib/ask.sh` sends one question from `questions.tsv` to the
   onboarder (Sonnet). Each call runs in an empty directory, with no settings files and no tools,
   so nothing outside the folder can reach the model.
3. **Grade it blind.** `lib/grade.sh` gives a separate grader (Opus) the full folder as ground
   truth, the question, the reply, and a PASS or FAIL criterion for the question's category.
   Every category fails on any fact that is not in the folder.
4. **Play a full day.** `lib/convo.sh` plays the eight turns in `conversation.txt` as one
   resumed conversation, then grades every turn.
5. **Score it.** `lib/score.sh` counts passes by category.

Every question is asked three times, because the same question can get a different answer.

## Question Categories

| Code | Category | Passes When |
|---|---|---|
| T | Trap | The answer is not in the folder. The reply says so, names the owning title, and invents nothing. |
| A | Answerable | The answer is in the folder. The reply gives it, not just "ask someone." |
| P | Pacing | The reply gives at most three new items and says when the rest comes. |
| C | Coverage | The reply gives a real, specific answer a new hire needs (start time, objections, scorecard). |
| R | Routing | The reply routes to the exact owner in `key.tsv`, not a generic "ask the founder." |

## Files

| File | Job |
|---|---|
| `run.sh` | Runs the whole suite against one folder and prints the score |
| `questions.tsv` | 13 questions: ID, then the question; most say which day the hire is on |
| `key.tsv` | The correct owner for each routing question |
| `conversation.txt` | The eight turns of the multi-turn day-one test |
| `lib/` | The five steps above, one script each |
| `results/baseline-c112c16/` | Raw replies and grades for the first version of the folder |
| `results/v4695c84/` | Raw replies and grades for commit `4695c84`, before `meetings.md` |
| `results/current/` | Raw replies and grades for this version |

## How to Run It

Requires the Claude Code CLI (`claude`), signed in. From the repo root:

```
tests/run.sh                          # test this folder; results go to tests/results/current
tests/run.sh path/to/folder other     # test another folder; results go to tests/results/other
RUNS=1 CONVOS=1 tests/run.sh          # a quicker, cheaper pass
```

A full run makes about 200 model calls. Any grade line that is neither PASS nor FAIL is a grader
call that failed, and `score.sh` lists it as UNGRADED so it can be regraded.

## Scores

The folder was rescoped to day one only. Earlier scores described a ten-day, 90-day folder and no longer apply. Results for the day-one folder are not yet recorded here.

The question set was cut from 37 to 13 questions: 24 asked about content that is now out of scope (days after day one, objections, discovery, case studies, proposals-related facts, pipeline reviews, later-day routing). `lib/roleplay.sh` and the objections checks in `lib/det.py` apply to a file that no longer exists; run `quality.sh` with `NOROLE=1`.

## How the Folder Was Improved

Each round ran the full test, read every FAIL, and changed the folder only where a reply showed a
real gap. Examples of fixes that came from a failed test:

- A guessed answer ("probably in your offer letter") led to the rule against guessing where,
  when, or how a missing answer will come.
- A reply that added its own "urgent" cases led to limiting interruptions to the two listed cases.
- A reply that said "more later" led to the rule that every held-back item names its module or day.
- The routing score of 0/18 led to the org chart in `reference/who-owns-what.md`.

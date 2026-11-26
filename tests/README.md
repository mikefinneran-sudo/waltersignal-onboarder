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
| `questions.tsv` | 30 questions: ID, then the question; most say which day the hire is on |
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

| Category | Baseline (`c112c16`) | `4695c84` | `b03dc24` | Current (`256954d`) |
|---|---|---|---|---|
| T Trap | 30/30 | 30/30 | 31/33 | 34/36 |
| A Answerable | 18/18 | 18/18 | 21/21 | 24/27 |
| P Pacing | 6/6 | 6/6 | 6/6 | 4/6 |
| C Coverage | 15/18 | 17/18 | 19/21 | 23/24 |
| R Routing | 0/18 | 17/18 | 18/18 | 18/18 |
| **Single-turn total** | **69/90** | **88/90** | **95/99** | **103/111** |
| **Multi-turn turns** | **11/16** (2 runs) | **21/24** (3 runs) | **21/24** (3 runs) | **21/24** (3 runs) |

The baseline routed every question to the founder by name, so it failed every routing question.
`4695c84` routes by title on the org chart. `b03dc24` adds `reference/meetings.md` and three
questions about it (T11, C7, A7), which pass 9/9. `256954d` rewrites the folder around a
fictional WalterSignal (ten-day goals, services and prices, second brain) and rewrites the
questions to match, so its scores are not a like-for-like comparison with earlier columns.

## Misses Still Open

These are the misses from the current run, as the grader wrote them. They are left in on purpose
so the next edit has a target.

- **A5 (run 1):** "Job posts for dispatchers or office staff often name the champion" generalizes
  beyond the folder's single practice example.
- **A6 (runs 1 and 3):** claimed the Head of Sales will guide the first one, which the folder does
  not say; once sent a non-urgent question to Slack, which is reserved for the two urgent cases.
- **C5 (run 1):** said brief 3 is due "tomorrow, day 6," but day 5 is Friday and day 6 is Monday.
- **P1 (runs 2 and 3):** once said the only meeting today is the 4:00 check-in, contradicting the
  9:00 welcome call; once gave Continuing Education topics without their numbers and weeks.
- **T1 (run 2):** invented a third interrupt path (Slack if blocked), breaking the two-case rule.
- **T3 (run 1):** said the number is not in the notes but named no owning title.
- **Multi-turn, turn 3:** dropped one fit signal and led with not-fit cases, which are module 2.
- **Multi-turn, turn 5:** guessed that tomorrow's goals arrive after the check-in.
- **Multi-turn, turn 8:** said module 2 finishes today and implied module 1 is signed off today;
  both happen on day 2.

## How the Folder Was Improved

Each round ran the full test, read every FAIL, and changed the folder only where a reply showed a
real gap. Examples of fixes that came from a failed test:

- A guessed answer ("probably in your offer letter") led to the rule against guessing where,
  when, or how a missing answer will come.
- A reply that added its own "urgent" cases led to limiting interruptions to the two listed cases.
- A reply that said "more later" led to the rule that every held-back item names its module or day.
- The routing score of 0/18 led to the org chart in `reference/who-owns-what.md`.

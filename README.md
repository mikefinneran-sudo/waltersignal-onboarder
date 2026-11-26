# WalterSignal Sales Executive Onboarder

A folder that gets a new Sales Executive through their first day, and their first 90, at
WalterSignal: a small AI and software consultancy in Fort Wayne, Indiana. Drop it into a Claude
project and Claude becomes the colleague who has been there since the first client. It answers
from this folder, sends you to the right title on the org chart when the answer is not here, and
paces the day so you are never handed the whole handbook at once.

## Who This Is For

The first salesperson WalterSignal hires. You probably know how to sell. You do not yet know this
company's message, its two buyers, its offers, or its rules. That is what this folder covers.

## How to Start

1. Create a Claude project and add every file in this folder, including `reference/`.
2. Paste the contents of `identity.md` and `rules.md` into the project instructions.
3. Start a chat with: "Hi, it's my first day."

The onboarder asks what you have sold before and builds from there.

## What to Ask First

1. "What does my first day look like, hour by hour?"
2. "What's the one thing everything here comes back to?"
3. "What do I need to finish before I'm launched?"
4. "Who do I ask when you don't know?"

## How It Is Built

| File | Job |
|---|---|
| `identity.md` | Who the onboarder is, the business, the role, and what is out of scope |
| `rules.md` | How it answers, what it does when it does not know, how it routes by title, how it paces the day |
| `examples.md` | Three short exchanges, including one the folder cannot answer |
| `reference/first-day.md` | Day one, hour by hour, and the day-one checklist |
| `reference/syllabus.md` | Six Initial Training modules with milestones, the Launch Gate, and six Continuing Education modules through day 90 |
| `reference/expectations.md` | Four tiers: what is expected, what is not, and a scorecard for each |
| `reference/who-owns-what.md` | The org chart and which title owns which question |
| `reference/meetings.md` | The daily check-in, weekly 1:1, and weekly pipeline review: when each starts and its agenda |
| `reference/the-message.md` | The one line, the arc, and what never to say |
| `reference/buyers.md` | The two buyers and the three qualifying questions |
| `reference/offers.md` | What WalterSignal sells and which prices may be said out loud |
| `reference/sales-process.md` | The discovery call, CRM stages, proposals, and what happens after a yes |
| `reference/discovery-questions.md` | The question bank for a discovery call |
| `reference/objections.md` | Nine common objections: what is underneath, what to say, when to route |
| `reference/case-study.md` | One live build, told so a new hire can use it on a call |
| `reference/templates.md` | Research brief, call note, and follow-up email, each with an example |
| `reference/tools.md` | What each tool is for and which page to send a buyer to |
| `reference/question-log.md` | Every question the onboarder could not answer, and where the answer was added |
| `tests/` | The questions used to test the onboarder, and the scores |

## Design Principles

- **Simplicity is the message.** The company's pitch is one line. The onboarder's answers are
  short.
- **A clear syllabus.** Six modules, each with a milestone the Head of Sales signs off, end at a
  Launch Gate into production on day 10. Six Continuing Education modules follow through day 90.
- **Tiered expectations.** Four tiers, each listing what is and is not expected, with a
  scorecard. Crawl, walk, run.
- **Classic training practice.** Start from what the learner knows, three items at a time, and
  tell, show, do, check.
- **Route by title.** Every question has an owner on the org chart, so the folder stays right as
  the team grows.
- **No invented answers.** If it is not in `reference/`, the onboarder says so and names the
  owning title. The question goes in the log, and the answer goes into the folder.

## How It Was Tested

`tests/` asks the onboarder 33 new-hire questions three times each and plays a full day-one
conversation, then has a separate model grade every reply against this folder. The first version
scored 69/90 on 30 questions; this version scores 95/99 on 33, and routing went from 0/18 to
18/18. Method, raw
replies, and the misses still open are in `tests/README.md`. Run it with `tests/run.sh`.

## Keeping It Current

Prices and facts are taken from waltersignal.io as of November 2026. Internal pricing that is not
public is deliberately left out; the onboarder routes those questions to the Founder & CEO. Each
answered question in `reference/question-log.md` is added to the right reference file.

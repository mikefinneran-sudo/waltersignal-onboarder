# WalterSignal Sales Executive Onboarder

A folder that gets a new Sales Executive through their first day at WalterSignal: a fictional
14-person software and AI consultancy that does client work for established small and mid-sized
businesses. Load it into a project in the Claude desktop app and Claude becomes the colleague who
has been there since the first client. It answers from this folder and sends you to the right
title on the org chart when the answer is not here.

WalterSignal, its clients, its prices, and its people are made up for this exercise.

## Scope

Day one only, in four two-hour blocks:

1. **Philosophy and company and product overview:** the four-part Core Philosophy, real solutions
   not hype, and the idea that sales is organized persistence, explained in the new hire's own
   words.
2. **Competitive landscape and gaps:** four categories of alternatives and where each falls short.
3. **Compensation structure and goals:** led by the Head of Sales; the standard plan as percentages
   (60/40 pay mix, monthly commission only, quarterly and annual bonuses on quota), with no dollar figures.
4. **Outbound campaign build:** a target list, a message, and a follow-up sequence, built and
   submitted for approval; nothing is sent on day one.

Two mentors share the day: the Revenue Operations leader in the morning blocks (what you need to
work at all) and the Solutions Engineering leader in Block 4 (what you need to sell honestly). The
Head of Sales is the manager, leads Block 3, and runs the 4:00 PM check-in. With each mentor, the
new hire watches first, then tries with the mentor guiding. Expectations are tiered Must, Should,
and Could. Anything past day one is out of scope: the onboarder says so and names the owning title.

## Who This Is For

The first salesperson WalterSignal hires. You probably know how to sell. You do not yet know this
company's pitch, who it sells to, what it sells, its tools, or who owns which question. That is
what day one covers.

## How to Start (Claude Desktop App)

1. Open the Claude desktop app and choose **Projects**, then **Create project**. Name it
   "WalterSignal Onboarder."
2. Open the project's **Instructions**. Paste the contents of `identity.md`, then the contents of
   `rules.md`, and save.
3. In the project's **Files** (project knowledge), upload `examples.md` and every file in
   `reference/`. Do not upload `tests/` or this README; `tests/` holds the answer key.
4. Start a new chat in the project with: "Hi, it's my first day."

Nothing else is needed: no connectors, no code, no other tools.

## What to Ask First

1. "What do I need to get done today?"
2. "What's our pitch?"
3. "Who are our clients, and who do I talk to inside them?"
4. "What do I need to finish before the check-in?"
5. "Who do I ask when you don't know?"

## How It Is Built

| File | Goes in | Job |
|---|---|---|
| `identity.md` | Instructions | Who the onboarder is, the business, the role, and what is out of scope |
| `rules.md` | Instructions | How it answers, what it does when it does not know, how it routes by title, how it holds to day one |
| `examples.md` | Files | Nine exchanges, including a miss, a question past day one, one the folder cannot answer, and the mentor hand-off |
| `reference/first-day.md` | Files | The four blocks of day one, the two mentors, and a "done looks like" line for each block |
| `reference/expectations.md` | Files | Three tiers (Must, Should, Could) with a scorecard for each |
| `reference/campaign.md` | Files | How to build the first outbound campaign: target list, message, and dated follow-up sequence. Built and submitted for approval; nothing is sent on day one |
| `reference/compensation.md` | Files | How a Sales Executive is paid under the standard plan (60/40 pay mix, flat monthly commission, quarterly and annual bonuses on quota) and the day-one goals; percentages only, no dollar figures |
| `reference/landscape.md` | Files | The four categories of alternatives a prospect weighs and the four gaps each leaves, mapped to the Core Philosophy |
| `reference/the-message.md` | Files | The four-part Core Philosophy, the company and product overview, the 30-second pitch, the four parts of the first two minutes, and what never to say |
| `reference/clients.md` | Files | Who is a good-fit client, who to talk to inside one, and what is not a fit |
| `reference/what-we-sell.md` | Files | The three phases, Support Plans, and every price; none is quoted on day one |
| `reference/meetings.md` | Files | The three day-one meetings |
| `reference/tools.md` | Files | The 8 tools to open on day one |
| `reference/who-owns-what.md` | Files | Who reports to whom and which title owns which question |
| `reference/glossary.md` | Files | The company terms heard on day one |
| `reference/question-log.md` | Files | Every question the onboarder could not answer, and where the answer was added |
| `tests/` | Stays on GitHub, never in the project | The test questions, answer key, and graders; kept out so the onboarder cannot see the answers |

## Design Principles

- **Complete, accurate answers.** The onboarder answers the question asked in full, from the
  folder, organized into lists or tables, with no filler.
- **Four blocks, not a schedule.** Each block has one goal and a "done looks like" line. Only the
  welcome call, account setup, and the 4:00 PM check-in have fixed times.
- **One simple message.** The 30-second pitch carries one idea, one proof, and one question.
- **Tiered expectations.** Must, Should, and Could, each with a scorecard.
- **Classic training practice.** Model (I do), guided (we do), independent (you do), then feedback
  against a stated threshold.
- **Route by title.** Every question has an owner on the org chart, and anything past day one is
  routed rather than answered.
- **No invented answers.** If it is not in `reference/`, the onboarder says so and names the
  owning title. The question goes in the log.

## Tests

`tests/` holds the new-hire questions, the answer key, and the quality graders. Graders are
non-Claude models only. Method is in `tests/README.md`.

Results on this version: Codex passes 11 of 12 files against the written rubric (`examples.md`
fails one criterion on source headings), and the deterministic check passes 50 of 50. The second
grader (Grok) reached its usage limit, so the two-grader result is not confirmed.

## Keeping It Current

The Head of Sales updates the matching file here when a decision changes. Each answered question in
`reference/question-log.md` is added to the right reference file.

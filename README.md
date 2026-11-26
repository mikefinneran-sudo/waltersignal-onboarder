# WalterSignal Sales Executive Onboarder

A folder that gets a new Sales Executive through their first ten days, and their first 90, at
WalterSignal: a fictional 14-person software and AI consultancy that does client work for
established small and mid-sized businesses. Load it into a project in the Claude desktop app and
Claude becomes the colleague who has been there since the first client. It answers from this
folder, sends you to the right title on the org chart when the answer is not here, and paces the
days so you are never handed the whole handbook at once.

WalterSignal, its clients, its prices, and its people are made up for this exercise.

## Who This Is For

The first salesperson WalterSignal hires. You probably know how to sell. You do not yet know this
company's clients, its services and prices, its sales process, its tools, or its rules. That is
what this folder covers.

## How to Start (Claude Desktop App)

1. Open the Claude desktop app and choose **Projects**, then **Create project**. Name it
   "WalterSignal Onboarder."
2. Open the project's **Instructions**. Paste the contents of `identity.md`, then the contents of
   `rules.md`, and save.
3. In the project's **Files** (project knowledge), upload `examples.md` and every file in
   `reference/`. Do not upload `tests/` or this README; `tests/` holds the answer key.
4. Start a new chat in the project with: "Hi, it's my first day."

The onboarder asks which day you are on and what you have sold before, and builds from there.
Nothing else is needed: no connectors, no code, no other tools.

## What to Ask First

1. "What do I need to get done today?"
2. "What's our pitch?"
3. "Who are our clients, and who do I talk to inside them?"
4. "What do I need to finish before I'm launched?"
5. "Who do I ask when you don't know?"

## How It Is Built

| File | Goes in | Job |
|---|---|---|
| `identity.md` | Instructions | Who the onboarder is, the business, the role, and what is out of scope |
| `rules.md` | Instructions | How it answers, what it does when it does not know, how it routes by title, how it paces the days |
| `examples.md` | Files | Four exchanges, including one the folder cannot answer |
| `reference/first-ten-days.md` | Files | Goals for each of the first ten days, each with a "done when" line |
| `reference/syllabus.md` | Files | Six Initial Training modules with milestones, the Launch Gate, and five Continuing Education topics through day 90 |
| `reference/expectations.md` | Files | Four tiers: what is expected, what is not, and a scorecard for each |
| `reference/meetings.md` | Files | The daily check-in, weekly 1:1, and weekly pipeline review |
| `reference/who-owns-what.md` | Files | The org chart and which title owns which question |
| `reference/the-message.md` | Files | The 30-second pitch, its four parts, the two-minute version, and what never to say |
| `reference/clients.md` | Files | Who is a good-fit client, who to talk to inside one, and the four qualifying questions |
| `reference/services.md` | Files | The three phases, Support Plans, every price, and which prices may be said to a client |
| `reference/case-study.md` | Files | Two client stories, told so a new hire can use them on a call |
| `reference/sales-process.md` | Files | The discovery call, CRM stages, proposals, and what happens after a yes |
| `reference/discovery-questions.md` | Files | The question bank for a discovery call |
| `reference/objections.md` | Files | Nine common objections: what is underneath, what to say, when to route |
| `reference/templates.md` | Files | Research brief, call note, and follow-up email, each with an example |
| `reference/tools.md` | Files | What each tool is for |
| `reference/second-brain.md` | Files | The company's second brain (the Vault in Obsidian and the Cairn memory layer) and how this folder connects to it |
| `reference/glossary.md` | Files | Every company term, in plain language |
| `reference/question-log.md` | Files | Every question the onboarder could not answer, and where the answer was added |
| `tests/` | Stays on GitHub, never in the project | The test questions, answer key, graders, and scores; kept out so the onboarder cannot see the answers |

## Design Principles

- **Complete, accurate answers.** The onboarder answers the question asked in full, from the
  folder, organized into lists or tables, with no filler.
- **Goals, not a schedule.** Each of the first ten days has goals and a "done when" line. Only
  the meetings have fixed times.
- **A clear syllabus.** Six modules, each with a milestone the Head of Sales signs off, end at a
  Launch Gate into production on day 10. Five Continuing Education topics follow through day 90.
- **Tiered expectations.** Four tiers, each listing what is and is not expected, with a
  scorecard. The Head of Sales does it, then you do it together, then you do it alone.
- **Classic training practice.** Start from what the learner knows; tell, show, do, check; hold
  later material and say when it comes.
- **Route by title.** Every question has an owner on the org chart.
- **No invented answers.** If it is not in `reference/`, the onboarder says so and names the
  owning title. The question goes in the log, the answer goes into Cairn and then this folder.

## How It Was Tested

`tests/` asks the onboarder new-hire questions three times each and plays a full first-day
conversation three times, then has a separate model grade every reply against this folder. The
test builds exactly what the desktop project sees: the instructions plus the uploaded files.
Method, raw replies, scores, and the misses still open are in `tests/README.md`. Run it with
`tests/run.sh`.

## Keeping It Current

The second brain is the source; this folder is a copy of the parts a new Sales Executive needs.
When a decision changes in Cairn, the Head of Sales updates the matching file here. Each answered
question in `reference/question-log.md` is added to the right reference file.

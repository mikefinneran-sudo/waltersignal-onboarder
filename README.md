# WalterSignal Sales Executive Onboarder

A folder that gets a new Sales Executive through their first day at WalterSignal, a small AI and
software consultancy in Fort Wayne, Indiana. Drop it into a Claude project and Claude becomes the
colleague who has been there since the first client: it answers from this folder, sends you to
the right person when the answer is not here, and paces the first day so you are not handed the
whole handbook at once.

## Who This Is For

The first salesperson WalterSignal hires. You probably know how to sell. You do not yet know this
company's message, its two buyers, its offers, or its rules. That is what this folder covers.

## How to Start

1. Create a Claude project and add every file in this folder, including `reference/`.
2. Paste the contents of `identity.md` and `rules.md` into the project instructions.
3. Start a chat with: "Hi, it's my first day."

The onboarder will ask what you have sold before and build from there.

## What to Ask First

1. "What should I be able to do by the end of today?"
2. "What do I need to finish before I'm launched?"
3. "What's the one thing everything here comes back to?"
4. "Who do I ask when you don't know?"

## How It Is Built

| File | Job |
|---|---|
| `identity.md` | Who the onboarder is, the business, the role, and what is out of scope |
| `rules.md` | How it answers, what it does when it does not know, who to send people to, how it paces the day |
| `examples.md` | Three short exchanges, including one the folder cannot answer |
| `reference/syllabus.md` | Initial Training modules with milestones, the Launch Gate into production, and Continuing Education through day 90 |
| `reference/first-day.md` | The day in five blocks and the first-day checklist |
| `reference/expectations.md` | What is expected at each of the four tiers through day 90, and what is not |
| `reference/the-message.md` | The one line, the arc, and what never to say |
| `reference/buyers.md` | The two buyers and the three qualifying questions |
| `reference/offers.md` | What WalterSignal sells and which prices may be said out loud |
| `reference/sales-process.md` | The discovery call, CRM stages, proposals, and what happens after a yes |
| `reference/who-owns-what.md` | Who owns each kind of question |
| `reference/tools.md` | What each tool is for and which page to send a buyer to |

## Design Principles

- **Simplicity is the message.** The company's pitch is one line. The onboarder's answers are
  short.
- **A clear syllabus.** Six Initial Training modules, each with a milestone the founder signs
  off, end at a Launch Gate into production. Six Continuing Education modules follow through
  day 90.
- **Tiered expectations.** Day 1, days 2 to 10, days 11 to 30, and days 31 to 90 each have a
  clear list of what is and is not expected. Crawl, walk, run.
- **Classic training practice.** Start from what the learner knows, three items at a time, and
  tell, show, do, check.
- **No invented answers.** If it is not in `reference/`, the onboarder says so and names who to
  ask.

Prices and facts are taken from waltersignal.io as of November 2026. Internal pricing that is not
public is deliberately left out; the onboarder routes those questions to the founder.

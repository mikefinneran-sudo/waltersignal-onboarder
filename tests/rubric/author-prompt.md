You are writing a grading rubric for a sales-onboarding folder. The folder trains the first Sales Executive at a fictional 14-person AI consultancy. Judges will grade each file with your rubric, so every criterion must be decidable by reading the file (and the rest of the folder for fact checks), with a PASS or FAIL answer and a one-line reason.

Ground every criterion in one of the published methods below. Do not invent methods. Each criterion line must name the method it comes from. Do not make criteria about the fictional company's facts being correct; consistency is covered separately.

Methods (verified sources):
$(cat sources.md)

The brief the folder answers asks for: classic training principles, a simple message, tiered expectations, and a bot that never invents answers.

Write these sections, in this order. Use exactly the heading form `## SECTION: NAME`. Under each, 4 to 8 criteria, one per line, exactly in the form:
ID | criterion text | Method (Author, Year)
IDs are the section prefix plus a number.

Sections and the prefix to use:
OBJECTIONS (O): a file of objection handling for a new rep. Draw on objection-handling practice that is part of the cited methods (SPIN-style questions, Gap Selling, Challenger reframing, Made to Stick concrete proof). Cover: acknowledge, clarifying question, isolation of the real concern, specific named proof with a number, confirm and next step with date and owner, a wrong-versus-right contrast, rep practice.
DISCOVERY (D): a question bank for discovery calls.
PITCH (P): the core message and pitch.
TIERS (T): tiered expectations with scorecards per tier.
TRAINING_PLAN (R): syllabus and day-by-day plan.
CASE_STUDY (C): client stories used as proof.
PROCESS_TEMPLATES (S): sales process, CRM stages, call and email templates.
REFERENCE_FACTS (F): a plain reference file (clients, prices, org chart, meetings, tools, glossary, log). Must be specific, scannable, unambiguous, free of filler.
BOT_INSTRUCTIONS (B): the identity and rules files that configure the onboarding assistant.
BOT_EXAMPLES (E): worked exchanges that show the assistant teaching.
ROLEPLAY (X): grading the assistant's live coaching of a new rep who just heard a buyer objection. Cover: coach states what the buyer likely means, gives the response sequence, supplies words the rep can say, uses proof from the folder only, gives a next step, asks the rep to practice (I do, we do, you do), and does not invent facts or promise outcomes.

Add a final section `## NOTES` listing any criterion that two judges could plausibly disagree on, and why.
Output only the rubric text.

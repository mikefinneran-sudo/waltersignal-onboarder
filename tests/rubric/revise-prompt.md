You wrote the rubric below. A first grading run showed a defect in section REFERENCE_FACTS: criteria F1 to F8 are each meant for a different kind of file (clients, prices, org chart, meetings, tools, glossary, log), but the judges apply them to every reference file. As a result F8 FAILs every single-topic file because it demands sections for all seven categories, and F4, F5, F2 fail files such as the glossary or the second-brain file that only mention meetings, tools, or prices in passing.

Rewrite ONLY the REFERENCE_FACTS section (and its NOTES lines). Requirements:
- Each criterion must begin with a scope condition, for example "If the file lists clients, PASS if ...; if it does not list clients, mark NA". A file is not graded on categories it does not primarily define.
- Replace F8 with a criterion that applies to every reference file: the file opens with a one-sentence statement of what it is for, uses headings or tables so a rep can find an item in under 10 seconds, and contains no sentence that restates another sentence or praises the company.
- Keep every criterion tied to a cited method from the same source list. Keep the ID, criterion text, method line format.
- Add a criterion that a rep can act on each entry (every row states what the rep does or says, not only a fact).
Output the full replacement section starting with `## SECTION: REFERENCE_FACTS`, followed by a `## NOTES` fragment for these IDs only. No other text.

Current rubric:
## SECTION: OBJECTIONS
O1 | PASS if every objection response begins by explicitly acknowledging the buyer’s concern without rebutting it; otherwise FAIL. | SPIN Selling (Rackham, 1988)
O2 | PASS if every objection response includes at least one open clarifying question about the buyer’s current situation or problem; otherwise FAIL. | SPIN Selling (Rackham, 1988)
O3 | PASS if every objection response includes a question that tests whether the stated objection is the real or only concern; otherwise FAIL. | Gap Selling (Keenan, 2018)
O4 | PASS if every objection response identifies the buyer’s current state, desired future state, or cost of the gap before proposing an answer; otherwise FAIL. | Gap Selling (Keenan, 2018)
O5 | PASS if every objection response reframes the concern with a buyer-relevant implication or new perspective rather than relying only on reassurance; otherwise FAIL. | The Challenger Sale (Dixon and Adamson, 2011)
O6 | PASS if every objection response cites a specifically named case, client, artifact, or result from the folder and includes at least one number; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
O7 | PASS if every objection response ends with a confirmation question and a next step naming both an owner and a calendar date, and the file includes at least one labeled wrong-versus-right response contrast; otherwise FAIL. | SPIN Selling (Rackham, 1988)
O8 | PASS if the file includes instructions for the rep to hear or read a model response, practice with guidance, and then perform independently; otherwise FAIL. | Gradual Release of Responsibility (Pearson and Gallagher, 1983)

## SECTION: DISCOVERY
D1 | PASS if the bank contains separately labeled Situation, Problem, Implication, and Need-payoff questions, with at least two questions in each category; otherwise FAIL. | SPIN Selling (Rackham, 1988)
D2 | PASS if at least one question elicits the buyer’s current state in observable terms such as workflow, timing, volume, people, or cost; otherwise FAIL. | Gap Selling (Keenan, 2018)
D3 | PASS if at least one question elicits a specific future state and how the buyer would measure it; otherwise FAIL. | Gap Selling (Keenan, 2018)
D4 | PASS if at least one question quantifies the size or cost of the gap between current and future states; otherwise FAIL. | Gap Selling (Keenan, 2018)
D5 | PASS if at least one question surfaces an unrecognized risk, assumption, or consequence instead of merely collecting background facts; otherwise FAIL. | The Challenger Sale (Dixon and Adamson, 2011)
D6 | PASS if the questions are phrased as words a rep can read aloud and each asks only one primary question; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)

## SECTION: PITCH
P1 | PASS if the file contains one labeled value-positioning statement that names the target customer, need or opportunity, offering category, primary benefit, and meaningful alternative or differentiation; otherwise FAIL. | Crossing the Chasm (Moore, 1991)
P2 | PASS if the core message can be read aloud in 30 seconds or fewer at 150 words per minute and expresses one primary idea; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
P3 | PASS if the pitch uses at least one concrete example, named deliverable, or observable buyer scenario instead of relying entirely on abstractions; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
P4 | PASS if the pitch includes a specific, attributable proof point from elsewhere in the folder; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
P5 | PASS if the pitch contrasts the buyer’s current state with a measurable future state and states the business cost or consequence of the gap; otherwise FAIL. | Gap Selling (Keenan, 2018)
P6 | PASS if the pitch teaches one non-obvious buyer insight and connects that insight to the offered approach; otherwise FAIL. | The Challenger Sale (Dixon and Adamson, 2011)
P7 | PASS if the pitch ends with one explicit buyer action or question that advances discovery; otherwise FAIL. | SPIN Selling (Rackham, 1988)

## SECTION: TIERS
T1 | PASS if the file defines at least three ordered proficiency tiers and gives each tier a distinct name; otherwise FAIL. | Mastery Learning (Bloom)
T2 | PASS if every tier has a scorecard containing observable rep behaviors rather than personality traits or vague labels; otherwise FAIL. | Behaviorally Anchored Rating Scales (Smith and Kendall, 1963)
T3 | PASS if every scored behavior includes the conditions under which it is performed and a numeric or otherwise explicit passing criterion; otherwise FAIL. | Preparing Instructional Objectives (Mager, 1962)
T4 | PASS if every tier includes a measurable target with a stated timeframe, and the target is relevant to the sales role; otherwise FAIL. | SMART Criteria (Doran, 1981)
T5 | PASS if the scorecards show what behavior distinguishes each adjacent tier, using concrete examples or anchors; otherwise FAIL. | Behaviorally Anchored Rating Scales (Smith and Kendall, 1963)
T6 | PASS if advancement requires meeting a stated mastery threshold and the file specifies what happens after a failed attempt, including corrective practice and reassessment; otherwise FAIL. | Mastery Learning (Bloom)
T7 | PASS if higher tiers require more independent performance than lower tiers; otherwise FAIL. | Gradual Release of Responsibility (Pearson and Gallagher, 1983)

## SECTION: TRAINING_PLAN
R1 | PASS if every syllabus objective states an observable learner behavior, the performance conditions, and an explicit success criterion; otherwise FAIL. | Preparing Instructional Objectives (Mager, 1962)
R2 | PASS if every training day lists activities, an expected output, and a completion or passing standard; otherwise FAIL. | Preparing Instructional Objectives (Mager, 1962)
R3 | PASS if the plan visibly progresses from trainer demonstration to guided practice to independent rep performance; otherwise FAIL. | Gradual Release of Responsibility (Pearson and Gallagher, 1983)
R4 | PASS if previously introduced knowledge or skills are revisited on at least two later, nonconsecutive days; otherwise FAIL. | Spaced Repetition
R5 | PASS if each major skill has a stated mastery threshold, a check against that threshold, and a corrective path before advancement; otherwise FAIL. | Mastery Learning (Bloom)
R6 | PASS if the plan includes dated or day-numbered milestones whose outcomes are specific and measurable; otherwise FAIL. | SMART Criteria (Doran, 1981)
R7 | PASS if at least one day each is devoted to discovery, pitching, objection handling, process execution, and independent role-play assessment; otherwise FAIL. | Gradual Release of Responsibility (Pearson and Gallagher, 1983)

## SECTION: CASE_STUDY
C1 | PASS if every case identifies a specific client or explicitly labeled anonymized client, the client’s initial situation, and the problem addressed; otherwise FAIL. | SPIN Selling (Rackham, 1988)
C2 | PASS if every case distinguishes the client’s current state, desired future state, and material gap between them; otherwise FAIL. | Gap Selling (Keenan, 2018)
C3 | PASS if every case states at least one quantified consequence, intervention, or result with its unit and timeframe; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
C4 | PASS if every case identifies the source of each result or labels it as an estimate, projection, or illustrative figure; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
C5 | PASS if every case follows a discernible story sequence of challenge, action, and outcome; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
C6 | PASS if every case ends with a short statement explaining which buyer problem or objection the case can credibly support; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)

## SECTION: PROCESS_TEMPLATES
S1 | PASS if every CRM stage has an entry condition, required rep actions or fields, and an observable exit criterion; otherwise FAIL. | Preparing Instructional Objectives (Mager, 1962)
S2 | PASS if the process defines a specific owner and time-bound next action for every active opportunity; otherwise FAIL. | SMART Criteria (Doran, 1981)
S3 | PASS if the discovery-call template contains prompts for Situation, Problem, Implication, and Need-payoff questions; otherwise FAIL. | SPIN Selling (Rackham, 1988)
S4 | PASS if the opportunity template records current state, future state, the gap, and the quantified cost or consequence of that gap; otherwise FAIL. | Gap Selling (Keenan, 2018)
S5 | PASS if each call or email template has one stated purpose and one explicit requested next action; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
S6 | PASS if at least one outreach template leads with a buyer-relevant insight that challenges an assumption and then connects it to the proposed conversation; otherwise FAIL. | The Challenger Sale (Dixon and Adamson, 2011)
S7 | PASS if templates use concrete placeholders that specify the required input, such as `[buyer metric]` or `[meeting date]`, rather than undefined blanks; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)

## SECTION: REFERENCE_FACTS
F1 | PASS if every client entry has a unique name or anonymized label plus at least one concrete descriptor that distinguishes it from other clients; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
F2 | PASS if every price is paired with a currency, billing unit or period, and the named offer to which it applies; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
F3 | PASS if the org chart names each role, its reporting relationship, and the role’s sales-relevant responsibility; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
F4 | PASS if every recurring meeting lists its purpose, participants, cadence, and owner; otherwise FAIL. | Preparing Instructional Objectives (Mager, 1962)
F5 | PASS if every tool entry states the tool’s name and one specific sales use; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
F6 | PASS if every glossary entry gives one unambiguous plain-language definition and does not define the term using the term itself; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
F7 | PASS if the log records dated changes or explicitly states that no changes have yet been recorded, and each recorded change names an owner; otherwise FAIL. | SMART Criteria (Doran, 1981)
F8 | PASS if the file uses labeled sections or a table for clients, prices, org chart, meetings, tools, glossary, and log, and contains no unlabeled motivational or promotional prose; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)

## SECTION: BOT_INSTRUCTIONS
B1 | PASS if the identity file states that the assistant teaches and coaches the new Sales Executive and names the folder as its factual source; otherwise FAIL. | Preparing Instructional Objectives (Mager, 1962)
B2 | PASS if the rules explicitly prohibit inventing, guessing, or promising any fact or outcome not supported by the folder; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
B3 | PASS if the rules require the assistant, when support is absent or conflicting, to say that it does not know, identify what is missing or conflicting, and direct the rep to a named human owner or source; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
B4 | PASS if the rules require factual answers to cite the supporting folder file and section, heading, or entry; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
B5 | PASS if the instructions define observable coaching behaviors: model an answer, guide practice, request independent performance, and give feedback against stated criteria; otherwise FAIL. | Gradual Release of Responsibility (Pearson and Gallagher, 1983)
B6 | PASS if the instructions require the assistant to test mastery against an explicit threshold and prescribe corrective practice plus reassessment after failure; otherwise FAIL. | Mastery Learning (Bloom)
B7 | PASS if the instructions require feedback to identify the observed behavior, the applicable behavioral anchor, and one concrete improvement; otherwise FAIL. | Behaviorally Anchored Rating Scales (Smith and Kendall, 1963)

## SECTION: BOT_EXAMPLES
E1 | PASS if the examples include at least one exchange in which the assistant models a complete response before asking the rep to respond; otherwise FAIL. | Gradual Release of Responsibility (Pearson and Gallagher, 1983)
E2 | PASS if the examples include at least one guided exchange in which the assistant provides a prompt or partial response and the rep completes it; otherwise FAIL. | Gradual Release of Responsibility (Pearson and Gallagher, 1983)
E3 | PASS if the examples include at least one exchange requiring the rep to perform independently and receive behavior-specific feedback; otherwise FAIL. | Gradual Release of Responsibility (Pearson and Gallagher, 1983)
E4 | PASS if at least one example shows the assistant refusing to guess when the folder lacks an answer and directing the rep to a named source or owner; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
E5 | PASS if every factual claim made by the assistant in the worked exchanges is traceable to an identified folder file and section, heading, or entry; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
E6 | PASS if at least one exchange evaluates the rep against an explicit observable passing standard and, upon a miss, assigns corrective practice and reassessment; otherwise FAIL. | Mastery Learning (Bloom)
E7 | PASS if at least one coaching exchange uses a concrete wrong-versus-right example tied to a named behavioral anchor; otherwise FAIL. | Behaviorally Anchored Rating Scales (Smith and Kendall, 1963)

## SECTION: ROLEPLAY
X1 | PASS if the coach states a plausible meaning behind the buyer’s objection and labels it as a hypothesis to verify rather than a fact; otherwise FAIL. | SPIN Selling (Rackham, 1988)
X2 | PASS if the coach gives a response sequence that acknowledges the objection, asks a clarifying question, tests the real concern, responds, confirms resolution, and proposes a next step; otherwise FAIL. | SPIN Selling (Rackham, 1988)
X3 | PASS if the coach supplies a complete, concrete response the rep can say aloud verbatim; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
X4 | PASS if every proof point in the coaching response is traceable to a named file and section, heading, or entry in the folder; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
X5 | PASS if the proposed next step specifies the action, owner, and calendar date; otherwise FAIL. | SMART Criteria (Doran, 1981)
X6 | PASS if the coach models the response, offers a guided attempt, and then asks the rep to perform the response independently; otherwise FAIL. | Gradual Release of Responsibility (Pearson and Gallagher, 1983)
X7 | PASS if the coach makes no unsupported factual claim, guarantee, or promised buyer outcome and explicitly marks unknown information as unknown; otherwise FAIL. | Made to Stick (Heath and Heath, 2007)
X8 | PASS if the coach gives feedback against observable behavioral anchors and states whether the rep met an explicit mastery threshold; otherwise FAIL. | Behaviorally Anchored Rating Scales (Smith and Kendall, 1963)

## NOTES
P2 | Judges may differ slightly when counting spoken words or interpreting what constitutes one primary idea; use the stated 150-words-per-minute rule and count separately asserted benefits as separate ideas.
P6 | Judges may disagree about whether an insight is non-obvious; require an explicit contrast between a common buyer assumption and the file’s alternative view.
T5 | “Concrete examples or anchors” can invite judgment; require quoted or paraphrased behaviors that a judge could directly observe in a call, email, or CRM record.
R7 | Judges may disagree about whether an activity qualifies as independent role-play; count it only when the rep performs without a supplied script or line-by-line prompting.
C2 | “Material gap” may be interpreted differently; count it only when the case explicitly contrasts current and desired conditions and states a business consequence.
C4 | Source attribution depth may vary; a named client record, measurement source, or explicit estimate/projection label is sufficient.
F8 | “Motivational or promotional prose” may be disputed; fail only prose that neither defines a fact nor helps locate or interpret one of the seven required reference categories.
B3 | Judges may differ on whether a source is sufficiently named; require a specific person, role, file, or system rather than “ask someone” or “check internally.”
X1 | More than one interpretation of an objection can be plausible; grade only whether the stated interpretation reasonably follows from the objection and is explicitly presented as a hypothesis.
X7 | Judges may disagree about what is an unsupported promise; treat unqualified predictions of results, timing, approval, or capability as promises unless the folder explicitly authorizes them.# Verified Sources Given to the Rubric Author

- Neil Rackham, SPIN Selling (McGraw-Hill, 1988). Situation, Problem, Implication, Need-payoff questions. Listed in Open Library.
- Matthew Dixon and Brent Adamson, The Challenger Sale (2011). https://en.wikipedia.org/wiki/The_Challenger_Sale
- Keenan, Gap Selling: Getting the Customer to Yes (2018). Current state, future state, the gap and its cost. Listed in Open Library.
- Chip Heath and Dan Heath, Made to Stick (2007). Simple, unexpected, concrete, credible, emotional, stories. Listed in Open Library.
- Geoffrey A. Moore, Crossing the Chasm (1991). The value-positioning statement. Listed in Open Library.
- Robert F. Mager, Preparing Instructional Objectives (1962). Observable behavior, conditions, criterion. Listed in Open Library.
- SMART criteria (Doran, 1981). https://en.wikipedia.org/wiki/SMART_criteria
- Behaviorally anchored rating scales (Smith and Kendall, 1963). https://en.wikipedia.org/wiki/Behaviorally_anchored_rating_scales
- Gradual release of responsibility, "I do, we do, you do" (Pearson and Gallagher, 1983). https://en.wikipedia.org/wiki/Gradual_release_of_responsibility
- Spaced repetition. https://en.wikipedia.org/wiki/Spaced_repetition
- Mastery learning (Bloom). https://en.wikipedia.org/wiki/Mastery_learning

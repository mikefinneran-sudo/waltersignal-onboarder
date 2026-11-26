#!/bin/zsh
# Plays one multi-turn day-one conversation (conversation.txt, one turn per
# line) in a single resumed session, then grades every turn.
# Each claude call reads stdin from /dev/null; without that it would swallow
# the remaining turns from the while-read loop.
#
# Usage: convo.sh <results-dir> <run-number>
set -euo pipefail
res=$1 run=$2
sid=$(uuidgen | tr A-Z a-z); out=$res/convo/run$run.txt; : > $out; n=0
cd $SANDBOX
while IFS= read -r turn; do
  n=$((n+1))
  if (( n == 1 )); then session=(--session-id $sid); else session=(--resume $sid); fi
  reply=$(claude -p --setting-sources "" --tools "" --model $ONBOARDER_MODEL \
    --system-prompt-file $res/system.md $session "$turn" < /dev/null 2>> $res/convo/run$run.err)
  printf '### TURN %d\nNEW HIRE: %s\nONBOARDER: %s\n\n' $n "$turn" "$reply" >> $out
done < $TESTS/conversation.txt
{
  echo "You grade an onboarding bot over a multi-turn day-one conversation. GROUND TRUTH FOLDER:"
  cat $res/system.md; echo; echo "TRANSCRIPT:"; cat $out; echo
  echo "Grade each of the 8 turns. A turn PASSES only if: it invents no fact absent from the folder; any question the folder cannot answer is said plainly and routed to the most specific owner the folder names; it gives at most three new main items; it holds to day-one expectations (no quoting prices to anyone on day one); a request for the whole handbook is declined with pacing. Output exactly 8 lines: 'TURN n: PASS|FAIL | reason under 20 words'."
} > $res/convo/grade-run$run.prompt
claude -p --setting-sources "" --tools "" --no-session-persistence --model $GRADER_MODEL \
  < $res/convo/grade-run$run.prompt > $res/convo/grade-run$run.txt 2> $res/convo/grade-run$run.err

#!/bin/zsh
# Grades one saved reply with a separate model that sees the full folder as
# ground truth. The criterion depends on the question category, taken from the
# first letter of the question ID:
#   T  trap        the answer is not in the folder; it must say so and route
#   A  answerable  the answer is in the folder; it must give it
#   P  pacing      answer the question in full, no handbook dump, say when held-back items come
#   C  coverage    a new hire needs a real answer drawn from the folder
#   R  routing     must route to the owner listed in key.tsv
# Every category also fails on any fact that is not in the folder.
#
# Usage: grade.sh <results-dir> <reply-file>
set -euo pipefail
res=$1 reply=$2
name=${reply:t:r}; id=${name#*-}
question=$(awk -F'\t' -v k=$id '$1==k{print $2}' $TESTS/questions.tsv)
case ${id[1]} in
  T) crit="TRAP: the answer is NOT in the folder. PASS only if the reply states plainly it is not in the notes (or that someone else quotes it), names who owns it, and invents NO fact absent from the folder.";;
  A) crit="ANSWERABLE: PASS only if the reply gives the correct answer from the folder (not just 'ask someone') and contains no fact absent from the folder.";;
  P) crit="PACING: PASS only if the reply answers what was asked, does not dump later material or paste the handbook, names the day or module when each held-back topic comes, and contains no fact absent from the folder.";;
  C) crit="COVERAGE: a new hire needs a real answer here. PASS only if the reply gives a substantive, specific answer drawn from the folder (not mainly 'not in my notes'), and contains no fact absent from the folder.";;
  R) owner=$(awk -F'\t' -v k=$id '$1==k{print $2}' $TESTS/key.tsv)
     crit="ROUTING: PASS only if the reply routes to this owner: [$owner]. Routing to a generic founder or manager name instead of that function FAILS. It must also invent no fact absent from the folder.";;
esac
{
  echo "You grade an onboarding bot. GROUND TRUTH FOLDER:"; cat $res/system.md
  echo; echo "QUESTION: $question"; echo; echo "REPLY:"; cat $reply; echo
  echo "CRITERION: $crit"
  echo "Check every concrete fact in the reply against the folder. Output exactly one line: PASS or FAIL, then ' | ' and a reason under 25 words."
} > $res/grade/$name.prompt
cd $SANDBOX
claude -p --setting-sources "" --tools "" --no-session-persistence --model $GRADER_MODEL \
  < $res/grade/$name.prompt > $res/grade/$name.txt 2> $res/grade/$name.err

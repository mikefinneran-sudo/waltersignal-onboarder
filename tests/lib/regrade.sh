#!/bin/zsh
# Regrades the SAME saved replies of an earlier run with the non-Claude grader, so old-grader and
# new-grader scores can be compared on identical text.
# Usage: regrade.sh <old-results-dir> <new-results-dir>
set -uo pipefail
export TESTS=${0:A:h:h} SANDBOX=$(mktemp -d) GRADER=${GRADER:-codex}
old=${1:A} new=${2:A}; mkdir -p $new/out $new/grade $new/convo
cp $old/system.md $new/; cp $old/out/*.txt $new/out/; cp $old/convo/run*.txt $new/convo/
cp $old/grades.txt $new/grades-old-grader.txt
for r in $new/convo/run?.txt; do n=${r:t:r}; n=${n#run}; cp $old/convo/grade-run$n.txt $new/convo/old-grade-run$n.txt
  python3 - $old/convo/grade-run$n.prompt $new/convo/run$n.txt $new/convo/grade-run$n.prompt <<'PY'
import sys; p=open(sys.argv[1]).read(); h,_=p.split("TRANSCRIPT:",1); tail=p.split("Grade each of the 8 turns",1)[1]
open(sys.argv[3],'w').write(h+"TRANSCRIPT:\n"+open(sys.argv[2]).read()+"\nGrade each of the 8 turns"+tail)
PY
  $TESTS/lib/llm.sh $GRADER < $new/convo/grade-run$n.prompt | grep -E '^TURN [0-9]+:' > $new/convo/grade-run$n.txt
done
for f in $new/out/*.txt; do print -rn -- "$new"$'\0'"$f"$'\0'; done | xargs -0 -n2 -P6 $TESTS/lib/grade.sh
for f in $new/grade/*.txt; do printf "%-10s %s\n" "${f:t:r}" "$(head -1 $f)"; done | sort > $new/grades.txt
echo "== old grader (Opus), same replies"; $TESTS/lib/score.sh $old
echo "== new grader ($GRADER), same replies"; $TESTS/lib/score.sh $new

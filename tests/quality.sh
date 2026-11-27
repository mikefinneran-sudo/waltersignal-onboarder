#!/bin/zsh
# Content-quality checks, graded only by non-Claude models (codex, gemini via agy, grok via cursor-agent).
#   1. det.py       deterministic structure, filler, measurability checks
#   2. judge.sh     each file graded by 3 graders against its rubric section (tests/rubric/rubric.md)
#   3. roleplay.sh  simulated buyer objections, coaching graded on the ROLEPLAY rubric
# Usage: tests/quality.sh [folder] [label]    Env: JOBS=8 ONBOARDER_MODEL=sonnet
set -euo pipefail
export TESTS=${0:A:h}
folder=${1:-$TESTS/..}; folder=${folder:A}; label=${2:-quality-current}
export ONBOARDER_MODEL=${ONBOARDER_MODEL:-sonnet} SANDBOX=$(mktemp -d)
res=$TESTS/results/$label; rm -rf $res/judge $res/roleplay; mkdir -p $res
$TESTS/lib/build_prompt.sh $folder $res/system.md
python3 -I $TESTS/lib/det.py $folder > $res/deterministic.txt
echo "Deterministic: $(grep -c ^PASS $res/deterministic.txt) pass, $(grep -c ^FAIL $res/deterministic.txt) fail"
while IFS=$'\t' read -r label sec files; do
  paths=(); for f in ${=files}; do paths+=($folder/$f); done
  for g in codex gemini grok; do print -rn -- "$res"$'\0'"$g"$'\0'"$label"$'\0'"$sec"$'\0'"${paths[*]}"$'\0'; done
done < $TESTS/lib/units.tsv | xargs -0 -n5 -P${JOBS:-6} $TESTS/lib/judge.sh 2>/dev/null || true
if [[ -z ${NOROLE:-} ]]; then $TESTS/lib/roleplay.sh $res $folder || true; fi
python3 -I $TESTS/lib/verdict.py $res | tee $res/verdict.txt

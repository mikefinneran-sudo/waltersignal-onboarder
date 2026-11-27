#!/bin/zsh
# Re-runs any judge call whose output is empty (grader timeout or CLI error). Usage: retry.sh <results-dir>
set -uo pipefail
export TESTS=${0:A:h:h}; res=${1:A}
for f in $res/judge/*/*.txt; do [[ -s $f ]] && continue
  g=${f:h:t}; label=${f:t:r}; p=$res/judge/$g/$label.prompt
  $TESTS/lib/llm.sh $g < $p | grep -E '^[A-Z]+[0-9]+: (PASS|FAIL|NA)' > $f &
  (( $(jobs | wc -l) >= 3 )) && wait
done; wait
python3 -I $TESTS/lib/verdict.py $res

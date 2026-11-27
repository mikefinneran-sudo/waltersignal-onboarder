#!/bin/zsh
# Grades one unit (one or more files) against one rubric section with one non-Claude grader.
# Usage: judge.sh <results-dir> <grader> <label> <SECTION> <file>...
# Writes <results-dir>/judge/<grader>/<label>.txt: one "ID: PASS|FAIL|NA | reason" line per criterion.
set -uo pipefail
res=$1 g=$2 label=$3 section=$4; files=(${=5})
mkdir -p $res/judge/$g
{
  echo "You are an independent grader of sales-training material. Grade the FILE UNDER REVIEW against the rubric criteria below."
  echo "Rules: a criterion is PASS only if EVERY applicable instance in the file meets it (all objections, all tiers, all entries). One failing instance means FAIL. Use NA only if the file has no instance of what the criterion covers. Judge the text as written; do not credit intent. Facts may be checked against the FOLDER."
  echo "Output exactly one line per criterion, in the form 'ID: PASS|FAIL|NA | reason in 25 words or fewer', and nothing else."
  echo; echo "RUBRIC SECTION: $section"; python3 -I $TESTS/lib/rubric_section.py $TESTS/rubric/rubric.md $section
  echo; echo "FOLDER (for fact checks only):"; cat $res/system.md
  echo; echo "FILE UNDER REVIEW:"
  for f in $files; do echo "----- ${f:t} -----"; cat $f; done
} > $res/judge/$g/$label.prompt
$TESTS/lib/llm.sh $g < $res/judge/$g/$label.prompt | grep -E '^[A-Z]+[0-9]+: (PASS|FAIL|NA)' > $res/judge/$g/$label.txt

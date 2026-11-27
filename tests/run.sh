#!/bin/zsh
# Runs the full onboarder test suite against one folder and prints the score.
#
#   1. Builds the system prompt from the folder (lib/build_prompt.sh).
#   2. Asks every question in questions.tsv, RUNS times (lib/ask.sh).
#   3. Grades every reply against the folder (lib/grade.sh).
#   4. Plays the multi-turn conversation CONVOS times and grades it (lib/convo.sh).
#   5. Writes results/<label>/grades.txt and prints pass counts by category.
#
# Usage:  tests/run.sh [folder] [label]
#   folder  onboarder folder to test (default: this repo)
#   label   results subfolder name (default: current)
# Env:    RUNS=3 CONVOS=3 JOBS=8 ONBOARDER_MODEL=sonnet GRADER=codex
# Needs:  the Claude Code CLI (`claude`) signed in.
set -euo pipefail
export TESTS=${0:A:h}
folder=${1:-$TESTS/..}; folder=${folder:A}; label=${2:-current}
export ONBOARDER_MODEL=${ONBOARDER_MODEL:-sonnet} GRADER=${GRADER:-codex}
export SANDBOX=$(mktemp -d)   # empty dir, so no project CLAUDE.md is picked up
RUNS=${RUNS:-3} CONVOS=${CONVOS:-3} JOBS=${JOBS:-8}
res=$TESTS/results/$label
mkdir -p $res/out $res/grade $res/convo
$TESTS/lib/build_prompt.sh $folder $res/system.md

# Multi-turn conversations run in the background alongside the single-turn questions.
( for r in $(seq $CONVOS); do print -rn -- "$res"$'\0'"$r"$'\0'; done \
    | xargs -0 -n2 -P$JOBS $TESTS/lib/convo.sh ) &

for r in $(seq $RUNS); do
  while IFS=$'\t' read -r id q; do print -rn -- "$res"$'\0'"$id"$'\0'"$r"$'\0'"$q"$'\0'; done < $TESTS/questions.tsv
done | xargs -0 -n4 -P$JOBS $TESTS/lib/ask.sh

for f in $res/out/*.txt; do print -rn -- "$res"$'\0'"$f"$'\0'; done \
  | xargs -0 -n2 -P$JOBS $TESTS/lib/grade.sh
wait

# One line per reply: "<run-id>  PASS|FAIL | reason". Anything else is a failed grader call.
for f in $res/grade/*.txt; do printf "%-10s %s\n" "${f:t:r}" "$(head -1 $f)"; done | sort > $res/grades.txt
$TESTS/lib/score.sh $res

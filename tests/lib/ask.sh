#!/bin/zsh
# Asks the onboarder one single-turn question and saves the reply.
# Runs from an empty working directory with no settings sources and no tools,
# so nothing but the built system prompt can reach the model.
#
# Usage: ask.sh <results-dir> <question-id> <run-number> <question-text>
set -euo pipefail
res=$1 id=$2 run=$3 question=$4
cd $SANDBOX
claude -p --setting-sources "" --tools "" --no-session-persistence --model $ONBOARDER_MODEL \
  --system-prompt-file $res/system.md "$question" < /dev/null > $res/out/run$run-$id.txt 2>&1

#!/bin/zsh
# Builds the system prompt a Claude project would see from an onboarder folder:
# identity.md and rules.md as the instructions, then every knowledge file
# (README, examples, reference/*.md) appended with a header naming its path.
#
# Usage: build_prompt.sh <onboarder-folder> <output-file>
set -euo pipefail
src=$1 out=$2
{
  cat $src/identity.md; echo
  cat $src/rules.md; echo
  echo "# Project Knowledge Files"
  for f in $src/README.md $src/examples.md $src/reference/*.md; do
    echo; echo "----- FILE: ${f#$src/} -----"; cat $f
  done
} > $out

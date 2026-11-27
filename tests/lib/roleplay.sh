#!/bin/zsh
# Role-play check. A simulated buyer raises each objection in reference/objections.md plus three that
# are not in it. The onboarder (Sonnet) coaches the new rep. Three non-Claude graders grade the
# coaching against the ROLEPLAY rubric section (not against faithfulness).
# Usage: roleplay.sh <results-dir> <folder>
set -uo pipefail
res=$1 folder=$2; mkdir -p $res/roleplay
python3 -I - $folder $res <<'PY'
import re,sys,json
folder,res=sys.argv[1:3]
t=open(folder+'/reference/objections.md').read()
heads=re.findall(r'(?m)^#{2,3} "(.*?)"?\s*$',t)
extra=["Our last consultant took our money and never delivered.","We tried an AI tool last year and my staff refused to use it.","My nephew says he can build this for free."]
buyers=[h.rstrip('."') for h in heads]
open(res+'/roleplay/buyers.tsv','w').write(''.join(f'IN{i+1}\t{b}\n' for i,b in enumerate(buyers))+''.join(f'OUT{i+1}\t{b}\n' for i,b in enumerate(extra)))
PY
while IFS=$'\t' read -r id b; do
  print -rn -- "$res"$'\0'"$id"$'\0'"$b"$'\0'
done < $res/roleplay/buyers.tsv | xargs -0 -n3 -P6 zsh -c '
  res=$1 id=$2 b=$3; cd $SANDBOX
  q="It is day 9, module 6, and I am role-playing a call. The buyer just said: \"$b\" Coach me on how to answer."
  claude -p --setting-sources "" --tools "" --no-session-persistence --model $ONBOARDER_MODEL --system-prompt-file $res/system.md "$q" < /dev/null > $res/roleplay/$id.reply 2>/dev/null
  { echo "BUYER SAID: $b"; echo; echo "ONBOARDER COACHING REPLY:"; cat $res/roleplay/$id.reply; } > $res/roleplay/$id.txt
' _
for g in codex gemini grok; do
  for f in $res/roleplay/*.txt; do [[ ${f:t} == buyers.tsv ]] && continue
    print -rn -- "$res"$'\0'"$g"$'\0'"rp-${f:t:r}"$'\0'"ROLEPLAY"$'\0'"$f"$'\0'; done
done | xargs -0 -n5 -P8 $TESTS/lib/judge.sh

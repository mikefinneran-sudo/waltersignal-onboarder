#!/bin/zsh
# One headless call to a non-Claude model. Prompt on stdin, answer on stdout.
# Usage: llm.sh codex|gemini|grok|qwen
# All three run on existing subscriptions through each vendor's CLI. No API keys.
# Each runs from an empty directory with a hard timeout; a hang returns nothing, never blocks.
set -uo pipefail
g=$1; d=$(mktemp -d); cd $d
T=${LLM_TIMEOUT:-300}
case $g in
  codex)  timeout $T codex exec --skip-git-repo-check -s read-only --ephemeral -o $d/last.txt - < /dev/stdin >/dev/null 2>$d/err; rc=$?; cat $d/last.txt > $d/out 2>/dev/null;;
  gemini) p=$(cat); timeout $T agy -p "$p" --model gemini-4-neon-high --print-timeout ${T}s < /dev/null >$d/out 2>$d/err; rc=$?;;
  grok)   p=$(cat); timeout $T cursor-agent -p --trust --mode ask --model grok-4.7-high "$p" < /dev/null >$d/out 2>$d/err; rc=$?;;
  qwen)   cat > $d/prompt; timeout 900 python3 -I -c 'import sys,json,os,urllib.request
b={"model":"Intel/Qwen3.5-122B-A10B-int4-AutoRound","messages":[{"role":"user","content":open(sys.argv[1]).read()}],"max_tokens":8000,"temperature":0}
if os.environ.get("QWEN_THINK","1")=="0": b["chat_template_kwargs"]={"enable_thinking":False}
r=json.load(urllib.request.urlopen(urllib.request.Request("http://192.168.68.62:8000/v1/chat/completions",json.dumps(b).encode(),{"Content-Type":"application/json"}),timeout=900))
print(r["choices"][0]["message"]["content"] or "")' $d/prompt >$d/out 2>$d/err; rc=$?;;
  *) echo "unknown grader $g" >&2; exit 2;;
esac
# Loud failure: a provider that exits non-zero or returns nothing must never look like an empty answer.
if [[ ! -s $d/out ]]; then
  echo "llm.sh: $g returned empty output (exit $rc); stderr: $(head -c 500 $d/err)" >&2
  rm -rf $d; exit ${${rc:#0}:-1}
fi
cat $d/out; rm -rf $d

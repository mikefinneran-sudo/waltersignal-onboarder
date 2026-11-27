#!/bin/zsh
# Determinism check: re-sends the SAME saved judge prompts (unit files only, no role-play) N more times
# and reports how often each grader repeats its own unit verdict and its per-criterion lines.
# Usage: rerun.sh <results-dir> [extra-runs=2]
set -uo pipefail
export TESTS=${0:A:h:h}; res=${1:A}; n=${2:-2}
for k in $(seq $n); do
  mkdir -p $res/rerun$k
  for p in $res/judge/*/*.prompt; do g=${p:h:t}; l=${p:t:r}; [[ $l == rp-* ]] && continue
    mkdir -p $res/rerun$k/$g
    print -rn -- "$g"$'\0'"$p"$'\0'"$res/rerun$k/$g/$l.txt"$'\0'
  done
done | xargs -0 -n3 -P6 zsh -c '$TESTS/lib/llm.sh $0 < $1 | grep -E "^[A-Z]+[0-9]+: (PASS|FAIL|NA)" > $2'
python3 -I - $res $n <<'PY'
import glob,os,sys
res,n=sys.argv[1],int(sys.argv[2]); tv=cv=tc=tu=0; per={}
def read(f):
    return {l.split(':')[0]:l.split(': ')[1].split(' ')[0] for l in open(f) if ': ' in l} if os.path.exists(f) else {}
def unit(d): return 'ERR' if not d else ('FAIL' if 'FAIL' in d.values() else 'PASS')
for f in sorted(glob.glob(res+'/judge/*/*.txt')):
    g=f.split('/')[-2]; l=os.path.basename(f)[:-4]
    if l.startswith('rp-'): continue
    runs=[read(f)]+[read(f'{res}/rerun{k}/{g}/{l}.txt') for k in range(1,n+1)]
    if any(not r for r in runs): continue
    s=per.setdefault(g,[0,0,0,0]); 
    s[1]+=1; s[0]+=len({unit(r) for r in runs})==1
    for c in runs[0]:
        s[3]+=1; s[2]+=len({r.get(c) for r in runs})==1
for g,s in per.items(): print(f'{g}: unit verdict identical across {n+1} runs {s[0]}/{s[1]}; per-criterion identical {s[2]}/{s[3]}')
PY

#!/bin/zsh
# Calibration: planted weak files (tests/calibration/weak-*.md) must FAIL under every grader, 3 repeats each.
# Usage: calibrate.sh <system.md source results dir> ; writes tests/results/calibration/
set -uo pipefail
export TESTS=${0:A:h:h}
res=$TESTS/results/calibration; mkdir -p $res; cp $1/system.md $res/system.md
typeset -A sec; sec=(weak-objections OBJECTIONS weak-expectations TIERS weak-the-message PITCH weak-discovery-questions DISCOVERY weak-case-study CASE_STUDY)
for w in ${(k)sec}; do for r in 1 2 3; do for g in ${=GRADERS:-gemini grok}; do
  print -rn -- "$res"$'\0'"$g"$'\0'"$w-r$r"$'\0'"${sec[$w]}"$'\0'"$TESTS/calibration/$w.md"$'\0'
done; done; done | xargs -0 -n5 -P6 $TESTS/lib/judge.sh
python3 -I - $res <<'PY'
import glob,os,sys,collections
res=sys.argv[1]; d=collections.defaultdict(dict)
for f in glob.glob(res+'/judge/*/*.txt'):
    g=f.split('/')[-2]; lab=os.path.basename(f)[:-4]; w,r=lab.rsplit('-r',1)
    st=[l.split(': ')[1].split(' ')[0] for l in open(f) if ': ' in l]
    d[w].setdefault(g,[]).append('ERR' if not st else 'FAIL' if 'FAIL' in st else 'PASS')
caught=tot=0
for w in sorted(d):
    row=[]; 
    for g in os.environ.get('GRADERS','gemini grok').split():
        v=d[w].get(g,[]); row.append(f"{g} FAIL {v.count('FAIL')}/{len(v)}")
    # a planted file is caught if at least 2 graders FAIL it in a majority of their runs
    gm=sum(1 for g in d[w] if d[w][g].count('FAIL')*2>len(d[w][g]))
    tot+=1; caught+=gm>=len(d[w])
    print(f"{w:26s} "+'; '.join(row)+f"  -> {'CAUGHT' if gm>=len(d[w]) else 'MISSED'}")
print(f'planted variants caught: {caught}/{tot}')
PY

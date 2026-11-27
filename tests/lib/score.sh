#!/bin/zsh
# Prints pass counts by category and overall for one results folder, then the
# multi-turn turn counts. Lines that are neither PASS nor FAIL (a grader call
# that errored, for example on a usage limit) are listed so they can be regraded.
#
# Usage: score.sh <results-dir>
res=$1
awk '{split($1,a,"-"); c=substr(a[2],1,1); t[c]++; T++; if($2=="PASS"){p[c]++; P++}}
     END{for(k in t) printf "%s %d/%d  ", k, p[k], t[k]; printf "\nSingle-turn: %d/%d\n", P, T}' $res/grades.txt
awk '$2!="PASS" && $2!="FAIL"{print "UNGRADED: " $1}' $res/grades.txt
pass=0 total=0
for f in $res/convo/grade-run*.txt(N); do
  pass=$((pass + $(grep -c ': PASS' $f))); total=$((total + 8))
done
echo "Multi-turn: $pass/$total turns"
# Per-grader counts, read from the [grader=VERDICT ...] suffix written by twostage.py.
python3 -I - $res <<'PY'
import re,sys,glob,collections
res=sys.argv[1]; c=collections.defaultdict(collections.Counter); n=collections.Counter()
files=[(res+'/grades.txt','s')]+[(f,'m') for f in glob.glob(res+'/convo/grade-run*.txt')]
for f,k in files:
    try: lines=open(f).read().splitlines()
    except OSError: continue
    for l in lines:
        m=re.findall(r'\[(\w+)=(\w+) (\w+)=(\w+)\]\s*$',l)
        if not m: continue
        a,va,b,vb=m[-1]; n[k]+=1
        c[(k,a)][va]+=1; c[(k,b)][vb]+=1
        c[(k,'both')]['PASS' if va==vb=='PASS' else 'FAIL']+=1
for k,lab in (('s','Single-turn'),('m','Multi-turn')):
    if n[k]: print(lab+' by grader: '+'; '.join(f"{g} {c[(k,g)]['PASS']}/{n[k]}" for (kk,g) in sorted(c) if kk==k and g!='both')+f"; both-pass {c[(k,'both')]['PASS']}/{n[k]}")
PY

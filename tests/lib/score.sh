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

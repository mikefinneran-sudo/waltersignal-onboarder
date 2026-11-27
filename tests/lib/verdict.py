#!/usr/bin/env python3
"""Aggregate judge output. A unit passes a grader if it has no FAIL line and at least one PASS.
A unit passes overall if at least 2 non-Claude graders pass it. Usage: verdict.py <results-dir>"""
import glob, os, sys
res = sys.argv[1]; gs = ['codex', 'gemini', 'grok']
units = {}
for g in gs:
    for f in glob.glob(f'{res}/judge/{g}/*.txt'):
        lab = os.path.basename(f)[:-4]
        ls = [l for l in open(f) if ': ' in l]
        st = [l.split(': ')[1].split(' ')[0] for l in ls]
        units.setdefault(lab, {})[g] = ('ERR' if not st else 'FAIL' if 'FAIL' in st else 'PASS', st.count('FAIL'), len(st))
tot = {g: [0, 0] for g in gs}; overall = [0, 0]; agree = [0, 0]
print(f"{'unit':22s} " + ' '.join(f'{g:>9s}' for g in gs) + '  overall')
for lab in sorted(units):
    u = units[lab]; row = []
    for g in gs:
        v = u.get(g, ('ERR', 0, 0)); row.append(f'{v[0]}({v[1]}f)' if v[0] != 'ERR' else 'ERR')
        if v[0] != 'ERR': tot[g][1] += 1; tot[g][0] += v[0] == 'PASS'
    passes = sum(1 for g in gs if u.get(g, ('ERR',))[0] == 'PASS')
    ok = passes >= 2; overall[1] += 1; overall[0] += ok
    vs = [u[g][0] for g in gs if g in u and u[g][0] != 'ERR']
    agree[1] += 1; agree[0] += len(set(vs)) == 1
    print(f'{lab:22s} ' + ' '.join(f'{r:>9s}' for r in row) + ('  PASS' if ok else '  FAIL'))
print('per-grader pass: ' + ', '.join(f'{g} {tot[g][0]}/{tot[g][1]}' for g in gs))
print(f'unanimous agreement on unit verdict: {agree[0]}/{agree[1]}')
print(f'OVERALL (2 of 3 graders): {overall[0]}/{overall[1]} units pass')

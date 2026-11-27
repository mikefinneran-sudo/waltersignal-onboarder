#!/usr/bin/env python3
"""Non-Claude faithfulness grading with two graders on every item (FIRST, default codex; SECOND, default grok).
An item passes only if BOTH pass. Each grader's own verdict is kept as a suffix: [codex=PASS grok=FAIL].
An item with a FAIL from either grader is a FAIL. An item where a grader errored and the other passed prints
nothing, so it shows as UNGRADED and can be retried.
Usage: twostage.py single|turns < prompt   (calls lib/llm.sh <grader>)"""
import os, re, subprocess, sys
mode = sys.argv[1]; F1 = os.environ.get('FIRST', 'codex'); F2 = os.environ.get('SECOND', 'grok')
prompt = sys.stdin.read(); T = os.path.dirname(os.path.abspath(__file__))
def ask(g): return subprocess.run([f'{T}/llm.sh', g], input=prompt, capture_output=True, text=True).stdout
def tag(a, b): return f' [{F1}={a} {F2}={b}]'
def word(s): return s.split()[0].rstrip(':|') if s else 'ERR'
if mode == 'single':
    pat = re.compile(r'^(PASS|FAIL)\b.*', re.M)
    gm = pat.search(ask(F1)); g = gm.group(0) if gm else ''
    km = pat.search(ask(F2)); k = km.group(0) if km else ''
    wg, wk = word(g), word(k)
    if wg == 'PASS' and wk == 'PASS': print(g + tag('PASS', 'PASS'))
    elif 'FAIL' in (wg, wk): print((g if wg == 'FAIL' else k) + tag(wg, wk))
else:
    pat = re.compile(r'^TURN (\d+): .*', re.M)
    gl = {m.group(1): m.group(0) for m in pat.finditer(ask(F1))}
    kl = {m.group(1): m.group(0) for m in pat.finditer(ask(F2))}
    for n in [str(i) for i in range(1, 9)]:
        g, k = gl.get(n, ''), kl.get(n, '')
        wg = 'PASS' if g.startswith(f'TURN {n}: PASS') else 'FAIL' if g.startswith(f'TURN {n}: FAIL') else 'ERR'
        wk = 'PASS' if k.startswith(f'TURN {n}: PASS') else 'FAIL' if k.startswith(f'TURN {n}: FAIL') else 'ERR'
        if wg == 'PASS' and wk == 'PASS': print(g + tag('PASS', 'PASS'))
        elif 'FAIL' in (wg, wk): print((g if wg == 'FAIL' else k) + tag(wg, wk))

#!/usr/bin/env python3
"""Two-stage non-Claude grading. Gemini grades first; Grok is asked only for items Gemini fails or errors on.
An item passes if Gemini passes it, or Grok passes it. Both verdicts are kept in the reason.
Usage: twostage.py single|turns < prompt   (calls lib/llm.sh gemini|grok)"""
import os, re, subprocess, sys
mode = sys.argv[1]; F1 = os.environ.get('FIRST','gemini'); F2 = os.environ.get('SECOND','grok'); prompt = sys.stdin.read(); T = os.path.dirname(os.path.abspath(__file__))
def ask(g): return subprocess.run([f'{T}/llm.sh', g], input=prompt, capture_output=True, text=True).stdout
if mode == 'single':
    pat = re.compile(r'^(PASS|FAIL)\b.*', re.M)
    gm = pat.search(ask(F1)); g = gm.group(0) if gm else ''
    if g.startswith('PASS'): print(g); sys.exit()
    km = pat.search(ask(F2)); k = km.group(0) if km else ''
    if k.startswith('PASS'): print(k + ' [' + F2 + '; ' + F1 + ': ' + (g or 'ERR') + ']')
    else: print(g or k)
else:
    pat = re.compile(r'^TURN (\d+): .*', re.M)
    gl = {m.group(1): m.group(0) for m in pat.finditer(ask(F1))}
    ns = [str(i) for i in range(1, 9)]
    if any(not gl.get(n, '').startswith(f'TURN {n}: PASS') for n in ns):
        kl = {m.group(1): m.group(0) for m in pat.finditer(ask(F2))}
        for n in ns:
            if gl.get(n, '').startswith(f'TURN {n}: PASS'): continue
            k = kl.get(n, '')
            if k.startswith(f'TURN {n}: PASS'): gl[n] = k + ' [' + F2 + '; ' + F1 + ': ' + (gl.get(n) or 'ERR') + ']'
            elif not gl.get(n): gl[n] = k
    for n in ns:
        if n in gl: print(gl[n])

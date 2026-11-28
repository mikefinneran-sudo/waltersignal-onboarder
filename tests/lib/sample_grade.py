#!/usr/bin/env python3
"""Sample grading pass: Qwen (and Gemini on the fix set) over a stored sample; writes twostage-style lines.
Usage: sample_grade.py <src-results-dir> <out-dir> <gemini:stored|live> """
import os, re, sys, subprocess, random, glob, json, concurrent.futures as cf
src, out, gmode = sys.argv[1:4]; T = os.path.dirname(os.path.abspath(__file__))
R = os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + '/results'
os.makedirs(out + '/grade', exist_ok=True); os.makedirs(out + '/convo', exist_ok=True)
ids = [l.strip() for l in open(R + '/sample-ids.txt') if l.strip() and not l.startswith('#')]
def ask(g, prompt, env=None):
    for i in range(2):
        r = subprocess.run([f'{T}/llm.sh', g], input=prompt, capture_output=True, text=True, env={**os.environ, **(env or {})})
        if r.stdout.strip(): return r.stdout
        err = r.stderr
    raise RuntimeError(f'{g} failed twice: {err[:300]}')
def stored(path, n):
    if not os.path.exists(path): return None
    for l in open(path):
        if l.startswith(n + ' ') or l.startswith(n + ':'):
            m = re.search(r'\[gemini=(\w+)', l); return m.group(1) if m else None
cnt = {'qwen': 0, 'gemini': 0}
def single(i):
    p = open(f'{src}/grade/{i}.prompt').read(); res = {}
    q = re.search(r'^(PASS|FAIL)\b.*', ask('qwen', p, {'QWEN_THINK': '0'}), re.M); cnt['qwen'] += 1
    qv = q.group(0) if q else 'ERR'
    if gmode == 'stored': gv = stored(f'{src}/grades.txt', i) or 'ERR'; gl = ''
    else:
        gv = stored(f'{src}/grades.txt', i)
        if gv: gl = ''
        else:
            m = re.search(r'^(PASS|FAIL)\b.*', ask('gemini', p), re.M); cnt['gemini'] += 1; gv = m.group(1) if m else 'ERR'; gl = m.group(0) if m else ''
    w = qv.split()[0].rstrip(':|') if qv != 'ERR' else 'ERR'
    line = f'{i:<10} {qv} [gemini={gv} qwen={w}]'
    open(f'{out}/grade/{i}.txt', 'w').write(line + '\n'); return line
def convo(n):
    p = open(f'{src}/convo/grade-run{n}.prompt').read(); pat = re.compile(r'^TURN (\d+): .*', re.M)
    ql = {m.group(1): m.group(0) for m in pat.finditer(ask('qwen', p, {'QWEN_THINK': '0'}))}; cnt['qwen'] += 1
    if gmode == 'live':
        gl = {m.group(1): m.group(0) for m in pat.finditer(ask('gemini', p))}; cnt['gemini'] += 1
    else: gl = None
    lines = []
    for t in map(str, range(1, 9)):
        wq = 'PASS' if ql.get(t, '').startswith(f'TURN {t}: PASS') else 'FAIL' if ql.get(t, '').startswith(f'TURN {t}: FAIL') else 'ERR'
        if gl is None:
            gv = stored(f'{src}/convo/grade-run{n}.txt', f'TURN {t}') or 'ERR'; txt = ql.get(t, '')
        else:
            g = gl.get(t, ''); gv = 'PASS' if g.startswith(f'TURN {t}: PASS') else 'FAIL' if g.startswith(f'TURN {t}: FAIL') else 'ERR'; txt = g if gv == 'FAIL' else ql.get(t, '')
        lines.append(f'{txt} [gemini={gv} qwen={wq}]')
    open(f'{out}/convo/grade-run{n}.txt', 'w').write('\n'.join(lines) + '\n'); return lines
if __name__ == '__main__':
    with cf.ThreadPoolExecutor(4) as ex:
        cl = list(ex.map(convo, [1, 2, 3]))
        sl = list(ex.map(single, [i for i in ids if not i.startswith('#')]))
    open(f'{out}/grades.txt', 'w').write('\n'.join(sorted(sl)) + '\n')
    print(json.dumps(cnt))

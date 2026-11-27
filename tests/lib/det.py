#!/usr/bin/env python3
"""Cheap deterministic checks that run before any model judge. Usage: det.py <folder>
Prints one 'PASS|FAIL file check | detail' line per check; exit 0 always (scoring reads the lines)."""
import re, sys, glob, os
root = sys.argv[1]
out = []
def chk(ok, f, name, detail=''): out.append(f"{'PASS' if ok else 'FAIL'} {f} {name} | {detail}")
files = [f for f in glob.glob(root + '/*.md') + glob.glob(root + '/reference/*.md') if os.path.basename(f) != 'README.md']
BANNED = ['simplest true answer', 'great question', 'game-changer', 'game changer', 'leverage', 'synergy', 'cutting-edge',
          'world-class', 'seamless', 'robust', 'unlock', 'delve', "it's important to note", 'in today', 'best-in-class',
          'touch base', 'circle back', 'low-hanging', 'move the needle', 'holistic', 'revolutionary']
for f in sorted(files):
    t = open(f).read(); n = os.path.relpath(f, root)
    hits = [b for b in BANNED if b in t.lower()]
    chk(not hits, n, 'banned-filler', ','.join(hits))
    chk('\u2014' not in t, n, 'no-em-dash', f"{t.count(chr(0x2014))} found")
    chk(not re.search(r'[\U0001F300-\U0001FAFF\u2600-\u27BF]', t), n, 'no-emoji')
def section(t, level='## '):
    parts = re.split(r'(?m)^' + level, t)
    return parts[1:]
p = root + '/reference/objections.md'
if os.path.exists(p):
    t = open(p).read(); secs = [s for s in section(t, '#{2,3} ') if s.startswith('"')]
    chk(len(secs) >= 8, 'reference/objections.md', 'objection-count>=8', str(len(secs)))
    for s in secs:
        h = s.splitlines()[0]; low = s.split('\n', 1)[1].lower()
        chk(low.count('?') >= 2, 'objections.md', 'two-questions:' + h[:30], f"{low.count('?')} question marks")
        chk(bool(re.search(r'brennan|harbor|what-we-sell|case-study', low)) or 'route' in low, 'objections.md', 'proof-or-route:' + h[:30])
        chk(bool(re.search(r'\d', s)), 'objections.md', 'has-number:' + h[:30])
        chk('isolate' in low or 'anything else' in low or 'only thing' in low or 'only concern' in low, 'objections.md', 'isolates:' + h[:30])
        chk(bool(re.search(r'next step|by (mon|tue|wed|thu|fri)|by \[date\]|\[date\]', low)), 'objections.md', 'next-step:' + h[:30])
        chk(bool(re.search(r'(?i)weak|wrong|never say|instead of', s)), 'objections.md', 'wrong-vs-right:' + h[:30])
p = root + '/reference/expectations.md'
if os.path.exists(p):
    rows = [l for l in open(p) if l.startswith('|') and '---' not in l and 'Target' not in l and 'Scorecard' not in l]
    bad = [r.strip()[:50] for r in rows if not re.search(r'\d|100%|every|all|none|zero', r.split('|')[-2].lower())]
    chk(not bad and rows, 'reference/expectations.md', 'scorecard-targets-measurable', f'{len(rows)} rows; unmeasurable: {bad}')
p = root + '/reference/the-message.md'
if os.path.exists(p):
    m = re.search(r'(?ms)^> (.*?)\n\n', open(p).read() + '\n\n')
    w = len(re.sub(r'[>\n]', ' ', m.group(1)).split()) if m else 999
    chk(w <= 75, 'reference/the-message.md', 'pitch-<=75-words', f'{w} words')
print('\n'.join(out))

#!/usr/bin/env python3
"""Print one rubric section plus the NOTES lines for its criteria. Usage: rubric_section.py rubric.md NAME"""
import re, sys
text = open(sys.argv[1]).read(); name = sys.argv[2]
secs = re.split(r'(?m)^## ', text)
body = next((s for s in secs if s.startswith('SECTION: ' + name + '\n')), None)
if body is None: sys.exit('no section ' + name)
lines = [l for l in body.splitlines()[1:] if l.strip()]
ids = {l.split(' | ')[0].strip() for l in lines}
notes = next((s for s in secs if s.startswith('NOTES')), '')
nl = [l for l in notes.splitlines()[1:] if l.split(' | ')[0].strip() in ids]
print('\n'.join(lines))
if nl: print('\nGrading notes:'); print('\n'.join(nl))

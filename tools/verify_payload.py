#!/usr/bin/env python3
from pathlib import Path
import json,hashlib,sys
root=Path(sys.argv[1] if len(sys.argv)>1 else 'payload')
manifest=Path(sys.argv[2] if len(sys.argv)>2 else 'payload_manifest.json')
m=json.loads(manifest.read_text(encoding='utf-8'))
bad=[]
for f in m['files']:
    p=root/f['name']
    if not p.is_file(): bad.append((f['name'],'MISSING')); continue
    b=p.read_bytes(); h=hashlib.sha256(b).hexdigest()
    if len(b)!=f['size'] or h!=f['sha256']: bad.append((f['name'],f'{len(b)} {h}'))
print(f"Expected files: {m['count']}")
print(f"Problems: {len(bad)}")
for x in bad: print(*x)
raise SystemExit(1 if bad else 0)

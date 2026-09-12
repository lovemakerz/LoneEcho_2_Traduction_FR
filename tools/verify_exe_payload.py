#!/usr/bin/env python3
from pathlib import Path
import struct,hashlib,sys,json
exe=Path(sys.argv[1]);manifest=Path(sys.argv[2] if len(sys.argv)>2 else 'payload_manifest.json')
d=exe.read_bytes();m=json.loads(manifest.read_text(encoding='utf-8'))
assert d[-16:-8]==b'LE2END01','footer missing';start=struct.unpack('<Q',d[-8:])[0];assert d[start:start+8]==b'LE2PAY01','payload magic missing'
pos=start+8;count=struct.unpack_from('<I',d,pos)[0];pos+=4
seen={}
for _ in range(count):
 nl=struct.unpack_from('<H',d,pos)[0];pos+=2;sz=struct.unpack_from('<Q',d,pos)[0];pos+=8;n=d[pos:pos+nl].decode();pos+=nl;b=d[pos:pos+sz];pos+=sz;seen[n]=(sz,hashlib.sha256(b).hexdigest())
problems=[]
for f in m['files']:
 if seen.get(f['name'])!=(f['size'],f['sha256']):problems.append(f['name'])
print('payload count:',count,'expected:',m['count'],'problems:',len(problems),'overlay:',hex(start))
for p in problems:print(p)
raise SystemExit(1 if problems or count!=m['count'] else 0)

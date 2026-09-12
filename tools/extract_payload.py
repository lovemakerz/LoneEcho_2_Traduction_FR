#!/usr/bin/env python3
"""Extract the exact LE2PAY01 payload from a TC2-style installer."""
from pathlib import Path
import argparse,struct,hashlib,json
PAY_MAGIC=b'LE2PAY01'; END_MAGIC=b'LE2END01'

def main():
    ap=argparse.ArgumentParser(); ap.add_argument('exe'); ap.add_argument('outdir'); ns=ap.parse_args()
    d=Path(ns.exe).read_bytes()
    if len(d)<16 or d[-16:-8]!=END_MAGIC: raise SystemExit('LE2END01 footer not found')
    start=struct.unpack('<Q',d[-8:])[0]
    if d[start:start+8]!=PAY_MAGIC: raise SystemExit('LE2PAY01 payload not found')
    pos=start+8; count=struct.unpack_from('<I',d,pos)[0];pos+=4
    root=Path(ns.outdir);root.mkdir(parents=True,exist_ok=True);manifest=[]
    for _ in range(count):
        nl=struct.unpack_from('<H',d,pos)[0];pos+=2
        size=struct.unpack_from('<Q',d,pos)[0];pos+=8
        name=d[pos:pos+nl].decode('utf-8');pos+=nl
        content=d[pos:pos+size];pos+=size
        p=root/Path(name);p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(content)
        manifest.append({'name':name,'size':size,'sha256':hashlib.sha256(content).hexdigest()})
    if pos != len(d)-16: raise SystemExit(f'Unexpected payload end: {pos} != {len(d)-16}')
    (root/'_payload_manifest.json').write_text(json.dumps({'format':'LE2PAY01','count':count,'files':manifest},indent=2),encoding='utf-8')
    print(f'Extracted {count} files from 0x{start:X}')

if __name__=='__main__':main()

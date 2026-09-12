#!/usr/bin/env python3
"""Append a LE2PAY01 payload to a Windows stub and finish with LE2END01+offset.
Usage: python tools/pack_payload.py build/stub.exe payload build/LoneEcho2_FR_Setup.exe
"""
from pathlib import Path
import argparse, struct, shutil

PAY_MAGIC=b'LE2PAY01'
END_MAGIC=b'LE2END01'

def strip_existing_overlay(data: bytes) -> bytes:
    if len(data) >= 16 and data[-16:-8] == END_MAGIC:
        start = struct.unpack('<Q', data[-8:])[0]
        if 0 <= start < len(data)-16 and data[start:start+8] == PAY_MAGIC:
            return data[:start]
    return data

def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('stub')
    ap.add_argument('payload_dir')
    ap.add_argument('output')
    ns=ap.parse_args()
    stub=Path(ns.stub); root=Path(ns.payload_dir); out=Path(ns.output)
    entries=[]
    for p in sorted(x for x in root.rglob('*') if x.is_file()):
        rel=p.relative_to(root).as_posix()
        nb=rel.encode('utf-8')
        if len(nb)>65535: raise SystemExit(f'Name too long: {rel}')
        entries.append((nb,p.read_bytes()))
    base=strip_existing_overlay(stub.read_bytes())
    start=len(base)
    with out.open('wb') as f:
        f.write(base)
        f.write(PAY_MAGIC)
        f.write(struct.pack('<I',len(entries)))
        for name,data in entries:
            f.write(struct.pack('<H',len(name)))
            f.write(struct.pack('<Q',len(data)))
            f.write(name)
            f.write(data)
        f.write(END_MAGIC)
        f.write(struct.pack('<Q',start))
    print(f'Packed {len(entries)} files -> {out}')
    print(f'Overlay starts at 0x{start:X}')

if __name__=='__main__': main()

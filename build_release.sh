#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
BUILD="$ROOT/build"
mkdir -p "$BUILD"
rm -f "$BUILD"/*.obj "$BUILD"/*.lib "$BUILD"/*.dll "$BUILD"/stub.exe "$BUILD"/LoneEcho2_FR_Traduction_FR_v1.2.0_RC1.exe
for d in kernel32 advapi32 user32 gdi32 shell32 ole32; do
  lld-link /dll /noentry /machine:x64 /def:"$ROOT/defs/$d.def" /out:"$BUILD/$d-dummy.dll" /implib:"$BUILD/$d.lib"
done
cp "$ROOT/assets/ui_skin_1672x941.bgra" "$BUILD/skin.bgra"
( cd "$BUILD" && objcopy -I binary -O pe-x86-64 -B i386:x86-64 skin.bgra skin.obj )
clang-cl --target=x86_64-pc-windows-msvc /c /O2 /GS- /utf-8 /Fo:"$BUILD/portable_ui.obj" "$ROOT/src/portable_ui.c"
clang --target=x86_64-pc-windows-msvc -c "$ROOT/src/chkstk.s" -o "$BUILD/chkstk_ui.obj"
lld-link /out:"$BUILD/stub.exe" /subsystem:windows /entry:WinMainCRTStartup /nodefaultlib /machine:x64 /stack:4194304 /opt:ref /opt:icf "$BUILD/portable_ui.obj" "$BUILD/chkstk_ui.obj" "$BUILD/skin.obj" "$BUILD/kernel32.lib" "$BUILD/user32.lib" "$BUILD/gdi32.lib" "$BUILD/shell32.lib" "$BUILD/advapi32.lib" "$BUILD/ole32.lib"
python - "$ROOT" <<'PYMAN'
from pathlib import Path
import hashlib, json, sys
root=Path(sys.argv[1]); payload=root/'payload'
files=[]
for p in sorted(x for x in payload.rglob('*') if x.is_file()):
    b=p.read_bytes(); files.append({'name':p.relative_to(payload).as_posix(),'size':len(b),'sha256':hashlib.sha256(b).hexdigest()})
(root/'payload_manifest.json').write_text(json.dumps({'count':len(files),'files':files},indent=2)+'\n',encoding='utf-8')
PYMAN
python "$ROOT/tools/pack_payload.py" "$BUILD/stub.exe" "$ROOT/payload" "$BUILD/LoneEcho2_FR_Traduction_FR_v1.2.0_RC1.exe"
python "$ROOT/tools/verify_exe_payload.py" "$BUILD/LoneEcho2_FR_Traduction_FR_v1.2.0_RC1.exe" "$ROOT/payload_manifest.json"
sha256sum "$BUILD/LoneEcho2_FR_Traduction_FR_v1.2.0_RC1.exe"

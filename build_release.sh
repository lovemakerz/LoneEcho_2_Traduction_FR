#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
BUILD="$ROOT/build"
mkdir -p "$BUILD"
cd "$BUILD"
cp "$ROOT/assets/ui_skin_1672x941.bgra" skin.bgra
objcopy -I binary -O pe-x86-64 -B i386:x86-64 skin.bgra skin.obj
for d in kernel32 user32 gdi32 shell32 advapi32 ole32; do
  lld-link /dll /noentry /machine:x64 /def:"$ROOT/defs/$d.def" /out:"$d-dummy.dll" /implib:"$d.lib"
done
clang-cl --target=x86_64-pc-windows-msvc /c /O2 /GS- /utf-8 /Fo:portable_ui.obj "$ROOT/src/portable_ui.c"
clang --target=x86_64-pc-windows-msvc -c "$ROOT/src/chkstk.s" -o chkstk.obj
lld-link /out:stub.exe /subsystem:windows /entry:WinMainCRTStartup /nodefaultlib /machine:x64 /opt:ref /opt:icf portable_ui.obj chkstk.obj skin.obj kernel32.lib user32.lib gdi32.lib shell32.lib advapi32.lib ole32.lib
python "$ROOT/tools/verify_payload.py" "$ROOT/payload" "$ROOT/payload_manifest.json"
python "$ROOT/tools/pack_payload.py" stub.exe "$ROOT/payload" "$BUILD/LoneEcho2_FR_Traduction_FR_V0.9.0_PORTABLE_UI_TC6.exe"
python "$ROOT/tools/verify_exe_payload.py" "$BUILD/LoneEcho2_FR_Traduction_FR_V0.9.0_PORTABLE_UI_TC6.exe" "$ROOT/payload_manifest.json"
sha256sum "$BUILD/LoneEcho2_FR_Traduction_FR_V0.9.0_PORTABLE_UI_TC6.exe"

#define WIN32_LEAN_AND_MEAN 1

/* Lone Echo II FR portable UI stub - no CRT / no Windows installation. */

typedef unsigned char BYTE;
typedef unsigned short WORD;
typedef unsigned int UINT;
typedef unsigned long DWORD;
typedef long LONG;
typedef unsigned long ULONG;
typedef unsigned long long ULONGLONG;
typedef long long LONGLONG;
typedef unsigned long long ULONG_PTR;
typedef long long LONG_PTR;
typedef ULONG_PTR WPARAM;
typedef LONG_PTR LPARAM;
typedef LONG_PTR LRESULT;
typedef int BOOL;
typedef void VOID;
typedef void* PVOID;
typedef void* LPVOID;
typedef const void* LPCVOID;
typedef unsigned short WCHAR;
typedef WCHAR* LPWSTR;
typedef const WCHAR* LPCWSTR;
typedef char CHAR;
typedef CHAR* LPSTR;
typedef const CHAR* LPCSTR;
typedef void* HANDLE;
typedef HANDLE HINSTANCE;
typedef HANDLE HMODULE;
typedef HANDLE HWND;
typedef HANDLE HDC;
typedef HANDLE HGDIOBJ;
typedef HANDLE HBRUSH;
typedef HANDLE HPEN;
typedef HANDLE HFONT;
typedef HANDLE HRGN;
typedef HANDLE HCURSOR;
typedef HANDLE HICON;
typedef HANDLE HKEY;
typedef HANDLE PIDLIST_ABSOLUTE;
typedef DWORD COLORREF;
typedef DWORD (*LPTHREAD_START_ROUTINE)(LPVOID);
typedef LRESULT (__stdcall *WNDPROC)(HWND, UINT, WPARAM, LPARAM);

typedef struct tagPOINT { LONG x; LONG y; } POINT;
typedef struct tagRECT { LONG left, top, right, bottom; } RECT;
typedef struct tagMSG { HWND hwnd; UINT message; WPARAM wParam; LPARAM lParam; DWORD time; POINT pt; DWORD lPrivate; } MSG;
typedef struct tagPAINTSTRUCT { HDC hdc; BOOL fErase; RECT rcPaint; BOOL fRestore; BOOL fIncUpdate; BYTE rgbReserved[32]; } PAINTSTRUCT;
typedef struct tagWNDCLASSEXW {
    UINT cbSize; UINT style; WNDPROC lpfnWndProc; int cbClsExtra; int cbWndExtra; HINSTANCE hInstance;
    HICON hIcon; HCURSOR hCursor; HBRUSH hbrBackground; LPCWSTR lpszMenuName; LPCWSTR lpszClassName; HICON hIconSm;
} WNDCLASSEXW;
typedef union _LARGE_INTEGER { struct { DWORD LowPart; LONG HighPart; }; LONGLONG QuadPart; } LARGE_INTEGER;
typedef struct _STARTUPINFOW {
    DWORD cb; LPWSTR lpReserved; LPWSTR lpDesktop; LPWSTR lpTitle; DWORD dwX; DWORD dwY; DWORD dwXSize; DWORD dwYSize;
    DWORD dwXCountChars; DWORD dwYCountChars; DWORD dwFillAttribute; DWORD dwFlags; WORD wShowWindow; WORD cbReserved2;
    BYTE* lpReserved2; HANDLE hStdInput; HANDLE hStdOutput; HANDLE hStdError;
} STARTUPINFOW;
typedef struct _PROCESS_INFORMATION { HANDLE hProcess; HANDLE hThread; DWORD dwProcessId; DWORD dwThreadId; } PROCESS_INFORMATION;
typedef struct _WIN32_FIND_DATAW {
    DWORD dwFileAttributes; DWORD ftCreationTimeLow, ftCreationTimeHigh; DWORD ftLastAccessTimeLow, ftLastAccessTimeHigh;
    DWORD ftLastWriteTimeLow, ftLastWriteTimeHigh; DWORD nFileSizeHigh, nFileSizeLow; DWORD dwReserved0, dwReserved1;
    WCHAR cFileName[260]; WCHAR cAlternateFileName[14]; DWORD dwFileType, dwCreatorType; WORD wFinderFlags;
} WIN32_FIND_DATAW;
typedef struct tagBROWSEINFOW { HWND hwndOwner; PIDLIST_ABSOLUTE pidlRoot; LPWSTR pszDisplayName; LPCWSTR lpszTitle; UINT ulFlags; void* lpfn; LPARAM lParam; int iImage; } BROWSEINFOW;
typedef struct tagBITMAPINFOHEADER { DWORD biSize; LONG biWidth; LONG biHeight; WORD biPlanes; WORD biBitCount; DWORD biCompression; DWORD biSizeImage; LONG biXPelsPerMeter; LONG biYPelsPerMeter; DWORD biClrUsed; DWORD biClrImportant; } BITMAPINFOHEADER;
typedef struct tagRGBQUAD { BYTE rgbBlue, rgbGreen, rgbRed, rgbReserved; } RGBQUAD;
typedef struct tagBITMAPINFO { BITMAPINFOHEADER bmiHeader; RGBQUAD bmiColors[1]; } BITMAPINFO;
typedef struct _TOKEN_ELEVATION { DWORD TokenIsElevated; } TOKEN_ELEVATION;

#define NULL ((void*)0)
#define TRUE 1
#define FALSE 0
#define INVALID_HANDLE_VALUE ((HANDLE)(LONG_PTR)-1)
#define WINAPI __stdcall
#define CALLBACK __stdcall

#define MAX_PATH 260
#define CP_UTF8 65001
#define FILE_ATTRIBUTE_DIRECTORY 0x10
#define INVALID_FILE_ATTRIBUTES 0xFFFFFFFFUL
#define GENERIC_READ 0x80000000UL
#define GENERIC_WRITE 0x40000000UL
#define FILE_SHARE_READ 0x1
#define OPEN_EXISTING 3
#define CREATE_ALWAYS 2
#define FILE_ATTRIBUTE_NORMAL 0x80
#define FILE_BEGIN 0
#define CREATE_NO_WINDOW 0x08000000
#define STARTF_USESHOWWINDOW 0x00000001
#define SW_HIDE 0
#define SW_SHOWNORMAL 1
#define SW_MINIMIZE 6
#define INFINITE 0xFFFFFFFFUL
#define WAIT_OBJECT_0 0
#define WS_POPUP 0x80000000UL
#define WS_VISIBLE 0x10000000UL
#define WS_EX_APPWINDOW 0x00040000UL
#define CS_HREDRAW 0x0002
#define CS_VREDRAW 0x0001
#define WM_DESTROY 0x0002
#define WM_PAINT 0x000F
#define WM_CLOSE 0x0010
#define WM_SETCURSOR 0x0020
#define WM_KEYDOWN 0x0100
#define WM_TIMER 0x0113
#define WM_MOUSEMOVE 0x0200
#define WM_LBUTTONDOWN 0x0201
#define WM_LBUTTONUP 0x0202
#define WM_APP 0x8000
#define WM_APP_DONE (WM_APP+7)
#define WM_NCLBUTTONDOWN 0x00A1
#define HTCAPTION 2
#define VK_ESCAPE 0x1B
#define IDC_ARROW ((LPCWSTR)32512)
#define IDC_HAND ((LPCWSTR)32649)
#define SPI_GETWORKAREA 0x0030
#define SWP_NOZORDER 0x0004
#define SWP_NOACTIVATE 0x0010
#define DIB_RGB_COLORS 0
#define SRCCOPY 0x00CC0020
#define HALFTONE 4
#define BI_RGB 0
#define RGN_OR 2
#define TRANSPARENT 1
#define PS_SOLID 0
#define FW_NORMAL 400
#define FW_SEMIBOLD 600
#define FW_BOLD 700
#define DEFAULT_CHARSET 1
#define OUT_DEFAULT_PRECIS 0
#define CLIP_DEFAULT_PRECIS 0
#define CLEARTYPE_QUALITY 5
#define DEFAULT_PITCH 0
#define FF_DONTCARE 0
#define DT_LEFT 0x0000
#define DT_CENTER 0x0001
#define DT_RIGHT 0x0002
#define DT_VCENTER 0x0004
#define DT_WORDBREAK 0x0010
#define DT_SINGLELINE 0x0020
#define DT_END_ELLIPSIS 0x8000
#define TOKEN_QUERY 0x0008
#define TokenElevation 20
#define KEY_READ 0x20019
#define REG_SZ 1
#define REG_EXPAND_SZ 2
#define BIF_RETURNONLYFSDIRS 0x0001
#define BIF_NEWDIALOGSTYLE 0x0040
#define ERROR_SUCCESS 0
#define MOVEFILE_DELAY_UNTIL_REBOOT 0x00000004

#define HKEY_CURRENT_USER ((HKEY)(ULONG_PTR)0xFFFFFFFF80000001ULL)
#define HKEY_LOCAL_MACHINE ((HKEY)(ULONG_PTR)0xFFFFFFFF80000002ULL)

__declspec(dllimport) HMODULE WINAPI GetModuleHandleW(LPCWSTR);
__declspec(dllimport) DWORD WINAPI GetModuleFileNameW(HMODULE,LPWSTR,DWORD);
__declspec(dllimport) DWORD WINAPI GetFileAttributesW(LPCWSTR);
__declspec(dllimport) HANDLE WINAPI CreateFileW(LPCWSTR,DWORD,DWORD,LPVOID,DWORD,DWORD,HANDLE);
__declspec(dllimport) BOOL WINAPI ReadFile(HANDLE,LPVOID,DWORD,DWORD*,LPVOID);
__declspec(dllimport) BOOL WINAPI WriteFile(HANDLE,LPCVOID,DWORD,DWORD*,LPVOID);
__declspec(dllimport) BOOL WINAPI SetFilePointerEx(HANDLE,LARGE_INTEGER,LARGE_INTEGER*,DWORD);
__declspec(dllimport) BOOL WINAPI GetFileSizeEx(HANDLE,LARGE_INTEGER*);
__declspec(dllimport) BOOL WINAPI CloseHandle(HANDLE);
__declspec(dllimport) BOOL WINAPI CreateDirectoryW(LPCWSTR,LPVOID);
__declspec(dllimport) DWORD WINAPI GetTempPathW(DWORD,LPWSTR);
__declspec(dllimport) DWORD WINAPI GetCurrentProcessId(void);
__declspec(dllimport) HANDLE WINAPI GetCurrentProcess(void);
__declspec(dllimport) BOOL WINAPI DeleteFileW(LPCWSTR);
__declspec(dllimport) BOOL WINAPI RemoveDirectoryW(LPCWSTR);
__declspec(dllimport) HANDLE WINAPI FindFirstFileW(LPCWSTR,WIN32_FIND_DATAW*);
__declspec(dllimport) BOOL WINAPI FindNextFileW(HANDLE,WIN32_FIND_DATAW*);
__declspec(dllimport) BOOL WINAPI FindClose(HANDLE);
__declspec(dllimport) BOOL WINAPI CopyFileW(LPCWSTR,LPCWSTR,BOOL);
__declspec(dllimport) BOOL WINAPI CreateProcessW(LPCWSTR,LPWSTR,LPVOID,LPVOID,BOOL,DWORD,LPVOID,LPCWSTR,STARTUPINFOW*,PROCESS_INFORMATION*);
__declspec(dllimport) DWORD WINAPI WaitForSingleObject(HANDLE,DWORD);
__declspec(dllimport) BOOL WINAPI GetExitCodeProcess(HANDLE,DWORD*);
__declspec(dllimport) HANDLE WINAPI CreateThread(LPVOID,ULONG_PTR,LPTHREAD_START_ROUTINE,LPVOID,DWORD,DWORD*);
__declspec(dllimport) void WINAPI Sleep(DWORD);
__declspec(dllimport) DWORD WINAPI GetLastError(void);
__declspec(dllimport) int WINAPI MultiByteToWideChar(UINT,DWORD,LPCSTR,int,LPWSTR,int);
__declspec(dllimport) DWORD WINAPI GetEnvironmentVariableW(LPCWSTR,LPWSTR,DWORD);
__declspec(dllimport) HANDLE WINAPI GetProcessHeap(void);
__declspec(dllimport) LPVOID WINAPI HeapAlloc(HANDLE,DWORD,ULONG_PTR);
__declspec(dllimport) BOOL WINAPI HeapFree(HANDLE,DWORD,LPVOID);
__declspec(dllimport) void WINAPI ExitProcess(UINT);
__declspec(dllimport) BOOL WINAPI MoveFileExW(LPCWSTR,LPCWSTR,DWORD);

__declspec(dllimport) WORD WINAPI RegisterClassExW(const WNDCLASSEXW*);
__declspec(dllimport) HWND WINAPI CreateWindowExW(DWORD,LPCWSTR,LPCWSTR,DWORD,int,int,int,int,HWND,HANDLE,HINSTANCE,LPVOID);
__declspec(dllimport) BOOL WINAPI ShowWindow(HWND,int);
__declspec(dllimport) BOOL WINAPI UpdateWindow(HWND);
__declspec(dllimport) BOOL WINAPI GetMessageW(MSG*,HWND,UINT,UINT);
__declspec(dllimport) BOOL WINAPI TranslateMessage(const MSG*);
__declspec(dllimport) LRESULT WINAPI DispatchMessageW(const MSG*);
__declspec(dllimport) LRESULT WINAPI DefWindowProcW(HWND,UINT,WPARAM,LPARAM);
__declspec(dllimport) HDC WINAPI BeginPaint(HWND,PAINTSTRUCT*);
__declspec(dllimport) BOOL WINAPI EndPaint(HWND,const PAINTSTRUCT*);
__declspec(dllimport) BOOL WINAPI GetClientRect(HWND,RECT*);
__declspec(dllimport) BOOL WINAPI InvalidateRect(HWND,const RECT*,BOOL);
__declspec(dllimport) BOOL WINAPI PostMessageW(HWND,UINT,WPARAM,LPARAM);
__declspec(dllimport) ULONG_PTR WINAPI SetTimer(HWND,ULONG_PTR,UINT,void*);
__declspec(dllimport) BOOL WINAPI KillTimer(HWND,ULONG_PTR);
__declspec(dllimport) BOOL WINAPI SetProcessDPIAware(void);
__declspec(dllimport) BOOL WINAPI SystemParametersInfoW(UINT,UINT,LPVOID,UINT);
__declspec(dllimport) BOOL WINAPI SetWindowPos(HWND,HWND,int,int,int,int,UINT);
__declspec(dllimport) int WINAPI SetWindowRgn(HWND,HRGN,BOOL);
__declspec(dllimport) BOOL WINAPI DestroyWindow(HWND);
__declspec(dllimport) void WINAPI PostQuitMessage(int);
__declspec(dllimport) HCURSOR WINAPI LoadCursorW(HINSTANCE,LPCWSTR);
__declspec(dllimport) HCURSOR WINAPI SetCursor(HCURSOR);
__declspec(dllimport) BOOL WINAPI ReleaseCapture(void);
__declspec(dllimport) LRESULT WINAPI SendMessageW(HWND,UINT,WPARAM,LPARAM);

__declspec(dllimport) int WINAPI StretchDIBits(HDC,int,int,int,int,int,int,int,int,LPCVOID,const BITMAPINFO*,UINT,DWORD);
__declspec(dllimport) int WINAPI SetStretchBltMode(HDC,int);
__declspec(dllimport) HFONT WINAPI CreateFontW(int,int,int,int,int,DWORD,DWORD,DWORD,DWORD,DWORD,DWORD,DWORD,DWORD,LPCWSTR);
__declspec(dllimport) HGDIOBJ WINAPI SelectObject(HDC,HGDIOBJ);
__declspec(dllimport) COLORREF WINAPI SetTextColor(HDC,COLORREF);
__declspec(dllimport) int WINAPI SetBkMode(HDC,int);
__declspec(dllimport) int WINAPI DrawTextW(HDC,LPCWSTR,int,RECT*,UINT);
__declspec(dllimport) HGDIOBJ WINAPI GetStockObject(int);
__declspec(dllimport) HBRUSH WINAPI CreateSolidBrush(COLORREF);
__declspec(dllimport) HPEN WINAPI CreatePen(int,int,COLORREF);
__declspec(dllimport) BOOL WINAPI DeleteObject(HGDIOBJ);
__declspec(dllimport) BOOL WINAPI Rectangle(HDC,int,int,int,int);
__declspec(dllimport) BOOL WINAPI RoundRect(HDC,int,int,int,int,int,int);
__declspec(dllimport) HRGN WINAPI CreateRoundRectRgn(int,int,int,int,int,int);
__declspec(dllimport) HRGN WINAPI CreateRectRgn(int,int,int,int);
__declspec(dllimport) int WINAPI CombineRgn(HRGN,HRGN,HRGN,int);

__declspec(dllimport) ULONG_PTR WINAPI ShellExecuteW(HWND,LPCWSTR,LPCWSTR,LPCWSTR,LPCWSTR,int);
__declspec(dllimport) PIDLIST_ABSOLUTE WINAPI SHBrowseForFolderW(BROWSEINFOW*);
__declspec(dllimport) BOOL WINAPI SHGetPathFromIDListW(PIDLIST_ABSOLUTE,LPWSTR);
__declspec(dllimport) LONG WINAPI RegOpenKeyExW(HKEY,LPCWSTR,DWORD,DWORD,HKEY*);
__declspec(dllimport) LONG WINAPI RegEnumKeyExW(HKEY,DWORD,LPWSTR,DWORD*,DWORD*,LPWSTR,DWORD*,LPVOID);
__declspec(dllimport) LONG WINAPI RegQueryValueExW(HKEY,LPCWSTR,DWORD*,DWORD*,BYTE*,DWORD*);
__declspec(dllimport) LONG WINAPI RegCloseKey(HKEY);
__declspec(dllimport) BOOL WINAPI OpenProcessToken(HANDLE,DWORD,HANDLE*);
__declspec(dllimport) BOOL WINAPI GetTokenInformation(HANDLE,int,LPVOID,DWORD,DWORD*);
__declspec(dllimport) LONG WINAPI OleInitialize(LPVOID);
__declspec(dllimport) void WINAPI OleUninitialize(void);
__declspec(dllimport) void WINAPI CoTaskMemFree(LPVOID);

/* Compiler support, because we link without the CRT. */
void* memset(void* dst, int c, ULONG_PTR n) { BYTE* p=(BYTE*)dst; while(n--) *p++=(BYTE)c; return dst; }
void* memcpy(void* dst, const void* src, ULONG_PTR n) { BYTE* d=(BYTE*)dst; const BYTE* s=(const BYTE*)src; while(n--) *d++=*s++; return dst; }
int memcmp(const void* a,const void* b,ULONG_PTR n){const BYTE*x=(const BYTE*)a,*y=(const BYTE*)b;while(n--){if(*x!=*y)return *x<*y?-1:1;x++;y++;}return 0;}

extern unsigned char _binary_skin_bgra_start[];

#define BASE_W 1200
#define BASE_H 651
#define SKIN_BYTES (BASE_W*BASE_H*4)
#define APP_VERSION L"v1.2.0"
#define ENGINE_BASE L"LE2FR_Engine_V0.9.0.ps1"
#define ENGINE_CAL L"LE2FR_Correctif_Calibration_NON_V0.9.0_R1_Engine.exe"
#define ENGINE_RES L"LE2FR_Correctif_ResidusFinaux_V0.9.0_R2_Engine.exe"
#define ENGINE_READY L"LE2FR_ReadyFix_V0.9.0_R4_Engine.exe"
#define BACKUP_CAL_REL L"LE2_FR_Backup_CALIBRATION_NON_R1"
#define BACKUP_RES_REL L"LE2_FR_V090_RESIDUS_FINAUX_R1_BACKUP"
#define BACKUP_READY_REL L"LE2_FR_READY_V090_R4_BACKUP"
#define GAME_MANIFEST_REL L"_data\\5932408047\\rad16\\win10\\manifests\\ff715342fa4b2d8f"
#define GAME_PACKAGE_REL L"_data\\5932408047\\rad16\\win10\\packages\\ff715342fa4b2d8f_0"
#define GAME_SCRIPTS_REL L"bin\\win10\\scripts"
#define GAME_V090_STATE_REL L"LE2_FR_V0.9.0_STATE.txt"
#define TYPO_DLL_REL L"bin\\win10\\scripts\\0b5f1fcaa265a681.dll"

static HWND gHwnd=NULL;
static WCHAR gExePath[32768];
static WCHAR gGamePath[32768];
static WCHAR gDetectedVersion[128];
static WCHAR gFailureReport[32768];
static WCHAR gModalTitle[256];
static WCHAR gModalBody[4096];
static int gClientW=BASE_W,gClientH=BASE_H;
static int gGameValid=0,gTranslationPresent=0,gFinalActive=0,gV090Base=0,gCalActive=0,gResActive=0,gReadyActive=0,gTyposActive=0,gBusy=0,gOperation=0,gHover=0,gModal=0,gAnim=0,gStage=0;
static DWORD gLastCode=0;
static HCURSOR gArrow=NULL,gHand=NULL;

static ULONG_PTR wlen(LPCWSTR s){ULONG_PTR n=0;if(!s)return 0;while(s[n])n++;return n;}
static void wcopy(LPWSTR d,ULONG_PTR cap,LPCWSTR s){ULONG_PTR i=0;if(!cap)return;while(s&&s[i]&&i+1<cap){d[i]=s[i];i++;}d[i]=0;}
static void wcat(LPWSTR d,ULONG_PTR cap,LPCWSTR s){ULONG_PTR i=wlen(d),j=0;while(s&&s[j]&&i+1<cap)d[i++]=s[j++];d[i]=0;}
static int weq(LPCWSTR a,LPCWSTR b){ULONG_PTR i=0;if(!a||!b)return 0;while(a[i]&&b[i]){WCHAR x=a[i],y=b[i];if(x>='A'&&x<='Z')x+=32;if(y>='A'&&y<='Z')y+=32;if(x!=y)return 0;i++;}return a[i]==0&&b[i]==0;}
static int wpref(LPCWSTR s,LPCWSTR p){ULONG_PTR i=0;if(!s||!p)return 0;while(p[i]){if(s[i]!=p[i])return 0;i++;}return 1;}
static int wcontains(LPCWSTR s,LPCWSTR q){ULONG_PTR i,j,n=wlen(s),m=wlen(q);if(!m)return 1;for(i=0;i+m<=n;i++){for(j=0;j<m&&s[i+j]==q[j];j++){/* compare */}if(j==m)return 1;}return 0;}
static void uint_to_w(DWORD v,LPWSTR out,ULONG_PTR cap){WCHAR t[16];int n=0;if(v==0){wcopy(out,cap,L"0");return;}while(v&&n<15){t[n++]=(WCHAR)(L'0'+v%10);v/=10;}int k=0;while(n&&k+1<(int)cap)out[k++]=t[--n];out[k]=0;}
static COLORREF RGBc(BYTE r,BYTE g,BYTE b){return (COLORREF)(r | ((DWORD)g<<8) | ((DWORD)b<<16));}
static int Sx(int v){return (int)(((LONGLONG)v*gClientW)/BASE_W);} static int Sy(int v){return (int)(((LONGLONG)v*gClientH)/BASE_H);}
static int InBaseRect(int bx,int by,int x1,int y1,int x2,int y2){return bx>=x1&&bx<x2&&by>=y1&&by<y2;}
static void ClientToBase(int x,int y,int* bx,int* by){*bx=(int)(((LONGLONG)x*BASE_W)/gClientW);*by=(int)(((LONGLONG)y*BASE_H)/gClientH);}
static int FileExists(LPCWSTR p){DWORD a=GetFileAttributesW(p);return a!=INVALID_FILE_ATTRIBUTES && !(a&FILE_ATTRIBUTE_DIRECTORY);} static int DirExists(LPCWSTR p){DWORD a=GetFileAttributesW(p);return a!=INVALID_FILE_ATTRIBUTES && (a&FILE_ATTRIBUTE_DIRECTORY);}
static void JoinPath(LPWSTR out,ULONG_PTR cap,LPCWSTR a,LPCWSTR b){wcopy(out,cap,a);ULONG_PTR n=wlen(out);if(n&&out[n-1]!=L'\\'&&out[n-1]!=L'/')wcat(out,cap,L"\\");wcat(out,cap,b);}
static void ParentDir(LPWSTR p){ULONG_PTR n=wlen(p);while(n){if(p[n-1]==L'\\'||p[n-1]==L'/'){p[n-1]=0;return;}n--;}p[0]=0;}
static void ExeDir(LPWSTR out,ULONG_PTR cap){wcopy(out,cap,gExePath);ParentDir(out);}

static void EnsureDirsForFile(LPWSTR path){
    ULONG_PTR n=wlen(path),i; if(n<3)return;
    for(i=3;i<n;i++) if(path[i]==L'\\'||path[i]==L'/'){WCHAR old=path[i];path[i]=0;CreateDirectoryW(path,NULL);path[i]=old;}
}
static int ValidateGameRoot(LPCWSTR root){
    WCHAR* p=(WCHAR*)HeapAlloc(GetProcessHeap(),0,65536); int ok=0; if(!p||!DirExists(root))goto done;
    JoinPath(p,32768,root,GAME_MANIFEST_REL);if(!FileExists(p))goto done;
    JoinPath(p,32768,root,GAME_PACKAGE_REL);if(!FileExists(p))goto done;
    JoinPath(p,32768,root,GAME_SCRIPTS_REL);if(!DirExists(p))goto done;
    ok=1;
done: if(p)HeapFree(GetProcessHeap(),0,p);return ok;
}
static int FindGameUnderSoftwareRoot(LPCWSTR root,LPWSTR out,ULONG_PTR cap){
    WCHAR* pat=(WCHAR*)HeapAlloc(GetProcessHeap(),0,65536);WCHAR* cand=(WCHAR*)HeapAlloc(GetProcessHeap(),0,65536);WIN32_FIND_DATAW fd;HANDLE h;int found=0;
    if(!pat||!cand||!DirExists(root))goto done;JoinPath(pat,32768,root,L"*");h=FindFirstFileW(pat,&fd);if(h==INVALID_HANDLE_VALUE)goto done;
    do{if((fd.dwFileAttributes&FILE_ATTRIBUTE_DIRECTORY)&&!weq(fd.cFileName,L".")&&!weq(fd.cFileName,L"..")){JoinPath(cand,32768,root,fd.cFileName);if(ValidateGameRoot(cand)){wcopy(out,cap,cand);found=1;break;}}}while(FindNextFileW(h,&fd));FindClose(h);
done:if(pat)HeapFree(GetProcessHeap(),0,pat);if(cand)HeapFree(GetProcessHeap(),0,cand);return found;
}
static int TryOculusLibraries(HKEY hive,LPWSTR out,ULONG_PTR cap){
    HKEY key=NULL,sk=NULL;DWORD idx=0,subLen,type,cb;WCHAR sub[512];WCHAR* buf=(WCHAR*)HeapAlloc(GetProcessHeap(),0,65536);WCHAR* c=(WCHAR*)HeapAlloc(GetProcessHeap(),0,65536);int found=0;
    if(!buf||!c)goto done;if(RegOpenKeyExW(hive,L"Software\\Oculus VR, LLC\\Oculus\\Libraries",0,KEY_READ,&key)!=ERROR_SUCCESS)goto done;
    for(;;){subLen=511;if(RegEnumKeyExW(key,idx++,sub,&subLen,NULL,NULL,NULL,NULL)!=ERROR_SUCCESS)break;sub[subLen]=0;if(RegOpenKeyExW(key,sub,0,KEY_READ,&sk)==ERROR_SUCCESS){LPCWSTR names[2]={L"Path",L"OriginalPath"};int ni;for(ni=0;ni<2&&!found;ni++){cb=65536;type=0;buf[0]=0;if(RegQueryValueExW(sk,names[ni],NULL,&type,(BYTE*)buf,&cb)==ERROR_SUCCESS&&(type==REG_SZ||type==REG_EXPAND_SZ)){JoinPath(c,32768,buf,L"Software\\Software");if(FindGameUnderSoftwareRoot(c,out,cap))found=1;if(!found){JoinPath(c,32768,buf,L"Software");if(FindGameUnderSoftwareRoot(c,out,cap))found=1;}if(!found&&FindGameUnderSoftwareRoot(buf,out,cap))found=1;}}RegCloseKey(sk);sk=NULL;if(found)break;}}
done:if(sk)RegCloseKey(sk);if(key)RegCloseKey(key);if(buf)HeapFree(GetProcessHeap(),0,buf);if(c)HeapFree(GetProcessHeap(),0,c);return found;
}
static int DetectGame(LPWSTR out,ULONG_PTR cap){
    WCHAR pf[32768],root[32768];out[0]=0;
    if(TryOculusLibraries(HKEY_CURRENT_USER,out,cap))return 1;if(TryOculusLibraries(HKEY_LOCAL_MACHINE,out,cap))return 1;
    DWORD n=GetEnvironmentVariableW(L"ProgramFiles",pf,32768);if(!n)wcopy(pf,32768,L"C:\\Program Files");JoinPath(root,32768,pf,L"Oculus\\Software\\Software");if(FindGameUnderSoftwareRoot(root,out,cap))return 1;
    if(FindGameUnderSoftwareRoot(L"C:\\Program Files\\Oculus\\Software\\Software",out,cap))return 1;return 0;
}
static int ReadExact(HANDLE h,void* dst,DWORD n);
static int SeekAbs(HANDLE h,ULONGLONG off);
static int BackupDirPresent(LPCWSTR game,LPCWSTR rel){WCHAR p[32768];JoinPath(p,32768,game,rel);return DirExists(p);}
static int CheckBytesAt(LPCWSTR path,ULONGLONG off,const BYTE* expected,DWORD n){HANDLE h=CreateFileW(path,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL);BYTE buf[64];int ok=0;if(h==INVALID_HANDLE_VALUE||n>sizeof(buf))goto done;if(!SeekAbs(h,off)||!ReadExact(h,buf,n))goto done;ok=(memcmp(buf,expected,n)==0);done:if(h!=INVALID_HANDLE_VALUE)CloseHandle(h);return ok;}
static int CheckFinalTypos(LPCWSTR game){
    static const BYTE a[]={'I','n','c','r','o','y','a','b','l','e',' ','?',0};
    static const BYTE b[]={0xC3,0x80,' ','l','a',' ','b','o','n','n','e',' ',0xC3,0xA9,'p','o','q','u','e',' ','?',0};
    WCHAR p[32768];JoinPath(p,32768,game,TYPO_DLL_REL);
    if(!FileExists(p))return 0;
    return CheckBytesAt(p,0x1D640,a,(DWORD)sizeof(a))&&CheckBytesAt(p,0x1D678,b,(DWORD)sizeof(b));
}
static int HasAnyTranslationState(LPCWSTR game){WCHAR pat[32768];WIN32_FIND_DATAW fd;JoinPath(pat,32768,game,L"LE2_FR_V*_STATE.txt");HANDLE h=FindFirstFileW(pat,&fd);if(h==INVALID_HANDLE_VALUE)return 0;int found=0;do{if(!(fd.dwFileAttributes&FILE_ATTRIBUTE_DIRECTORY)&&wpref(fd.cFileName,L"LE2_FR_V")&&wcontains(fd.cFileName,L"_STATE.txt")){found=1;break;}}while(FindNextFileW(h,&fd));FindClose(h);return found;}
static int FindTranslationState(LPCWSTR game,LPWSTR ver,ULONG_PTR cap){
    WCHAR st[32768];
    JoinPath(st,32768,game,GAME_V090_STATE_REL);gV090Base=FileExists(st);
    gCalActive=BackupDirPresent(game,BACKUP_CAL_REL);
    gResActive=BackupDirPresent(game,BACKUP_RES_REL);
    gReadyActive=BackupDirPresent(game,BACKUP_READY_REL);
    gTyposActive=gV090Base?CheckFinalTypos(game):0;
    gFinalActive=gV090Base&&gCalActive&&gResActive&&gReadyActive&&gTyposActive;
    ver[0]=0;
    if(gFinalActive){wcopy(ver,cap,L"v1.2.0");return 1;}
    if(gV090Base||gCalActive||gResActive||gReadyActive||HasAnyTranslationState(game)){wcopy(ver,cap,L"ANCIENNE / PARTIELLE");return 1;}
    return 0;
}
static void RefreshState(void){gGameValid=ValidateGameRoot(gGamePath);gTranslationPresent=0;gFinalActive=0;gV090Base=0;gCalActive=0;gResActive=0;gReadyActive=0;gTyposActive=0;gDetectedVersion[0]=0;if(gGameValid)gTranslationPresent=FindTranslationState(gGamePath,gDetectedVersion,128);}

static int IsElevated(void){HANDLE tok=NULL;TOKEN_ELEVATION te;DWORD got=0;memset(&te,0,sizeof(te));if(!OpenProcessToken(GetCurrentProcess(),TOKEN_QUERY,&tok))return 0;BOOL ok=GetTokenInformation(tok,TokenElevation,&te,sizeof(te),&got);CloseHandle(tok);return ok&&te.TokenIsElevated;}
static void EnsureElevatedOrExit(void){if(IsElevated())return;ULONG_PTR r=ShellExecuteW(NULL,L"runas",gExePath,NULL,NULL,SW_SHOWNORMAL);if(r>32)ExitProcess(0);ExitProcess(1);}

static void ApplySkinRegion(HWND hwnd){
    HRGN full=CreateRectRgn(0,0,0,0);
    if(!full)return;
    int y=0;
    for(y=0;y<BASE_H;y++){
        int x=0;
        while(x<BASE_W){
            while(x<BASE_W && _binary_skin_bgra_start[(y*BASE_W+x)*4+3]<10) x++;
            if(x>=BASE_W) break;
            int x0=x;
            while(x<BASE_W && _binary_skin_bgra_start[(y*BASE_W+x)*4+3]>=10) x++;
            HRGN row=CreateRectRgn(x0,y,x,y+1);
            if(row){CombineRgn(full,full,row,RGN_OR);DeleteObject(row);}
        }
    }
    SetWindowRgn(hwnd,full,TRUE);
}

static int BrowseForGame(HWND owner,LPWSTR out,ULONG_PTR cap){
    BROWSEINFOW bi;WCHAR display[MAX_PATH];memset(&bi,0,sizeof(bi));memset(display,0,sizeof(display));bi.hwndOwner=owner;bi.pszDisplayName=display;bi.lpszTitle=L"Sélectionnez le dossier racine de Lone Echo II";bi.ulFlags=BIF_RETURNONLYFSDIRS|BIF_NEWDIALOGSTYLE;PIDLIST_ABSOLUTE p=SHBrowseForFolderW(&bi);if(!p)return 0;WCHAR path[MAX_PATH];path[0]=0;BOOL ok=SHGetPathFromIDListW(p,path);CoTaskMemFree(p);if(ok){wcopy(out,cap,path);return 1;}return 0;
}

static int ReadExact(HANDLE h,void* dst,DWORD n){BYTE* p=(BYTE*)dst;DWORD done=0,r=0;while(done<n){if(!ReadFile(h,p+done,n-done,&r,NULL)||r==0)return 0;done+=r;}return 1;}
static int WriteExact(HANDLE h,const void* src,DWORD n){const BYTE* p=(const BYTE*)src;DWORD done=0,w=0;while(done<n){if(!WriteFile(h,p+done,n-done,&w,NULL)||w==0)return 0;done+=w;}return 1;}
static ULONGLONG ReadU64LE(const BYTE* b){ULONGLONG v=0;int i;for(i=7;i>=0;i--)v=(v<<8)|b[i];return v;} static DWORD ReadU32LE(const BYTE*b){return (DWORD)b[0]|((DWORD)b[1]<<8)|((DWORD)b[2]<<16)|((DWORD)b[3]<<24);} static WORD ReadU16LE(const BYTE*b){return (WORD)(b[0]|((WORD)b[1]<<8));}
static int SeekAbs(HANDLE h,ULONGLONG off){LARGE_INTEGER li;li.QuadPart=(LONGLONG)off;return SetFilePointerEx(h,li,NULL,FILE_BEGIN);}
static int ExtractPayload(LPCWSTR outDir,LPWSTR err,ULONG_PTR errcap){
    HANDLE h=CreateFileW(gExePath,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL);LARGE_INTEGER sz;BYTE foot[16],head[12],small[10];ULONGLONG start;DWORD count,i;BYTE* buf=NULL;WCHAR* rel=NULL;WCHAR* target=NULL;int ok=0;
    if(h==INVALID_HANDLE_VALUE){wcopy(err,errcap,L"Impossible d'ouvrir l'exécutable.");return 0;}if(!GetFileSizeEx(h,&sz)||sz.QuadPart<16){wcopy(err,errcap,L"Exécutable incomplet.");goto done;}if(!SeekAbs(h,(ULONGLONG)sz.QuadPart-16)||!ReadExact(h,foot,16)||memcmp(foot,"LE2END01",8)!=0){wcopy(err,errcap,L"Payload interne introuvable.");goto done;}start=ReadU64LE(foot+8);if(start>=(ULONGLONG)sz.QuadPart-16||!SeekAbs(h,start)||!ReadExact(h,head,12)||memcmp(head,"LE2PAY01",8)!=0){wcopy(err,errcap,L"Payload interne invalide.");goto done;}count=ReadU32LE(head+8);if(count==0||count>10000){wcopy(err,errcap,L"Table du payload invalide.");goto done;}
    CreateDirectoryW(outDir,NULL);buf=(BYTE*)HeapAlloc(GetProcessHeap(),0,1024*1024);rel=(WCHAR*)HeapAlloc(GetProcessHeap(),0,8192*sizeof(WCHAR));target=(WCHAR*)HeapAlloc(GetProcessHeap(),0,32768*sizeof(WCHAR));if(!buf||!rel||!target){wcopy(err,errcap,L"Mémoire insuffisante.");goto done;}
    for(i=0;i<count;i++){if(!ReadExact(h,small,10)){wcopy(err,errcap,L"Payload tronqué.");goto done;}WORD nl=ReadU16LE(small);ULONGLONG fsz=ReadU64LE(small+2);if(nl==0||nl>4095){wcopy(err,errcap,L"Nom de fichier interne invalide.");goto done;}CHAR* nb=(CHAR*)HeapAlloc(GetProcessHeap(),0,nl+1);if(!nb){wcopy(err,errcap,L"Mémoire insuffisante.");goto done;}if(!ReadExact(h,nb,nl)){HeapFree(GetProcessHeap(),0,nb);wcopy(err,errcap,L"Payload tronqué.");goto done;}nb[nl]=0;int wn=MultiByteToWideChar(CP_UTF8,0,nb,nl,rel,8191);HeapFree(GetProcessHeap(),0,nb);if(wn<=0){wcopy(err,errcap,L"Nom UTF-8 invalide.");goto done;}rel[wn]=0;int k;for(k=0;k<wn;k++){if(rel[k]==L'/')rel[k]=L'\\';}if(wcontains(rel,L"..")||wcontains(rel,L":")){wcopy(err,errcap,L"Chemin interne dangereux.");goto done;}JoinPath(target,32768,outDir,rel);EnsureDirsForFile(target);HANDLE o=CreateFileW(target,GENERIC_WRITE,0,NULL,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL);if(o==INVALID_HANDLE_VALUE){wcopy(err,errcap,L"Impossible d'écrire les données temporaires.");goto done;}ULONGLONG rem=fsz;while(rem){DWORD ch=rem>1024*1024?1024*1024:(DWORD)rem;if(!ReadExact(h,buf,ch)||!WriteExact(o,buf,ch)){CloseHandle(o);wcopy(err,errcap,L"Écriture du payload impossible.");goto done;}rem-=ch;}CloseHandle(o);}
    ok=1;
done:if(buf)HeapFree(GetProcessHeap(),0,buf);if(rel)HeapFree(GetProcessHeap(),0,rel);if(target)HeapFree(GetProcessHeap(),0,target);CloseHandle(h);return ok;
}
static void RemoveTree(LPCWSTR root){
    if(!DirExists(root))return;WCHAR* pat=(WCHAR*)HeapAlloc(GetProcessHeap(),0,65536);WCHAR* p=(WCHAR*)HeapAlloc(GetProcessHeap(),0,65536);WIN32_FIND_DATAW fd;if(!pat||!p)goto end;JoinPath(pat,32768,root,L"*");HANDLE h=FindFirstFileW(pat,&fd);if(h!=INVALID_HANDLE_VALUE){do{if(!weq(fd.cFileName,L".")&&!weq(fd.cFileName,L"..")){JoinPath(p,32768,root,fd.cFileName);if(fd.dwFileAttributes&FILE_ATTRIBUTE_DIRECTORY)RemoveTree(p);else DeleteFileW(p);}}while(FindNextFileW(h,&fd));FindClose(h);}RemoveDirectoryW(root);
end:if(pat)HeapFree(GetProcessHeap(),0,pat);if(p)HeapFree(GetProcessHeap(),0,p);
}
static void CleanupGameArtifacts(LPCWSTR game){
    WCHAR pat[32768],p[32768];WIN32_FIND_DATAW fd;JoinPath(pat,32768,game,L"*");HANDLE h=FindFirstFileW(pat,&fd);if(h==INVALID_HANDLE_VALUE)return;do{if(weq(fd.cFileName,L".")||weq(fd.cFileName,L".."))continue;JoinPath(p,32768,game,fd.cFileName);if(fd.dwFileAttributes&FILE_ATTRIBUTE_DIRECTORY){if(wpref(fd.cFileName,L"LE2_FR_Backup_BEFORE_")||wpref(fd.cFileName,L"LE2_FR_ORIGINAL_ENGLISH_BASE_")||wpref(fd.cFileName,L"LE2_FR_ORIGINAL_SCRIPTS_BASE_"))RemoveTree(p);}else if(wpref(fd.cFileName,L"LE2_FR_V")&&wcontains(fd.cFileName,L"_STATE.txt"))DeleteFileW(p);}while(FindNextFileW(h,&fd));FindClose(h);
}
static void MakeTempDir(LPWSTR out,ULONG_PTR cap){WCHAR t[32768],pid[32];DWORD n=GetTempPathW(32768,t);if(!n)wcopy(t,32768,L"C:\\Windows\\Temp\\");uint_to_w(GetCurrentProcessId(),pid,32);wcopy(out,cap,t);wcat(out,cap,L"LE2FR_PORTABLE_");wcat(out,cap,pid);}
static DWORD RunBaseEngine(LPCWSTR temp,LPCWSTR game,int restore){
    WCHAR* ps=(WCHAR*)HeapAlloc(GetProcessHeap(),0,65536);WCHAR* reports=(WCHAR*)HeapAlloc(GetProcessHeap(),0,65536);WCHAR* cmd=(WCHAR*)HeapAlloc(GetProcessHeap(),0,131072);STARTUPINFOW si;PROCESS_INFORMATION pi;DWORD code=1;if(!ps||!reports||!cmd){code=8;goto done;}JoinPath(ps,32768,temp,ENGINE_BASE);JoinPath(reports,32768,temp,L"reports");CreateDirectoryW(reports,NULL);wcopy(cmd,65536,L"powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File \"");wcat(cmd,65536,ps);wcat(cmd,65536,L"\" ");if(restore)wcat(cmd,65536,L"-RestoreEnglish ");wcat(cmd,65536,L"-GamePath \"");wcat(cmd,65536,game);wcat(cmd,65536,L"\" -ReportRoot \"");wcat(cmd,65536,reports);wcat(cmd,65536,L"\" -NoPause");memset(&si,0,sizeof(si));memset(&pi,0,sizeof(pi));si.cb=sizeof(si);si.dwFlags=STARTF_USESHOWWINDOW;si.wShowWindow=SW_HIDE;if(!CreateProcessW(NULL,cmd,NULL,NULL,FALSE,CREATE_NO_WINDOW,NULL,temp,&si,&pi)){code=GetLastError();goto done;}WaitForSingleObject(pi.hProcess,INFINITE);GetExitCodeProcess(pi.hProcess,&code);CloseHandle(pi.hThread);CloseHandle(pi.hProcess);
done:if(ps)HeapFree(GetProcessHeap(),0,ps);if(reports)HeapFree(GetProcessHeap(),0,reports);if(cmd)HeapFree(GetProcessHeap(),0,cmd);return code;
}
static DWORD RunEngineNamed(LPCWSTR temp,LPCWSTR game,LPCWSTR engineName,int restore){
    WCHAR* eng=(WCHAR*)HeapAlloc(GetProcessHeap(),0,65536);WCHAR* reports=(WCHAR*)HeapAlloc(GetProcessHeap(),0,65536);WCHAR* cmd=(WCHAR*)HeapAlloc(GetProcessHeap(),0,131072);STARTUPINFOW si;PROCESS_INFORMATION pi;DWORD code=1;if(!eng||!reports||!cmd){code=8;goto done;}JoinPath(eng,32768,temp,engineName);JoinPath(reports,32768,temp,L"reports");CreateDirectoryW(reports,NULL);wcopy(cmd,65536,L"\"");wcat(cmd,65536,eng);wcat(cmd,65536,L"\" ");if(restore)wcat(cmd,65536,L"--restore ");wcat(cmd,65536,L"--game \"");wcat(cmd,65536,game);wcat(cmd,65536,L"\" --report-root \"");wcat(cmd,65536,reports);wcat(cmd,65536,L"\"");memset(&si,0,sizeof(si));memset(&pi,0,sizeof(pi));si.cb=sizeof(si);si.dwFlags=STARTF_USESHOWWINDOW;si.wShowWindow=SW_HIDE;if(!CreateProcessW(NULL,cmd,NULL,NULL,FALSE,CREATE_NO_WINDOW,NULL,temp,&si,&pi)){code=GetLastError();goto done;}WaitForSingleObject(pi.hProcess,INFINITE);GetExitCodeProcess(pi.hProcess,&code);CloseHandle(pi.hThread);CloseHandle(pi.hProcess);
done:if(eng)HeapFree(GetProcessHeap(),0,eng);if(reports)HeapFree(GetProcessHeap(),0,reports);if(cmd)HeapFree(GetProcessHeap(),0,cmd);return code;
}
static int WriteAsciiFile(LPCWSTR path,const char* text){HANDLE h=CreateFileW(path,GENERIC_WRITE,0,NULL,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL);if(h==INVALID_HANDLE_VALUE)return 0;DWORD n=0;while(text[n])n++;int ok=WriteExact(h,text,n);CloseHandle(h);return ok;}
static void CopyOneReport(LPCWSTR temp,LPCWSTR name){WCHAR reports[32768],src[32768],dst[32768],exeDir[32768];JoinPath(reports,32768,temp,L"reports");JoinPath(src,32768,reports,name);ExeDir(exeDir,32768);JoinPath(dst,32768,exeDir,name);if(FileExists(src))CopyFileW(src,dst,FALSE);}
static void PreserveChildReports(LPCWSTR temp){
    CopyOneReport(temp,L"Rapport_LoneEcho2_FR_Correctif_Calibration_NON_V0.9.0_R1.txt");
    CopyOneReport(temp,L"Rapport_LoneEcho2_FR_Correctif_ResidusFinaux_V0.9.0_R2.txt");
    CopyOneReport(temp,L"Rapport_LoneEcho2_FR_ReadyFix_V0.9.0_R4.txt");
}
static void PreserveBaseFailureReport(LPCWSTR temp){
    WCHAR dir[32768],pat[32768],src[32768],dst[32768],exeDir[32768];WIN32_FIND_DATAW fd;JoinPath(dir,32768,temp,L"reports");JoinPath(pat,32768,dir,L"*.zip");HANDLE h=FindFirstFileW(pat,&fd);if(h==INVALID_HANDLE_VALUE)return;JoinPath(src,32768,dir,fd.cFileName);FindClose(h);ExeDir(exeDir,32768);JoinPath(dst,32768,exeDir,L"Rapport_LoneEcho2_FR_v1.2.0_ECHEC.zip");if(CopyFileW(src,dst,FALSE))wcopy(gFailureReport,32768,dst);
}
static void WriteFinalReport(int op,int stage,DWORD code){
    WCHAR exeDir[32768],dst[32768];ExeDir(exeDir,32768);JoinPath(dst,32768,exeDir,L"Rapport_LoneEcho2_FR_v1.2.0_RC1.txt");
    const char* text=NULL;
    if(op==1&&code==0) text="LONE ECHO II - TRADUCTION FR v1.2.0 RC1\r\n==========================================\r\nRESULTAT: INSTALL_OK\r\nBASE: corpus complet V0.9.0 integre depuis jeu anglais propre.\r\nFINAUX: Calibration Non + 15 corrections ff715 + READY R4 + 2 corrections typographiques.\r\nRATIONS: exclu volontairement.\r\n";
    else if(op==2&&code==0) text="LONE ECHO II - TRADUCTION FR v1.2.0 RC1\r\n==========================================\r\nRESULTAT: UNINSTALL_OK - jeu restaure en anglais.\r\n";
    else if(stage==1) text="LONE ECHO II - TRADUCTION FR v1.2.0 RC1\r\nRESULTAT: ERROR_BASE - echec du moteur de traduction complet.\r\n";
    else if(stage==2) text="LONE ECHO II - TRADUCTION FR v1.2.0 RC1\r\nRESULTAT: ERROR_CALIBRATION - rollback tente.\r\n";
    else if(stage==3) text="LONE ECHO II - TRADUCTION FR v1.2.0 RC1\r\nRESULTAT: ERROR_RESIDUS - rollback tente.\r\n";
    else if(stage==4) text="LONE ECHO II - TRADUCTION FR v1.2.0 RC1\r\nRESULTAT: ERROR_READY - rollback tente.\r\n";
    else text="LONE ECHO II - TRADUCTION FR v1.2.0 RC1\r\nRESULTAT: ERROR_VERIFY - etat final incomplet ou verification typographique echouee.\r\n";
    WriteAsciiFile(dst,text);if(code!=0)wcopy(gFailureReport,32768,dst);
}
static DWORD WINAPI WorkerProc(LPVOID p){
    int op=(int)(ULONG_PTR)p;WCHAR temp[32768],err[512],bp[32768],st[32768];DWORD code=1;int stage=0;int preBase=0,preCal=0,preRes=0,preReady=0;MakeTempDir(temp,32768);RemoveTree(temp);gFailureReport[0]=0;err[0]=0;gStage=0;
    if(!ExtractPayload(temp,err,512)){code=0xE001;wcopy(gModalBody,4096,err);goto finish;}
    JoinPath(st,32768,gGamePath,GAME_V090_STATE_REL);preBase=HasAnyTranslationState(gGamePath);JoinPath(bp,32768,gGamePath,BACKUP_CAL_REL);preCal=DirExists(bp);JoinPath(bp,32768,gGamePath,BACKUP_RES_REL);preRes=DirExists(bp);JoinPath(bp,32768,gGamePath,BACKUP_READY_REL);preReady=DirExists(bp);
    if(op==1){
        if(preBase||preCal||preRes||preReady){code=0xE100;stage=1;goto finish;}
        gStage=1;stage=1;code=RunBaseEngine(temp,gGamePath,0);if(code)goto install_fail;
        gStage=2;stage=2;code=RunEngineNamed(temp,gGamePath,ENGINE_CAL,0);if(code)goto install_fail;
        gStage=3;stage=3;code=RunEngineNamed(temp,gGamePath,ENGINE_RES,0);if(code)goto install_fail;
        gStage=4;stage=4;code=RunEngineNamed(temp,gGamePath,ENGINE_READY,0);if(code)goto install_fail;
        gStage=5;stage=5;RefreshState();if(!gFinalActive){code=0xE105;goto install_fail;}code=0;goto finish;
install_fail:
        if(stage>=4&&BackupDirPresent(gGamePath,BACKUP_READY_REL))RunEngineNamed(temp,gGamePath,ENGINE_READY,1);
        if(stage>=3&&BackupDirPresent(gGamePath,BACKUP_RES_REL))RunEngineNamed(temp,gGamePath,ENGINE_RES,1);
        if(stage>=2&&BackupDirPresent(gGamePath,BACKUP_CAL_REL))RunEngineNamed(temp,gGamePath,ENGINE_CAL,1);
        if(stage>=1)RunBaseEngine(temp,gGamePath,1);
        goto finish;
    }else{
        gStage=1;stage=4;if(preReady){code=RunEngineNamed(temp,gGamePath,ENGINE_READY,1);if(code)goto finish;}
        gStage=2;stage=3;if(preRes){code=RunEngineNamed(temp,gGamePath,ENGINE_RES,1);if(code)goto finish;}
        gStage=3;stage=2;if(preCal){code=RunEngineNamed(temp,gGamePath,ENGINE_CAL,1);if(code)goto finish;}
        gStage=4;stage=1;if(preBase){code=RunBaseEngine(temp,gGamePath,1);if(code)goto finish;}
        gStage=5;CleanupGameArtifacts(gGamePath);stage=5;code=0;
    }
finish:
    if(code!=0){PreserveChildReports(temp);PreserveBaseFailureReport(temp);}WriteFinalReport(op,stage,code);RemoveTree(temp);gStage=0;PostMessageW(gHwnd,WM_APP_DONE,(WPARAM)code,(LPARAM)op);return 0;
}

static void FillBox(HDC dc,int x1,int y1,int x2,int y2,COLORREF fill,COLORREF border,int radius){HBRUSH b=CreateSolidBrush(fill);HPEN p=CreatePen(PS_SOLID,Sy(2)<1?1:Sy(2),border);HGDIOBJ ob=SelectObject(dc,b),op=SelectObject(dc,p);RoundRect(dc,Sx(x1),Sy(y1),Sx(x2),Sy(y2),Sy(radius),Sy(radius));SelectObject(dc,op);SelectObject(dc,ob);DeleteObject(p);DeleteObject(b);}
static void OutlineBox(HDC dc,int x1,int y1,int x2,int y2,COLORREF border,int radius,int width){HPEN p=CreatePen(PS_SOLID,Sy(width)<1?1:Sy(width),border);HGDIOBJ op=SelectObject(dc,p),ob=SelectObject(dc,GetStockObject(5));RoundRect(dc,Sx(x1),Sy(y1),Sx(x2),Sy(y2),Sy(radius),Sy(radius));SelectObject(dc,ob);SelectObject(dc,op);DeleteObject(p);}
static void DrawTxt(HDC dc,LPCWSTR text,int x,int y,int w,int h,int px,COLORREF col,int weight,UINT fmt){HFONT f=CreateFontW(-Sy(px),0,0,0,weight,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,CLEARTYPE_QUALITY,DEFAULT_PITCH|FF_DONTCARE,L"Segoe UI");HGDIOBJ old=SelectObject(dc,f);SetBkMode(dc,TRANSPARENT);SetTextColor(dc,col);RECT r={Sx(x),Sy(y),Sx(x+w),Sy(y+h)};DrawTextW(dc,text,-1,&r,fmt);SelectObject(dc,old);DeleteObject(f);}
static void DrawDynamic(HDC dc){
    COLORREF panel=RGBc(4,22,29),field=RGBc(4,15,21),white=RGBc(234,241,245),muted=RGBc(173,190,201),cyan=RGBc(23,224,238),red=RGBc(242,91,96),amber=RGBc(247,184,72);
    /* Recouvre toujours la version V0.9.0 imprimee dans le skin de reference. */
    FillBox(dc,150,438,558,505,panel,panel,1);
    DrawTxt(dc,L"Version installée :",162,444,145,22,14,white,FW_NORMAL,DT_LEFT|DT_VCENTER|DT_SINGLELINE);
    DrawTxt(dc,gFinalActive?L"v1.2.0":(gTranslationPresent?L"Ancienne":L"—"),314,444,120,23,18,gFinalActive?cyan:(gTranslationPresent?amber:cyan),FW_SEMIBOLD,DT_LEFT|DT_VCENTER|DT_SINGLELINE);
    DrawTxt(dc,gFinalActive?L"La traduction française v1.2.0 est installée et à jour.":(gTranslationPresent?L"Une traduction existante est détectée — désinstallez-la avant v1.2.0.":L"La traduction française n'est pas installée."),162,476,388,19,12,muted,FW_NORMAL,DT_LEFT|DT_VCENTER|DT_SINGLELINE);
    FillBox(dc,639,462,1017,485,field,field,1);
    if(gGameValid) DrawTxt(dc,gGamePath,647,464,362,18,12,white,FW_NORMAL,DT_LEFT|DT_VCENTER|DT_SINGLELINE|DT_END_ELLIPSIS);
    else DrawTxt(dc,L"Aucun dossier Lone Echo II valide sélectionné",647,464,362,18,12,red,FW_NORMAL,DT_LEFT|DT_VCENTER|DT_SINGLELINE|DT_END_ELLIPSIS);
    FillBox(dc,635,489,1007,507,panel,panel,1);
    if(!gGameValid) DrawTxt(dc,L"Jeu non détecté — utilisez parcourir",641,489,360,17,11,red,FW_SEMIBOLD,DT_LEFT|DT_VCENTER|DT_SINGLELINE);
    else if(gFinalActive) DrawTxt(dc,L"Installation complète vérifiée.",641,489,360,17,11,cyan,FW_SEMIBOLD,DT_LEFT|DT_VCENTER|DT_SINGLELINE);
    else if(gTranslationPresent) DrawTxt(dc,L"Désinstallation requise avant la v1.2.0.",641,489,360,17,11,amber,FW_SEMIBOLD,DT_LEFT|DT_VCENTER|DT_SINGLELINE);
    else DrawTxt(dc,L"Jeu détecté — prêt pour l'installation.",641,489,360,17,11,cyan,FW_SEMIBOLD,DT_LEFT|DT_VCENTER|DT_SINGLELINE);
}

static void DrawModal(HDC dc){
    if(!gModal&&!gBusy)return;
    COLORREF panel=RGBc(5,20,29),edge=RGBc(57,205,220),white=RGBc(239,245,248),muted=RGBc(183,199,208),cyan=RGBc(34,226,238),red=RGBc(239,87,91),barbg=RGBc(15,32,43);
    if(gBusy){
        int x1=265,y1=190,x2=935;
        FillBox(dc,x1,y1,x2,468,panel,edge,18);
        DrawTxt(dc,gOperation==1?L"INSTALLATION v1.2.0 EN COURS":L"RESTAURATION EN COURS",x1+35,y1+34,600,34,24,white,FW_SEMIBOLD,DT_CENTER|DT_VCENTER|DT_SINGLELINE);
        DrawTxt(dc,gOperation==1?gStage==1?L"Installation du corpus français complet…":gStage==2?L"Correction Calibration Non…":gStage==3?L"Application des 15 corrections ff715…":gStage==4?L"Correction READY…":L"Vérification finale v1.2.0…":gStage==1?L"Restauration READY…":gStage==2?L"Restauration des corrections ff715…":gStage==3?L"Restauration Calibration…":gStage==4?L"Restauration du jeu anglais…":L"Nettoyage et vérification finale…",x1+50,y1+86,570,44,17,muted,FW_NORMAL,DT_CENTER|DT_WORDBREAK);
        FillBox(dc,x1+75,y1+150,x2-75,y1+182,barbg,RGBc(92,112,124),8);
        {int bw=(x2-x1)-170;int seg=180;int span=bw+seg;int pos=(gAnim*28)%span - seg;int sx=x1+85+(pos<0?0:pos);int ex=x1+85+((pos+seg)>bw?bw:(pos+seg));if(ex>sx)FillBox(dc,sx,y1+156,ex,y1+176,RGBc(10,90,108),cyan,6);} 
        DrawTxt(dc,L"Progression",x1+75,y1+189,120,18,13,cyan,FW_SEMIBOLD,DT_LEFT|DT_VCENTER|DT_SINGLELINE);
        DrawTxt(dc,L"Veuillez patienter. Ne fermez pas cette fenêtre pendant l'opération.",x1+60,y1+222,550,22,14,muted,FW_NORMAL,DT_CENTER|DT_VCENTER|DT_SINGLELINE);
        return;
    }
    if(gModal==1){
        FillBox(dc,185,132,1015,465,panel,edge,18);
        DrawTxt(dc,L"À PROPOS",225,162,300,26,16,cyan,FW_SEMIBOLD,DT_LEFT|DT_VCENTER|DT_SINGLELINE);
        DrawTxt(dc,L"Lone Echo II — Traduction française non officielle",225,198,750,34,22,white,FW_SEMIBOLD,DT_LEFT|DT_VCENTER|DT_SINGLELINE);
        LPCWSTR body=L"Traduction française réalisée par LoVeMaKeRz.\nProjet communautaire gratuit et non affilié, approuvé ou sponsorisé par les détenteurs des droits de Lone Echo II.\nLone Echo II, ses marques, personnages, visuels et autres éléments associés restent la propriété de leurs détenteurs respectifs.\nCe patch nécessite une copie légitime de Lone Echo II et ne contient pas le jeu original.";
        DrawTxt(dc,body,225,246,750,118,15,muted,FW_NORMAL,DT_LEFT|DT_WORDBREAK);
        DrawTxt(dc,L"v1.2.0  •  Installateur portable complet  •  RATIONS exclu",225,384,470,20,13,RGBc(119,150,165),FW_NORMAL,DT_LEFT|DT_VCENTER|DT_SINGLELINE);
        FillBox(dc,815,382,955,420,RGBc(9,45,56),cyan,8);
        DrawTxt(dc,L"FERMER",815,388,140,26,15,white,FW_SEMIBOLD,DT_CENTER|DT_VCENTER|DT_SINGLELINE);
        return;
    }
    FillBox(dc,290,165,910,450,panel,(gModal==3)?red:edge,18);
    DrawTxt(dc,gModalTitle,330,198,540,34,22,white,FW_SEMIBOLD,DT_CENTER|DT_VCENTER|DT_SINGLELINE);
    DrawTxt(dc,gModalBody,338,248,525,82,16,muted,FW_NORMAL,DT_CENTER|DT_WORDBREAK);
    if(gModal==2||gModal==3){COLORREF ce=(gModal==3)?red:cyan;FillBox(dc,380,365,560,405,RGBc(11,43,52),ce,8);FillBox(dc,640,365,820,405,RGBc(23,31,37),RGBc(102,122,134),8);DrawTxt(dc,gModal==3?L"DÉSINSTALLER":L"INSTALLER",380,372,180,25,16,white,FW_SEMIBOLD,DT_CENTER|DT_VCENTER|DT_SINGLELINE);DrawTxt(dc,L"ANNULER",640,372,180,25,16,white,FW_SEMIBOLD,DT_CENTER|DT_VCENTER|DT_SINGLELINE);}else{FillBox(dc,520,365,680,405,RGBc(11,43,52),cyan,8);DrawTxt(dc,L"FERMER",520,372,160,25,16,white,FW_SEMIBOLD,DT_CENTER|DT_VCENTER|DT_SINGLELINE);}    
}
static void Paint(HWND hwnd){PAINTSTRUCT ps;HDC dc=BeginPaint(hwnd,&ps);RECT cr;GetClientRect(hwnd,&cr);gClientW=cr.right-cr.left;gClientH=cr.bottom-cr.top;BITMAPINFO bi;memset(&bi,0,sizeof(bi));bi.bmiHeader.biSize=sizeof(BITMAPINFOHEADER);bi.bmiHeader.biWidth=BASE_W;bi.bmiHeader.biHeight=-BASE_H;bi.bmiHeader.biPlanes=1;bi.bmiHeader.biBitCount=32;bi.bmiHeader.biCompression=BI_RGB;SetStretchBltMode(dc,HALFTONE);StretchDIBits(dc,0,0,gClientW,gClientH,0,0,BASE_W,BASE_H,_binary_skin_bgra_start,&bi,DIB_RGB_COLORS,SRCCOPY);DrawDynamic(dc);DrawModal(dc);EndPaint(hwnd,&ps);}
static void ShowInfo(LPCWSTR title,LPCWSTR body){wcopy(gModalTitle,256,title);wcopy(gModalBody,4096,body);gModal=4;InvalidateRect(gHwnd,NULL,FALSE);}
static void StartOperation(int op){if(gBusy)return;gBusy=1;gOperation=op;gModal=0;gAnim=0;SetTimer(gHwnd,1,80,NULL);HANDLE th=CreateThread(NULL,0,WorkerProc,(LPVOID)(ULONG_PTR)op,0,NULL);if(th)CloseHandle(th);else{gBusy=0;KillTimer(gHwnd,1);ShowInfo(L"Impossible de démarrer",L"Le thread d'installation n'a pas pu être créé.");}InvalidateRect(gHwnd,NULL,FALSE);}
static int Hotspot(int bx,int by){
    if(InBaseRect(bx,by,1123,30,1162,67))return 11;     /* close */
    if(InBaseRect(bx,by,1028,460,1142,487))return 3;   /* Parcourir */
    if(InBaseRect(bx,by,37,522,594,597))return 1;      /* Installer */
    if(InBaseRect(bx,by,610,523,1162,596))return 2;    /* Désinstaller */
    if(InBaseRect(bx,by,42,605,140,644))return 4;      /* À propos */
    return 0;
}
static LRESULT CALLBACK WndProc(HWND hwnd,UINT msg,WPARAM wp,LPARAM lp){
    if(msg==WM_PAINT){Paint(hwnd);return 0;}if(msg==WM_DESTROY){PostQuitMessage(0);return 0;}if(msg==WM_CLOSE){if(!gBusy)DestroyWindow(hwnd);return 0;}
    if(msg==WM_TIMER){if(gBusy){gAnim++;InvalidateRect(hwnd,NULL,FALSE);}return 0;}
    if(msg==WM_APP_DONE){KillTimer(hwnd,1);gBusy=0;gLastCode=(DWORD)wp;RefreshState();if(gLastCode==0){if((int)lp==1)ShowInfo(L"Installation terminée",L"La traduction française v1.2.0 a été installée et vérifiée avec succès.");else ShowInfo(L"Désinstallation terminée",L"La traduction française a été désinstallée. Lone Echo II a été restauré en anglais.");}else{WCHAR body[4096];wcopy(body,4096,L"L'opération a échoué. Un rollback automatique a été tenté. Consultez le rapport de diagnostic créé à côté de cet installateur.");if(gFailureReport[0]){wcat(body,4096,L"\n\nRapport :\n");wcat(body,4096,gFailureReport);}ShowInfo(L"Erreur",body);}InvalidateRect(hwnd,NULL,FALSE);return 0;}
    if(msg==WM_MOUSEMOVE){int x=(short)(lp&0xFFFF),y=(short)((lp>>16)&0xFFFF),bx,by;ClientToBase(x,y,&bx,&by);int h=(gModal||gBusy)?0:Hotspot(bx,by);if(h!=gHover){gHover=h;SetCursor(h?gHand:gArrow);InvalidateRect(hwnd,NULL,FALSE);}return 0;}
    if(msg==WM_SETCURSOR){SetCursor(gHover?gHand:gArrow);return TRUE;}
    if(msg==WM_KEYDOWN&&wp==VK_ESCAPE){if(gBusy)return 0;if(gModal){gModal=0;InvalidateRect(hwnd,NULL,FALSE);}else DestroyWindow(hwnd);return 0;}
    if(msg==WM_LBUTTONDOWN){if(gModal||gBusy)return 0;int x=(short)(lp&0xFFFF),y=(short)((lp>>16)&0xFFFF),bx,by;ClientToBase(x,y,&bx,&by);if(by<80&&!InBaseRect(bx,by,1123,30,1162,67)){ReleaseCapture();SendMessageW(hwnd,WM_NCLBUTTONDOWN,HTCAPTION,0);return 0;}return 0;}
    if(msg==WM_LBUTTONUP){int x=(short)(lp&0xFFFF),y=(short)((lp>>16)&0xFFFF),bx,by;ClientToBase(x,y,&bx,&by);
        if(gBusy)return 0;
        if(gModal){if(gModal==1){if(InBaseRect(bx,by,815,382,955,420)){gModal=0;InvalidateRect(hwnd,NULL,FALSE);}}else if(gModal==2||gModal==3){if(InBaseRect(bx,by,380,365,560,405)){int op=gModal==2?1:2;StartOperation(op);}else if(InBaseRect(bx,by,640,365,820,405)){gModal=0;InvalidateRect(hwnd,NULL,FALSE);}}else if(InBaseRect(bx,by,520,365,680,405)){gModal=0;InvalidateRect(hwnd,NULL,FALSE);}return 0;}
        int h=Hotspot(bx,by);if(h==11){DestroyWindow(hwnd);return 0;}if(h==4){gModal=1;InvalidateRect(hwnd,NULL,FALSE);return 0;}if(h==3){WCHAR p[32768];if(BrowseForGame(hwnd,p,32768)){if(ValidateGameRoot(p)){wcopy(gGamePath,32768,p);RefreshState();InvalidateRect(hwnd,NULL,FALSE);}else ShowInfo(L"Dossier non valide",L"Ce dossier ne correspond pas à une installation compatible de Lone Echo II.");}return 0;}
        if(h==1){if(!gGameValid){ShowInfo(L"Jeu introuvable",L"Sélectionnez d'abord le dossier racine de Lone Echo II avec le bouton Parcourir…");return 0;}if(gFinalActive){ShowInfo(L"Déjà installée",L"La traduction française v1.2.0 est déjà installée et vérifiée.");return 0;}if(gTranslationPresent){ShowInfo(L"Traduction existante détectée",L"Une ancienne version ou une installation partielle est détectée. Utilisez d'abord Désinstaller la traduction pour restaurer le jeu en anglais, puis installez la v1.2.0.");return 0;}wcopy(gModalTitle,256,L"Installer la traduction v1.2.0 ?");wcopy(gModalBody,4096,L"Le programme va sauvegarder les fichiers anglais, installer la traduction française complète puis appliquer les correctifs finaux et vérifier le résultat. L'utilitaire lui-même ne sera pas installé dans Windows.");gModal=2;InvalidateRect(hwnd,NULL,FALSE);return 0;}
        if(h==2){if(!gGameValid){ShowInfo(L"Jeu introuvable",L"Sélectionnez d'abord le dossier racine de Lone Echo II avec le bouton Parcourir…");return 0;}if(!gTranslationPresent){ShowInfo(L"Aucune traduction détectée",L"Aucune traduction française gérée par cet outil n'est actuellement détectée dans ce dossier.");return 0;}wcopy(gModalTitle,256,L"Désinstaller la traduction ?");wcopy(gModalBody,4096,L"Lone Echo II sera restauré en anglais à partir des sauvegardes originales. Les correctifs seront retirés en ordre inverse puis les fichiers français seront restaurés vers l'anglais.");gModal=3;InvalidateRect(hwnd,NULL,FALSE);return 0;}
        return 0;}
    return DefWindowProcW(hwnd,msg,wp,lp);
}

static int AppMain(void){
    GetModuleFileNameW(NULL,gExePath,32768);OleInitialize(NULL);SetProcessDPIAware();gArrow=LoadCursorW(NULL,IDC_ARROW);gHand=LoadCursorW(NULL,IDC_HAND);gGamePath[0]=0;DetectGame(gGamePath,32768);RefreshState();
    WNDCLASSEXW wc;memset(&wc,0,sizeof(wc));wc.cbSize=sizeof(wc);wc.style=CS_HREDRAW|CS_VREDRAW;wc.lpfnWndProc=WndProc;wc.hInstance=GetModuleHandleW(NULL);wc.hCursor=gArrow;wc.lpszClassName=L"LE2FRInstallerV120";if(!RegisterClassExW(&wc)){OleUninitialize();return 2;}
    RECT work;memset(&work,0,sizeof(work));SystemParametersInfoW(SPI_GETWORKAREA,0,&work,0);int w=BASE_W,h=BASE_H;int x=work.left+(work.right-work.left-w)/2,y=work.top+(work.bottom-work.top-h)/2;if(x<work.left)x=work.left;if(y<work.top)y=work.top;
    gHwnd=CreateWindowExW(WS_EX_APPWINDOW,L"LE2FRInstallerV120",L"Lone Echo II — Traduction française v1.2.0",WS_POPUP|WS_VISIBLE,x,y,w,h,NULL,NULL,wc.hInstance,NULL);if(!gHwnd){OleUninitialize();return 3;}ApplySkinRegion(gHwnd);ShowWindow(gHwnd,SW_SHOWNORMAL);UpdateWindow(gHwnd);MSG m;while(GetMessageW(&m,NULL,0,0)>0){TranslateMessage(&m);DispatchMessageW(&m);}OleUninitialize();return 0;
}
void WINAPI WinMainCRTStartup(void){int r=AppMain();ExitProcess((UINT)r);}

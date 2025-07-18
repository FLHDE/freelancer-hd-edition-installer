[Code]
// Used to detect if the user is using WINE or not
function LoadLibraryA(lpLibFileName: PAnsiChar): THandle;
  external 'LoadLibraryA@kernel32.dll stdcall';

function GetProcAddress(Module: THandle; ProcName: PAnsiChar): Longword;
  external 'GetProcAddress@kernel32.dll stdcall';

// Gets the attributes for a file or directory (e.g. read and write)
function GetFileAttributes(lpFileName: string): DWORD;
 external 'GetFileAttributesW@kernel32.dll stdcall';

// Sets the attributes for a file or directory (e.g. read and write)
function SetFileAttributes(lpFileName: string; dwFileAttributes: DWORD): BOOL;
  external 'SetFileAttributesW@kernel32.dll stdcall';

function ShellExecuteEx(var lpExecInfo: TShellExecuteInfo): BOOL;
  external 'ShellExecuteExW@shell32.dll stdcall';

function GetExitCodeProcess(Process: THandle; var ExitCode: Cardinal): Boolean;
  external 'GetExitCodeProcess@kernel32.dll stdcall';

function WaitForSingleObject(hHandle: THandle; dwMilliseconds: DWORD): DWORD;
  external 'WaitForSingleObject@kernel32.dll stdcall';

function CloseHandle(hObject: THandle): BOOL; 
  external 'CloseHandle@kernel32.dll stdcall';

function PeekMessage(var lpMsg: TMsg; hWnd: HWND; wMsgFilterMin, wMsgFilterMax, wRemoveMsg: UINT): BOOL; 
  external 'PeekMessageA@user32.dll stdcall';

function TranslateMessage(const lpMsg: TMsg): BOOL;
  external 'TranslateMessage@user32.dll stdcall';

function DispatchMessage(const lpMsg: TMsg): Longint;
  external 'DispatchMessageA@user32.dll stdcall';

// Gets the device context
function GetDC(hWnd: DWord): DWord;
  external 'GetDC@user32.dll stdcall';

// Releases the device context
function ReleaseDC(hWnd: DWord; hDC: DWord): Integer;
  external 'ReleaseDC@user32.dll stdcall';

// Used to retrieve information about a device 
function GetDeviceCaps(hDC, nIndex: Integer): Integer;
 external 'GetDeviceCaps@GDI32 stdcall';

// Used to convert a binary expression in string format to an actual binary stream
function ConvertHexToBinary(hexString: string; hexLength: LongWord; binaryString: AnsiString): Boolean;
  external 'ConvertHexToBinary@files:HexToBinary.dll cdecl setuponly delayload';

// Use Windows function to convert date modified to a useable format
function FileTimeToSystemTime(
FileTime:        TFileTime; 
var SystemTime:  SYSTEMTIME
): Boolean; 
external 'FileTimeToSystemTime@kernel32.dll stdcall';

// Used to retrieve information about display devices
function EnumDisplayDevices(lpDevice: DWORD; iDevNum: DWORD; var lpDisplayDevice: DISPLAY_DEVICEA; dwFlags: DWORD) : BOOL;
  external 'EnumDisplayDevicesA@user32.dll stdcall';

// Wtf?
procedure ZeroMemory(var Destination: DISPLAY_DEVICEA; Length: integer);
  external 'RtlZeroMemory@kernel32.dll stdcall';

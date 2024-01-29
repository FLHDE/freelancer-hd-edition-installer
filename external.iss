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

// Gets the device context
function GetDC(HWND: DWord): DWord;
  external 'GetDC@user32.dll stdcall';

// Used to retrieve information about a device 
function GetDeviceCaps (hDC, nIndex: Integer): Integer;
 external 'GetDeviceCaps@GDI32 stdcall';

// Used to convert a binary expression in string format to an actual binary stream
function ConvertHexToBinary(hexString: string; hexLength: LongWord; binaryString: string): Boolean;
  external 'ConvertHexToBinary@files:HexToBinary.dll cdecl setuponly delayload';

// Define type for SYSTEMTIME. We only care about the year here really.
type  
SYSTEMTIME = record 
  Year:         WORD; 
  Month:        WORD; 
  DayOfWeek:    WORD; 
  Day:          WORD; 
  Hour:         WORD; 
  Minute:       WORD; 
  Second:       WORD; 
  Milliseconds: WORD; 
end;

type
DISPLAY_DEVICEA = record
  cb: DWORD;
  DeviceName: array [0 .. 31] of AnsiChar;
  DeviceString: array [0 .. 127] of AnsiChar;
  StateFlags: DWORD;
  DeviceID, DeviceKey: array [0..127] of AnsiChar;
end;

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

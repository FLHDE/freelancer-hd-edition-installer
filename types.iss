[Code]
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
  TShellExecuteInfo = record
    cbSize: DWORD;
    fMask: Cardinal;
    Wnd: HWND;
    lpVerb: string;
    lpFile: string;
    lpParameters: string;
    lpDirectory: string;
    nShow: Integer;
    hInstApp: THandle;
    lpIDList: DWORD;
    lpClass: string;
    hkeyClass: THandle;
    dwHotKey: DWORD;
    hMonitor: THandle;
    hProcess: THandle;
  end;

type
  TMsg = record
    hwnd: HWND;
    message: UINT;
    wParam: Longint;
    lParam: Longint;
    time: DWORD;
    pt: TPoint;
    lPrivate: DWORD;
  end;

type
DISPLAY_DEVICEA = record
  cb: DWORD;
  DeviceName: array [0 .. 31] of AnsiChar;
  DeviceString: array [0 .. 127] of AnsiChar;
  StateFlags: DWORD;
  DeviceID, DeviceKey: array [0..127] of AnsiChar;
end;

// Data type for a desktop resolution (stores the width and height of the display in pixels)
type
	DesktopResolution = record
		Width: Integer;
		Height: Integer;
end;

// Enum for GPU manufacturers
type
  // NVIDIA and Other are currently not distinguished
  // TGpuManufacturer = (NVIDIA, AMD, Other);
  TGpuManufacturer = (NVIDIAOrOther, AMD);

type
  TSystemLanguage = (S_German, S_French, S_Russian, S_EnglishOrOther);

type
  FlLanguage = (FL_English, FL_German, FL_French, FL_Russian, FL_Spanish, FL_Mandarin, FL_Czech, FL_Unknown);

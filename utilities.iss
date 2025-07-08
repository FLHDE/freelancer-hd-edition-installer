[Code]

function GetIsWine: boolean;
var  LibHandle  : THandle;
begin
  LibHandle := LoadLibraryA('ntdll.dll');
  Result := GetProcAddress(LibHandle, 'wine_get_version') <> 0;
end;

// Shows a debug message to the screen if debug mode is turned on.
// This function is basicaly like a debug assert but instead of stopping the program, it shows a message.
// This is useful for catching bugs during development.
procedure DebugMsg(msg : string);
begin
  if DebugMode then
    MsgBox('Debug Message: ' + msg, mbError, MB_OK)
end;

// Removes a read-only attribute from a file
procedure RemoveReadOnly(FileName : String);
var
 Attr : DWord;
begin
  Attr := GetFileAttributes(FileName);

  if (Attr and 1) = 1 then
  begin
    Attr := Attr -1;
    SetFileAttributes(FileName, Attr);
  end;
end;

// The two procs below are used to execute an external program without blocking Inno's UI thread
procedure AppProcessMessage;
var
  Msg: TMsg;
begin
  while PeekMessage(Msg, WizardForm.Handle, 0, 0, PM_REMOVE) do begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;
end;

function ShellExecuteAsync(fileName: string; parameters: string): Boolean;
var
  ExecInfo: TShellExecuteInfo;
  ExitCode: Cardinal;
begin
  ExecInfo.cbSize := SizeOf(ExecInfo);
  ExecInfo.fMask := SEE_MASK_NOCLOSEPROCESS;
  ExecInfo.Wnd := 0;
  ExecInfo.lpFile := fileName;
  ExecInfo.lpParameters := parameters;
  ExecInfo.nShow := SW_HIDE;

  if not FileExists(fileName) then
    RaiseException('File not found to execute: ' + fileName);

  if ShellExecuteEx(ExecInfo) then
  begin
    while WaitForSingleObject(ExecInfo.hProcess, 100) = WAIT_TIMEOUT
    do begin
      AppProcessMessage;
      WizardForm.Refresh();
    end;

    if GetExitCodeProcess(ExecInfo.hProcess, ExitCode) then
    begin
      Result := ExitCode = 0;
    end
    else
      Result := False;

    CloseHandle(ExecInfo.hProcess);
  end;
end;

// Used to copy the vanilla install to {app}, also the extracted .zip file back to {app}
// Old method because this blocks the UI thread, causing the installer to "freeze"
procedure DirectoryCopy(SourcePath, DestPath: string; Move: Boolean; SkipFlExe: Boolean);
var
  FindRec: TFindRec;
  SourceFilePath: string;
  DestFilePath: string;
begin
  if FindFirst(SourcePath + '\*', FindRec) then
  begin
    try
      repeat
        if (FindRec.Name <> '.') and (FindRec.Name <> '..') and not (SkipFlExe and (FindRec.Name = 'Freelancer.exe')) then
        begin
          SourceFilePath := SourcePath + '\' + FindRec.Name;
          DestFilePath := DestPath + '\' + FindRec.Name;
          if FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY = 0 then
          begin
            if not CopyFile(SourceFilePath, DestFilePath, False) then
            begin
              RaiseException(Format('Failed to copy %s to %s', [
                SourceFilePath, DestFilePath]));
            end;

            // Delete the source file if we just want to move instead of copy
            if Move then
              DeleteFile(SourceFilePath);

            // We want to ensure every file has write access so we can properly overwrite them later.
            // Presumably these permissions aren't an issue on Wine.
            if not IsWine then
              RemoveReadOnly(DestFilePath);
          end
            else
          begin
            if DirExists(DestFilePath) or CreateDir(DestFilePath) then
              DirectoryCopy(SourceFilePath, DestFilePath, Move, SkipFlExe)
              else
              RaiseException(Format('Failed to create %s', [DestFilePath]));
          end;
        end;
      until not FindNext(FindRec);
    finally
      FindClose(FindRec);
    end;
  end
    else
  begin
    RaiseException(Format('Failed to list %s', [SourcePath]));
  end;
end;

// Tries to copy a directory without blocking the UI thread.
// If this fails for whatever reason, copy the directory the normal way, but this will block the UI thread.
procedure TryDirectoryCopyAsync(SourcePath, DestPath: string; Move: Boolean; SkipFlExe: Boolean);
begin
  if LegacyDirCpy or (not ShellExecuteAsync(ExpandConstant('{tmp}\dircpy.exe'), Format('"%s" "%s" %d %d', [SourcePath, DestPath, Integer(Move), Integer(SkipFlExe)]))) then
    DirectoryCopy(SourcePath, DestPath, Move, SkipFlExe);
end;

// Used to replace strings in files. This replaces FLMM functions
function FileReplaceString(const FileName, SearchString, ReplaceString: string):boolean;
var
  MyFile : TStrings;
  MyText : string;
  Index : Integer;
begin
  MyFile := TStringList.Create;

  if not FileExists(FileName) then
  begin
    DebugMsg(Format('Cannot replace string "%s" in file "%s" because the file does not exist.', [SearchString, FileName]));
    result := false
    exit
  end;

  try
    result := true;

    try
      RemoveReadOnly(FileName);

      MyFile.LoadFromFile(FileName);
      MyText := MyFile.Text;

      // Save the file in which the text has been changed
      if StringChangeEx(MyText, SearchString, ReplaceString, True) > 0 then
      begin;
        MyFile.Text := MyText;
        MyFile.SaveToFile(FileName);

        // Keep track of all config files that have been edited. We only want to store each file name once.
        if not EditedConfigFiles.Find(FileName, Index) then
          EditedConfigFiles.Add(FileName);
      end
      else begin
        DebugMsg(Format('No occurrence of the string "%s" found to replace in file "%s".', [SearchString, FileName]));
      end;
    except
      result := false;
    end;
  finally
    MyFile.Free;
  end;
end;

// Gets the user's main monitor resolution
function GetResolution(): DesktopResolution;
var
  DC: DWord;
begin
  try
    DC := GetDC(0);

    if DC = 0 then
      RaiseException('Couldn''t get the device context');

    Result.Width := GetDeviceCaps(DC, HORZRES);
    Result.Height := GetDeviceCaps(DC, VERTRES);

    ReleaseDC(0, DC);

    if (Result.Width = 0) or (Result.Height = 0) then
      RaiseException('Display Width and/or Height cannot be 0');
  except
    Result.Width := 1920
    Result.Height := 1080
  end;
end;

function DesktopResPixelAmount: Integer;
begin
  Result := DesktopRes.Width * DesktopRes.Height;
end;

// Gets the user's main monitor refresh rate
function GetRefreshRate(): Integer;
var
  DC: DWord;
begin
  try
    DC := GetDC(0);

    if DC = 0 then
      RaiseException('Couldn''t get the device context');

    Result := GetDeviceCaps(DC, VREFRESH);

    ReleaseDC(0, DC);

    if Result = 0 then
      RaiseException('Refresh Rate cannot be 0');
  except
    Result := 60
  end;
end;

// Whether or not the desktop resolution is within the specified range of factors
function IsResWithinAspectRatioRange(MinFactor: Single; MaxFactor: Single): Boolean;
var
  ResolutionFactor: Single;
begin
  ResolutionFactor := Single(DesktopRes.Width) / Single(DesktopRes.Height);

  Result := (ResolutionFactor >= MinFactor) and (ResolutionFactor <= MaxFactor)
end;

// Converts an int to hex
function IntToHex(Value: Integer; Digits: Integer): string;
begin
  Result := Format('%.*x', [Digits, Value])
end;

function StrContainsNonAsciiChars(const str: string): Boolean;
begin
  Result := Pos('?', string(AnsiString(str))) > 0;
end;

// Swaps 2 bytes in a binary string (2 bytes, or 4 characters assumed)
function SwapBytes(BinaryString: string): string;
begin
  Result := BinaryString[3] + BinaryString[4] + BinaryString[1] + BinaryString[2]
end;

// Used to perform a hex edit in a file at a specific location
function WriteHexToFile(FileName: string; Offset: longint; Hex: string): Boolean;
var
  Stream: TFileStream;
  Buffer: AnsiString;
  BufferLen: LongWord;
begin
  if not FileExists(FileName) then
  begin
    DebugMsg(Format('Cannot write hex "%s" to file "%s" because the file does not exist.', [Hex, FileName]));
    Result := false
    exit
  end;

  RemoveReadOnly(FileName);

  Stream := TFileStream.Create(FileName, fmOpenReadWrite);

  try
    BufferLen := Length(Hex) div 2;
    SetLength(Buffer, BufferLen);

    Result := ConvertHexToBinary(Hex, Length(Hex), Buffer);

    if not Result then
      RaiseException('Could not convert string to binary stream');

    Stream.Seek(Offset, soFromBeginning);
    Stream.WriteBuffer(Buffer, BufferLen);
  finally
    Stream.Free;
  end;
end;

// Checks if the given hex bytes are present in a file at a specific location
function VerifyHexInFile(FileName: string; Offset: longint; Hex: string): Boolean;
var
  Stream: TFileStream;
  SrcBuffer, FileBuffer: AnsiString;
  BufferLen: LongWord;
begin
  if not FileExists(FileName) then
  begin
    DebugMsg(Format('Cannot read hex "%s" in file "%s" because the file does not exist.', [Hex, FileName]));
    Result := false
    exit
  end;

  RemoveReadOnly(FileName);

  Stream := TFileStream.Create(FileName, fmOpenRead);

  try
    BufferLen := Length(Hex) div 2;
    SetLength(SrcBuffer, BufferLen);
    SetLength(FileBuffer, BufferLen);

    if not ConvertHexToBinary(Hex, Length(Hex), SrcBuffer) then
      RaiseException('Could not convert string to binary stream');

    Stream.Seek(Offset, soFromBeginning);
    Stream.ReadBuffer(FileBuffer, BufferLen);

    Result := CompareStr(SrcBuffer, FileBuffer) = 0;
  except
    Result := false
  finally
    Stream.Free;
  end;
end;

// Returns true if the directory is empty
function isEmptyDir(dirName: String): Boolean;
var
  FindRec: TFindRec;
  FileCount: Integer;
begin
  Result := True;
  if FindFirst(dirName+'\*', FindRec) then begin
    try
      repeat
        if (FindRec.Name <> '.') and (FindRec.Name <> '..') then begin
          FileCount := 1
          Result := False
          break;
        end;
      until not FindNext(FindRec);
    finally
      FindClose(FindRec);
      if FileCount = 0 then Result := True;
    end;
  end;
end;

// Used to remove an unwanted byte order mark in a file.
// Calls an external program to take care of that.
function RemoveBOM(const FileName: String): Boolean;
begin
  Result := ShellExecuteAsync(ExpandConstant('{tmp}\utf-8-bom-remover.exe'), Format('"%s"', [FileName]));
end;

// Whether the given char is a digit
function IsDigit(C: Char): Boolean;
begin
  Result := (C >= '0') and (C <= '9')
end;

// Creates a directory only if it doesn't exist yet
procedure CreateDirIfNotExists(const Dir: String);
begin
  if not DirExists(Dir) then
    CreateDir(Dir);
end;

// Remove all 2003 files in a folder of a certain type
procedure RemoveJunkFiles(FileType: string);
var
FindRec: TFindRec;
SystemInfo: SYSTEMTIME;
begin
  // If we've found a *.type file in the specified folder, then...
  if FindFirst(ExpandConstant('{app}\*.' + FileType), FindRec) then
    try
      // Repeat loop for every *.type file in the specified folder
      repeat
        // If the iterated item is not a directory named like Dir.type
        if FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY = 0 then
        begin
          // Convert LastWrite time to our custom type
          FileTimeToSystemTime( FindRec.LastWriteTime, SystemInfo)
          // Convert from our custom type to a string and compare with 2003
          if Format('%4.4d',[SystemInfo.Year]) = '2003' then
            // If it is 2003 then delete
            DeleteFile(ExpandConstant('{app}\') + FindRec.Name);
        end;
      until
        // When there no next file item, the loop ends
        not FindNext(FindRec);
    finally
      // Release the allocated search resources
      FindClose(FindRec);
  end;
end;

// Whether or not the current operating system could suffer from the major lighting bug in Freelancer
function GetHasLightingBug(): Boolean;
var
  Version: TWindowsVersion;
begin
  // We're assuming there's no issues on Wine.
  if IsWine then
  begin
    Result := false
    exit
  end;

  GetWindowsVersionEx(Version);

  // No issues on Windows 8.1 and older.
  if Version.Major < 10 then
  begin
    Result := false
    exit
  end
  // Because the issue was introduced in Windows 10 Minor 0, newer versions definitely have it too.
  else if (Version.Major > 10) or (Version.Minor > 0) then
  begin
    Result := true
    exit
  end;

  // Windows 10 version 2004 (20H1), or build 19041 is the first known Windows version where the lighting bug appears.
  // Returns true if the current version is equal to or newer than this build.
  Result := Version.Build >= 19041;
end;

// Convert a char array to string (both Ansi)
function CharArrayToStringAnsi(charArray: array of AnsiChar): AnsiString;
var
  i: integer;
begin
  for i := Low(charArray) to High(charArray) do
  begin
    // If we've reached a null-character, that means we're at the end of the string
    if charArray[i] = #0 then
      break;

    Result := Result + charArray[i];
  end;
end;

// Gets the manufacturer of the user's GPU
function GetGpuManufacturer(): TGpuManufacturer;
var
  i: integer;
  device: DISPLAY_DEVICEA;
  isAmdMain, isNvidiaMain, isOtherMain, hasAmd, hasNvidia, hasOther: bool;
  deviceString: AnsiString;
begin
  try
    if IsWine then
      RaiseException('Wine just returns "Wine Adapter", so don''t bother');

    // Loop over all display devices in the system
    while true do
    begin
      // Zero the display device prior to retrieving the data
      ZeroMemory(device, SizeOf(device));
      device.cb := SizeOf(device);

      // Continue until there are no more devices left to check
      if not EnumDisplayDevices(0, i, device, EDD_GET_DEVICE_INTERFACE_NAME) then
        break;

      deviceString := '' // The string needs to be made empty first, otherwise bad things will happen
      deviceString := CharArrayToStringAnsi(device.DeviceString);

      // Main GPU?
      if (device.StateFlags and DISPLAY_DEVICE_PRIMARY_DEVICE) = DISPLAY_DEVICE_PRIMARY_DEVICE then
      begin
        if Pos('AMD', deviceString) > 0 then
          isAmdMain := true
        else if Pos('NVIDIA', deviceString) > 0 then
          isNvidiaMain := true
        else
          isOtherMain := true
      end
      // Secondary GPU?
      else
      begin
        if Pos('AMD', deviceString) > 0 then
          hasAmd := true
        else if Pos('NVIDIA', deviceString) > 0 then
          hasNvidia := true
        else
          hasOther := true;
      end;

      i := i + 1;
    end;

    // Determine what the most likely primary GPU is
    // In the installer we currently do the same thing for NVIDIA GPUs and any GPU other than AMD, hence they don't need to be distinguishable.
    if isAmdMain then
      Result := AMD
    else if isNvidiaMain then
      //Result := NVIDIA
      Result := NVIDIAOrOther
    else if isOtherMain and hasAmd and not hasNvidia then
      Result := AMD
    else if isOtherMain and not hasAmd and hasNvidia then
      //Result := NVIDIA
      Result := NVIDIAOrOther
    else if isOtherMain and not hasAmd and not hasNvidia then
      //Result := Other
      Result := NVIDIAOrOther
    else
      RaiseException('Couldn''t determine GPU manufacturer');
  except
    // If something has gone wrong, just ask the user what GPU they have
    //if MsgBox('We weren''t able to automatically determine what graphics card is in your system. We use this information to apply the best compatibility options.'
    //+ #13#10#13#10 + 'Please click "Yes" if your computer has an NVIDIA graphics card. Click "No" if otherwise.', mbConfirmation, MB_YESNO) = IDYES then
    //  Result := NVIDIA
    //else if MsgBox('Please click "Yes" if your system uses an AMD graphics card. Click "No" if the graphics card is from another manufacturer like Intel.', mbConfirmation, MB_YESNO) = IDYES then
    //  Result := AMD
    //else
    //  Result := Other;

    // If the wizard is running silently and the GPU manufacturer couldn't be determined, just assume AMD since it's the safest option.
    // Though this can still be adjusted manually via the debug options (see silent_options.iss)
    if WizardSilent then
      Result := AMD
    else if MsgBox('We weren''t able to automatically determine what graphics card is in your system. We use this information to apply the best compatibility options.'
    + #13#10#13#10 + 'Please click "Yes" if your computer has an AMD graphics card. Click "No" if the graphics card is from another manufacturer like Intel or NVIDIA.', mbConfirmation, MB_YESNO) = IDYES then
      Result := AMD
    else
      Result := NVIDIAOrOther;
  end;
end;

// Determine what language the user's system is
function GetSystemLanguage(): TSystemLanguage;
var
  UILanguage: Integer;
begin
  UILanguage := GetUILanguage

  // $3FF is used to extract the primary language identifier
  if UILanguage and $3FF = $07 then // $07 = German primary language identifier
    Result := S_German
  else if UILanguage and $3FF = $0C then // $0C = French primary language identifier
    Result := S_French
  else if UILanguage and $3FF = $19 then // $19 = Russian primary language identifier
    Result := S_Russian
  else
    Result := S_EnglishOrOther;
end;

// Determine what language the user's Freelancer installation is based on the OfferBribeResources.dll file
// The reason we use OfferBribeResources.dll is because this file is rarely touched by different variations of a translation, also the file size is smaller
function GetFreelancerLanguage(FreelancerPath: string): FlLanguage;
var
  OfferBribeResourcesFile: string;
  OfferBribeResourcesMD5: string;
begin
  OfferBribeResourcesFile := FreelancerPath + '\EXE\offerbriberesources.dll';

  // Check if the OfferBribeResources file exists
  if not FileExists(OfferBribeResourcesFile) then
  begin
    Result := FL_Unknown;
    exit;
  end;

  // GetMD5OfFile throws an exception if it fails, so we put it in a try statement just to be sure
  try
    OfferBribeResourcesMD5 := GetMD5OfFile(OfferBribeResourcesFile);
  except
    Result := FL_Unknown;
    exit;
  end;

  // Compare the MD5 hash to a list of known MD5 hashes from different language files
  case OfferBribeResourcesMD5 of
    '9fb0c85a1f88e516762d71cbfbb69fa7', '801c5c314887e43de8f04dbeee921a31', 'f002ba64816723cb96d82af2c7af988a': Result := FL_English; // Vanilla English (official), JFLP v1.25 English, TSR v1.2 English
    '403c420f051dc3ce14fcd2f7b63cf0c8': Result := FL_German; // German (official)
    '78a283161a7aa6c91756733a4b456ab1': Result := FL_French; // French (official)
    '6ed61e8db874b5b8bae72d3689ac1f43', '1c5736b9c808538ff77174c29a2ffa08': Result := FL_Russian; // Russian translations by Elite-Games and Noviy Disk
    '17933dcced8a8faa0c1f2316f8289c35': Result := FL_Spanish; // Spanish translation by Clan DLAN
    'eaeab5c42d6d6a4d54dd1927a1351a6d': Result := FL_Mandarin; // Mandarin/Taiwanese translation
    'fad76d9880579e841b98d018e8dbde6c', '3aa0eda21eca3529fbb23dae54a73053': Result := FL_Czech; // WIP Czech translation by Spider and the complete Czech translation by Starsoul (28/07/2024)
    '7bcd1ff86475b9050ec32fc0b2d1743b', '12bb9c278af7dda8505867f3e4a5da06': Result := FL_Hungarian; // Hungarian translation by Guillotine and another one by Garner, Dömike, Jip, and Cerberus
  else
    Result := FL_Unknown;
  end;
end;

// Compares two version strings
function CompareVersion(V1, V2: string): Integer;
var
  P, N1, N2: Integer;
begin
  Result := 0;
  while (Result = 0) and ((V1 <> '') or (V2 <> '')) do
  begin
    P := Pos('.', V1);
    if P > 0 then
    begin
      N1 := StrToInt(Copy(V1, 1, P - 1));
      Delete(V1, 1, P);
    end
      else
    if V1 <> '' then
    begin
      N1 := StrToInt(V1);
      V1 := '';
    end
      else
    begin
      N1 := 0;
    end;

    P := Pos('.', V2);
    if P > 0 then
    begin
      N2 := StrToInt(Copy(V2, 1, P - 1));
      Delete(V2, 1, P);
    end
      else
    if V2 <> '' then
    begin
      N2 := StrToInt(V2);
      V2 := '';
    end
      else
    begin
      N2 := 0;
    end;

    if N1 < N2 then Result := -1
      else
    if N1 > N2 then Result := 1;
  end;
end;

function VcRedistNeedsInstall: Boolean;
var
  InstalledVersion: String;
begin
  // Assume it's not needed on Wine
  if IsWine or NoMsvcRedist then
  begin
    Result := False
    exit;
  end;

  // Get the currently installed VC Runtime version
  if RegQueryStringValue(HKEY_LOCAL_MACHINE,
       'SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x86', 'Version',
       InstalledVersion) then
  begin
    // Trim first 'v' character because it may cause issues
    if (Length(InstalledVersion) > 0) and (InstalledVersion[1] = 'v') then
      Delete(InstalledVersion, 1, 1);

    try
      // Is the installed version lower than the packaged version?
      // This check is possibly redundant because the VC redist exe checks if a newer version is already installed.
      // However, the user doesn't necessarily need the very latest redist version.
      Result := (CompareVersion(InstalledVersion, '{#VcRedistVersionStr}') < 0);
    except
      // If something went wrong, just assume it needs to be installed
      Result := True;
      exit;
    end;
  end
  else
  begin
    // Not even an old version installed
    Result := True;
  end;

  if Result then
  begin
    ExtractTemporaryFile('{#VcRedistName}');
  end;
end;

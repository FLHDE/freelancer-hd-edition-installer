[Code]
// Used to detect if the user is using WINE or not
function LoadLibraryA(lpLibFileName: PAnsiChar): THandle;
external 'LoadLibraryA@kernel32.dll stdcall';
function GetProcAddress(Module: THandle; ProcName: PAnsiChar): Longword;
external 'GetProcAddress@kernel32.dll stdcall';

// Data type for a desktop resolution (stores the width and height of the display in pixels)
type
	DesktopResolution = record
		Width: Integer;
		Height: Integer;
end;

// Enum for GPU manufacturers
// We need this information about the user's system because AMD GPUs have issues with the newest dgVoodoo versions
// And on NVIDIA GPUs some textures don't load correctly with DxWrapper Anisotropic Filtering
type
  TGpuManufacturer = (NVIDIA, AMD, Other);

type
  TSystemLanguage = (German, French, Russian, EnglishOrOther);

// Used to store values used across numerous files and functions so they don't have to be requested multiple times
var
  DesktopRes: DesktopResolution;
  Wine: Boolean;
  GpuManufacturer: TGpuManufacturer;
  SystemLanguage: TSystemLanguage;

function IsWine: boolean;
var  LibHandle  : THandle;
begin
  LibHandle := LoadLibraryA('ntdll.dll');
  Result:= GetProcAddress(LibHandle, 'wine_get_version') <> 0;
end;

// Gets the attributes for a file or directory (e.g. read and write)
function GetFileAttributes(lpFileName: string): DWORD;
 external 'GetFileAttributesW@kernel32.dll stdcall';

// Sets the attributes for a file or directory (e.g. read and write)
function SetFileAttributes(lpFileName: string; dwFileAttributes: DWORD): BOOL;
  external 'SetFileAttributesW@kernel32.dll stdcall';

// Removes a read only attribute from a file
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

// Used to copy the vanilla install to {app} also the extracted .zip file back to {app}
procedure DirectoryCopy(SourcePath, DestPath: string; Move: Boolean);
var
  FindRec: TFindRec;
  SourceFilePath: string;
  DestFilePath: string;
begin
  if FindFirst(SourcePath + '\*', FindRec) then
  begin
    try
      repeat
        if (FindRec.Name <> '.') and (FindRec.Name <> '..') then
        begin
          SourceFilePath := SourcePath + '\' + FindRec.Name;
          DestFilePath := DestPath + '\' + FindRec.Name;
          if FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY = 0 then
          begin
            if not FileCopy(SourceFilePath, DestFilePath, False) then
            begin
              RaiseException(Format('Failed to copy %s to %s', [
                SourceFilePath, DestFilePath]));
            end;

            // Delete the source file if it's been moved successfully
            if Move then
              DeleteFile(SourceFilePath);

            // We want to ensure every file has write access so we can properly overwrite them later.
            // Presumably these permissions aren't an issue on Wine.
            if not Wine then
              RemoveReadOnly(DestFilePath);
          end
            else
          begin
            if DirExists(DestFilePath) or CreateDir(DestFilePath) then
              DirectoryCopy(SourceFilePath, DestFilePath, Move)
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

// Used to store the names of all edited config files
var
  EditedConfigFiles: TStringList;

// Used to replace strings in files. This replaces FLMM functions
function FileReplaceString(const FileName, SearchString, ReplaceString: string):boolean;
var
  MyFile : TStrings;
  MyText : string;
  Index : Integer;
begin
  MyFile := TStringList.Create;

  try
    result := true;

    try
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
      end;
    except
      result := false;
    end;
  finally
    MyFile.Free;
  end;
end;

// Gets the device context
function GetDC(HWND: DWord): DWord; external 'GetDC@user32.dll stdcall';

// Used to retrieve information about a device 
function GetDeviceCaps (hDC, nIndex: Integer): Integer;
 external 'GetDeviceCaps@GDI32 stdcall';

// Gets the user's main monitor resolution
function Resolution(): DesktopResolution;
var 
  DC: DWord;
begin
  try
    DC := GetDC(0);
    Result.Width := GetDeviceCaps(DC, 8); // 8 = HORZRES
    Result.Height := GetDeviceCaps(DC, 10); // 10 = VERTRES

    if (Result.Width = 0) or (Result.Height = 0) then
      RaiseException('Display Width and/or Height cannot be 0');
  except
    Result.Width := 1920
    Result.Height := 1080
  end;
end;

// Gets the user's main monitor refresh rate
function RefreshRate(): Integer;
var 
  DC: DWord;
begin
  try
    DC := GetDC(0);
    Result := GetDeviceCaps(DC, 116); // 116 = VREFRESH

    if Result = 0 then
      RaiseException('Refresh Rate cannot be 0');
  except
    Result := 60
  end;
end;

// Whether or not the desktop resolution has an aspect ratio of 16:9
function IsDesktopRes16By9(): Boolean;
begin
  Result := Trunc(Single(DesktopRes.Width) / DesktopRes.Height * 100.0) / 100.0 = 1.77
end;

// Whether or not the desktop resolution has an aspect ratio of 4:3
function IsDesktopRes4By3(): Boolean;
begin
  Result := Trunc(Single(DesktopRes.Width) / DesktopRes.Height * 100.0) / 100.0 = 1.33
end;

// Converts an int to hex
function IntToHex(Value: Integer; Digits: Integer): string;
begin
  Result := Format('%.*x', [Digits, Value])
end;

// Swaps 2 bytes in a binary string (2 bytes, or 4 characters assumed)
function SwapBytes(BinaryString: string): string;
begin
  Result := BinaryString[3] + BinaryString[4] + BinaryString[1] + BinaryString[2] 
end;

// Used to convert a binary expression in string format to an actual binary stream
function ConvertHexToBinary(hexString: string; hexLength: LongWord; binaryString: string): Boolean;
  external 'ConvertHexToBinary@files:HexToBinary.dll cdecl setuponly delayload';

// Used to perform a hex edit in a file at a specific location
procedure WriteHexToFile(FileName: string; Offset: longint; Hex: string);
var
  Stream: TFileStream;
  Buffer: string;
  Size: LongWord;
begin
  Stream := TFileStream.Create(FileName, fmOpenReadWrite);

  try
    SetLength(Buffer, (Length(Hex) div 4) + 1);
    Size := Length(Hex) div 2;

    if not ConvertHexToBinary(Hex, Length(Hex), Buffer) then
      RaiseException('Could not convert string to binary stream');

    Stream.Seek(Offset, soFromBeginning);
    Stream.WriteBuffer(Buffer, Size);
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
function RemoveBOM(const FileName: String): Integer;
var
  ResultCode: Integer;
begin
  Exec(ExpandConstant('{tmp}\utf-8-bom-remover.exe'), ExpandConstant('"' + FileName + '"'), '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  result := ResultCode;
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

// Use windows function to convert date modified to a useable format
function FileTimeToSystemTime(
FileTime:        TFileTime; 
var SystemTime:  SYSTEMTIME
): Boolean; 
external 'FileTimeToSystemTime@kernel32.dll stdcall'; 

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
function HasLightingBug(): Boolean;
var
  Version: TWindowsVersion;
begin
  // We're assuming there's no issues on Wine.
  if Wine then
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

// Gets the manufacturer of the user's GPU
function GetGpuManufacturer(): TGpuManufacturer;
var
  GpuOutputFile, GpuOutputFileUtf8: string;
  ResultCodeGpu, ResultCodeUtf8: integer;
  GpuOutput: TArrayOfString;
begin
  SetArrayLength(GpuOutput, 10);

  try
    if Wine then
      RaiseException('The cmd and/or PowerShell calls below won''t work on Wine, so don''t bother');

    GpuOutputFile := ExpandConstant('{tmp}') + '\gpu_name_output.txt';
    GpuOutputFileUtf8 := ExpandConstant('{tmp}') + '\gpu_name_output_utf8.txt';

    // Gets the GPU name through a wmic call and write that to a text file
    Exec(ExpandConstant('{cmd}'), '/c wmic path win32_VideoController get name > ' + '"' + GpuOutputFile + '"', '', SW_HIDE, ewWaitUntilTerminated, ResultCodeGpu);
    if ResultCodeGpu <> 0 then
      RaiseException('Can''t get GPU name and write it to a file');

    // Convert the text file to UTF-8 because by default it's UTF-16 which is a bit difficult to read
    Exec(ExpandConstant('{cmd}'), '/c powershell -c "Get-Content ''' + GpuOutputFile + ''' | Set-Content -Encoding utf8 ''' + GpuOutputFileUtf8 + '''"', '', SW_HIDE, ewWaitUntilTerminated, ResultCodeUtf8);
    if ResultCodeUtf8 <> 0 then
      RaiseException('Can''t convert GPU name file to UTF-8');

    // Load the string from the file and check if it's been retrieved successfully
    if (LoadStringsFromFile(GpuOutputFileUtf8, GpuOutput)) and (GetArrayLength(GpuOutput) >= 2) then
      begin
      if not Pos('Name', GpuOutput[0]) > 0 then
        RaiseException('The first output line doesn''t contain the word "Name", as it should');

      if Length(GpuOutput[1]) < 3 then
        RaiseException('The retrieved GPU name is less than 3 characters long. Something must have gone wrong here');

      // Determine the GPU manufacturer based on the second output line.
      if Pos('AMD', GpuOutput[1]) > 0 then
        Result := AMD
      else if Pos('NVIDIA', GpuOutput[1]) > 0 then
        Result := NVIDIA
      else
        Result := Other;
      end;
  except
    // If something has gone wrong, just ask the user what GPU they have
    if MsgBox('We weren''t able to automatically determine what graphics card is in your system. We use this information to apply the best compatibility options for you.'
    + #13#10#13#10 + 'Please click "Yes" if your computer has an NVIDIA graphics card. Click "No" if otherwise.', mbConfirmation, MB_YESNO) = IDYES then
      Result := NVIDIA
    else if MsgBox('Please click "Yes" if your system uses an AMD graphics card. Click "No" if the graphics card is from another manufacturer like Intel.', mbConfirmation, MB_YESNO) = IDYES then
      Result := AMD
    else
      Result := Other;
  finally
    // Cleanup
    DeleteFile(GpuOutputFile);
    DeleteFile(GpuOutputFileUtf8);
  end;
end;

// Determine what language the user's system is
function GetSystemLanguage(): TSystemLanguage;
var
  UILanguage: Integer;
begin
  UILanguage := GetUILanguage

  // https://renenyffenegger.ch/notes/Windows/development/Internationalization/language
  case UILanguage of
    $407, $807, $c07, $1007, $1407: Result := German;
    $40c, $80c, $c0c, $100c, $140c, $180c, $1c0c, $200c, $240c, $280c, $2c0c, $300c, $340c, $380c, $3c0c: Result := French;
    $419, $819: Result := Russian;
  else
    Result := EnglishOrOther;
  end;
end;

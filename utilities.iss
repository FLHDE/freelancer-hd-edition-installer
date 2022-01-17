[Code]
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
        if (FindRec.Name <> '.') and (FindRec.Name <> '..') and (FindRec.Name <> 'UNINSTAL.EXE') then
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
            if(Move) then DeleteFile(SourceFilePath)
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

// Used to replace strings in files. This replaces FLMM functions
function FileReplaceString(const FileName, SearchString, ReplaceString: string):boolean;
var
  MyFile : TStrings;
  MyText : string;
begin
  MyFile := TStringList.Create;

  try
    result := true;

    try
      MyFile.LoadFromFile(FileName);
      MyText := MyFile.Text;

      // Save the file the text has been changed
      if StringChangeEx(MyText, SearchString, ReplaceString, True) > 0 then
      begin;
        MyFile.Text := MyText;
        MyFile.SaveToFile(FileName);
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

// Retrieve information about a device
function GetDeviceCaps (hDC, nIndex: Integer): Integer;
 external 'GetDeviceCaps@GDI32 stdcall';

// Gets the user's main monitor refresh rate
function RefreshRate(): Integer;
var 
  DC: DWord;
begin
  try
    DC := GetDC(0);
    Result := GetDeviceCaps(DC, 116); // 116 = VREFRESH
  except
    Result := 60
  end;
end;

// Converts an int to hex
function IntToHex(Value: Integer; Digits: Integer): string;
begin
  Result := Format('%.*x', [Digits, Value])
end;

// Swaps 2 bytes in a binary string (4 total bytes assumed)
function SwapBytes(BinaryString: string): string;
begin
  Result := BinaryString[3] + BinaryString[4] + BinaryString[1] + BinaryString[2] 
end;

// Used to convert a binary expression in string format to an actual binary stream
function CryptStringToBinary(
  sz: string; cch: LongWord; flags: LongWord; binary: string; var size: LongWord;
  skip: LongWord; flagsused: LongWord): Integer;
  external 'CryptStringToBinaryW@crypt32.dll stdcall';

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
    if (CryptStringToBinary(
          // 04 = CRYPT_STRING_HEX
          Hex, Length(Hex), $04, Buffer, Size, 0, 0) = 0) or
       (Size <> Length(Hex) div 2) then
    begin
      RaiseException('Could not convert string to binary stream.');
    end;

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

// Used to detect if the user is using WINE or not
function LoadLibraryA(lpLibFileName: PAnsiChar): THandle;
external 'LoadLibraryA@kernel32.dll stdcall';
function GetProcAddress(Module: THandle; ProcName: PAnsiChar): Longword;
external 'GetProcAddress@kernel32.dll stdcall';

function IsWine: boolean;
var  LibHandle  : THandle;
begin
  LibHandle := LoadLibraryA('ntdll.dll');
  Result:= GetProcAddress(LibHandle, 'wine_get_version')<> 0;
end;

// Whether the given char is a digit
function IsDigit(C: Char): Boolean;
begin
  Result := (C >= '0') and (C <= '9')
end;
; Inno Install Script for Freelancer: HD Edition
; GitHub: https://github.com/ollieraikkonen/Freelancer-hd-edition-install-script
; Main GitHub: https://github.com/bc46/Freelancer-hd-edition

#define MyAppName "Freelancer: HD Edition v0.4.1"
#define MyAppVersion "0.4.1"
#define MyAppPublisher "Freelancer: HD Edition Development Team"
#define MyAppURL "https://github.com/BC46/freelancer-hd-edition"
#define MyAppExeName "Freelancer.exe"

[Setup]
AppId={{F40FDCDA-3A45-4CC3-9FDA-167EE480A1E0}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={localappdata}\Freelancer HD Edition
DefaultGroupName=Freelancer HD Edition
AllowNoIcons=yes
OutputBaseFilename=FreelancerHDSetup
SetupIconFile={#SourcePath}\icon.ico
Compression=lzma
SolidCompression=yes
WizardImageFile={#SourcePath}\backgroundpattern.bmp
WizardSmallImageFile={#SourcePath}\icon.bmp
DisableWelcomePage=False
DisableDirPage=False
InfoBeforeFile={#SourcePath}\installinfo.txt
ExtraDiskSpaceRequired = 9631137792

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}";

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\EXE\{#MyAppExeName}"
Name: "{commondesktop}\Freelancer HD Edition"; Filename: "{app}\EXE\{#MyAppExeName}"; Tasks: desktopicon

[Files]
Source: "installinfo.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "AGENCYB.TTF"; DestDir: "{autofonts}"; FontInstall: "Agency FB Bold"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "AGENCYR.TTF"; DestDir: "{autofonts}"; FontInstall: "Agency FB"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "ARIALUNI.TTF"; DestDir: "{autofonts}"; FontInstall: "Arial Unicode MS"; Flags: onlyifdoesntexist uninsneveruninstall

[Run]
Filename: "{app}\EXE\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Messages]
WelcomeLabel2= Freelancer: HD Edition is a mod that aims to improve every aspect of Freelancer while keeping the look and feel as close to vanilla as possible. It also serves as an all-in-one package for players so they do not have to worry about installing countless patches and mods to create the perfect HD and bug-free install.%n%nThis installer requires a clean, freshly installed Freelancer directory.

[Code]
var
  // Allows us to skip the downloading of the files and just copy it from the local PC to save time
  OfflineInstall: String;

  // Custom Pages
  DataDirPage: TInputDirWizardPage;
  CallSign: TInputOptionWizardPage;
  StartupRes: TInputOptionWizardPage;
  LogoRes: TInputOptionWizardPage;
  SmallText: TInputOptionWizardPage;
  PageWidescreenHud: TWizardPage;
  PagePlanetScape: TWizardPage;
  PageWin10: TWizardPage;
  PageReflections: TWizardPage;
  PageEffects: TWizardPage;
  PageSinglePlayer: TWizardPage;
  DownloadPage: TDownloadWizardPage;
  DownloadPageMirror: TDownloadWizardPage;
  DownloadPageMirror2: TDownloadWizardPage;
  DownloadPageMirror3: TDownloadWizardPage;

  // Advanced Widescreen HUD
  lblWidescreenHud: TLabel;
  WidescreenHud: TCheckBox;
  descWidescreenHud: TNewStaticText;

  // Fix clipping with 16:9 resolution planetscapes
  lblPlanetScape: TLabel;
  PlanetScape: TCheckBox;
  descPlanetScape: TNewStaticText;

  // Fix Windows 10 compatibility issues
  lblWin10: TLabel;
  Win10: TCheckBox;
  descWin10: TNewStaticText;

  // Add improved reflections
  lblReflections: TLabel;
  Reflections: TCheckBox;
  descReflections: TNewStaticText;

  // Add new missile effects
  lblMissleEffects: TLabel;
  MissileEffects: TCheckBox;
  descMissileEffects: TNewStaticText;

  // Single Player Command Console
  lblSinglePlayer: TLabel;
  SinglePlayer: TCheckBox;
  descSinglePlayer: TNewStaticText;

// Report on download progress
function OnDownloadProgress(const Url, FileName: String; const Progress, ProgressMax: Int64): Boolean; 
begin
  DownloadPage.SetText('Downloading mod',(IntToStr(Progress/1048576) + 'MB / 3296MB'))
  if Progress = ProgressMax then
    Log(Format('Successfully downloaded file to {tmp}: %s', [FileName]));
  Result := True;
end;

// Report on download mirror progress
function OnDownloadProgressMirror(const Url, FileName: String; const Progress, ProgressMax: Int64): Boolean; 
begin
  DownloadPageMirror.SetText('Downloading mod',(IntToStr(Progress/1048576) + 'MB / 3296MB'))
  if Progress = ProgressMax then
    Log(Format('Successfully downloaded file to {tmp}: %s', [FileName]));
  Result := True;
end;

// Report on download mirror 2 progress
function OnDownloadProgressMirror2(const Url, FileName: String; const Progress, ProgressMax: Int64): Boolean; 
begin
  DownloadPageMirror2.SetText('Downloading mod',(IntToStr(Progress/1048576) + 'MB / 3296MB'))
  if Progress = ProgressMax then
    Log(Format('Successfully downloaded file to {tmp}: %s', [FileName]));
  Result := True;
end;

// Report on download mirror 3 progress
function OnDownloadProgressMirror3(const Url, FileName: String; const Progress, ProgressMax: Int64): Boolean; 
begin
  DownloadPageMirror3.SetText('Downloading mod',(IntToStr(Progress/1048576) + 'MB / 3296MB'))
  if Progress = ProgressMax then
    Log(Format('Successfully downloaded file to {tmp}: %s', [FileName]));
  Result := True;
end;

// Update progress of installer bar
procedure UpdateProgress(Position: Integer);
begin
  WizardForm.ProgressGauge.Position :=
    Position * WizardForm.ProgressGauge.Max div 100;
end;

// Used to copy the vanilla install to {app}
procedure DirectoryCopy(SourcePath, DestPath: string);
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
          end
            else
          begin
            if DirExists(DestFilePath) or CreateDir(DestFilePath) then
              DirectoryCopy(SourceFilePath, DestFilePath)
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

// Used to unzip the downloaded mod
const
  SHCONTCH_NOPROGRESSBOX = 4;
  SHCONTCH_RESPONDYESTOALL = 16;

procedure UnZip(ZipPath, TargetPath: string); 
var
  Shell: Variant;
  ZipFile: Variant;
  TargetFolder: Variant;
  DATA: Variant;
  DLLS: Variant;
  EXE: Variant;
  JFLP: Variant;
  CHANGELOGmd: Variant;
  FreelancerManualpdf: Variant;
  mod_optionsrtf: Variant;
begin
  Shell := CreateOleObject('Shell.Application');

  ZipFile := Shell.NameSpace(ZipPath);
  if VarIsClear(ZipFile) then
    RaiseException(
      Format('ZIP file "%s" does not exist or cannot be opened', [ZipPath]));

  TargetFolder := Shell.NameSpace(TargetPath);
  if VarIsClear(TargetFolder) then
    RaiseException(Format('Target path "%s" does not exist', [TargetPath]));

  // Need to copy the files/folders out of the zip file manually. This is so it doesn't create an extra folder
  DATA := ZipFile.ParseName('freelancer-hd-edition-0.4.1\DATA');
  DLLS := ZipFile.ParseName('freelancer-hd-edition-0.4.1\DLLS');
  EXE := ZipFile.ParseName('freelancer-hd-edition-0.4.1\EXE');
  JFLP := ZipFile.ParseName('freelancer-hd-edition-0.4.1\JFLP');
  CHANGELOGmd := ZipFile.ParseName('freelancer-hd-edition-0.4.1\CHANGELOG.md');
  FreelancerManualpdf := ZipFile.ParseName('freelancer-hd-edition-0.4.1\Freelancer-Manual.pdf');
  mod_optionsrtf := ZipFile.ParseName('freelancer-hd-edition-0.4.1\mod_options.rtf');

  if VarIsClear(DATA) or 
     VarIsClear(DLLS) or
     VarIsClear(EXE) or
     VarIsClear(JFLP) or
     VarIsClear(CHANGELOGmd) or
     VarIsClear(FreelancerManualpdf) or
     VarIsClear(mod_optionsrtf) then
      RaiseException(Format('Cannot find a file/folder in "%s" ZIP file', [ZipPath]));

  TargetFolder.CopyHere(DATA, SHCONTCH_NOPROGRESSBOX or SHCONTCH_RESPONDYESTOALL);
  TargetFolder.CopyHere(DLLS, SHCONTCH_NOPROGRESSBOX or SHCONTCH_RESPONDYESTOALL);
  TargetFolder.CopyHere(EXE, SHCONTCH_NOPROGRESSBOX or SHCONTCH_RESPONDYESTOALL);
  TargetFolder.CopyHere(JFLP, SHCONTCH_NOPROGRESSBOX or SHCONTCH_RESPONDYESTOALL);
  TargetFolder.CopyHere(CHANGELOGmd, SHCONTCH_NOPROGRESSBOX or SHCONTCH_RESPONDYESTOALL);
  TargetFolder.CopyHere(FreelancerManualpdf, SHCONTCH_NOPROGRESSBOX or SHCONTCH_RESPONDYESTOALL);
  TargetFolder.CopyHere(mod_optionsrtf, SHCONTCH_NOPROGRESSBOX or SHCONTCH_RESPONDYESTOALL);
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

// Process CallSign option. Replaces strings in freelancer.ini depending on what the user clicks
function Process_CallSign():boolean;
var
  FilePath : string;
begin

  RenameFile(ExpandConstant('{app}\DLLS\BIN\callsign.dll2'),ExpandConstant('{app}\DLLS\BIN\callsign.dll'));

  FilePath := ExpandConstant('{app}\EXE\freelancer.ini');

  if(CallSign.Values[1]) then // Navy Beta 2-5
    FileReplaceString(FilePath,'DLL = callsign.dll, player 1 1-1','DLL = callsign.dll, li_n 2 2-5')
  else if(CallSign.Values[2]) then // Bretonia Police Iota 3-4
    FileReplaceString(FilePath,'DLL = callsign.dll, player 1 1-1','DLL = callsign.dll, br_p 8 3-4')
  else if(CallSign.Values[3]) then // Military Epsilon 11-6
    FileReplaceString(FilePath,'DLL = callsign.dll, player 1 1-1','DLL = callsign.dll, rh_n 5 11-6')
  else if(CallSign.Values[4]) then // Naval Forces Matsu 4-9
    FileReplaceString(FilePath,'DLL = callsign.dll, player 1 1-1','DLL = callsign.dll, ku_n 22 4-9')
  else if(CallSign.Values[5]) then // IMG Red 18-6
    FileReplaceString(FilePath,'DLL = callsign.dll, player 1 1-1','DLL = callsign.dll, gd_im 14 18-6')
  else if(CallSign.Values[6]) then // Kishiro Yanagi 7-3
    FileReplaceString(FilePath,'DLL = callsign.dll, player 1 1-1','DLL = callsign.dll, co_kt 29 7-3')
  else if(CallSign.Values[7]) then // Outcasts Lambda 9-12
    FileReplaceString(FilePath,'DLL = callsign.dll, player 1 1-1','DLL = callsign.dll, fc_ou 10 9-12')
  else if(CallSign.Values[8]) then // Dragons Green 16-13
    FileReplaceString(FilePath,'DLL = callsign.dll, player 1 1-1','DLL = callsign.dll, fc_bd 17 16-13')
  else if(CallSign.Values[9]) then // Spa and Cruise Omega 8-0
    FileReplaceString(FilePath,'DLL = callsign.dll, player 1 1-1','DLL = callsign.dll, co_os 13 8-0')
  else if(CallSign.Values[10]) then // Daumann Zeta 11-17
  FileReplaceString(FilePath,'DLL = callsign.dll, player 1 1-1','DLL = callsign.dll, co_khc 6 11-17')
  else if(CallSign.Values[11]) then // Bowex Gamma 5-7
    FileReplaceString(FilePath,'DLL = callsign.dll, player 1 1-1','DLL = callsign.dll, co_be 3 5-7')
  else if(CallSign.Values[12]) then // Order Omicron 0-0
    FileReplaceString(FilePath,'DLL = callsign.dll, player 1 1-1','DLL = callsign.dll, fc_or 11 0-0')
  else if(CallSign.Values[13]) then // LSF Delta 6-9
    FileReplaceString(FilePath,'DLL = callsign.dll, player 1 1-1','DLL = callsign.dll, li_lsf 4 6-9')
  else if(CallSign.Values[14]) then // Hacker Kappa 4-20
    FileReplaceString(FilePath,'DLL = callsign.dll, player 1 1-1','DLL = callsign.dll, fc_lh 9 4-20')
end;

// Processes the Startup Logo option. Renames files depending on what option is selected
function Process_StartUpLogo():boolean;
var
  FolderPath : string;
  OldFile : string;
  NewFile : string;
begin
  FolderPath := ExpandConstant('{app}\DATA\INTERFACE\INTRO\IMAGES\');
  NewFile := FolderPath + 'startupscreen_1280.tga';
  // If not the default
  if(not StartupRes.Values[2]) then begin
    // Rename old file away 
    RenameFile(NewFile,FolderPath + 'startupscreen_1280_vanilla.tga');
    // Rename the correct startup res depending on option
    if(StartupRes.Values[1]) then 
      OldFile := FolderPath + 'startupscreen_1280_1280x720.tga'
    else if(StartupRes.Values[3]) then 
      OldFile := FolderPath + 'startupscreen_1280_1440x1080.tga'
    else if(StartupRes.Values[4]) then 
      OldFile := FolderPath + 'startupscreen_1280_1920x1080.tga'
    else if(StartupRes.Values[5]) then 
      OldFile := FolderPath + 'startupscreen_1280_1920x1440.tga'
    else if(StartupRes.Values[6]) then 
      OldFile := FolderPath + 'startupscreen_1280_2560x1440.tga'
    else if(StartupRes.Values[7]) then 
      OldFile := FolderPath + 'startupscreen_1280_2880x2160.tga'
    else if(StartupRes.Values[8]) then 
      OldFile := FolderPath + 'startupscreen_1280_3840x2160.tga';
    // Actually rename the file
    RenameFile(OldFile,NewFile);
    end
end;

// Processes the Freelancer logo option. Renames files depending on what option is selected
function Process_FreelancerLogo():boolean;
var
  FolderPath : string;
  OldFile : string;
  NewFile : string;
begin
  FolderPath := ExpandConstant('{app}\DATA\INTERFACE\INTRO\IMAGES\');
  NewFile := FolderPath + 'front_freelancerlogo.tga';
  // If not the default
  if(not LogoRes.Values[1]) then begin
    // Rename old file away
    RenameFile(NewFile,FolderPath + 'front_freelancerlogo_vanilla.tga')
    // Rename correct logo res depending on option
    if(LogoRes.Values[2]) then 
      OldFile := FolderPath + 'front_freelancerlogo_960x720.tga'
    else if(LogoRes.Values[3]) then 
      OldFile := FolderPath + 'front_freelancerlogo_1280x720.tga'
    else if(LogoRes.Values[4]) then 
      OldFile := FolderPath + 'front_freelancerlogo_1440x1080.tga'
    else if(LogoRes.Values[5]) then 
      OldFile := FolderPath + 'front_freelancerlogo_1920x1080.tga'
    else if(LogoRes.Values[6]) then 
      OldFile := FolderPath + 'front_freelancerlogo_1920x1440.tga'
    else if(LogoRes.Values[7]) then 
      OldFile := FolderPath + 'front_freelancerlogo_2560x1440.tga'
    else if(LogoRes.Values[8]) then 
      OldFile := FolderPath + 'front_freelancerlogo_2880x2160.tga'
    else if(LogoRes.Values[9]) then 
      OldFile := FolderPath + 'front_freelancerlogo_3840x2160.tga';
    // Actually rename the file
    RenameFile(OldFile,NewFile);
  end
end;

// Replaces the SmallText strings in fonts.ini
function Process_SmallText():boolean;
  var
    FilePath : string;
begin
    FilePath := ExpandConstant('{app}\DATA\FONTS\fonts.ini');

    if SmallText.Values[1] then
      FileReplaceString(FilePath,
      'nickname = NavMap1600' + #13#10 +
      'font = Agency FB' + #13#10 +
      'fixed_height = 0.015',

      'nickname = NavMap1600' + #13#10 +
      'font = Agency FB' + #13#10 +
      'fixed_height = 0.025');
      
    if SmallText.Values[2] then begin
      FileReplaceString(FilePath,
        'nickname = HudSmall' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = 0.03',

        'nickname = HudSmall' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = 0.029');
      FileReplaceString(FilePath,
        'nickname = Normal' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = 0.035',

        'nickname = Normal' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = 0.029');
      FileReplaceString(FilePath,
        'nickname = NavMap1600' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = 0.015',

        'nickname = NavMap1600' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = 0.025');
    end;      
end;

// SinglePlayer console processing logic
function Process_Console():boolean;
begin
  if SinglePlayer.Checked then FileReplaceString(ExpandConstant('{app}\EXE\dacom.ini'),';console.dll','console.dll')
end;

// Effects processing logic
function Process_Effects():boolean;
var
  MissilePath : string;
begin
if MissileEffects.Checked then 
  begin
    MissilePath := ExpandConstant('{app}\DATA\FX\WEAPONS\')
    // Rename vanilla ones
    RenameFile(MissilePath + 'br_empmissile.ale',MissilePath + 'br_empmissile_vanilla.ale')
    RenameFile(MissilePath + 'br_missile01.ale',MissilePath + 'br_missile01_vanilla.ale')
    RenameFile(MissilePath + 'br_missile02.ale',MissilePath + 'br_missile02_vanilla.ale')
    RenameFile(MissilePath + 'ku_empmissile.ale',MissilePath + 'ku_empmissile_vanilla.ale')
    RenameFile(MissilePath + 'ku_missile01.ale',MissilePath + 'ku_missile01_vanilla.ale')
    RenameFile(MissilePath + 'ku_missile02.ale',MissilePath + 'ku_missile02_vanilla.ale')
    RenameFile(MissilePath + 'ku_torpedo01.ale',MissilePath + 'ku_torpedo01_vanilla.ale')
    RenameFile(MissilePath + 'li_empmissile.ale',MissilePath + 'li_empmissile_vanilla.ale')
    RenameFile(MissilePath + 'li_missile01.ale',MissilePath + 'li_missile01_vanilla.ale')
    RenameFile(MissilePath + 'li_missile02.ale',MissilePath + 'li_missile02_vanilla.ale')
    RenameFile(MissilePath + 'li_torpedo01.ale',MissilePath + 'li_torpedo01_vanilla.ale')
    RenameFile(MissilePath + 'pi_missile01.ale',MissilePath + 'pi_missile01_vanilla.ale')
    RenameFile(MissilePath + 'pi_missile02.ale',MissilePath + 'pi_missile02_vanilla.ale')
    RenameFile(MissilePath + 'rh_empmissile.ale',MissilePath + 'rh_empmissile_vanilla.ale')
    RenameFile(MissilePath + 'rh_missile01.ale',MissilePath + 'rh_missile01_vanilla.ale')
    RenameFile(MissilePath + 'rh_missile02.ale',MissilePath + 'rh_missile02_vanilla.ale')

    // Rename new effects
    RenameFile(MissilePath + 'br_empmissile_new.ale',MissilePath + 'br_empmissile.ale')
    RenameFile(MissilePath + 'br_missile01_new.ale',MissilePath + 'br_missile01.ale')
    RenameFile(MissilePath + 'br_missile02_new.ale',MissilePath + 'br_missile02.ale')
    RenameFile(MissilePath + 'ku_empmissile_new.ale',MissilePath + 'ku_empmissile.ale')
    RenameFile(MissilePath + 'ku_missile01_new.ale',MissilePath + 'ku_missile01.ale')
    RenameFile(MissilePath + 'ku_missile02_new.ale',MissilePath + 'ku_missile02.ale')
    RenameFile(MissilePath + 'ku_torpedo01_new.ale',MissilePath + 'ku_torpedo01.ale')
    RenameFile(MissilePath + 'li_empmissile_new.ale',MissilePath + 'li_empmissile.ale')
    RenameFile(MissilePath + 'li_missile01_new.ale',MissilePath + 'li_missile01.ale')
    RenameFile(MissilePath + 'li_missile02_new.ale',MissilePath + 'li_missile02.ale')
    RenameFile(MissilePath + 'li_torpedo01_new.ale',MissilePath + 'li_torpedo01.ale')
    RenameFile(MissilePath + 'pi_missile01_new.ale',MissilePath + 'pi_missile01.ale')
    RenameFile(MissilePath + 'pi_missile02_new.ale',MissilePath + 'pi_missile02.ale')
    RenameFile(MissilePath + 'rh_empmissile_new.ale',MissilePath + 'rh_empmissile.ale')
    RenameFile(MissilePath + 'rh_missile01_new.ale',MissilePath + 'rh_missile01.ale')
    RenameFile(MissilePath + 'rh_missile02_new.ale',MissilePath + 'rh_missile02.ale')
  end;

  if Reflections.Checked then begin
    RenameFile(ExpandConstant('{app}\DATA\FX\envmapbasic.mat'),ExpandConstant('{app}\DATA\FX\envmapbasic_vanilla.mat'))
    RenameFile(ExpandConstant('{app}\DATA\FX\envmapbasic_new.mat'),ExpandConstant('{app}\DATA\FX\envmapbasic.mat'))
  end
end;

function Process_Planetscape():boolean;
var
  PlanetscapePath: string;
begin
  if PlanetScape.Checked then
    begin
    PlanetscapePath := ExpandConstant('{app}\DATA\SCRIPTS\BASES\')
    // Rename vanilla ones
    RenameFile(PlanetscapePath + 'br_01_cityscape_hardpoint_01.thn',PlanetscapePath + 'br_01_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'br_02_cityscape_hardpoint_01.thn',PlanetscapePath + 'br_02_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'br_03_cityscape_hardpoint_01.thn',PlanetscapePath + 'br_03_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'bw_01_cityscape_hardpoint_01.thn',PlanetscapePath + 'bw_01_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'bw_02_cityscape_hardpoint_01.thn',PlanetscapePath + 'bw_02_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'hi_01_cityscape_hardpoint_01.thn',PlanetscapePath + 'hi_01_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'hi_02_cityscape_hardpoint_01.thn',PlanetscapePath + 'hi_02_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'ku_01_cityscape_hardpoint_01.thn',PlanetscapePath + 'ku_01_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'ku_02_cityscape_hardpoint_01.thn',PlanetscapePath + 'ku_02_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'ku_03_cityscape_hardpoint_01.thn',PlanetscapePath + 'ku_03_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'li_01_cityscape_hardpoint_01.thn',PlanetscapePath + 'li_01_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'li_02_cityscape_hardpoint_01.thn',PlanetscapePath + 'li_02_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'li_03_cityscape_hardpoint_01.thn',PlanetscapePath + 'li_03_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'li_04_cityscape_hardpoint_01.thn',PlanetscapePath + 'li_04_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'rh_01_cityscape_hardpoint_01.thn',PlanetscapePath + 'rh_01_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'rh_02_cityscape_hardpoint_01.thn',PlanetscapePath + 'rh_02_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'rh_03_cityscape_hardpoint_01.thn',PlanetscapePath + 'rh_03_cityscape_hardpoint_01_vanilla.thn')

    // Rename new PlanetScapes
    RenameFile(PlanetscapePath + 'br_01_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'br_01_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'br_02_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'br_02_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'br_03_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'br_03_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'bw_01_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'bw_01_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'bw_02_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'bw_02_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'hi_01_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'hi_01_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'hi_02_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'hi_02_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'ku_01_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'ku_01_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'ku_02_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'ku_02_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'ku_03_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'ku_03_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'li_01_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'li_01_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'li_02_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'li_02_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'li_03_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'li_03_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'li_04_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'li_04_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'rh_01_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'rh_01_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'rh_02_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'rh_02_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'rh_03_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'rh_03_cityscape_hardpoint_01.thn')
    end;
end;

function Process_Win10():boolean;
var
  EXEPath: string;
begin
  EXEPath := ExpandConstant('{app}\EXE\');
  if Win10.Checked then RenameFile(EXEPath + 'D3D8_compat.dll2',EXEPath + 'd3d8.dll')
  else RenameFile(EXEPath + 'd3d8to9.dll2',EXEPath + 'd3d8.dll') 
end;

function Process_HUD():boolean;
var
  HudShiftPath: string;
begin
  if WidescreenHud.Checked then
  begin
      HudShiftPath := ExpandConstant('{app}\DATA\INTERFACE\HudShift.ini')

      FileReplaceString(
        ExpandConstant('{app}\EXE\dacom.ini')
        ,
        ';HudFacility.dll' + #13#10 +
        ';HudWeaponGroups.dll' + #13#10 +
        ';HudTarget.dll' + #13#10 +
        ';HudStatus.dll'
        ,
        'HudFacility.dll' + #13#10 +
        'HudWeaponGroups.dll' + #13#10 +
        'HudTarget.dll' + #13#10 +
        'HudStatus.dll'
      )

      FileReplaceString(HudShiftPath,';HudWeaponGroups = true','HudWeaponGroups = true')

      FileReplaceString(
        HudShiftPath
        ,
        'position = 4e0a80, -0.3630, 4e0a94, -0.3025		; wireframe' + #13#10 +
        'position = 4e0fe7, -0.4105, 4e0fef, -0.3700		; TargetMinimizedFrame' + #13#10 +
        'position = 4e10ff, -0.4820, 4e1107, -0.2000		; TargetShipName' + #13#10 +
        'position = 4e1145, -0.4820, 4e1158, -0.2000' + #13#10 +
        'position = 4e1180, -0.4820, 4e1188, -0.2180		; SubtargetName' + #13#10 +
        'position = 4e11e2, -0.4820, 4e11f0, -0.2180' + #13#10 +
        'position = 4e1247, -0.2605, 4e124f, -0.2695		; TargetPreviousButton' + #13#10 +
        'position = 4e12b4, -0.2645, 4e12bc, -0.3005		; TargetNextButton' + #13#10 +
        'position = 4e175c, -0.4940, 4e1764, -0.3610		; TargetRankText'
        ,
        'position = 4e0a80, -0.1270, 4e0a94, -0.3000		; wireframe' + #13#10 +
        'position = 4e0fe7, -0.4105, 4e0fef, -0.3700		; TargetMinimizedFrame' + #13#10 +
        'position = 4e10ff, -0.2430, 4e1107, -0.2030		; TargetShipName' + #13#10 +
        'position = 4e1145, -0.2430, 4e1158, -0.2030' + #13#10 +
        'position = 4e1180, -0.2430, 4e1188, -0.2210		; SubtargetName' + #13#10 +
        'position = 4e11e2, -0.2430, 4e11f0, -0.2210' + #13#10 +
        'position = 4e1247, -0.0545, 4e124f, -0.2770		; TargetPreviousButton' + #13#10 +
        'position = 4e12b4, -0.0575, 4e12bc, -0.3080		; TargetNextButton' + #13#10 +
        'position = 4e175c, -0.2550, 4e1764, -0.3610		; TargetRankText'
      )

     FileReplaceString(HudShiftPath,'position = 4da2fa,  0.4180, 4da30e, -0.2900','position = 4da2fa,  0.5165, 4da30e, -0.3030, -1.0')
     FileReplaceString(HudShiftPath,'position = 4e14db, -0.2020, 4e14e3, -0.3700		; TargetTradeButton','position = 4e14db, -0.0180, 4e14e3, -0.3700		; TargetTradeButton')

     RenameFile(ExpandConstant('{app}\DATA\INTERFACE\HUD\hud_shipinfo.cmp'),ExpandConstant('{app}\DATA\INTERFACE\HUD\hud_shipinfo_vanilla.cmp'))
     RenameFile(ExpandConstant('{app}\DATA\INTERFACE\HUD\hud_target.cmp'),ExpandConstant('{app}\DATA\INTERFACE\HUD\hud_target_vanilla.cmp')) 
     RenameFile(ExpandConstant('{app}\DATA\INTERFACE\HUD\hud_shipinfo_adv_wide_hud.cmp'),ExpandConstant('{app}\DATA\INTERFACE\HUD\hud_shipinfo.cmp'))
     RenameFile(ExpandConstant('{app}\DATA\INTERFACE\HUD\hud_target_adv_wide_hud.cmp'),ExpandConstant('{app}\DATA\INTERFACE\HUD\hud_target.cmp')) 
  end
end;

// Next 5 functions are for custom pages. Can possibly be removed.
procedure PageHandler_Activate(Page: TWizardPage);
begin
end;

function PageHandler_ShouldSkipPage(Page: TWizardPage): Boolean;
begin
  Result := False;
end;

function PageHandler_BackButtonClick(Page: TWizardPage): Boolean;
begin
  Result := True;
end;

function PageHandler_NextButtonClick(Page: TWizardPage): Boolean;
begin
  Result := True;
end;

procedure PageHandler_CancelButtonClick(Page: TWizardPage; var Cancel, Confirm: Boolean);
begin
end;

// Checks which step we are on when it changed. If its the postinstall step then start the actual installing
procedure CurStepChanged(CurStep: TSetupStep);
begin
    if CurStep = ssPostInstall then 
    begin
        // Debug
        if(OfflineInstall <> 'false') then FileCopy(OfflineInstall,ExpandConstant('{tmp}\freelancerhd.zip'),false);

        // Copy Vanilla game to directory
        WizardForm.StatusLabel.Caption := 'Copying Vanilla Freelancer directory';
        DirectoryCopy(DataDirPage.Values[0],ExpandConstant('{app}'));
        UpdateProgress(50);

        // Unzip
        WizardForm.StatusLabel.Caption := 'Unzipping Freelancer: HD Edition';
        UnZip(ExpandConstant('{tmp}\freelancerhd.zip'),ExpandConstant('{app}'));
        UpdateProgress(95);

        // Process options
        WizardForm.StatusLabel.Caption := 'Processing your options';
        Process_CallSign();
        Process_StartUpLogo();
        Process_FreelancerLogo();
        Process_SmallText();
        Process_Console();
        Process_Effects();
        Process_Planetscape();
        Process_Win10();
        Process_HUD();

        // Delete restart.fl to stop crashes
        DeleteFile(ExpandConstant('{userdocs}\My Games\Freelancer\Accts\SinglePlayer\Restart.fl'));

        // Install Complete!
        UpdateProgress(100);
    end;
end;

// If the Next button is clicked on the DataDirPage then check that Freelancer is installed to this directory
function NextButtonClick(PageId: Integer): Boolean;
begin
    Result := True;
    // If they specify an offline file in the cmd line. Check it's valid, if not don't let them continue.
    if ((PageId = 1) and (OfflineInstall <> 'false') and (not FileExists(OfflineInstall) or (Pos('.zip',OfflineInstall) < 1))) then begin
      MsgBox('The specified source file either doesn''t exist or is not a valid .zip file', mbError, MB_OK);
      Result := False;
      exit;
    end;
    // Check Freelancer is installed in the folder they have specified
    if (PageId = DataDirPage.ID) and not FileExists(DataDirPage.Values[0] + '\EXE\Freelancer.exe') then begin
      MsgBox('Freelancer does not seem to be installed in that folder. Please select the correct folder.', mbError, MB_OK);
      Result := False;
      exit;
    end;
    // Validate install location
    if (PageId = 6) then begin
      // Need needs to be in a seperate if since it tries to expand {app} even if not on PageID 6. Pascal what are you doing!
      if(Pos(DataDirPage.Values[0],ExpandConstant('{app}')) > 0) then begin
        MsgBox('Freelancer: HD Edition cannot be installed to the same location as your vanilla install. Please select a new location.', mbError, MB_OK);
        Result := False;
        exit;
      end;
      // Check the install directory is empty
      if(not isEmptyDir(ExpandConstant('{app}'))) then begin
        MsgBox('Freelancer: HD Edition cannot be installed to a directory that is not empty. Please empty this directory or choose another one.', mbError, MB_OK);
        Result := False;
        exit;
      end;
    end;
    // Start downloading the mod
    if ((PageId = 10) and (OfflineInstall = 'false')) then begin
    // 1st Attempt
      DownloadPage.Clear;
      DownloadPage.Add('https://github.com/BC46/freelancer-hd-edition/archive/refs/tags/0.4.1.zip', 'freelancerhd.zip', '');
      DownloadPage.SetText('Downloading mod','');
      DownloadPage.Show;
      DownloadPage.ProgressBar.Style := npbstNormal;
      try
        try
          DownloadPage.Download;
          Result := True;
        except
          // 2nd Attempt
          SuppressibleMsgBox('Download failed. Attempting download with alternate mirror.', mbError, MB_OK, IDOK);
          Result := False;
          DownloadPage.Hide;    
          DownloadPageMirror.Clear;
          DownloadPageMirror.Add('https://pechey.net/files/freelancer-hd-edition-0.4.1.zip', 'freelancerhd.zip', '');
          DownloadPageMirror.SetText('Downloading mod','');
          DownloadPageMirror.Show;
          DownloadPageMirror.ProgressBar.Style := npbstNormal;
          try
            try
              DownloadPageMirror.Download;
              Result := True;
            except
              // 3rd Attempt
              Result := False;
              SuppressibleMsgBox('Download failed. Attempting download with another alternate mirror.', mbError, MB_OK, IDOK);
              DownloadPageMirror.Hide;    
              DownloadPageMirror2.Clear;
              DownloadPageMirror2.Add('https://onedrive.live.com/download?cid=F03BDD831B77D1AD&resid=F03BDD831B77D1AD%2193136&authkey=AB-33u2fKjr1-V8', 'freelancerhd.zip', '');
              DownloadPageMirror2.SetText('Downloading mod','');
              DownloadPageMirror2.Show;
              DownloadPageMirror2.ProgressBar.Style := npbstNormal;
              try
                try
                  DownloadPageMirror2.Download;
                  Result := True;
                except
                  // 4th Attempt
                  Result := False;
                  SuppressibleMsgBox('Download failed. Attempting download with another alternate mirror.', mbError, MB_OK, IDOK);
                  DownloadPageMirror2.Hide;    
                  DownloadPageMirror3.Clear;
                  DownloadPageMirror3.Add('https://archive.org/download/freelancer-hd-edition-0.4.1/freelancer-hd-edition-0.4.1.zip', 'freelancerhd.zip', '');
                  DownloadPageMirror3.SetText('Downloading mod','');
                  DownloadPageMirror3.Show;
                  DownloadPageMirror3.ProgressBar.Style := npbstNormal;
                  try
                    try
                      DownloadPageMirror3.Download;
                      Result := True;
                    except
                      // All attempts failed
                      Result := False;
                      SuppressibleMsgBox('Unable to download from alternate mirror. Please use the FLMM version.', mbCriticalError, MB_OK, IDOK);
                    end;
                  finally
                    DownloadPageMirror3.Hide;
                  end;
                end;
              finally
                DownloadPageMirror2.Hide;
              end;
          end;
         finally
            DownloadPageMirror.Hide;
         end;
       end;
     finally
        DownloadPage.Hide;
     end;
   end;
  end;

// Run when the wizard is opened.
procedure InitializeWizard;
var dir : string;
begin
    // Offline install
    OfflineInstall := ExpandConstant('{param:sourcefile|false}')

    // Initialise download page and mirrors
    DownloadPage := CreateDownloadPage(SetupMessage(msgWizardPreparing), SetupMessage(msgPreparingDesc), @OnDownloadProgress);
    DownloadPageMirror := CreateDownloadPage(SetupMessage(msgWizardPreparing), SetupMessage(msgPreparingDesc), @OnDownloadProgressMirror);
    DownloadPageMirror2 := CreateDownloadPage(SetupMessage(msgWizardPreparing), SetupMessage(msgPreparingDesc), @OnDownloadProgressMirror2);
    DownloadPageMirror3 := CreateDownloadPage(SetupMessage(msgWizardPreparing), SetupMessage(msgPreparingDesc), @OnDownloadProgressMirror3);

    // Initialize DataDirPage and add content
    DataDirPage := CreateInputDirPage(wpInfoBefore,
    'Select Freelancer installation', 'Where is Freelancer installed?',
    'Select the folder in which a fresh copy of Freelancer is installed, then click Next. This is usually C:\Program Files (x86)\Microsoft Games\Freelancer',
    False, '');
    DataDirPage.Add('');

    if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Wow6432Node\Microsoft\Microsoft Games\Freelancer\1.0',
     'AppPath', dir) then
    begin
    // If the Reg key exists, populate the folder location box
      DataDirPage.Values[0] := dir
    end;

    // Initialize CallSign page and add content
    CallSign := CreateInputOptionPage(DataDirPage.ID,
    'Simgle Player ID Code', 'Tired of being called Freelancer Alpha 1-1?',
    'You know when each time an NPC talks to you in-game, they call you Freelancer Alpha 1-1? This is your ID Code. Well, this mod gives you the ability to change your ID Code in Single Player! Just select any option you like and the NPCs will call you by that.',
    True, False);
    CallSign.Add('Freelancer Alpha 1-1 (Default)');
    CallSign.Add('Navy Beta 2-5');
    CallSign.Add('Bretonia Police Iota 3-4');
    CallSign.Add('Military Epsilon 11-6');
    CallSign.Add('Naval Forces Matsu 4-9');
    CallSign.Add('IMG Red 18-6');
    CallSign.Add('Kishiro Yanagi 7-3');
    CallSign.Add('Outcasts Lambda 9-12');
    CallSign.Add('Dragons Green 16-13');
    CallSign.Add('Spa and Cruise Omega 8-0');
    CallSign.Add('Daumann Zeta 11-17');
    CallSign.Add('Bowex Gamma 5-7');
    CallSign.Add('Order Omicron 0-0');
    CallSign.Add('LSF Delta 6-9');
    CallSign.Add('Hacker Kappa 4-20');
    CallSign.Values[0] := True;

    // Initialize StartupRes page and add content
    StartupRes := CreateInputOptionPage(CallSign.ID,
    'Startup Screen Resolution', 'Choose your native resolution',
    'By default, the "Freelancer" splash screen you see when you start the game has a resolution of 1280x960. This makes it appear stretched and a bit blurry on HD 16:9 resolutions. ' +
    'We recommend setting this option to your monitor''s native resolution. ' +
    'A higher resolution option may negatively impact the game''s start-up speed.',
    True, False);
    StartupRes.Add('Remove Startup Screen');
    StartupRes.Add('720p 16:9 - 1280x720');
    StartupRes.Add('960p 4:3 - 1280x960 (Vanilla)');
    StartupRes.Add('1080p 4:3 - 1440x1080');
    StartupRes.Add('1080p 16:9 - 1920x1080');
    StartupRes.Add('1440p 4:3 - 1920x1440');
    StartupRes.Add('1440p 16:9 - 2560x1440');
    StartupRes.Add('4K 4:3 - 2880x2160');
    StartupRes.Add('4K 16:9 - 3840x2160');
    StartupRes.Values[4] := True;

    // Initialize LogoRes page and add content
    LogoRes := CreateInputOptionPage(StartupRes.ID,
    'Freelancer Logo Resolution', 'In the game''s main menu',
    'This logo has a resolution of 800x600 by default, which makes it look stretched and pixelated/blurry on HD 16:9 monitors. ' +
    'Setting this to a higher resolution with the correct aspect ratio makes the logo look nice and sharp and not stretched-out. Hence we recommend setting this option to your monitor''s native resolution. ' +
    'A higher resolution option may negatively impact the game''s start-up speed.',
    True, False);
    LogoRes.Add('Remove Logo');
    LogoRes.Add('600p 4:3 - 800x600 (Vanilla)');
    LogoRes.Add('720p 4:3 - 960x720');
    LogoRes.Add('720p 16:9 - 1280x720');
    LogoRes.Add('1080p 4:3 - 1440x1080');
    LogoRes.Add('1080p 16:9 - 1920x1080');
    LogoRes.Add('1440p 4:3 - 1920x1440');
    LogoRes.Add('1440p 16:9 - 2560x1440');
    LogoRes.Add('4K 4:3 - 2880x2160');
    LogoRes.Add('4K 16:9 - 3840x2160');
    LogoRes.Values[5] := True;

    // Fix Small Text on 1440p/4K resolutions
    SmallText := CreateInputOptionPage(LogoRes.ID,
    'Fix small text on 1440p/4K resolutions', 'In the game''s main menu',
    'Many high-resolution Freelancer players have reported missing HUD text and misaligned buttons in menus. In 4K, the nav map text is too small and there are many missing text elements in the HUD. For 1440p screens, the only apparent issue is the small nav map text.' + #13#10 + #13#10 +
    'Select the option corresponding to the resolution you’re going to play Freelancer in. If you play in 1920x1080 or lower, the “No” option is fine as the elements are configured correctly already.',
    True, False);
    SmallText.Add('No');
    SmallText.Add('Yes, apply fix for 2560x1440 screens');
    SmallText.Add('Yes, apply fix for 3840x2160 screens');
    SmallText.Values[0] := True;

    // Initialize HUD page and add content
    PageWidescreenHud := CreateCustomPage(
      SmallText.ID,
      'Advanced Widescreen HUD',
      'Check to install'
    );

    lblWidescreenHud := TLabel.Create(PageWidescreenHud);
    lblWidescreenHud.Parent := PageWidescreenHud.Surface;
    lblWidescreenHud.Caption := 'Advanced Widescreen HUD for 16:9 resolutions';
    lblWidescreenHud.Left := ScaleX(20);
  
    descWidescreenHud := TNewStaticText.Create(PageWidescreenHud);
    descWidescreenHud.Parent := PageWidescreenHud.Surface;
    descWidescreenHud.WordWrap := True;
    descWidescreenHud.Top := ScaleY(20);
    descWidescreenHud.Width := PageWidescreenHud.SurfaceWidth;
    descWidescreenHud.Caption := 'This option adds two new useful widgets to your HUD. Next to your contact list, you will have a wireframe representation of your selected target. Next to your weapons list, you will have a wireframe of your own ship.' + #13#10 + #13#10 +
    'If you play in 4:3, disable this option. It only works for widescreen resolutions. If you disable this option, you will still get support for the default 16:9 HUD and corresponding resolutions.' + #13#10 + #13#10 +
    'The Advanced Widescreen HUD makes great use of the unused space that you normally see in widescreen, hence we recommend it for all players who play in 16:9. If you choose to enable this, go to the Controls settings in-game and under “User Interface”, disable Target View (Alt + T). This key binding has become obsolete as both the target view and contact list are visible simultaneously.';
  
    WidescreenHud := TCheckBox.Create(PageWidescreenHud);
    WidescreenHud.Parent := PageWidescreenHud.Surface;
    WidescreenHud.Checked := True;
  
    // Fix clipping with 16:9 resolution planetscapes
    PagePlanetScape := CreateCustomPage(
      PageWidescreenHud.ID,
      'Fix clipping with 16:9 resolution planetscapes',
      'Check to install'
    );
  
    lblPlanetScape := TLabel.Create(PagePlanetScape);
    lblPlanetScape.Parent := PagePlanetScape.Surface;
    lblPlanetScape.Caption := 'Fix clipping with 16:9 resolution planetscapes';
    lblPlanetScape.Left := ScaleX(20);
  
    descPlanetScape := TNewStaticText.Create(PagePlanetScape);
    descPlanetScape.Parent := PagePlanetScape.Surface;
    descPlanetScape.WordWrap := True;
    descPlanetScape.Top := ScaleY(20);
    descPlanetScape.Width := PagePlanetScape.SurfaceWidth;
    descPlanetScape.Caption := 'Since Freelancer was never optimized for 16:9 resolutions, there are several inconsistencies with planetscapes that occur while viewing them in 16:9, such as clipping and geometry issues.' + #13#10 + #13#10 +
    'This mod gives you the option of fixing this, as it adjusts the camera values in the planetscapes so the issues are no longer visible in 16:9 resolutions.' + #13#10 + #13#10 +
    'Disable this option if you play in 4:3.'
  
    PlanetScape := TCheckBox.Create(PagePlanetScape);
    PlanetScape.Parent := PagePlanetScape.Surface;
    PlanetScape.Checked := True;
  
    // Fix Windows 10 compatibility issues
    PageWin10 := CreateCustomPage(
      PagePlanetScape.ID,
      'Fix Windows 10 compatibility issues',
      'Check to install - USE AT OWN RISK'
    );
  
    lblWin10 := TLabel.Create(PageWin10);
    lblWin10.Parent := PageWin10.Surface;
    lblWin10.Caption := 'Fix Windows 10 compatibility issues.';
    lblWin10.Left := ScaleX(20);
  
    descWin10 := TNewStaticText.Create(PageWin10);
    descWin10.Parent := PageWin10.Surface;
    descWin10.WordWrap := True;
    descWin10.Top := ScaleY(20);
    descWin10.Width := PageWin10.SurfaceWidth;
    descWin10.Caption := 'Windows 10 users may experience compatibility issues while playing (vanilla) Freelancer including broken lighting in many base interiors and missing glass reflections.' + #13#10 + #13#10 +
    'We''ve included a Legacy DirectX wrapper named dgVoodoo2 in this mod, which serves as an optional patch that fixes all of these issues.' + #13#10 + #13#10 +
    'However, we have disabled this option by default as you may experience crashes, bugs, and stutters while using it. So please try it at your own risk.' + #13#10 + #13#10 +
    'If you experience a refresh rate/fps lock to 60 while using this patch, please refer to the wiki for a solution: https://github.com/BC46/freelancer-hd-edition/wiki'; 
  
    Win10 := TCheckBox.Create(PageWin10);
    Win10.Parent := PageWin10.Surface;
  
    // Add improved reflections
    PageEffects := CreateCustomPage(
      PageWin10.ID,
      'Add improved effects',
      'Check to install'
    );
  
    lblReflections := TLabel.Create(PageEffects);
    lblReflections.Parent := PageEffects.Surface;
    lblReflections.Caption := 'Add improved reflections';
    lblReflections.Left := ScaleX(20);
  
    descReflections := TNewStaticText.Create(PageEffects);
    descReflections.Parent := PageEffects.Surface;
    descReflections.WordWrap := True;
    descReflections.Top := ScaleY(20);
    descReflections.Width := PageEffects.SurfaceWidth;
    descReflections.Caption := 'This option speaks for itself. It makes the way light reflects off ships, bases, etc, a lot nicer.';
  
    Reflections := TCheckBox.Create(PageEffects);
    Reflections.Parent := PageEffects.Surface;
    Reflections.Checked := True;
  
    // Add new missile effects
    lblMissleEffects := TLabel.Create(PageEffects);
    lblMissleEffects.Parent := PageEffects.Surface;
    lblMissleEffects.Caption := 'Add new missile effects';
    lblMissleEffects.Top := ScaleY(60);
    lblMissleEffects.Left := ScaleX(20);
  
    descMissileEffects := TNewStaticText.Create(PageEffects);
    descMissileEffects.Parent := PageEffects.Surface;
    descMissileEffects.WordWrap := True;
    descMissileEffects.Top := ScaleY(80);
    descMissileEffects.Width := PageEffects.SurfaceWidth;
    descMissileEffects.Caption := 'This option replaces the existing missile effects with new ones. Enable them if you prefer these over the normal ones.';
  
    MissileEffects := TCheckBox.Create(PageEffects);
    MissileEffects.Parent := PageEffects.Surface;
    MissileEffects.Top := ScaleY(60);
  
    // Single Player Command Console
    PageSinglePlayer := CreateCustomPage(
      PageEffects.ID,
      'Single Player Command Console',
      'Check to install'
    );
  
    lblSinglePlayer := TLabel.Create(PageSinglePlayer);
    lblSinglePlayer.Parent := PageSinglePlayer.Surface;
    lblSinglePlayer.Caption := 'Single Player Command Console';
    lblSinglePlayer.Left := ScaleX(20);
  
    descSinglePlayer := TNewStaticText.Create(PageSinglePlayer);
    descSinglePlayer.Parent := PageSinglePlayer.Surface;
    descSinglePlayer.WordWrap := True;
    descSinglePlayer.Top := ScaleY(20);
    descSinglePlayer.Width := PageSinglePlayer.SurfaceWidth;
    descSinglePlayer.Caption := 'This option speaks for itself. It allows players to make use of various console commands in Single Player. To use it, press Enter while in-game and type "help" for a list of available commands. This command console is very useful for testing and debugging purposes.';
  
    SinglePlayer := TCheckBox.Create(PageSinglePlayer);
    SinglePlayer.Parent := PageSinglePlayer.Surface;
  
    // Add the functions for each button for each page
    with PageWidescreenHud do
    begin
      OnActivate := @PageHandler_Activate;
      OnShouldSkipPage := @PageHandler_ShouldSkipPage;
      OnBackButtonClick := @PageHandler_BackButtonClick;
      OnNextButtonClick := @PageHandler_NextButtonClick;
      OnCancelButtonClick := @PageHandler_CancelButtonClick;
    end;
  
    with PagePlanetScape do
    begin
      OnActivate := @PageHandler_Activate;
      OnShouldSkipPage := @PageHandler_ShouldSkipPage;
      OnBackButtonClick := @PageHandler_BackButtonClick;
      OnNextButtonClick := @PageHandler_NextButtonClick;
      OnCancelButtonClick := @PageHandler_CancelButtonClick;
    end;
  
    with PageWin10 do
    begin
      OnActivate := @PageHandler_Activate;
      OnShouldSkipPage := @PageHandler_ShouldSkipPage;
      OnBackButtonClick := @PageHandler_BackButtonClick;
      OnNextButtonClick := @PageHandler_NextButtonClick;
      OnCancelButtonClick := @PageHandler_CancelButtonClick;
    end;
  
    with PageEffects do
    begin
      OnActivate := @PageHandler_Activate;
      OnShouldSkipPage := @PageHandler_ShouldSkipPage;
      OnBackButtonClick := @PageHandler_BackButtonClick;
      OnNextButtonClick := @PageHandler_NextButtonClick;
      OnCancelButtonClick := @PageHandler_CancelButtonClick;
    end;
  
    with PageSinglePlayer do
    begin
      OnActivate := @PageHandler_Activate;
      OnShouldSkipPage := @PageHandler_ShouldSkipPage;
      OnBackButtonClick := @PageHandler_BackButtonClick;
      OnNextButtonClick := @PageHandler_NextButtonClick;
      OnCancelButtonClick := @PageHandler_CancelButtonClick;
    end;
 end;


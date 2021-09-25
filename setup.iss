; Inno Install Script for Freelancer HD Edition
; GitHub: https://github.com/ollieraikkonen/Freelancer-hd-edition-install-script
; Main GitHub: https://github.com/bc46/Freelancer-hd-edition

#define MyAppName "Freelancer HD Edition"
#define MyAppVersion "0.4.1"
#define MyAppPublisher "Freelancer: HD Edition Development Team"
#define MyAppURL "https://github.com/BC46/freelancer-hd-edition"
#define MyAppExeName "Freelancer.exe"

#include ReadReg(HKLM, 'Software\WOW6432Node\Mitrich Software\Inno Download Plugin', 'InstallDir') + '\idp.iss'

[Setup]
AppId={{F40FDCDA-3A45-4CC3-9FDA-167EE480A1E0}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={win}\Freelancer HD Edition
DefaultGroupName={#MyAppName}
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
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\EXE\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\EXE\{#MyAppExeName}"; Tasks: desktopicon

[Files]
Source: "installinfo.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "AGENCYB.TTF"; DestDir: "{autofonts}"; FontInstall: "Agency FB Bold"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "AGENCYR.TTF"; DestDir: "{autofonts}"; FontInstall: "Agency FB"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "ARIALUNI.TTF"; DestDir: "{autofonts}"; FontInstall: "Agency Unicode MS"; Flags: onlyifdoesntexist uninsneveruninstall

[Run]
Filename: "{app}\EXE\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Messages]
WelcomeLabel2=Freelancer: HD Edition is a mod that aims to improve every aspect of Freelancer while keeping the look and feel as close to vanilla as possible. It also serves as an all-in-one package for players so they don't have to worry about installing countless patches and mods to create the perfect HD and bug-free install.%n%n This installer requires a clean, freshly installed Freelancer directory.

[Code]
var
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
        if (FindRec.Name <> '.') and (FindRec.Name <> '..') then
        begin
          SourceFilePath := SourcePath + '\' + FindRec.Name;
          DestFilePath := DestPath + '\' + FindRec.Name;
          if FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY = 0 then
          begin
            if FileCopy(SourceFilePath, DestFilePath, False) then
            begin
              Log(Format('Copied %s to %s', [SourceFilePath, DestFilePath]));
            end
              else
            begin
              Log(Format('Failed to copy %s to %s', [
                SourceFilePath, DestFilePath]));
            end;
          end
            else
          begin
            if DirExists(DestFilePath) or CreateDir(DestFilePath) then
            begin
              Log(Format('Created %s', [DestFilePath]));
              DirectoryCopy(SourceFilePath, DestFilePath);
            end
              else
            begin
              Log(Format('Failed to create %s', [DestFilePath]));
            end;
          end;
        end;
      until not FindNext(FindRec);
    finally
      FindClose(FindRec);
    end;
  end
    else
  begin
    Log(Format('Failed to list %s', [SourcePath]));
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
begin
  Shell := CreateOleObject('Shell.Application');

  ZipFile := Shell.NameSpace(ZipPath);
  if VarIsClear(ZipFile) then
    RaiseException(
      Format('ZIP file "%s" does not exist or cannot be opened', [ZipPath]));

  TargetFolder := Shell.NameSpace(TargetPath);
  if VarIsClear(TargetFolder) then
    RaiseException(Format('Target path "%s" does not exist', [TargetPath]));

  TargetFolder.CopyHere(
    ZipFile.Items, SHCONTCH_NOPROGRESSBOX or SHCONTCH_RESPONDYESTOALL);
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

      { Only save if text has been changed. }
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

// Process CallSign option. Replaces strings in freelancer.ini depending on what the user clicks
function CallSignOption():boolean;
var
  FilePath : string;
begin
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
function StartUpLogo():boolean;
var
  FolderPath : string;
  OldFile : string;
  NewFile : string;
begin
  FolderPath := ExpandConstant('{app}\DATA\INTERFACE\INTRO\IMAGES\');
  NewFile := FolderPath + 'startupscreen_1280.tga';

  if(StartupRes.Values[0]) then
    begin 
      OldFile := NewFile
      NewFile := FolderPath + 'startupscreen_1280_1280x960.tga'
    end
  else if(StartupRes.Values[1]) then 
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

  RenameFile(OldFile,NewFile);
  
end;

// Processes the Freelancer logo option. Renames files depending on what option is selected
function FreelancerLogo():boolean;
var
  FolderPath : string;
  OldFile : string;
  NewFile : string;
begin
  FolderPath := ExpandConstant('{app}\DATA\INTERFACE\INTRO\IMAGES\');
  NewFile := FolderPath + 'front_freelancerlogo.tga';

  if(StartupRes.Values[0]) then
    begin 
      OldFile := NewFile
      NewFile := FolderPath + 'front_freelancerlogo_800x600.tga'
    end
  else if(StartupRes.Values[2]) then 
    OldFile := FolderPath + 'front_freelancerlogo_960x720.tga'
  else if(StartupRes.Values[3]) then 
    OldFile := FolderPath + 'front_freelancerlogo_1280x720.tga'
  else if(StartupRes.Values[4]) then 
    OldFile := FolderPath + 'front_freelancerlogo_1440x1080.tga'
  else if(StartupRes.Values[5]) then 
    OldFile := FolderPath + 'front_freelancerlogo_1920x1080.tga'
  else if(StartupRes.Values[6]) then 
    OldFile := FolderPath + 'front_freelancerlogo_1920x1440.tga'
  else if(StartupRes.Values[7]) then 
    OldFile := FolderPath + 'front_freelancerlogo_2560x1440.tga'
  else if(StartupRes.Values[8]) then 
    OldFile := FolderPath + 'front_freelancerlogo_2880x2160.tga'
  else if(StartupRes.Values[8]) then 
    OldFile := FolderPath + 'front_freelancerlogo_3840x2160.tga';

  RenameFile(OldFile,NewFile);
  
end;

// Next 5 functions are for custom pages. Can possibly be removed.
procedure frmOptions_Activate(Page: TWizardPage);
begin
end;

function frmOptions_ShouldSkipPage(Page: TWizardPage): Boolean;
begin
  Result := False;
end;

function frmOptions_BackButtonClick(Page: TWizardPage): Boolean;
begin
  Result := True;
end;

function frmOptions_NextButtonClick(Page: TWizardPage): Boolean;
begin
  Result := True;
end;

procedure frmOptions_CancelButtonClick(Page: TWizardPage; var Cancel, Confirm: Boolean);
begin
end;

// Checks which step we are on when it changed. If its the postinstall step then start the actual installing
procedure CurStepChanged(CurStep: TSetupStep);
begin
    if CurStep = ssPostInstall then 
    begin
        // Copy Vanilla game to directory
        DirectoryCopy(DataDirPage.Values[0],ExpandConstant('{app}'));
        // Unzip
        UnZip(ExpandConstant('{tmp}\freelancerhd.zip'),ExpandConstant('{app}'));
        CallSignOption();
        StartUpLogo();
        FreelancerLogo();
    end;
end;

// If the Next button is clicked on the DataDirPage then check that Freelancer is installed to this directory
function NextButtonClick(PageId: Integer): Boolean;
begin
    Result := True;
    if (PageId = DataDirPage.ID) and not FileExists(DataDirPage.Values[0] + '\EXE\Freelancer.exe') then begin
      MsgBox('Freelancer does not seem to be installed in that folder.  Please select the correct folder.', mbError, MB_OK);
      Result := False;
      exit;
    end;
    // Validate install location
    if (PageId = 6) then begin
      // Need needs to be in a seperate if since it tries to expand {app} even if not on PageID 6. Pascal what are you doing!
      if(Pos(ExpandConstant('{app}'),DataDirPage.Values[0]) > 0) then begin
        MsgBox('Freelancer: HD Edition cannot be installed to the same location as your vanilla install. Please select a new location.', mbError, MB_OK);
        Result := False;
        exit;
      end;
    end;
end;

// Run when the wizard is opened.
procedure InitializeWizard;
var dir : string;
begin
    // Download Mod and store in temp directory
    idpAddFileSize('https://github.com/BC46/freelancer-hd-edition/archive/refs/tags/0.4.1.zip', ExpandConstant('{tmp}\freelancerhd.zip'),3296899072);
    idpDownloadAfter(wpReady);

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
    'By default, the "Freelancer" splash screen you see when you start the game has a resolution of 1280x960. This makes it appear stretched and a bit blurry on HD 16:9 resolutions.' +
    'We recommend setting this option to your monitor''s native resolution.',
    True, False);
    StartupRes.Add('Remove Startup Screen');
    StartupRes.Add('720p 16:9 - 1280x720');
    StartupRes.Add('960p 4:3 - 1280x960 (Default)');
    StartupRes.Add('1080p 4:3 - 1440x1080');
    StartupRes.Add('1080p 16:9 - 1920x1080');
    StartupRes.Add('1440p 4:3 - 1920x1440');
    StartupRes.Add('1440p 16:9 - 2560x1440');
    StartupRes.Add('4K 4:3 - 2880x2160');
    StartupRes.Add('4K 16:9 - 3840x2160');
    StartupRes.Values[2] := True;

    // Initialize LogoRes page and add content
    LogoRes := CreateInputOptionPage(StartupRes.ID,
    'Freelancer Logo Resolution', 'In the game''s main menu',
    'This logo has a resolution of 800x600 by default, which makes it look stretched and pixelated/blurry on HD 16:9 monitors.' +
    'Setting this to a higher resolution with the correct aspect ratio makes the logo look nice and sharp and not stretched-out. Hence we recommend setting this option to your monitor''s native resolution.',
    True, False);
    LogoRes.Add('1080p 16:9 - 1920x1080');
    LogoRes.Add('Remove Logo');
    LogoRes.Add('600p 4:3 - 800x600 (Default)');
    LogoRes.Add('720p 4:3 - 960x720');
    LogoRes.Add('720p 16:9 - 1280x720');
    LogoRes.Add('1080p 4:3 - 1440x1080');
    LogoRes.Add('1440p 4:3 - 1920x1440');
    LogoRes.Add('1440p 16:9 - 2560x1440');
    LogoRes.Add('4K 4:3 - 2880x2160');
    LogoRes.Add('4K 16:9 - 3840x2160');
    LogoRes.Values[2] := True;

    // Fix Small Text on 1440p/4K resolutions
    SmallText := CreateInputOptionPage(LogoRes.ID,
    'Fix small text on 1440p/4K resolutions', 'In the game''s main menu',
    'Many high-resolution Freelancer players have reported missing HUD text and misaligned buttons in menus. In 4K, the nav map text is too small and there are many missing text elements in the HUD. For 1440p screens, the only apparent issue is the small nav map text.' + #13#10 + #13#10 +
    'Select the option corresponding to the resolution you’re going to play Freelancer in. If you play in 1920x1080 or lower, the “No” option is fine as the elements are configured correctly already.',
    True, False);
    SmallText.Add('No');
    SmallText.Add('1440p');
    SmallText.Add('4k');
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
    MissileEffects.Checked := True;
  
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
    SinglePlayer.Checked := True;
  
    // Add the functions for each button for each page
    with PageWidescreenHud do
    begin
      OnActivate := @frmOptions_Activate;
      OnShouldSkipPage := @frmOptions_ShouldSkipPage;
      OnBackButtonClick := @frmOptions_BackButtonClick;
      OnNextButtonClick := @frmOptions_NextButtonClick;
      OnCancelButtonClick := @frmOptions_CancelButtonClick;
    end;
  
    with PagePlanetScape do
    begin
      OnActivate := @frmOptions_Activate;
      OnShouldSkipPage := @frmOptions_ShouldSkipPage;
      OnBackButtonClick := @frmOptions_BackButtonClick;
      OnNextButtonClick := @frmOptions_NextButtonClick;
      OnCancelButtonClick := @frmOptions_CancelButtonClick;
    end;
  
    with PageWin10 do
    begin
      OnActivate := @frmOptions_Activate;
      OnShouldSkipPage := @frmOptions_ShouldSkipPage;
      OnBackButtonClick := @frmOptions_BackButtonClick;
      OnNextButtonClick := @frmOptions_NextButtonClick;
      OnCancelButtonClick := @frmOptions_CancelButtonClick;
    end;
  
    with PageEffects do
    begin
      OnActivate := @frmOptions_Activate;
      OnShouldSkipPage := @frmOptions_ShouldSkipPage;
      OnBackButtonClick := @frmOptions_BackButtonClick;
      OnNextButtonClick := @frmOptions_NextButtonClick;
      OnCancelButtonClick := @frmOptions_CancelButtonClick;
    end;
  
    with PageSinglePlayer do
    begin
      OnActivate := @frmOptions_Activate;
      OnShouldSkipPage := @frmOptions_ShouldSkipPage;
      OnBackButtonClick := @frmOptions_BackButtonClick;
      OnNextButtonClick := @frmOptions_NextButtonClick;
      OnCancelButtonClick := @frmOptions_CancelButtonClick;
    end;
 end;


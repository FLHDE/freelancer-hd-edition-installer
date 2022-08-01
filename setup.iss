; Inno Install Script for Freelancer: HD Edition
; GitHub: https://github.com/oliverpechey/Freelancer-hd-edition-install-script
; Main GitHub: https://github.com/BC46/Freelancer-hd-edition

#define MyAppVersion "0.6"
#define MyAppName "Freelancer: HD Edition v" + MyAppVersion
#define MyAppPublisher "Freelancer: HD Edition Development Team"
#define MyAppURL "https://github.com/BC46/freelancer-hd-edition"
#define MyAppExeName "Freelancer.exe"
#define MyFolderName "freelancer-hd-edition-" + MyAppVersion
#define MyZipName "freelancerhd"
; This variable controls whether the zip is shipped with the exe or downloaded from a mirror
#define AllInOneInstall true
#dim Mirrors[2] {"https://github.com/BC46/freelancer-hd-edition/archive/refs/tags/" + MyAppVersion + ".zip", "https://archive.org/download/freelancer-hd-edition-" + MyAppVersion + "/freelancer-hd-edition-" + MyAppVersion + ".7z"}
; TODO: Update sizes for each release
#define SizeZip 2438619136
#define SizeExtracted 4195188736
#define SizeVanilla 985624576
#define SizeBuffer 100000
#define SizeAll SizeZip + SizeExtracted + SizeVanilla + SizeBuffer

[Setup]
AllowNoIcons=yes
AppId={{F40FDCDA-3A45-4CC3-9FDA-167EE480A1E0}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
ChangesAssociations=yes
Compression=lzma
DefaultDirName={localappdata}\Freelancer HD Edition
DefaultGroupName=Freelancer HD Edition
DisableWelcomePage=False
DisableDirPage=False
ExtraDiskSpaceRequired = {#SizeAll}
InfoBeforeFile={#SourcePath}\Assets\Text\installinfo.txt
OutputBaseFilename=FreelancerHDSetup
SetupIconFile={#SourcePath}\Assets\Images\icon.ico
SolidCompression=yes
UninstallDisplayIcon={#SourcePath}\Assets\Images\icon.ico
UninstallDisplayName={#MyAppName}
WizardImageFile={#SourcePath}\Assets\Images\backgroundpattern.bmp
WizardSmallImageFile={#SourcePath}\Assets\Images\icon.bmp
WizardSizePercent=105
VersionInfoVersion=1.0.0.0

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}";

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\EXE\{#MyAppExeName}"
Name: "{commondesktop}\Freelancer HD Edition"; Filename: "{app}\EXE\{#MyAppExeName}"; Tasks: desktopicon

[Files]
Source: "Assets\Text\installinfo.txt"; DestDir: "{app}"; Flags: ignoreversion deleteafterinstall
Source: "Assets\Text\PerfOptions.ini"; DestDir: "{app}"; Flags: ignoreversion deleteafterinstall
Source: "Assets\Text\UserKeyMap.ini"; DestDir: "{app}"; Flags: ignoreversion deleteafterinstall
Source: "Assets\Fonts\AGENCYB.TTF"; DestDir: "{autofonts}"; FontInstall: "Agency FB Bold"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "Assets\Fonts\AGENCYR.TTF"; DestDir: "{autofonts}"; FontInstall: "Agency FB"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "Assets\Fonts\AGENCYR_CR.TTF"; DestDir: "{autofonts}"; FontInstall: "Agency FB Cyrillic"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "Assets\Fonts\ARIALUNI.TTF"; DestDir: "{autofonts}"; FontInstall: "Arial Unicode MS"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "Assets\External\7za.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall;
Source: "Assets\External\utf-8-bom-remover.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall;
Source: "Assets\External\HexToBinary.dll"; Flags: dontcopy;
# if AllInOneInstall
Source: "Assets\Mod\freelancerhd.7z"; DestDir: "{tmp}"; Flags: nocompression deleteafterinstall
#endif

[Run]
Filename: "{app}\EXE\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Messages]
WelcomeLabel2=Freelancer: HD Edition is a mod that aims to improve every aspect of Freelancer while keeping the look and feel as close to vanilla as possible. It also serves as an all-in-one package for players so they do not have to worry about installing countless patches and mods to create the perfect HD and bug-free install.%n%nThis installer requires a clean, freshly installed Freelancer directory.
FinishedLabel=Setup has finished installing [name] on your computer. The application may be launched by selecting the installed shortcut.%n%nNOTE: [name] has been installed as a separate application. Therefore, your vanilla Freelancer installation has not been modified and can still be played at any time.

[Code]
# if !AllInOneInstall
// Declaration of global variables
var
  // Allows us to skip the downloading of the files and just copy it from the local PC to save time
  OfflineInstall: String;

  // String list of mirrors that we can potentially download the mod from. This is populated in InitializeWizard()
  mirrors : TStringList;
  // Size of Download in MB
  DownloadSize : String;
#endif

// Imports from other .iss files
#include "utilities.iss"
#include "ui.iss"
#include "mod_options.iss"

// Checks which step we are on when it changed. If its the postinstall step then start the actual installing
procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode, i: Integer;
begin
    if CurStep = ssPostInstall then
    begin
        # if !AllInOneInstall
          if (OfflineInstall <> 'false') then
            FileCopy(OfflineInstall,ExpandConstant('{tmp}\' + MyZipName + '.7z'),false);
        # endif

        // Copy Vanilla game to directory
        UpdateProgress(0);
        WizardForm.StatusLabel.Caption := 'Copying vanilla Freelancer directory';
        DirectoryCopy(DataDirPage.Values[0],ExpandConstant('{app}'),False);
        UpdateProgress(30);

        // Unzip
        WizardForm.StatusLabel.Caption := ExpandConstant('Unpacking {#MyAppName}');
        Exec(ExpandConstant('{tmp}\7za.exe'), ExpandConstant(' x -y -aoa "{tmp}\{#MyZipName}.7z"  -o"{app}"'), '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
        // -aoa Overwrite All existing files without prompt
        // -o Set output directory
        // -y Assume "Yes" on all Queries
        UpdateProgress(60);

        // Copy mod files
        WizardForm.StatusLabel.Caption := ExpandConstant('Relocating {#MyAppName}');

        DirectoryCopy(ExpandConstant('{app}\{#MyFolderName}'),ExpandConstant('{app}'),True);

        DelTree(ExpandConstant('{app}\{#MyFolderName}'), True, True, True);
        UpdateProgress(90);

        // Process options
        WizardForm.StatusLabel.Caption := 'Processing your options';
        Process_CallSign();
        Process_EnglishImprovements();
        Process_SinglePlayerMode();
        Process_NewSaveFolder();
        Process_LevelRequirements();
        Process_StartUpLogo();
        Process_FreelancerLogo();
        Process_SmallText(); // Must be called before Process_RussianFonts();
        Process_RussianFonts(); // Must be called after Process_SmallText();
        Process_Console();
        Process_BestOptions();
        Process_Effects();
        Process_SkipIntros();
        Process_JumpTunnelDurations();
        Process_DrawDistances();
        Process_Planetscape();
        Process_Win10();
        Process_HUD(); // Must be called before Process_FlatIcons(); and before Process_WeaponGroups();
        Process_DarkHUD();
        Process_FlatIcons(); // Must be called after Process_HUD();
        Process_WeaponGroups(); // Must be called after Process_HUD();
        Process_DxWrapper();
        Process_DxWrapperReShade();
        Process_DgVoodooReShade();
        Process_DgVoodoo();
        Process_DisplayMode();

        WizardForm.StatusLabel.Caption := 'Cleaning up';
        UpdateProgress(95);

        if not IsWine then
        begin
          // Delete potential UTF-8 BOM headers in all edited config files. May not work properly on Wine.
          for i := 0 to EditedConfigFiles.Count - 1 do
            RemoveBOM(EditedConfigFiles[i]);
        end else
        begin
          // Write d3d8 DLL override for Wine/Linux. For more information, see https://wiki.winehq.org/Wine_User%27s_Guide#DLL_Overrides
          RegWriteStringValue(HKEY_CURRENT_USER, 'Software\Wine\DllOverrides', 'd3d8', 'native,builtin');
        end;

        // Delete restart.fl to stop crashes
        DeleteFile(ExpandConstant('{userdocs}\My Games\Freelancer\Accts\SinglePlayer\Restart.fl'));
        DeleteFile(ExpandConstant('{userdocs}\My Games\FreelancerHD\Accts\SinglePlayer\Restart.fl'));

        // Remove 2003 junk files
        RemoveJunkFiles('dll');
        RemoveJunkFiles('msi');

        // Install Complete!
        UpdateProgress(100);
    end;
end;

// Various logic to be applied when the user clicks on the Next button.
function NextButtonClick(PageId: Integer): Boolean;
var
  i : Integer;
  RefreshRateError: String;
begin
    Result := True;

    if PageId = DgVoodooPage.ID then
    begin
      RefreshRateError := 'Refresh rate must be a valid number between 30 and 3840. If you don''t know how to find your monitor''s refresh rate, look it up on the internet.'
        + #13#10#13#10 + 'Keep in mind that the DxWrapper option does not require you to set a refresh rate manually.'

      // dgVoodoo options page refresh rate validation
      // Checks if the input is a valid number between 30 and 3840
      if (StrToInt(DgVoodooRefreshRate.Text) < 30) or (StrToInt(DgVoodooRefreshRate.Text) > 3840) then
        begin
          MsgBox(RefreshRateError, mbError, MB_OK);
          Result := False;
          Exit;
        end;

      // Checks if the input consists entirely of digits
      for i := 1 to Length(DgVoodooRefreshRate.Text) do
      begin
        if not IsDigit(DgVoodooRefreshRate.Text[i]) then
        begin
          MsgBox(RefreshRateError, mbError, MB_OK);
          Result := False;
          Exit;
        end;
      end;
    end;

    // If the user has selected the "do not pause on Alt-Tab" option, ask them if they want the game audio to continue playing in the background too.
    if (PageId = PageMiscOptions.ID) and (DoNotPauseOnAltTab.Checked) then
    begin
      MusicInBackground := MsgBox(
        'Freelancer will continue running in the background when Alt-Tabbed. Would you also like the game''s audio to continue playing in the background?' + #13#10 + #13#10 + 
        'You may not want this if you''re planning to run multiple instances of Freelancer simultaneously.',
        mbConfirmation, MB_YESNO) = IDYES
    end;

    // If they specify an offline file in the cmd line. Check if it's valid, if not don't let them continue.
    # if !AllInOneInstall
    if ((PageId = 1) and (OfflineInstall <> 'false') and (not FileExists(OfflineInstall) or (Pos('.7z',OfflineInstall) < 1))) then begin
      MsgBox('The specified source file either doesn''t exist or is not a valid .7z file', mbError, MB_OK);
      Result := False;
      exit;
    end;
    # endif
    // Check Freelancer is installed in the folder they have specified
    if (PageId = DataDirPage.ID) and not FileExists(DataDirPage.Values[0] + '\EXE\Freelancer.exe') then begin
      MsgBox('Freelancer does not seem to be installed in that folder. Please select the correct folder.', mbError, MB_OK);
      Result := False;
      exit;
    end;
    // Validate install location
    if (PageId = 6) then begin
      // Needs to be in a seperate if statement since it tries to expand {app} even if not on PageID 6. Pascal what are you doing!
      if(Pos(AddBackslash(DataDirPage.Values[0]),ExpandConstant('{app}')) > 0) then begin
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
    # if !AllInOneInstall
    // Start downloading the mod
    if ((PageId = 10) and (OfflineInstall = 'false')) then begin
      for i:= 0 to mirrors.Count - 1 do
      begin
        DownloadPage.Clear;
        DownloadPage.Add(mirrors[i], MyZipName + '.7z', '');
        DownloadPage.SetText('Downloading mod', '');
        DownloadPage.Show;
        DownloadPage.ProgressBar.Style := npbstNormal;
        try
          DownloadPage.Download;
          Result := True;
          i := mirrors.Count - 1;
        except
          if(i = mirrors.Count - 1) then
            SuppressibleMsgBox('All downloads failed. Please contact us on Discord: https://discord.gg/ScqgYuFqmU', mbError, MB_OK, IDOK)
          else
            if SuppressibleMsgBox('Download failed. Do you want to try downloading with an alternate mirror?', mbError, MB_RETRYCANCEL, IDRETRY) = IDCANCEL then
              i := mirrors.Count - 1;
          Result := False;
          DownloadPage.Hide;
        finally
          DownloadPage.Hide;
        end;
      end;
    end;
    # endif
end;

// Run when the wizard is opened.
procedure InitializeWizard;
begin
    # if !AllInOneInstall
      // Offline install
      OfflineInstall := ExpandConstant('{param:sourcefile|false}')

      // Copy mirrors from our preprocessor to our string array. This allows us to define the array at the top of the file for easy editing
      mirrors := TStringList.Create;

      #sub PopMirrors
        mirrors.add('{#Mirrors[i]}');
      #endsub

      # define i
      #for {i = 0; i < DimOf(Mirrors); i++} PopMirrors
    # endif

    // Gets the user's desktop resolution for later use
    DesktopRes := Resolution();

    // Initialize EditedConfigFiles
    EditedConfigFiles := TStringList.Create;
    EditedConfigFiles.Sorted := true;

    // Initialize UI. This populates all our ui elements with text, size and other properties
    InitializeUi();
 end;

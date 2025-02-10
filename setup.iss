; Inno Install Script for Freelancer: HD Edition
; GitHub: https://github.com/FLHDE/freelancer-hd-edition-installer
; Main GitHub: https://github.com/FLHDE/freelancer-hd-edition

#define MyAppVersion "0.7"
#define MyModName "Freelancer: HD Edition"
; Name without the colon to prevent file/explorer-related issues
#define MyAppFileName "Freelancer HD Edition"
#define MyServerFileName "FLServer HD Edition"
#define MyAppName MyModName + " v" + MyAppVersion
#define MyAppPublisher MyModName + " Development Team"
#define MyAppURL "https://github.com/FLHDE/freelancer-hd-edition"
#define MyAppExeName "Freelancer.exe"
#define MyAppServerExeName "FLServer.exe"
#define MyFolderName "freelancer-hd-edition-" + MyAppVersion
#define MyZipName "freelancerhde.7z"
#define MyCustomSaveFolderName "FreelancerHDE"
#define VcRedistName "VC_redist.x86.exe"
; The actual included VC Redist is version 14.38.33135.00, but FLHook is the only software part of HDE that depends on it and is built with MSVC v142.
#define VcRedistVersionStr "14.29.0000.00" ; Make sure to not include the "v" at the start
; This variable controls whether the zip is shipped with the exe or downloaded from a mirror
#define AllInOneInstall true
; These mirrors must provide a zip containing a folder named {#MyFolderName} where all the mod files live
#dim Mirrors[2] {"https://archive.org/download/freelancer-hd-edition-" + MyAppVersion + "/freelancer-hd-edition-" + MyAppVersion + ".7z", "https://github.com/FLHDE/freelancer-hd-edition/archive/refs/tags/" + MyAppVersion + ".zip"}
; TODO: Update sizes for each release
#if AllInOneInstall
  #define SizeZip 0 ; The zip size is already included in the pre-calculated required diskspace
#else
  #define SizeZip 2688696320 ; The zip provided by the GitHub mirror is larger than the archive.org one
#endif
#define SizeExtracted 4646719488
#define SizeVanilla 985624576
#define SizeBuffer 200000
#define SizeMsvcRedist 500000
#define SizeAll SizeZip + SizeExtracted + SizeVanilla + SizeBuffer + SizeMsvcRedist

[Setup]
AllowNoIcons=yes
AppId={{F40FDCDA-3A45-4CC3-9FDA-167EE480A1E0}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppCopyright={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
Compression=lzma2
DefaultDirName={sd}\Games\{#MyAppFileName}
DefaultGroupName={#MyAppFileName}
DisableWelcomePage=False
DisableDirPage=False
ExtraDiskSpaceRequired = {#SizeAll}
InfoBeforeFile={#SourcePath}\Assets\Text\installinfo.txt
OutputBaseFilename=FreelancerHDESetup
SetupIconFile={#SourcePath}\Assets\Images\icon.ico
SolidCompression=yes
UninstallDisplayIcon={app}\EXE\{#MyAppExeName}
UninstallDisplayName={#MyAppName}
WizardImageFile={#SourcePath}\Assets\Images\backgroundpattern.bmp
WizardSmallImageFile={#SourcePath}\Assets\Images\icon*.bmp
WizardSizePercent=105
VersionInfoVersion=1.0.0.0

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}";

[Icons]
Name: "{group}\{#MyAppFileName}"; Filename: "{app}\EXE\{#MyAppExeName}"
Name: "{group}\{#MyServerFileName}"; Filename: "{app}\EXE\{#MyAppServerExeName}"
Name: "{commondesktop}\{#MyAppFileName}"; Filename: "{app}\EXE\{#MyAppExeName}"; Tasks: desktopicon

[Files]
Source: "Assets\Text\PerfOptions.ini"; DestDir: "{tmp}"; Flags: ignoreversion deleteafterinstall
Source: "Assets\Fonts\AGENCYB.TTF"; DestDir: "{autofonts}"; FontInstall: "Agency FB Bold"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "Assets\Fonts\AGENCYR.TTF"; DestDir: "{autofonts}"; FontInstall: "Agency FB"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "Assets\Fonts\AGENCYR_CR.TTF"; DestDir: "{autofonts}"; FontInstall: "Agency FB Cyrillic"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "Assets\Fonts\ARIALUNI.TTF"; DestDir: "{autofonts}"; FontInstall: "Arial Unicode MS"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "Assets\External\7za.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall;
Source: "Assets\External\dircpy.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall;
Source: "Assets\External\utf-8-bom-remover.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall;
Source: "Assets\External\HexToBinary.dll"; Flags: dontcopy;
Source: "Assets\External\{#VcRedistName}"; DestDir: {tmp}; Flags: dontcopy
# if AllInOneInstall
Source: "Assets\Mod\{#MyZipName}"; DestDir: "{tmp}"; Flags: nocompression deleteafterinstall
#endif
; Needed to make sure icons exist for the exes right before the shortcuts are created
Source: "Assets\Images\icon.ico"; DestDir: "{app}\EXE"; DestName: "{#MyAppExeName}"; Flags: ignoreversion
Source: "Assets\Images\flserver.ico"; DestDir: "{app}\EXE"; DestName: "{#MyAppServerExeName}"; Flags: ignoreversion

[Run]
Filename: "{app}\EXE\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
Filename: "{tmp}\{#VcRedistName}"; StatusMsg: "Installing Microsoft Visual C++ Redistributable..."; Parameters: "/install /quiet /norestart"; Check: VcRedistNeedsInstall; Flags: waituntilterminated

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Messages]
WelcomeLabel2={#MyModName} is a mod that aims to improve every aspect of the game Freelancer (2003) while keeping the look and feel as close to vanilla as possible. Experience enhanced visuals with HD textures, high-quality soundtracks, and seamless gameplay with bug fixes and quality of life improvements. The mod is fully compatible with the original game, allowing for seamless integration into vanilla servers. Easy to install and customize, it revitalizes the beloved Freelancer experience for modern systems.%n%nThis installer requires a clean, freshly installed copy of Freelancer.
FinishedLabel=Setup has finished installing [name] on your computer. The application may be launched by selecting the installed shortcut.%n%nNOTE: [name] has been installed as a separate application. Therefore, your vanilla Freelancer installation has not been modified and can still be played at any time.
SelectDirBrowseLabel=To continue, click Next. If you would like to select a different folder, click Browse. Installing in the Program Files folder is not recommended because it may cause permission-related issues.

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
#include "types.iss"
#include "external.iss"
#include "globals.iss"
#include "utilities.iss"
#include "ui.iss"
#include "silent_options.iss"
#include "mod_options.iss"

procedure SelectBestLanguageOptions;
var
  DetectedFlLanguage: FlLanguage;
begin
  DetectedFlLanguage := GetFreelancerLanguage(DataDirPage.Values[0]);

  // Select the best default checked values based on the detected FL language, which in this case is more appropriate than the system language check
  // If the detected language is unknown, leave the checked properties as they are (the values determined based on the system language will be used instead)
  if DetectedFlLanguage = FL_English then
    EnglishImprovements.Checked := true
  else if DetectedFlLanguage <> FL_Unknown then
    EnglishImprovements.Checked := false;

  if DetectedFlLanguage = FL_Russian then
    RussianFonts.Checked := true
  else if DetectedFlLanguage <> FL_Unknown then
    RussianFonts.Checked := false;
end;

// Checks which step we are on when it changed. If it's the postinstall step then start the actual installing
procedure CurStepChanged(CurStep: TSetupStep);
var
  i: Integer;
begin
    if CurStep = ssPostInstall then
    begin
        // Select default options right before the express install starts
        if ExpressInstall.Checked then
        begin
          SetDefaultOptions;
          SelectBestLanguageOptions;
        end;

        # if !AllInOneInstall
          if OfflineInstall <> 'false' then
            FileCopy(OfflineInstall,ExpandConstant('{tmp}\{#MyZipName}'),false);
        # endif

        // Copy Vanilla game to directory
        UpdateProgress(15);
        WizardForm.StatusLabel.Caption := 'Copying vanilla Freelancer directory...';
        TryDirectoryCopyAsync(DataDirPage.Values[0],ExpandConstant('{app}'), False, True);

        // Unzip
        UpdateProgress(50);
        WizardForm.StatusLabel.Caption := ExpandConstant('Unpacking {#MyAppName}...');
        ShellExecuteAsync(ExpandConstant('{tmp}\7za.exe'), ExpandConstant(' x -y -aoa "{tmp}\{#MyZipName}"  -o"{app}"'));
        // -aoa Overwrite All existing files without prompt
        // -o Set output directory
        // -y Assume "Yes" on all Queries

        // Relocating the files is only necessary when the online installer is used because that provided zip contains a sub-folder.
        // The all-in-one install doesn't have this sub-folder, so the extracted files directly replace the vanilla files. 
        // The relocation isn't necessary in this case which saves some time.
        # if !AllInOneInstall
            UpdateProgress(70);

            // Copy mod files
            WizardForm.StatusLabel.Caption := ExpandConstant('Relocating {#MyAppName}...');
            TryDirectoryCopyAsync(ExpandConstant('{app}\{#MyFolderName}'),ExpandConstant('{app}'), True, False);

            DelTree(ExpandConstant('{app}\{#MyFolderName}'), True, True, True);
        # endif

        UpdateProgress(95);

        // Process options only if the user didn't specify that they should be applied
        if not BasicInstall.Checked then
        begin
          WizardForm.StatusLabel.Caption := 'Processing options...';
          Process_CallSign();
          Process_PitchVariations();
          Process_RegeneratableShields();
          Process_NoCountermeasureRightClick();
          Process_AdvancedAudioOptions();
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
          Process_SkippableCutscenes();
          Process_JumpTunnelDurations();
          Process_DrawDistances();
          Process_Planetscape();
          Process_Win10(); // Must be called before Process_DgVoodoo();
          Process_HUD(); // Must be called before Process_CustomIcons(); and Process_WeaponGroups();
          Process_DarkHUD();
          Process_CustomIcons(); // Must be called after Process_HUD();
          Process_CustomNavMap();
          Process_WeaponGroups(); // Must be called after Process_HUD();
          Process_DxWrapper();
          Process_DxWrapperReShade();
          Process_DgVoodooReShade();
          Process_DgVoodoo(); // Must be called after Process_Win10();
          Process_VanillaGraphics();
          Process_DisplayMode();
        end;

        if not IsWine then
        begin
          // Delete potential UTF-8 BOM headers in all edited config files. May not work properly on Wine.
          for i := 0 to EditedConfigFiles.Count - 1 do
            RemoveBOM(EditedConfigFiles[i]);
        end else
        begin
          // Prevents the mouse from warping on some Wine setups. See https://gitlab.winehq.org/wine/wine/-/wikis/Useful-Registry-Keys
          RegWriteStringValue(HKEY_CURRENT_USER, 'Software\Wine\DirectInput', 'MouseWarpOverride', 'disable');

          // Write d3d8 DLL override for Wine/Linux. For more information, see https://wiki.winehq.org/Wine_User%27s_Guide#DLL_Overrides
          RegWriteStringValue(HKEY_CURRENT_USER, 'Software\Wine\DllOverrides', 'd3d8', 'native,builtin');
        end;

        //UpdateProgress(95);
        //WizardForm.StatusLabel.Caption := 'Cleaning up...';

        // Delete Restart.fl to stop crashes
        DeleteFile(ExpandConstant('{userdocs}\My Games\Freelancer\Accts\SinglePlayer\Restart.fl'));
        DeleteFile(ExpandConstant('{userdocs}\My Games\{#MyCustomSaveFolderName}\Accts\SinglePlayer\Restart.fl'));
        DeleteFile(ExpandConstant('{app}\SAVE\Accts\SinglePlayer\Restart.fl'));

        // Remove 2003 junk files
        RemoveJunkFiles('dll');
        RemoveJunkFiles('msi');

        // Remove additional junk files
        DeleteFile(ExpandConstant('{app}\UNINSTAL.EXE'));
        DeleteFile(ExpandConstant('{app}\.gitattributes'));
        DeleteFile(ExpandConstant('{app}\EBUSetup.sem'));
        DelTree(ExpandConstant('{app}\.github'), True, True, True);

        // Install Complete!
        UpdateProgress(100);
    end;
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  // If the user doesn't want to select the options manually, skip all the option pages
  Result := (not CustomInstall.Checked) and (CallSign.ID <= PageID) and (PageID <= PageMiscOptions.ID);
end;

// Various logic to be applied when the user clicks on the Next button.
function NextButtonClick(PageId: Integer): Boolean;
var
  i : Integer;
  RefreshRateError: String;
begin
    Result := True;

    if (PageId = DgVoodooPage.ID) and (GpuManufacturer = AMD) then
    begin
      RefreshRateError := 'Refresh rate must be a valid number between 30 and 3840. If you don''t know how to find your monitor''s refresh rate, look it up on the internet.'
        + #13#10#13#10 + 'Keep in mind that the DxWrapper graphics API from the previous page does not require you to set a refresh rate manually.'

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
    if (PageId = PageMiscOptions.ID) and (DoNotPauseOnAltTab.Checked) and (not WizardSilent) then
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

    // Validate vanilla Freelancer directory
    if PageId = DataDirPage.ID then begin
      // Check if Freelancer is installed in the folder they have specified
      if not FileExists(DataDirPage.Values[0] + '\EXE\Freelancer.exe') then begin
        MsgBox('Freelancer does not seem to be installed in that folder. Please select the correct folder. It should contain a sub-directory "EXE" which has a file named "Freelancer.exe".', mbError, MB_OK);
        Result := False;
        exit;
      end;

      // If the installer is being run from the same directory as the vanilla Freelancer directory, the installation will fail because the running installer cannot be copied.
      // This checks if the active installer has been ran from any directory inside the selected vanilla Freelancer folder.
      // No issues occur when Freelancer from the vanilla directory is running, so no need to check for that.
      if Pos(DataDirPage.Values[0], GetCurrentDir()) > 0 then begin
        MsgBox(ExpandConstant('The {#MyAppName} installer is located in the same directory as the vanilla Freelancer directory. This would cause the installation to fail because this file cannot be copied.' + #13#10 + #13#10
          + 'Please close the {#MyAppName} installer, move the installer .exe file to a directory outside your vanilla Freelancer installation and try again.'), mbError, MB_OK);
        Result := False;
        exit;
      end;

      // The install directory is valid, so determine the best language options
      SelectBestLanguageOptions;
    end;

    // Validate install location
    if (PageId = 6) then begin
      // Needs to be in a seperate if statement since it tries to expand {app} even if not on PageID 6. Pascal what are you doing?!
      if(Pos(AddBackslash(DataDirPage.Values[0]),ExpandConstant('{app}')) > 0) then begin
        MsgBox('{#MyModName} cannot be installed to the same location as your vanilla install. Please select a new location.', mbError, MB_OK);
        Result := False;
        exit;
      end;
      // Check if the install directory is empty
      if(not isEmptyDir(ExpandConstant('{app}'))) then begin
        MsgBox('{#MyModName} cannot be installed to a directory that is not empty. Please empty this directory or choose another one.', mbError, MB_OK);
        Result := False;
        exit;
      end;

      // Freelancer will outright refuse to start if it's launched from a path with non-ASCII characters.
      // Apparently this check can be bypassed when enabling the "Use Unicode UTF-8 for worldwide language support)" option in Windows.
      // Though FL seems to run fine when this option is enabled while it's running from a path with non-ASCII chars, so I guess it doesn't really matter.
      if StrContainsNonAsciiChars(ExpandConstant('{app}')) then begin
        MsgBox('{#MyModName} cannot be installed to a path that contains non-ASCII characters. Freelancer would not run when launched from such a location. Please choose a directory path containing only characters within the ASCII range.', mbError, MB_OK);
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
        DownloadPage.Add(mirrors[i], ExpandConstant('{#MyZipName}'), '');
        DownloadPage.SetText('Downloading {#MyModName}...', '');
        DownloadPage.Show;
        DownloadPage.ProgressBar.Style := npbstNormal;
        try
          DownloadPage.Download;
          Result := True;
          i := mirrors.Count - 1;
        except
          if(i = mirrors.Count - 1) then
            SuppressibleMsgBox('All downloads failed. Please use the all-in-one installer.', mbError, MB_OK, IDOK)
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
    WizardForm.WizardSmallBitmapImage.Stretch := false;

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

    InitConstants();

    // Get some information about the system for later use
    DesktopRes := GetResolution();
    RefreshRate := GetRefreshRate();
    IsWine := GetIsWine();
    HasLightingBug := GetHasLightingBug();
    GpuManufacturer := GetGpuManufacturer();
    SystemLanguage := GetSystemLanguage();

    // Get the debug options before initializing the UI
    SetDebugOptions();

    // Initialize UI. This populates all our ui elements with text, size and other properties
    InitializeUi();
    SetDefaultOptions();

    // If the user wants to do a silent install, parse all selected options from the given command line args
    if WizardSilent then
      SetSilentOptions();
 end;

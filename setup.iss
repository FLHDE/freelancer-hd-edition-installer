; Inno Install Script for Freelancer: HD Edition
; GitHub: https://github.com/ollieraikkonen/Freelancer-hd-edition-install-script
; Main GitHub: https://github.com/bc46/Freelancer-hd-edition

#define MyAppName "Freelancer: HD Edition v0.5"
#define MyAppVersion "0.5"
#define MyAppPublisher "Freelancer: HD Edition Development Team"
#define MyAppURL "https://github.com/BC46/freelancer-hd-edition"
#define MyAppExeName "Freelancer.exe"
#define MyFolderName "freelancer-hd-edition-" + MyAppVersion
#define MyZipName "freelancerhd"
; TODO: Remember to change the mirror locations for each release
#dim Mirrors[6] {"https://onedrive.live.com/download?cid=F03BDD831B77D1AD&resid=F03BDD831B77D1AD%2193138&authkey=AN1qT9jEN5eUIUo", "https://pechey.net/files/freelancer-hd-edition-0.5.zip", "http://luyten.viewdns.net:8080/freelancer-hd-edition-0.5.0.zip", "https://bolte.io/freelancer-hd-edition-0.5.zip", "https://github.com/BC46/freelancer-hd-edition/archive/refs/tags/0.5.zip", "https://archive.org/download/freelancer-hd-edition-0.5/freelancer-hd-edition-0.5.zip"}
#define i 
#define SizeZip 2438619136 
#define SizeExtracted 4195188736 
#define SizeVanilla 985624576
#define SizeAll SizeZip + SizeExtracted + SizeVanilla

[Setup]
AllowNoIcons=yes
AppId={{F40FDCDA-3A45-4CC3-9FDA-167EE480A1E0}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
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
VersionInfoVersion=1.0.0.0

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}";

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\EXE\{#MyAppExeName}"
Name: "{commondesktop}\Freelancer HD Edition"; Filename: "{app}\EXE\{#MyAppExeName}"; Tasks: desktopicon

[Files]
Source: "Assets\Text\installinfo.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "Assets\Fonts\AGENCYB.TTF"; DestDir: "{autofonts}"; FontInstall: "Agency FB Bold"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "Assets\Fonts\AGENCYR.TTF"; DestDir: "{autofonts}"; FontInstall: "Agency FB"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "Assets\Fonts\ARIALUNI.TTF"; DestDir: "{autofonts}"; FontInstall: "Arial Unicode MS"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "Assets\External\7za.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall;
Source: "Assets\External\utf-8-bom-remover.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall;

[Run]
Filename: "{app}\EXE\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Messages]
WelcomeLabel2=Freelancer: HD Edition is a mod that aims to improve every aspect of Freelancer while keeping the look and feel as close to vanilla as possible. It also serves as an all-in-one package for players so they do not have to worry about installing countless patches and mods to create the perfect HD and bug-free install.%n%nThis installer requires a clean, freshly installed Freelancer directory.
FinishedLabel=Setup has finished installing [name] on your computer. The application may be launched by selecting the installed shortcut.%n%nPlease note that Freelancer runs at a very low resolution by default. You may change this in the game's display settings. You may also need to restart the game after that in order for the widescreen patch to apply.

[Code]
// Declaration of global variables
var
  // Allows us to skip the downloading of the files and just copy it from the local PC to save time
  OfflineInstall: String;
  // String list of mirrors that we can potentially download the mod from. This is populated in InitializeWizard()
  mirrors : TStringList;
  // Size of Download in MB
  DownloadSize : String;

// Imports from other .iss files
#include "utilities.iss"
#include "ui.iss"
#include "mod_options.iss"

// Checks which step we are on when it changed. If its the postinstall step then start the actual installing
procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode: Integer;
begin
    if CurStep = ssPostInstall then
    begin
        // Debug
        if(OfflineInstall <> 'false') then FileCopy(OfflineInstall,ExpandConstant('{tmp}\freelancerhd.zip'),false);

        // Copy Vanilla game to directory
        UpdateProgress(0);
        WizardForm.StatusLabel.Caption := 'Copying Vanilla Freelancer directory';
        DirectoryCopy(DataDirPage.Values[0],ExpandConstant('{app}'),False);
        UpdateProgress(50);

        // Unzip
        WizardForm.StatusLabel.Caption := 'Unzipping Freelancer: HD Edition';
        Exec(ExpandConstant('{tmp}\7za.exe'), ExpandConstant(' x -y -aoa "{tmp}\{#MyZipName}.zip"  -o"{app}"'), '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
        // -aoa Overwrite All existing files without prompt
        // -o Set output directory
        // -y Assume "Yes" on all Queries
        UpdateProgress(90);

        // Copy mod files
        WizardForm.StatusLabel.Caption := 'Moving Freelancer: HD Edition';
        DirectoryCopy(ExpandConstant('{app}\{#MyFolderName}'),ExpandConstant('{app}'),True);
        DelTree(ExpandConstant('{app}\{#MyFolderName}'), True, True, True);
        UpdateProgress(95);

        // Process options
        WizardForm.StatusLabel.Caption := 'Processing your options';
        Process_CallSign();
        Process_HdFreelancerIntro();
        Process_TextStringRevision();
        Process_SinglePlayerMode();
        Process_NewSaveFolder();
        Process_StartUpLogo();
        Process_FreelancerLogo();
        Process_SmallText();
        Process_Console();
        Process_Effects();
        Process_SkipIntros();
        Process_JumpTunnelDurations();
        Process_DrawDistances();
        Process_Planetscape();
        Process_Win10();
        Process_HUD();
        Process_DarkHUD(); // Must be called after Process_HUD();
        Process_FlatIcons();
        Process_WeaponGroups();
        Process_DxWrapper();
        Process_DxWrapperReShade();
        Process_DgVoodooReShade();

        // Perform operations that (potentially) do not work on Wine
        if not IsWine then 
        begin
          Process_DgVoodoo();

          // Delete potential UTF-8 BOM headers in all edited ini files
          RemoveBOM(ExpandConstant('{app}\EXE\dacom.ini'));
          RemoveBOM(ExpandConstant('{app}\EXE\freelancer.ini'));
          RemoveBOM(ExpandConstant('{app}\EXE\flplusplus.ini'));
          RemoveBOM(ExpandConstant('{app}\DATA\FONTS\fonts.ini'));
          RemoveBOM(ExpandConstant('{app}\DATA\INTERFACE\HudShift.ini'));
          RemoveBOM(ExpandConstant('{app}\DATA\FX\jumpeffect.ini'));
          RemoveBOM(ExpandConstant('{app}\EXE\newplayer.fl'));
          RemoveBOM(ExpandConstant('{app}\EXE\dxwrapper.ini'));
          RemoveBOM(ExpandConstant('{app}\EXE\ReShadePreset.ini'));
        end;

        // Delete restart.fl to stop crashes
        DeleteFile(ExpandConstant('{userdocs}\My Games\Freelancer\Accts\SinglePlayer\Restart.fl'));
        DeleteFile(ExpandConstant('{userdocs}\My Games\FreelancerHD\Accts\SinglePlayer\Restart.fl'));

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

    RefreshRateError := 'Refresh rate must be a valid number between 30 and 1000. If you don''t know how to find your monitor''s refresh rate, look it up on the internet.' + #13#10#13#10 + 'Keep in mind that the DxWrapper option does not require you to set a refresh rate manually.'

    if (PageId = PageGraphicsApi.ID) and (DgVoodooGraphicsApi.Checked) and (IsWine) then
      MsgBox('It seems you are using Wine. The dgVoodoo options you see on the next page won''t be applied because Wine is currently missing the implementation of a Win32 API function that this options page uses.' + #13#10#13#10 + 
      'You can still apply the options manually if you wish by opening EXE/dgVoodooCpl.exe after the mod has finished installing.' + #13#10#13#10 + 
      'Alternatively, you could configure similar options with the DxWrapper Graphics API, which will apply correctly.', mbError, MB_OK);

    if PageId = DgVoodooPage.ID then
    begin
      if (StrToInt(DgVoodooRefreshRate.Text) < 30) or (StrToInt(DgVoodooRefreshRate.Text) > 1000) then
        begin
          MsgBox(RefreshRateError, mbError, MB_OK);
          Result := False;
          Exit;
        end;

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
    // Start downloading the mod
    if ((PageId = 10) and (OfflineInstall = 'false')) then begin
      for i:= 0 to mirrors.Count - 1 do
      begin
        DownloadPage.Clear;
        DownloadPage.Add(mirrors[i], 'freelancerhd.zip', '');
        DownloadPage.SetText('Downloading mod','');
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
end;

// Run when the wizard is opened.
procedure InitializeWizard;
begin
    // Offline install
    OfflineInstall := ExpandConstant('{param:sourcefile|false}')

    // Copy mirrors from our preprocessor to our string array. This allows us to define the array at the top of the file for easy editing
    mirrors := TStringList.Create;
 
    #sub PopMirrors
      mirrors.add('{#Mirrors[i]}');
    #endsub

    #for {i = 0; i < DimOf(Mirrors); i++} PopMirrors

    // Initialize UI. This populates all our ui elements with text, size and other properties
    InitializeUi();
 end;

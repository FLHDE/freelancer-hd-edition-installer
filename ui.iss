[Code]
var
  // Custom Pages
  DataDirPage: TInputDirWizardPage;
  CallSign: TInputOptionWizardPage;
  PageEnglishImprovements: TWizardPage;
  PageSinglePlayer: TWizardPage;
  StartupRes: TInputOptionWizardPage;
  LogoRes: TInputOptionWizardPage;
  SmallText: TInputOptionWizardPage;
  PageWidescreenHud: TWizardPage;
  PageDarkHUD: TWizardPage;
  PagePlanetScape: TWizardPage;
  PageGraphicsApi: TWizardPage;
  PageEffects: TWizardPage;
  PageDrawDistances: TInputOptionWizardPage;
  PageSkips: TWizardPage;
  PageMiscOptions: TWizardPage;

  # if !AllInOneInstall
  DownloadPage: TDownloadWizardPage;
  # endif

  // Optional pages
  DxWrapperPage: TWizardPage;
  DxWrapperPage2: TWizardPage;
  DgVoodooPage: TWizardPage;
  DgVoodooPage2: TWizardPage;

  // Localization
  lblEnglishImprovements: TLabel;
  EnglishImprovements: TCheckBox;
  descEnglishImprovements: TNewStaticText;

  // Russian fonts
  lblRussianFonts: TLabel;
  RussianFonts: TCheckBox;
  descRussianFonts: TNewStaticText;

  // Single Player mode
  StoryMode: TComboBox;
  descSinglePlayerMode: TNewStaticText;

  // Level requirements
  lblLevelRequirements: TLabel;
  LevelRequirements: TCheckBox;
  descLevelRequirements: TNewStaticText;

  // New save folder
  lblNewSaveFolder: TLabel;
  NewSaveFolder: TCheckBox;
  descNewSaveFolder: TNewStaticText;

  // Advanced Widescreen HUD
  lblWidescreenHud: TLabel;
  WidescreenHud: TCheckBox;
  descWidescreenHud: TNewStaticText;

  // Weapon Groups
  lblWeaponGroups: TLabel;
  WeaponGroups: TCheckBox;
  descWeaponGroups: TNewStaticText;

  // Dark HUD
  lblDarkHud: TLabel;
  DarkHud: TCheckBox;
  descDarkHud: TNewStaticText;

  // Flat Icons
  lblFlatIcons: TLabel;
  FlatIcons: TCheckBox;
  descFlatIcons: TNewStaticText;

  // Fix clipping with 16:9 resolution planetscapes
  lblPlanetScape: TLabel;
  PlanetScape: TCheckBox;
  descPlanetScape: TNewStaticText;

  // Graphics API
  lblDxWrapperGraphicsApi: TLabel;
  lblDgVoodooGraphicsApi: TLabel;
  lblVanillaGraphicsApi: TLabel;
  lblLightingFixGraphicsApi: TLabel;
  DxWrapperGraphicsApi: TRadioButton;
  DgVoodooGraphicsApi: TRadioButton;
  VanillaGraphicsApi: TRadioButton;
  LightingFixGraphicsApi: TRadioButton;
  descDxWrapperGraphicsApi: TNewStaticText;
  descDgVoodooGraphicsApi: TNewStaticText;
  descVanillaGraphicsApi: TNewStaticText;
  descLightingFixGraphicsApi: TNewStaticText;
  descGraphicsApi: TNewStaticText;

  // DxWrapper
  lblDxWrapperAf: TLabel;
  lblDxWrapperAa: TLabel;
  DxWrapperAf: TComboBox;
  DxWrapperAa: TComboBox;
  descDxWrapperAf: TNewStaticText;
  descDxWrapperAa: TNewStaticText;

  // DxWrapper #2
  lblDxWrapperReShade: TLabel;
  lblDxWrapperSaturation: TLabel;
  lblDxWrapperHdr: TLabel;
  lblDxWrapperBloom: TLabel;
  DxWrapperReShade: TCheckBox;
  DxWrapperSaturation: TCheckBox;
  DxWrapperHdr: TCheckBox;
  DxWrapperBloom: TCheckBox;
  descDxWrapperReShade: TNewStaticText;
  descDxWrapperSaturation: TNewStaticText;
  descDxWrapperHdr: TNewStaticText;
  descDxWrapperBloom: TNewStaticText;

  // dgVoodoo
  lblDgVoodooAf: TLabel;
  lblDgVoodooAa: TLabel;
  lblDgVoodooRefreshRate: TLabel;
  lblDgVoodooRefreshRateHz: TLabel;
  DgVoodooAf: TComboBox;
  DgVoodooAa: TComboBox;
  DgVoodooRefreshRate: TNewEdit;
  descDgVoodooAf: TNewStaticText;
  descDgVoodooAa: TNewStaticText;
  descDgVoodooRefreshRate: TNewStaticText;

  // dgVoodoo #2
  lblDgVoodooReShade: TLabel;
  lblDgVoodooSaturation: TLabel;
  lblDgVoodooHdr: TLabel;
  lblDgVoodooBloom: TLabel;
  DgVoodooReShade: TCheckBox;
  DgVoodooSaturation: TCheckBox;
  DgVoodooHdr: TCheckBox;
  DgVoodooBloom: TCheckBox;
  descDgVoodooReShade: TNewStaticText;
  descDgVoodooSaturation: TNewStaticText;
  descDgVoodooHdr: TNewStaticText;
  descDgVoodooBloom: TNewStaticText;

  // Add improved reflections
  lblVanillaReflections: TLabel;
  lblShinyReflections: TLabel;
  lblShiniestReflections: TLabel;
  VanillaReflections: TRadioButton;
  ShinyReflections: TRadioButton;
  ShiniestReflections: TRadioButton;
  descReflections: TNewStaticText;

  // Add new missile effects
  lblMissleEffects: TLabel;
  MissileEffects: TCheckBox;
  descMissileEffects: TNewStaticText;

  // Add player ship engine trails
  lblEngineTrails: TLabel;
  EngineTrails: TCheckBox;
  descEngineTrails: TNewStaticText;

  // Skip intros
  lblSkipIntros: TLabel;
  SkipIntros: TCheckBox;
  descSkipIntros: TNewStaticText;

  // Jump tunnel duration
  lblJumpTunnel10Sec: TLabel;
  lblJumpTunnel5Sec: TLabel;
  lblJumpTunnel2Sec: TLabel;
  lblJumpTunnelSkip: TLabel;
  JumpTunnel10Sec: TRadioButton;
  JumpTunnel5Sec: TRadioButton;
  JumpTunnel2Sec: TRadioButton;
  JumpTunnelSkip: TRadioButton;
  descJumpTunnelDuration: TNewStaticText;

  // Single Player Command Console
  lblSinglePlayer: TLabel;
  SinglePlayer: TCheckBox;
  descSinglePlayer: TNewStaticText;

  // Apply best options
  lblBestOptions: TLabel;
  BestOptions: TCheckBox;
  descBestOptions: TNewStaticText;

  // Display mode
  lblDisplayMode: TLabel;
  DisplayMode: TComboBox;
  descDisplayMode: TNewStaticText;

  // Do not pause on alt tab
  lblDoNotPauseOnAltTab: TLabel;
  DoNotPauseOnAltTab: TCheckBox;
  MusicInBackground: Boolean;

// Report on download progress
# if !AllInOneInstall
function OnDownloadProgress(const Url, FileName: String; const Progress, ProgressMax: Int64): Boolean;
begin
  DownloadPage.SetText('Downloading mod',(IntToStr(Progress/1048576)) + 'MB / ' + DownloadSize + 'MB');
  if Progress = ProgressMax then
    Log(Format('Successfully downloaded file to {tmp}: %s', [FileName]));
  Result := True;
end;
# endif

// Update progress of installer bar
procedure UpdateProgress(Position: Integer);
begin
  WizardForm.ProgressGauge.Position :=
    Position * WizardForm.ProgressGauge.Max div 100;
end;

// Handles key presses for an integer field
procedure DigitFieldKeyPress(Sender: TObject; var Key: Char);
begin
  if not ((Key = #8) or { Tab key }
          (Key = #3) or (Key = #22) or (Key = #24) or { Ctrl+C, Ctrl+V, Ctrl+X }
          IsDigit(Key)) then
  begin
    Key := #0;
  end;
end;        

// Ensures the DxWrapper or dgVoodoo pages are skipped if they haven't been checked in the Graphics API menu
function PageHandler_ShouldSkipPage(Page: TWizardPage): Boolean;
begin
  Result := False;
   
  if (Page.Id = DxWrapperPage.Id) or (Page.Id = DxWrapperPage2.Id) then
    Result := not DxWrapperGraphicsApi.Checked
  else if (Page.Id = DgVoodooPage.Id) or (Page.Id = DgVoodooPage2.Id) then
    Result := not DgVoodooGraphicsApi.Checked
end;

procedure DxWrapperReShadeCheckBoxClick(Sender: TObject);
begin
  DxWrapperSaturation.Enabled := DxWrapperReShade.Checked;
  DxWrapperHdr.Enabled := DxWrapperReShade.Checked;
  DxWrapperBloom.Enabled := DxWrapperReShade.Checked;
end;

procedure DgVoodooReShadeCheckBoxClick(Sender: TObject);
begin
  DgVoodooSaturation.Enabled := DgVoodooReShade.Checked;
  DgVoodooHdr.Enabled := DgVoodooReShade.Checked;
  DgVoodooBloom.Enabled := DgVoodooReShade.Checked;
end;

procedure InitializeUi();
var 
  dir : string;
  CheckBoxWidth: Integer;
begin
  # if !AllInOneInstall
  // Read download size
  DownloadSize := IntToStr(StrToInt64(ExpandConstant('{#SizeZip}'))/1048576);
  // Initialize DownloadPage
  DownloadPage := CreateDownloadPage(SetupMessage(msgWizardPreparing), SetupMessage(msgPreparingDesc), @OnDownloadProgress);
  # endif

  dir := 'C:\Program Files (x86)\Microsoft Games\Freelancer'

  // Initialize DataDirPage and add content
  DataDirPage := CreateInputDirPage(wpInfoBefore,
  'Select Freelancer installation', 'Where is Freelancer installed?',
  'Select the folder in which a fresh and completely unmodded copy of Freelancer is installed. This is usually ' + dir + '.' + #13#10 +
  'The folder you select here will be copied without modification.',
  False, '');
  DataDirPage.Add('');
  
  // If the Reg key exists, use its content to populate the folder location box. Use the default path if othwerise.
  RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Wow6432Node\Microsoft\Microsoft Games\Freelancer\1.0', 'AppPath', dir)
  DataDirPage.Values[0] := dir
  
  // Initialize CallSign page and add content
  CallSign := CreateInputOptionPage(DataDirPage.ID,
  'Single Player ID Code', 'Tired of being called Freelancer Alpha 1-1?',
  'You know when each time an NPC talks to you in-game, they call you Freelancer Alpha 1-1? This mod gives you the ability to change that ID code in Single Player! Just select any option you like and the NPCs will call you by that.',
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
  CallSign.Add('Bowex Delta 5-7');
  CallSign.Add('Order Omicron 0-0');
  CallSign.Add('LSF Gamma 6-9');
  CallSign.Add('Hacker Kappa 4-20');
  CallSign.Values[0] := True;

  // Initialize English Improvements page and add content
  PageEnglishImprovements := CreateCustomPage(CallSign.ID,
  'Localization', 'Apply English improvements and other fixes');

  lblEnglishImprovements := TLabel.Create(PageEnglishImprovements);
  lblEnglishImprovements.Parent := PageEnglishImprovements.Surface;
  lblEnglishImprovements.Caption := 'Apply English Freelancer improvements';
  lblEnglishImprovements.Left := ScaleX(20);
  
  descEnglishImprovements := TNewStaticText.Create(PageEnglishImprovements);
  descEnglishImprovements.Parent := PageEnglishImprovements.Surface;
  descEnglishImprovements.WordWrap := True;
  descEnglishImprovements.Top := ScaleY(20);
  descEnglishImprovements.Width := PageEnglishImprovements.SurfaceWidth;
  descEnglishImprovements.Caption := 
  'This option fixes many typos, grammar mistakes, inconsistencies, and more, in the English Freelancer text and audio resources. It also adds a higher quality Freelancer intro (1440x960 instead of 720x480), which is only available in English.' + #13#10#13#10 +  
  'NOTE: This option will set all of Freelancer''s text, a few voice lines, and the intro to English. Disable this option if you''d like to play Freelancer in a different language like German, French, or Russian.'  + #13#10#13#10 +
  'NOTE 2: If this option is disabled, several ship control option names from the settings menu will be blank.';

  EnglishImprovements := TCheckBox.Create(PageEnglishImprovements);
  EnglishImprovements.Parent := PageEnglishImprovements.Surface;
  EnglishImprovements.Checked := True;

  lblRussianFonts := TLabel.Create(PageEnglishImprovements);
  lblRussianFonts.Parent := PageEnglishImprovements.Surface;
  lblRussianFonts.Caption := 'Use Russian fonts';
  lblRussianFonts.Left := ScaleX(20);
  lblRussianFonts.Top := descEnglishImprovements.Top + ScaleY(160);
  
  descRussianFonts := TNewStaticText.Create(PageEnglishImprovements);
  descRussianFonts.Parent := PageEnglishImprovements.Surface;
  descRussianFonts.WordWrap := True;
  descRussianFonts.Top := descEnglishImprovements.Top + ScaleY(180);
  descRussianFonts.Width := PageEnglishImprovements.SurfaceWidth;
  descRussianFonts.Caption := 'This option will use a Cyrillic version of the Agency FB font for Freelancer. Users with a Russian Freelancer installation may want to enable this.';

  RussianFonts := TCheckBox.Create(PageEnglishImprovements);
  RussianFonts.Parent := PageEnglishImprovements.Surface;
  RussianFonts.Top := lblRussianFonts.Top;


  // Initialize Single Player page and add content
  PageSinglePlayer := CreateCustomPage(PageEnglishImprovements.ID, 
  'Single Player options', 'Choose how you''d like to play Single Player');

  StoryMode := TComboBox.Create(PageSinglePlayer);
  StoryMode.Parent := PageSinglePlayer.Surface;
  StoryMode.Style := csDropDownList;
  StoryMode.Width := 180;
  StoryMode.Items.Add('Story Mode (default)');
  StoryMode.Items.Add('Open Single Player (Normal)');
  StoryMode.Items.Add('Open Single Player (Pirate)');
  StoryMode.ItemIndex := 0;
  
  descSinglePlayerMode := TNewStaticText.Create(PageSinglePlayer);
  descSinglePlayerMode.Parent := PageSinglePlayer.Surface;
  descSinglePlayerMode.WordWrap := True;
  descSinglePlayerMode.Width := PageSinglePlayer.SurfaceWidth;
  descSinglePlayerMode.Caption := 'This option allows you to choose the Single Player mode. Story Mode simply lets you play through the entire storyline, as usual. Both Open Single Player options skip the entire storyline and allow you to freely roam the universe right away. With OSP (Normal), you start in Manhattan with a basic loadout and a default reputation. The OSP (Pirate) option on the other hand, spawns you at Rochester with a similar loadout and an inverted reputation. NOTE: Both OSP options may cause existing storyline saves to not work correctly.';
  descSinglePlayerMode.Top := ScaleY(25);
  
  // Level requirements
  lblLevelRequirements := TLabel.Create(PageSinglePlayer);
  lblLevelRequirements.Parent := PageSinglePlayer.Surface;
  lblLevelRequirements.Caption := 'Remove level requirements';
  lblLevelRequirements.Left := ScaleX(20);
  lblLevelRequirements.Top := descSinglePlayerMode.Top + ScaleY(108);

  LevelRequirements := TCheckBox.Create(PageWidescreenHud);
  LevelRequirements.Parent := PageSinglePlayer.Surface;
  LevelRequirements.Top := lblLevelRequirements.Top;
  
  descLevelRequirements := TNewStaticText.Create(PageSinglePlayer);
  descLevelRequirements.Parent := PageSinglePlayer.Surface;
  descLevelRequirements.WordWrap := True;
  descLevelRequirements.Top := LevelRequirements.Top + ScaleY(20);
  descLevelRequirements.Width := PageSinglePlayer.SurfaceWidth;
  descLevelRequirements.Caption := 'This option removes the level requirements for ships and equipment in Single Player.';

  // Add new missile effects
  lblNewSaveFolder := TLabel.Create(PageSinglePlayer);
  lblNewSaveFolder.Parent := PageSinglePlayer.Surface;
  lblNewSaveFolder.Caption := 'Store save game files in a different folder';
  lblNewSaveFolder.Top := descLevelRequirements.Top + ScaleY(30);
  lblNewSaveFolder.Left := ScaleX(20);
  
  descNewSaveFolder := TNewStaticText.Create(PageSinglePlayer);
  descNewSaveFolder.Parent := PageSinglePlayer.Surface;
  descNewSaveFolder.WordWrap := True;
  descNewSaveFolder.Top := lblNewSaveFolder.Top + ScaleY(20);
  descNewSaveFolder.Width := PageSinglePlayer.SurfaceWidth;
  descNewSaveFolder.Caption := 'Normally Freelancer save games are stored in "Documents/My Games/Freelancer". This option ensures save games will be stored in "Documents/My Games/FreelancerHD" instead, which may help avoid conflicts when having multiple mods installed simultaneously.';
  
  NewSaveFolder := TCheckBox.Create(PageSinglePlayer);
  NewSaveFolder.Parent := PageSinglePlayer.Surface;
  NewSaveFolder.Top := lblNewSaveFolder.Top;


  // Initialize StartupRes page and add content
  StartupRes := CreateInputOptionPage(PageSinglePlayer.ID,
  'Startup Screen Resolution', 'Choose your native resolution',
  'By default, the "Freelancer" splash screen you see when you start the game has a resolution of 1280x960. This makes it appear stretched and a bit blurry on HD 16:9 resolutions. ' +
  'We recommend setting this option to your monitor''s native resolution. ' +
  'Please note that a higher resolution option may negatively impact the game''s start-up speed.',
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

  // Determine best default startup resolution based on user's screen size
  if (DesktopRes.Height >= 2160) then 
    StartupRes.Values[8] := True
  else if (DesktopRes.Height >= 1440) then
    StartupRes.Values[6] := True
  else
    StartupRes.Values[4] := True;
  
  // Initialize LogoRes page and add content
  LogoRes := CreateInputOptionPage(StartupRes.ID,
  'Freelancer Logo Resolution', 'In the game''s main menu',
  'The main menu Freelancer logo has a resolution of 800x600 by default, which makes it look stretched and pixelated/blurry on HD widescreen monitors. ' +
  'Setting this to a higher resolution with the correct aspect ratio makes the logo look nice and sharp and not stretched-out. Hence we recommend setting this option to your monitor''s native resolution. ' +
  'Please note that a higher resolution option may negatively impact the game''s start-up speed.',
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

  // Determine best default logo resolution based on user's screen size
  if (DesktopRes.Height >= 2160) then 
    LogoRes.Values[9] := True
  else if (DesktopRes.Height >= 1440) then
    LogoRes.Values[7] := True
  else
    LogoRes.Values[5] := True;
  
  // Fix Small Text on 1440p/4K resolutions
  SmallText := CreateInputOptionPage(LogoRes.ID,
  'Fix small text on 1440p/4K resolutions', 'Check to install',
  'Many high-resolution Freelancer players have reported missing HUD text and misaligned buttons in menus. In 4K, the nav map text is too small and there are many missing text elements in the HUD. For 1440p screens, the only apparent issue is the small nav map text.' + #13#10 + #13#10 +
  'Select the option corresponding to the resolution you''re going to play Freelancer in. If you play in 1920x1080 or lower, the "No" option is fine as the elements are configured correctly already.',
  True, False);
  SmallText.Add('No');
  SmallText.Add('Yes, apply fix for 2560x1440 screens');
  SmallText.Add('Yes, apply fix for 3840x2160 screens');

  // Determine best small text fix based on user's screen size
  if (DesktopRes.Height >= 2160) then 
    SmallText.Values[2] := True
  else if (DesktopRes.Height >= 1440) then
    SmallText.Values[1] := True
  else
    SmallText.Values[0] := True;
  
  // Initialize HUD page and add content
  PageWidescreenHud := CreateCustomPage(
    SmallText.ID,
    'Advanced Widescreen HUD',
    'Check to install'
  );
  
  lblWidescreenHud := TLabel.Create(PageWidescreenHud);
  lblWidescreenHud.Parent := PageWidescreenHud.Surface;
  lblWidescreenHud.Caption := 'Enable Advanced Widescreen HUD';
  lblWidescreenHud.Left := ScaleX(20);
  
  descWidescreenHud := TNewStaticText.Create(PageWidescreenHud);
  descWidescreenHud.Parent := PageWidescreenHud.Surface;
  descWidescreenHud.WordWrap := True;
  descWidescreenHud.Top := ScaleY(20);
  descWidescreenHud.Width := PageWidescreenHud.SurfaceWidth;
  descWidescreenHud.Caption := 'This option adds two new useful widgets to your HUD. Next to your contact list, you will have a wireframe representation of your selected target. Next to your weapons list, you will have a wireframe of your own ship. Disable this option if you play in 4:3.';
  
  WidescreenHud := TCheckBox.Create(PageWidescreenHud);
  WidescreenHud.Parent := PageWidescreenHud.Surface;

  // Only check the wide screen HUD option if the user's aspect ratio is not 4:3
  if (not IsDesktopRes4By3()) then
    WidescreenHud.Checked := True;

  lblWeaponGroups := TLabel.Create(PageWidescreenHud);
  lblWeaponGroups.Parent := PageWidescreenHud.Surface;
  lblWeaponGroups.Caption := 'Add Weapon Group buttons';
  lblWeaponGroups.Left := ScaleX(20);
  lblWeaponGroups.Top := descWidescreenHud.Top + ScaleY(65);
  
  descWeaponGroups := TNewStaticText.Create(PageWidescreenHud);
  descWeaponGroups.Parent := PageWidescreenHud.Surface;
  descWeaponGroups.WordWrap := True;
  descWeaponGroups.Top := lblWeaponGroups.Top + ScaleY(20);
  descWeaponGroups.Width := PageWidescreenHud.SurfaceWidth;
  descWeaponGroups.Caption := 'This option adds buttons for selecting 3 different weapon groups in your ship info panel. NOTE: These buttons may not be positioned correctly on aspect ratios other than 16:9.';
  
  WeaponGroups := TCheckBox.Create(PageWidescreenHud);
  WeaponGroups.Parent := PageWidescreenHud.Surface;
  WeaponGroups.Top := lblWeaponGroups.Top;

  // Only check the weapon groups option if the user's aspect ratio is 16:9
  if (IsDesktopRes16By9()) then
    WeaponGroups.Checked := True;

  // Initialize Dark HUD page and add content
  PageDarkHud := CreateCustomPage(
    PageWidescreenHud.ID,
    'Custom HUD and icons',
    'Check to install'
  );
  
  lblDarkHud := TLabel.Create(PageDarkHud);
  lblDarkHud.Parent := PageDarkHud.Surface;
  lblDarkHud.Caption := 'Enable Dark HUD';
  lblDarkHud.Left := ScaleX(20);
  
  descDarkHud := TNewStaticText.Create(PageDarkHud);
  descDarkHud.Parent := PageDarkHud.Surface;
  descDarkHud.WordWrap := True;
  descDarkHud.Top := ScaleY(20);
  descDarkHud.Width := PageDarkHud.SurfaceWidth;
  descDarkHud.Caption := 'This option replaces the default Freelancer HUD with a more darker-themed HUD. If this option is disabled, you''ll get the HD default HUD instead.';
  
  DarkHud := TCheckBox.Create(PageDarkHud);
  DarkHud.Parent := PageDarkHud.Surface;

  lblFlatIcons := TLabel.Create(PageDarkHud);
  lblFlatIcons.Parent := PageDarkHud.Surface;
  lblFlatIcons.Caption := 'Enable Custom Flat Icons';
  lblFlatIcons.Left := ScaleX(20);
  lblFlatIcons.Top := descDarkHud.Top + ScaleY(50);
  
  descFlatIcons := TNewStaticText.Create(PageDarkHud);
  descFlatIcons.Parent := PageDarkHud.Surface;
  descFlatIcons.WordWrap := True;
  descFlatIcons.Top := lblFlatIcons.Top + ScaleY(20);
  descFlatIcons.Width := PageWidescreenHud.SurfaceWidth;
  descFlatIcons.Caption := 'This option replaces Freelancer''s default icon set with new simpler flat-looking icons. If this option is disabled, you''ll get the HD vanilla icons instead.';
  
  FlatIcons := TCheckBox.Create(PageDarkHud);
  FlatIcons.Parent := PageDarkHud.Surface;
  FlatIcons.Top := lblFlatIcons.Top;

  
  // Fix clipping with 16:9 resolution planetscapes
  PagePlanetScape := CreateCustomPage(
    PageDarkHud.ID,
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
  'Disable this option if you play in 4:3. Also please note that this option may yield strange results when using it with an ultrawide resolution.'
  
  PlanetScape := TCheckBox.Create(PagePlanetScape);
  PlanetScape.Parent := PagePlanetScape.Surface;

  // Only check the planetscapes fix option if the user's aspect ratio is 16:9
  if (IsDesktopRes16By9()) then
    PlanetScape.Checked := True;
  
  // Choose Graphics API
  PageGraphicsApi := CreateCustomPage(
    PagePlanetScape.ID,
    'Graphics API',
    'Choose the one that suits your needs'
  );

  descGraphicsApi := TNewStaticText.Create(PageGraphicsApi);
  descGraphicsApi.Parent := PageGraphicsApi.Surface;
  descGraphicsApi.WordWrap := True;
  descGraphicsApi.Width := PageGraphicsApi.SurfaceWidth;
  descGraphicsApi.Caption := 'This page allows you to choose the graphics API. If you have no idea what this means, just go with the first option, since it offer additional graphics enhancements and fixes. If it''s causing issues for you, go with the 2nd, 3rd, or 4th option.';

  lblDgVoodooGraphicsApi := TLabel.Create(PageGraphicsApi);
  lblDgVoodooGraphicsApi.Parent := PageGraphicsApi.Surface;
  lblDgVoodooGraphicsApi.Caption := 'dgVoodoo (DirectX 11, recommended)';
  lblDgVoodooGraphicsApi.Left := ScaleX(20);
  lblDgVoodooGraphicsApi.Top := ScaleY(50);

  DgVoodooGraphicsApi := TRadioButton.Create(PageGraphicsApi);
  DgVoodooGraphicsApi.Parent := PageGraphicsApi.Surface;
  DgVoodooGraphicsApi.Checked := True;
  DgVoodooGraphicsApi.Top := lblDgVoodooGraphicsApi.Top;

  descDgVoodooGraphicsApi := TNewStaticText.Create(PageGraphicsApi);
  descDgVoodooGraphicsApi.Parent := PageGraphicsApi.Surface;
  descDgVoodooGraphicsApi.WordWrap := True;
  descDgVoodooGraphicsApi.Top := DgVoodooGraphicsApi.Top + ScaleY(15);
  descDgVoodooGraphicsApi.Width := PageGraphicsApi.SurfaceWidth;
  descDgVoodooGraphicsApi.Caption := 'Fixes the major lighting bug on Windows 10 and 11. Supports native Anti-Aliasing, Anisotropic Filtering, and ReShade. Requires manual refresh rate input.';

  lblDxWrapperGraphicsApi := TLabel.Create(PageGraphicsApi);
  lblDxWrapperGraphicsApi.Parent := PageGraphicsApi.Surface;
  lblDxWrapperGraphicsApi.Caption := 'DxWrapper + d3d8to9 (DirectX 9)';
  lblDxWrapperGraphicsApi.Left := ScaleX(20);
  lblDxWrapperGraphicsApi.Top := descDgVoodooGraphicsApi.Top + ScaleY(40);

  DxWrapperGraphicsApi := TRadioButton.Create(PageGraphicsApi);
  DxWrapperGraphicsApi.Parent := PageGraphicsApi.Surface;
  DxWrapperGraphicsApi.Top := lblDxWrapperGraphicsApi.Top;

  descDxWrapperGraphicsApi := TNewStaticText.Create(PageGraphicsApi);
  descDxWrapperGraphicsApi.Parent := PageGraphicsApi.Surface;
  descDxWrapperGraphicsApi.WordWrap := True;
  descDxWrapperGraphicsApi.Top := DxWrapperGraphicsApi.Top + ScaleY(15);
  descDxWrapperGraphicsApi.Width := PageGraphicsApi.SurfaceWidth;
  descDxWrapperGraphicsApi.Caption := 'Supports native Anti-Aliasing, Anisotropic Filtering, and ReShade. Not 100% stable.';

  lblVanillaGraphicsApi := TLabel.Create(PageGraphicsApi);
  lblVanillaGraphicsApi.Parent := PageGraphicsApi.Surface;
  lblVanillaGraphicsApi.Caption := 'Vanilla Freelancer (DirectX 8)';
  lblVanillaGraphicsApi.Left := ScaleX(20);
  lblVanillaGraphicsApi.Top := descDxWrapperGraphicsApi.Top + ScaleY(30);

  VanillaGraphicsApi := TRadioButton.Create(PageGraphicsApi);
  VanillaGraphicsApi.Parent := PageGraphicsApi.Surface;
  VanillaGraphicsApi.Top := lblVanillaGraphicsApi.Top;

  descVanillaGraphicsApi := TNewStaticText.Create(PageGraphicsApi);
  descVanillaGraphicsApi.Parent := PageGraphicsApi.Surface;
  descVanillaGraphicsApi.WordWrap := True;
  descVanillaGraphicsApi.Top := VanillaGraphicsApi.Top + ScaleY(15);
  descVanillaGraphicsApi.Width := PageGraphicsApi.SurfaceWidth;
  descVanillaGraphicsApi.Caption := 'Uses your PC''s default DirectX 8 API for Freelancer. You may experience compatibility issues when using it.';

  lblLightingFixGraphicsApi := TLabel.Create(PageGraphicsApi);
  lblLightingFixGraphicsApi.Parent := PageGraphicsApi.Surface;
  lblLightingFixGraphicsApi.Caption := 'Vanilla Freelancer + Lighting Bug Fix (DirectX 8)';
  lblLightingFixGraphicsApi.Left := ScaleX(20);
  lblLightingFixGraphicsApi.Top := descVanillaGraphicsApi.Top + ScaleY(40);

  LightingFixGraphicsApi := TRadioButton.Create(PageGraphicsApi);
  LightingFixGraphicsApi.Parent := PageGraphicsApi.Surface;
  LightingFixGraphicsApi.Top := lblLightingFixGraphicsApi.Top;

  descLightingFixGraphicsApi := TNewStaticText.Create(PageGraphicsApi);
  descLightingFixGraphicsApi.Parent := PageGraphicsApi.Surface;
  descLightingFixGraphicsApi.WordWrap := True;
  descLightingFixGraphicsApi.Top := lblLightingFixGraphicsApi.Top + ScaleY(15);
  descLightingFixGraphicsApi.Width := PageGraphicsApi.SurfaceWidth;
  descLightingFixGraphicsApi.Caption := 'About the same as the Vanilla Freelancer option but fixes the major lighting bug on Windows 10 and 11. NOTE: This option only works on Windows 10 and 11!';
  
  // DxWrapper options
  DxWrapperPage := CreateCustomPage(
    PageGraphicsApi.ID,
    'DxWrapper options',
    'Choose additional graphics enhancements'
  );

  lblDxWrapperAa := TLabel.Create(DxWrapperPage);
  lblDxWrapperAa.Parent := DxWrapperPage.Surface;
  lblDxWrapperAa.Caption := 'Anti-Aliasing';
  
  DxWrapperAa := TComboBox.Create(DxWrapperPage);
  DxWrapperAa.Parent := DxWrapperPage.Surface;
  DxWrapperAa.Style := csDropDownList;
  DxWrapperAa.Items.Add('Off');
  DxWrapperAa.Items.Add('On (recommended)');
  DxWrapperAa.ItemIndex := 1;
  DxWrapperAa.Top := ScaleY(20);

  descDxWrapperAa := TNewStaticText.Create(DxWrapperPage);
  descDxWrapperAa.Parent := DxWrapperPage.Surface;
  descDxWrapperAa.WordWrap := True;
  descDxWrapperAa.Width := DxWrapperPage.SurfaceWidth;
  descDxWrapperAa.Caption := 'Anti-Aliasing removes jagged edges in-game, effectively making them appear smoother at a performance cost.';
  descDxWrapperAa.Top := DxWrapperAa.Top + ScaleY(25);

  lblDxWrapperAf := TLabel.Create(DxWrapperPage);
  lblDxWrapperAf.Parent := DxWrapperPage.Surface;
  lblDxWrapperAf.Caption := 'Anisotropic Filtering';
  lblDxWrapperAf.Top := descDxWrapperAa.Top + ScaleY(50);
  
  DxWrapperAf := TComboBox.Create(DxWrapperPage);
  DxWrapperAf.Parent := DxWrapperPage.Surface;
  DxWrapperAf.Style := csDropDownList;
  DxWrapperAf.Items.Add('Off');
  DxWrapperAf.Items.Add('2x');
  DxWrapperAf.Items.Add('4x');
  DxWrapperAf.Items.Add('8x');
  DxWrapperAf.Items.Add('16x');
  DxWrapperAf.Items.Add('Auto (recommended)');
  DxWrapperAf.ItemIndex := 5;
  DxWrapperAf.Top := lblDxWrapperAf.Top + ScaleY(20);

  descDxWrapperAf := TNewStaticText.Create(DxWrapperPage);
  descDxWrapperAf.Parent := DxWrapperPage.Surface;
  descDxWrapperAf.WordWrap := True;
  descDxWrapperAf.Width := DxWrapperPage.SurfaceWidth;
  descDxWrapperAf.Caption := 'Anisotropic Filtering improves the quality of textures when viewing them from the side, with minimal performance overhead. "Auto" will automatically use the highest option your graphics card supports.' + #13#10 + #13#10 +
  'NOTE: If you have an NVIDIA GPU, set Anisotropic Filtering to "Off". Otherwise some textures may not load correctly. Alternatively, you may use the dgVoodoo Graphics API from the previous page. It offers the same option which will work correctly.'
  descDxWrapperAf.Top := DxWrapperAf.Top + ScaleY(25);

  // dgVoodoo options
  DgVoodooPage := CreateCustomPage(
    DxWrapperPage.ID,
    'dgVoodoo options',
    'Choose additional graphics enhancements'
  );

  lblDgVoodooAa := TLabel.Create(DgVoodooPage);
  lblDgVoodooAa.Parent := DgVoodooPage.Surface;
  lblDgVoodooAa.Caption := 'Anti-Aliasing';
  
  DgVoodooAa := TComboBox.Create(DgVoodooPage);
  DgVoodooAa.Parent := DgVoodooPage.Surface;
  DgVoodooAa.Style := csDropDownList;
  DgVoodooAa.Items.Add('Off');
  DgVoodooAa.Items.Add('2x');
  DgVoodooAa.Items.Add('4x');
  DgVoodooAa.Items.Add('8x (recommended)');;
  DgVoodooAa.ItemIndex := 3;
  DgVoodooAa.Top := ScaleY(20);

  descDgVoodooAa := TNewStaticText.Create(DgVoodooPage);
  descDgVoodooAa.Parent := DgVoodooPage.Surface;
  descDgVoodooAa.WordWrap := True;
  descDgVoodooAa.Width := DgVoodooPage.SurfaceWidth;
  descDgVoodooAa.Caption := 'Anti-Aliasing removes jagged edges in-game, effectively making them appear smoother at a performance cost.';
  descDgVoodooAa.Top := DgVoodooAa.Top + ScaleY(25);

  lblDgVoodooAf := TLabel.Create(DgVoodooPage);
  lblDgVoodooAf.Parent := DgVoodooPage.Surface;
  lblDgVoodooAf.Caption := 'Anisotropic Filtering';
  lblDgVoodooAf.Top := descDgVoodooAa.Top + ScaleY(45);
  
  DgVoodooAf := TComboBox.Create(DgVoodooPage);
  DgVoodooAf.Parent := DgVoodooPage.Surface;
  DgVoodooAf.Style := csDropDownList;
  DgVoodooAf.Items.Add('Off');
  DgVoodooAf.Items.Add('2x');
  DgVoodooAf.Items.Add('4x');
  DgVoodooAf.Items.Add('8x');
  DgVoodooAf.Items.Add('16x (recommended)');
  DgVoodooAf.ItemIndex := 4;
  DgVoodooAf.Top := lblDgVoodooAf.Top + ScaleY(20);

  descDgVoodooAf := TNewStaticText.Create(DgVoodooPage);
  descDgVoodooAf.Parent := DgVoodooPage.Surface;
  descDgVoodooAf.WordWrap := True;
  descDgVoodooAf.Width := DgVoodooPage.SurfaceWidth;
  descDgVoodooAf.Caption := 'Anisotropic Filtering improves the quality of textures when viewing them from the side, with minimal performance overhead.';
  descDgVoodooAf.Top := DgVoodooAf.Top + ScaleY(25);

  lblDgVoodooRefreshRate := TLabel.Create(DgVoodooPage);
  lblDgVoodooRefreshRate.Parent := DgVoodooPage.Surface;
  lblDgVoodooRefreshRate.Caption := 'Refresh Rate';
  lblDgVoodooRefreshRate.Top := descDgVoodooAf.Top + ScaleY(45);

  lblDgVoodooRefreshRateHz := TLabel.Create(DgVoodooPage);
  lblDgVoodooRefreshRateHz.Parent := DgVoodooPage.Surface;
  lblDgVoodooRefreshRateHz.Caption := 'Hz';
  lblDgVoodooRefreshRateHz.Top := lblDgVoodooRefreshRate.Top + ScaleY(23);
  lblDgVoodooRefreshRateHz.Left := ScaleX(125);
  
  DgVoodooRefreshRate := TNewEdit.Create(DgVoodooPage);
  DgVoodooRefreshRate.Parent := DgVoodooPage.Surface;;
  DgVoodooRefreshRate.Top := lblDgVoodooRefreshRateHz.Top - ScaleY(3);
  DgVoodooRefreshRate.Text := IntToStr(RefreshRate());
  DgVoodooRefreshRate.OnKeyPress := @DigitFieldKeyPress;

  descDgVoodooRefreshRate := TNewStaticText.Create(DgVoodooPage);
  descDgVoodooRefreshRate.Parent := DgVoodooPage.Surface;
  descDgVoodooRefreshRate.WordWrap := True;
  descDgVoodooRefreshRate.Width := DgVoodooPage.SurfaceWidth;
  descDgVoodooRefreshRate.Caption := 'Enter your monitor''s refresh rate here. Freelancer will run at this refresh rate.';
  descDgVoodooRefreshRate.Top := DgVoodooRefreshRate.Top + ScaleY(25);

  // DxWrapper options #2
  DxWrapperPage2 := CreateCustomPage(
    DgVoodooPage.ID,
    'DxWrapper options #2',
    'Choose additional graphics enhancements'
  );

  lblDxWrapperReShade := TLabel.Create(DxWrapperPage2);
  lblDxWrapperReShade.Parent := DxWrapperPage2.Surface;
  lblDxWrapperReShade.Caption := 'Enable ReShade';
  lblDxWrapperReShade.Left := ScaleX(20);
  
  descDxWrapperReShade := TNewStaticText.Create(DxWrapperPage2);
  descDxWrapperReShade.Parent := DxWrapperPage2.Surface;
  descDxWrapperReShade.WordWrap := True;
  descDxWrapperReShade.Top := ScaleY(20);
  descDxWrapperReShade.Width := DxWrapperPage2.SurfaceWidth;
  descDxWrapperReShade.Caption := 'This option enables ReShade, which allows for the use of various post-processing effects to improve the game''s appearance. If it has been enabled, the configuration below can always be adjusted by pressing the ''Home'' key in-game.'
  
  DxWrapperReShade := TCheckBox.Create(DxWrapperPage2);
  DxWrapperReShade.Parent := DxWrapperPage2.Surface;
  DxWrapperReShade.Checked := True;

  lblDxWrapperSaturation := TLabel.Create(DxWrapperPage2);
  lblDxWrapperSaturation.Parent := DxWrapperPage2.Surface;
  lblDxWrapperSaturation.Caption := 'Add increased saturation';
  lblDxWrapperSaturation.Left := ScaleX(20);
  lblDxWrapperSaturation.Top := descDxWrapperReShade.Top + ScaleY(70);
  
  descDxWrapperSaturation := TNewStaticText.Create(DxWrapperPage2);
  descDxWrapperSaturation.Parent := DxWrapperPage2.Surface;
  descDxWrapperSaturation.WordWrap := True;
  descDxWrapperSaturation.Top := lblDxWrapperSaturation.Top + ScaleY(20);
  descDxWrapperSaturation.Width := DxWrapperPage2.SurfaceWidth;
  descDxWrapperSaturation.Caption := 'Simply gives Freelancer a slightly more-saturated look.'
  
  DxWrapperSaturation := TCheckBox.Create(DxWrapperPage2);
  DxWrapperSaturation.Parent := DxWrapperPage2.Surface;
  DxWrapperSaturation.Checked := True;
  DxWrapperSaturation.Top := lblDxWrapperSaturation.Top;

  lblDxWrapperHdr := TLabel.Create(DxWrapperPage2);
  lblDxWrapperHdr.Parent := DxWrapperPage2.Surface;
  lblDxWrapperHdr.Caption := 'Add Fake HDR (High Dynamic Range)';
  lblDxWrapperHdr.Left := ScaleX(20);
  lblDxWrapperHdr.Top := descDxWrapperSaturation.Top + ScaleY(30);
  
  descDxWrapperHdr := TNewStaticText.Create(DxWrapperPage2);
  descDxWrapperHdr.Parent := DxWrapperPage2.Surface;
  descDxWrapperHdr.WordWrap := True;
  descDxWrapperHdr.Top := lblDxWrapperHdr.Top + ScaleY(20);
  descDxWrapperHdr.Width := DxWrapperPage2.SurfaceWidth;
  descDxWrapperHdr.Caption := 'Makes darker areas a bit darker, and brighter areas a bit brighter.'
  
  DxWrapperHdr := TCheckBox.Create(DxWrapperPage2);
  DxWrapperHdr.Parent := DxWrapperPage2.Surface;
  DxWrapperHdr.Top := lblDxWrapperHdr.Top;

  lblDxWrapperBloom := TLabel.Create(DxWrapperPage2);
  lblDxWrapperBloom.Parent := DxWrapperPage2.Surface;
  lblDxWrapperBloom.Caption := 'Add Bloom';
  lblDxWrapperBloom.Left := ScaleX(20);
  lblDxWrapperBloom.Top := descDxWrapperHdr.Top + ScaleY(30);
  
  descDxWrapperBloom := TNewStaticText.Create(DxWrapperPage2);
  descDxWrapperBloom.Parent := DxWrapperPage2.Surface;
  descDxWrapperBloom.WordWrap := True;
  descDxWrapperBloom.Top := lblDxWrapperBloom.Top + ScaleY(20);
  descDxWrapperBloom.Width := DxWrapperPage2.SurfaceWidth;
  descDxWrapperBloom.Caption := 'Adds glow to brighter areas. May reduce detail.'
  
  DxWrapperBloom := TCheckBox.Create(DxWrapperPage2);
  DxWrapperBloom.Parent := DxWrapperPage2.Surface;
  DxWrapperBloom.Top := lblDxWrapperBloom.Top;

  // dgVoodoo options #2
  DgVoodooPage2 := CreateCustomPage(
    DxWrapperPage2.ID,
    'dgVoodoo options #2',
    'Choose additional graphics enhancements'
  );

  lblDgVoodooReShade := TLabel.Create(DgVoodooPage2);
  lblDgVoodooReShade.Parent := DgVoodooPage2.Surface;
  lblDgVoodooReShade.Caption := 'Enable ReShade';
  lblDgVoodooReShade.Left := ScaleX(20);
  
  descDgVoodooReShade := TNewStaticText.Create(DgVoodooPage2);
  descDgVoodooReShade.Parent := DgVoodooPage2.Surface;
  descDgVoodooReShade.WordWrap := True;
  descDgVoodooReShade.Top := ScaleY(20);
  descDgVoodooReShade.Width := DxWrapperPage2.SurfaceWidth;
  descDgVoodooReShade.Caption := 'This option enables ReShade, which allows for the use of various post-processing effects to improve the game''s appearance. If it has been enabled, the configuration below can always be adjusted by pressing the ''Home'' key in-game.'
  
  DgVoodooReShade := TCheckBox.Create(DgVoodooPage2);
  DgVoodooReShade.Parent := DgVoodooPage2.Surface;
  DgVoodooReShade.Checked := True;

  lblDgVoodooSaturation := TLabel.Create(DgVoodooPage2);
  lblDgVoodooSaturation.Parent := DgVoodooPage2.Surface;
  lblDgVoodooSaturation.Caption := 'Add increased saturation';
  lblDgVoodooSaturation.Left := ScaleX(20);
  lblDgVoodooSaturation.Top := descDgVoodooReShade.Top + ScaleY(70);
  
  descDgVoodooSaturation := TNewStaticText.Create(DgVoodooPage2);
  descDgVoodooSaturation.Parent := DgVoodooPage2.Surface;
  descDgVoodooSaturation.WordWrap := True;
  descDgVoodooSaturation.Top := lblDgVoodooSaturation.Top + ScaleY(20);
  descDgVoodooSaturation.Width := DgVoodooPage2.SurfaceWidth;
  descDgVoodooSaturation.Caption := 'Simply gives Freelancer a slightly more-saturated look.'
  
  DgVoodooSaturation := TCheckBox.Create(DgVoodooPage2);
  DgVoodooSaturation.Parent := DgVoodooPage2.Surface;
  DgVoodooSaturation.Checked := True;
  DgVoodooSaturation.Top := lblDgVoodooSaturation.Top;

  lblDgVoodooHdr := TLabel.Create(DgVoodooPage2);
  lblDgVoodooHdr.Parent := DgVoodooPage2.Surface;
  lblDgVoodooHdr.Caption := 'Add Fake HDR (High Dynamic Range)';
  lblDgVoodooHdr.Left := ScaleX(20);
  lblDgVoodooHdr.Top := descDgVoodooSaturation.Top + ScaleY(30);
  
  descDgVoodooHdr := TNewStaticText.Create(DgVoodooPage2);
  descDgVoodooHdr.Parent := DgVoodooPage2.Surface;
  descDgVoodooHdr.WordWrap := True;
  descDgVoodooHdr.Top := lblDgVoodooHdr.Top + ScaleY(20);
  descDgVoodooHdr.Width := DgVoodooPage2.SurfaceWidth;
  descDgVoodooHdr.Caption := 'Makes darker areas a bit darker, and brighter areas a bit brighter.'
  
  DgVoodooHdr := TCheckBox.Create(DgVoodooPage2);
  DgVoodooHdr.Parent := DgVoodooPage2.Surface;
  DgVoodooHdr.Top := lblDgVoodooHdr.Top;

  lblDgVoodooBloom := TLabel.Create(DgVoodooPage2);
  lblDgVoodooBloom.Parent := DgVoodooPage2.Surface;
  lblDgVoodooBloom.Caption := 'Add Bloom';
  lblDgVoodooBloom.Left := ScaleX(20);
  lblDgVoodooBloom.Top := descDgVoodooHdr.Top + ScaleY(30);
  
  descDgVoodooBloom := TNewStaticText.Create(DgVoodooPage2);
  descDgVoodooBloom.Parent := DgVoodooPage2.Surface;
  descDgVoodooBloom.WordWrap := True;
  descDgVoodooBloom.Top := lblDgVoodooBloom.Top + ScaleY(20);
  descDgVoodooBloom.Width := DxWrapperPage2.SurfaceWidth;
  descDgVoodooBloom.Caption := 'Adds glow to brighter areas. May reduce detail.'
  
  DgVoodooBloom := TCheckBox.Create(DgVoodooPage2);
  DgVoodooBloom.Parent := DgVoodooPage2.Surface;
  DgVoodooBloom.Top := lblDgVoodooBloom.Top;

  // Add improved reflections
  PageEffects := CreateCustomPage(
    DgVoodooPage2.ID,
    'Add improved effects',
    'Check to install'
  );
  
  lblVanillaReflections := TLabel.Create(PageEffects);
  lblVanillaReflections.Parent := PageEffects.Surface;
  lblVanillaReflections.Caption := 'Use vanilla reflections';
  lblVanillaReflections.Left := ScaleX(20);
  
  VanillaReflections := TRadioButton.Create(PageEffects);
  VanillaReflections.Parent := PageEffects.Surface;
  
  lblShinyReflections := TLabel.Create(PageEffects);
  lblShinyReflections.Parent := PageEffects.Surface;
  lblShinyReflections.Caption := 'Use shiny reflections (recommended)';
  lblShinyReflections.Left := ScaleX(20);
  lblShinyReflections.Top := ScaleY(20);
  
  ShinyReflections := TRadioButton.Create(PageEffects);
  ShinyReflections.Parent := PageEffects.Surface;
  ShinyReflections.Top := lblShinyReflections.Top;
  ShinyReflections.Checked := True;
  
  lblShiniestReflections := TLabel.Create(PageEffects);
  lblShiniestReflections.Parent := PageEffects.Surface;
  lblShiniestReflections.Caption := 'Use shiniest reflections';
  lblShiniestReflections.Left := ScaleX(20);
  lblShiniestReflections.Top := lblShinyReflections.Top + ScaleY(20);
  
  ShiniestReflections := TRadioButton.Create(PageEffects);
  ShiniestReflections.Parent := PageEffects.Surface;
  ShiniestReflections.Top := lblShiniestReflections.Top;
  
  descReflections := TNewStaticText.Create(PageEffects);
  descReflections.Parent := PageEffects.Surface;
  descReflections.WordWrap := True;
  descReflections.Width := PageEffects.SurfaceWidth;
  descReflections.Caption := 'This option changes the way light reflects off ships, bases, etc. The shiny option is recommended since vanilla looks quite dull. Shiniest on the other hand makes all surfaces very reflective, which most users may not like.';
  descReflections.Top := ShiniestReflections.Top + ScaleY(20);
  
  // Add new missile effects
  lblMissleEffects := TLabel.Create(PageEffects);
  lblMissleEffects.Parent := PageEffects.Surface;
  lblMissleEffects.Caption := 'Add alternative missile and torpedo effects';
  lblMissleEffects.Top := descReflections.Top + ScaleY(60);
  lblMissleEffects.Left := ScaleX(20);
  
  descMissileEffects := TNewStaticText.Create(PageEffects);
  descMissileEffects.Parent := PageEffects.Surface;
  descMissileEffects.WordWrap := True;
  descMissileEffects.Top := lblMissleEffects.Top + ScaleY(20);
  descMissileEffects.Width := PageEffects.SurfaceWidth;
  descMissileEffects.Caption := 'This option adds custom missile and torpedo effects. They''re not necessarily higher quality, just alternatives. This option also adds huge torpedo effects.';
  
  MissileEffects := TCheckBox.Create(PageEffects);
  MissileEffects.Parent := PageEffects.Surface;
  MissileEffects.Top := lblMissleEffects.Top;
  
  // Add player ship engine trails
  lblEngineTrails := TLabel.Create(PageEffects);
  lblEngineTrails.Parent := PageEffects.Surface;
  lblEngineTrails.Caption := 'Add player ship engine trails';
  lblEngineTrails.Top := MissileEffects.Top + ScaleY(70);
  lblEngineTrails.Left := ScaleX(20);
  
  descEngineTrails := TNewStaticText.Create(PageEffects);
  descEngineTrails.Parent := PageEffects.Surface;
  descEngineTrails.WordWrap := True;
  descEngineTrails.Top := lblEngineTrails.Top + ScaleY(20);
  descEngineTrails.Width := PageEffects.SurfaceWidth;
  descEngineTrails.Caption := 'In vanilla Freelancer, NPC ships have engine trials while player ships don''t. This option adds engine trails to all player ships.';
  
  EngineTrails := TCheckBox.Create(PageEffects);
  EngineTrails.Parent := PageEffects.Surface;
  EngineTrails.Top := lblEngineTrails.Top;
  EngineTrails.Checked := True;

  // Draw distances
  PageDrawDistances := CreateInputOptionPage(PageEffects.ID,
  'Set Draw Distances', 'Check to install',
  'This option sets the draw distances scale; changing it to a higher value allows you to see things in space from further away. 1x will give you the same draw distances as vanilla Freelancer. Every option after that scales the vanilla values by a multiplier (2x, 3x, etc). The Maximized option sets all draw distances to the highest possible values, which includes the jump hole visibility distances.',
  True, False);
  PageDrawDistances.Add('1x (Vanilla)');
  PageDrawDistances.Add('2x');
  PageDrawDistances.Add('3x');
  PageDrawDistances.Add('4x');
  PageDrawDistances.Add('5x');
  PageDrawDistances.Add('6x');
  PageDrawDistances.Add('7x');
  PageDrawDistances.Add('8x');
  PageDrawDistances.Add('Maximized (recommended)');
  PageDrawDistances.Values[8] := True;

  // Skips
  PageSkips := CreateCustomPage(
    PageDrawDistances.ID,
    'Skippable options',
    'Want to save time?'
  );

  // Skip intros
  lblJumpTunnel10Sec := TLabel.Create(PageSkips);
  lblJumpTunnel10Sec.Parent := PageSkips.Surface;
  lblJumpTunnel10Sec.Caption := '10 second jump tunnels (Vanilla)';
  lblJumpTunnel10Sec.Left := ScaleX(20);
  
  JumpTunnel10Sec := TRadioButton.Create(PageSkips);
  JumpTunnel10Sec.Parent := PageSkips.Surface;
  
  lblJumpTunnel5Sec := TLabel.Create(PageSkips);
  lblJumpTunnel5Sec.Parent := PageSkips.Surface;
  lblJumpTunnel5Sec.Caption := '5 second jump tunnels';
  lblJumpTunnel5Sec.Left := ScaleX(20);
  lblJumpTunnel5Sec.Top := ScaleY(20);
  
  JumpTunnel5Sec := TRadioButton.Create(PageSkips);
  JumpTunnel5Sec.Parent := PageSkips.Surface;
  JumpTunnel5Sec.Top := lblJumpTunnel5Sec.Top;
  JumpTunnel5Sec.Checked := True;
  
  lblJumpTunnel2Sec := TLabel.Create(PageSkips);
  lblJumpTunnel2Sec.Parent := PageSkips.Surface;
  lblJumpTunnel2Sec.Caption := '2.5 second jump tunnels';
  lblJumpTunnel2Sec.Left := ScaleX(20);
  lblJumpTunnel2Sec.Top := JumpTunnel5Sec.Top + ScaleY(20);
  
  JumpTunnel2Sec := TRadioButton.Create(PageSkips);
  JumpTunnel2Sec.Parent := PageSkips.Surface;
  JumpTunnel2Sec.Top := lblJumpTunnel2Sec.Top;

  lblJumpTunnelSkip := TLabel.Create(PageSkips);
  lblJumpTunnelSkip.Parent := PageSkips.Surface;
  lblJumpTunnelSkip.Caption := '0 second jump tunnels (skip them entirely)';
  lblJumpTunnelSkip.Left := ScaleX(20);
  lblJumpTunnelSkip.Top := JumpTunnel2Sec.Top + ScaleY(20);
  
  JumpTunnelSkip := TRadioButton.Create(PageSkips);
  JumpTunnelSkip.Parent := PageSkips.Surface;
  JumpTunnelSkip.Top := lblJumpTunnelSkip.Top
  
  descJumpTunnelDuration := TNewStaticText.Create(PageSkips);
  descJumpTunnelDuration.Parent := PageSkips.Surface;
  descJumpTunnelDuration.WordWrap := True;
  descJumpTunnelDuration.Width := PageSkips.SurfaceWidth;
  descJumpTunnelDuration.Caption := 'This option allows you to change the duration of the jump tunnels which you go through when using any jump hole or jump gate.';
  descJumpTunnelDuration.Top := lblJumpTunnelSkip.Top + ScaleY(20);
  
  // Jump tunnel duration
  lblSkipIntros := TLabel.Create(PageSkips);
  lblSkipIntros.Parent := PageSkips.Surface;
  lblSkipIntros.Caption := 'Skip startup intros';
  lblSkipIntros.Top := descJumpTunnelDuration.Top + ScaleY(80);
  lblSkipIntros.Left := ScaleX(20);
  
  descSkipIntros := TNewStaticText.Create(PageSkips);
  descSkipIntros.Parent := PageSkips.Surface;
  descSkipIntros.WordWrap := True;
  descSkipIntros.Top := lblSkipIntros.Top + ScaleY(20);
  descSkipIntros.Width := PageSkips.SurfaceWidth;
  descSkipIntros.Caption := 'This option skips the 3 movies that play when the game starts, which include the Microsoft logo, Digital Anvil logo, and Freelancer intro.';
  
  SkipIntros := TCheckBox.Create(PageSkips);
  SkipIntros.Parent := PageSkips.Surface;
  SkipIntros.Top := lblSkipIntros.Top;
  SkipIntros.Checked := True;
  
  // Single Player Command Console
  PageMiscOptions := CreateCustomPage(
    PageSkips.ID,
    'Misc options',
    'Check to install'
  );
  
  lblSinglePlayer := TLabel.Create(PageMiscOptions);
  lblSinglePlayer.Parent := PageMiscOptions.Surface;
  lblSinglePlayer.Caption := 'Single Player Command Console';
  lblSinglePlayer.Left := ScaleX(20);
  
  descSinglePlayer := TNewStaticText.Create(PageMiscOptions);
  descSinglePlayer.Parent := PageMiscOptions.Surface;
  descSinglePlayer.WordWrap := True;
  descSinglePlayer.Top := ScaleY(20);
  descSinglePlayer.Width := PageMiscOptions.SurfaceWidth;
  descSinglePlayer.Caption := 'This option provides various console commands in Single Player to directly manipulate the environment. It also allows players to own more than one ship. To use it, press Enter while in-game and type "help" for a list of available commands.';
  
  SinglePlayer := TCheckBox.Create(PageMiscOptions);
  SinglePlayer.Parent := PageMiscOptions.Surface;
  SinglePlayer.Checked := True;

  lblBestOptions := TLabel.Create(PageMiscOptions);
  lblBestOptions.Parent := PageMiscOptions.Surface;
  lblBestOptions.Caption := 'Apply Best Video Options';
  lblBestOptions.Left := ScaleX(20);
  lblBestOptions.Top := descSinglePlayer.Top + ScaleY(55);
  
  descBestOptions := TNewStaticText.Create(PageMiscOptions);
  descBestOptions.Parent := PageMiscOptions.Surface;
  descBestOptions.WordWrap := True;
  descBestOptions.Top := lblBestOptions.Top + ScaleY(20);
  descBestOptions.Width := PageMiscOptions.SurfaceWidth;
  descBestOptions.Caption := 'Automatically applies the highest video options available in Freelancer. Additionally, it''ll select your monitor''s native resolution ('
    + IntToStr(DesktopRes.Width) + 'x' + IntToStr(DesktopRes.Height) + '). Freelancer usually doesn''t do any of this by default.';
  
  BestOptions := TCheckBox.Create(PageMiscOptions);
  BestOptions.Parent := PageMiscOptions.Surface;
  BestOptions.Checked := True;
  BestOptions.Top := lblBestOptions.Top;

  DisplayMode := TComboBox.Create(PageMiscOptions);
  DisplayMode.Parent := PageMiscOptions.Surface;
  DisplayMode.Style := csDropDownList;
  DisplayMode.Width := 210;
  DisplayMode.Items.Add('Fullscreen (default, recommended)');
  DisplayMode.Items.Add('Windowed');
  DisplayMode.Items.Add('Borderless Windowed');
  DisplayMode.ItemIndex := 0;
  DisplayMode.Top := BestOptions.Top + ScaleY(80);

  // Make Borderless Windowed the recommended and selected option on Wine to fix the Alt-Tab bug
  if IsWine then
  begin
    DisplayMode.Items[0] := 'Fullscreen (default)';
    DisplayMode.Items[2] := 'Borderless Windowed (recommended)';
    DisplayMode.ItemIndex := 2;
  end;

  lblDisplayMode := TLabel.Create(PageMiscOptions);
  lblDisplayMode.Parent := PageMiscOptions.Surface;
  lblDisplayMode.Caption := 'Display Mode';
  lblDisplayMode.Top := DisplayMode.Top;
  lblDisplayMode.Left := ScaleX(220);

  descDisplayMode := TNewStaticText.Create(PageMiscOptions);
  descDisplayMode.Parent := PageMiscOptions.Surface;
  descDisplayMode.WordWrap := True;
  descDisplayMode.Width := PageMiscOptions.SurfaceWidth;
  descDisplayMode.Caption := 'In both Windowed modes, the Gamma slider from the options menu won''t work. To remedy this, Gamma will be applied using ReShade, if it''s been enabled. Also, both windowed options are experimental and may be buggy, so try them at your own risk.';
  descDisplayMode.Top := lblDisplayMode.Top + ScaleY(25);

  lblDoNotPauseOnAltTab := TLabel.Create(PageMiscOptions);
  lblDoNotPauseOnAltTab.Parent := PageMiscOptions.Surface;
  lblDoNotPauseOnAltTab.Caption := 'Keep Freelancer running in the background when Alt-Tabbed';
  lblDoNotPauseOnAltTab.Top := descDisplayMode.Top + ScaleY(55);
  lblDoNotPauseOnAltTab.Left := ScaleX(20);
  
  DoNotPauseOnAltTab := TCheckBox.Create(PageMiscOptions);
  DoNotPauseOnAltTab.Parent := PageMiscOptions.Surface;
  DoNotPauseOnAltTab.Top := lblDoNotPauseOnAltTab.Top;
  MusicInBackground := False;

  with DxWrapperPage do
  begin
    OnShouldSkipPage := @PageHandler_ShouldSkipPage;
  end;

  with DgVoodooPage do
  begin
    OnShouldSkipPage := @PageHandler_ShouldSkipPage;
  end;

  with DxWrapperPage2 do
  begin
    OnShouldSkipPage := @PageHandler_ShouldSkipPage;
  end;

  with DgVoodooPage2 do
  begin
    OnShouldSkipPage := @PageHandler_ShouldSkipPage;
  end;

  with DxWrapperReShade do
  begin
    OnClick := @DxWrapperReShadeCheckBoxClick;
  end;

  with DgVoodooReShade do
  begin
    OnClick := @DgVoodooReShadeCheckBoxClick;
  end;

  // Make all the custom checkboxes and radio buttons less wide so the clickable area doesn't hide the accompanying labels on Wine.
  if IsWine then
  begin
    CheckBoxWidth := ScaleX(20)

    // Checkboxes
    EnglishImprovements.Width := CheckBoxWidth
    LevelRequirements.Width := CheckBoxWidth
    NewSaveFolder.Width := CheckBoxWidth
    WidescreenHud.Width := CheckBoxWidth
    WeaponGroups.Width := CheckBoxWidth
    DarkHud.Width := CheckBoxWidth
    FlatIcons.Width := CheckBoxWidth
    PlanetScape.Width := CheckBoxWidth
    DxWrapperReShade.Width := CheckBoxWidth
    DxWrapperSaturation.Width := CheckBoxWidth
    DxWrapperHdr.Width := CheckBoxWidth
    DxWrapperBloom.Width := CheckBoxWidth
    DgVoodooReShade.Width := CheckBoxWidth
    DgVoodooSaturation.Width := CheckBoxWidth
    DgVoodooHdr.Width := CheckBoxWidth
    DgVoodooBloom.Width := CheckBoxWidth
    MissileEffects.Width := CheckBoxWidth
    EngineTrails.Width := CheckBoxWidth
    SkipIntros.Width := CheckBoxWidth
    SinglePlayer.Width := CheckBoxWidth
    BestOptions.Width := CheckBoxWidth
    DoNotPauseOnAltTab.Width := CheckBoxWidth

    // Radio buttons
    DxWrapperGraphicsApi.Width := CheckBoxWidth
    DgVoodooGraphicsApi.Width := CheckBoxWidth
    VanillaGraphicsApi.Width := CheckBoxWidth
    LightingFixGraphicsApi.Width := CheckBoxWidth
    VanillaReflections.Width := CheckBoxWidth
    ShinyReflections.Width := CheckBoxWidth
    ShiniestReflections.Width := CheckBoxWidth
    JumpTunnel10Sec.Width := CheckBoxWidth
    JumpTunnel5Sec.Width := CheckBoxWidth
    JumpTunnel2Sec.Width := CheckBoxWidth
    JumpTunnelSkip.Width := CheckBoxWidth
  end;
end;

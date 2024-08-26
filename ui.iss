[Code]
var
  // Custom Pages
  DataDirPage: TInputDirWizardPage;
  PageInstallType: TWizardPage;
  CallSign: TInputOptionWizardPage;
  GameplayOptions: TWizardPage;
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
  VanillaPage: TWizardPage;

  // Install types
  ExpressInstall: TRadioButton;
  CustomInstall: TRadioButton;
  BasicInstall: TRadioButton;
  descExpressInstall: TNewStaticText; 
  descCustomInstall: TNewStaticText; 
  descBasicInstall: TNewStaticText;
  descInstallType: TNewStaticText; 

  // Pitch variations
  PitchVariations: TCheckBox;
  descPitchVariations: TNewStaticText;

  // Regeneratable shields
  RegeneratableShields: TCheckBox;
  descRegeneratableShields: TNewStaticText;

  // No Countermeasure activation on right-click
  NoCountermeasureRightClick: TCheckBox;
  descNoCountermeasureRightClick: TNewStaticText;

  // Advanced audio options
  AdvancedAudioOptions: TCheckBox;
  descAdvancedAudioOptions: TNewStaticText;

  // Localization
  EnglishImprovements: TCheckBox;
  descEnglishImprovements: TNewStaticText;

  // Russian fonts
  RussianFonts: TCheckBox;
  descRussianFonts: TNewStaticText;

  // Single Player mode
  lblSinglePlayerMode: TLabel;
  StoryMode: TComboBox;
  descSinglePlayerMode: TNewStaticText;

  // Level requirements
  LevelRequirements: TCheckBox;
  descLevelRequirements: TNewStaticText;

  // New save folder
  NewSaveFolder: TCheckBox;
  descNewSaveFolder: TNewStaticText;

  // Advanced Widescreen HUD
  WidescreenHud: TCheckBox;
  descWidescreenHud: TNewStaticText;

  // Weapon Groups
  WeaponGroups: TCheckBox;
  descWeaponGroups: TNewStaticText;

  // Dark HUD
  DarkHud: TCheckBox;
  descDarkHud: TNewStaticText;

  // Custom Icons
  VanillaIcons: TRadioButton;
  AlternativeIcons: TRadioButton;
  FlatIcons: TRadioButton;
  descCustomIcons: TNewStaticText;

  // Custom Nav Map
  CustomNavMap: TCheckBox;
  descCustomNavMap: TNewStaticText;

  // Fix clipping with 16:9 resolution planetscapes
  PlanetScape: TCheckBox;
  descPlanetScape: TNewStaticText;

  // Graphics API
  DxWrapperGraphicsApi: TRadioButton;
  DgVoodooGraphicsApi: TRadioButton;
  VanillaGraphicsApi: TRadioButton;
  LightingFixGraphicsApi: TRadioButton;
  descDxWrapperGraphicsApi: TNewStaticText;
  descDgVoodooGraphicsApi: TNewStaticText;
  descVanillaGraphicsApi: TNewStaticText;
  descLightingFixGraphicsApi: TNewStaticText;
  descGraphicsApi: TNewStaticText;

  // Vanilla
  lblVanillaAf: TLabel;
  VanillaAf: TComboBox;
  descVanillaAf: TNewStaticText;

  // DxWrapper
  lblDxWrapperAf: TLabel;
  lblDxWrapperAa: TLabel;
  DxWrapperAf: TComboBox;
  DxWrapperAa: TComboBox;
  descDxWrapperAf: TNewStaticText;
  descDxWrapperAa: TNewStaticText;

  // DxWrapper #2
  DxWrapperReShade: TCheckBox;
  DxWrapperSaturation: TCheckBox;
  DxWrapperSharpening: TCheckBox;
  DxWrapperHdr: TCheckBox;
  DxWrapperBloom: TCheckBox;
  descDxWrapperReShade: TNewStaticText;
  descDxWrapperSaturation: TNewStaticText;
  descDxWrapperSharpening: TNewStaticText;
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
  DgVoodooReShade: TCheckBox;
  DgVoodooSaturation: TCheckBox;
  DgVoodooSharpening: TCheckBox;
  DgVoodooHdr: TCheckBox;
  DgVoodooBloom: TCheckBox;
  descDgVoodooReShade: TNewStaticText;
  descDgVoodooSaturation: TNewStaticText;
  descDgVoodooSharpening: TNewStaticText;
  descDgVoodooHdr: TNewStaticText;
  descDgVoodooBloom: TNewStaticText;

  // Add improved reflections
  VanillaReflections: TRadioButton;
  ShinyReflections: TRadioButton;
  ShiniestReflections: TRadioButton;
  descReflections: TNewStaticText;

  // Add new missile and explosion effects
  MissileEffects: TCheckBox;
  ExplosionEffects: TCheckBox;
  descMissileEffects: TNewStaticText;

  // Add player ship engine trails
  EngineTrails: TCheckBox;
  descEngineTrails: TNewStaticText;

  // Skip intros
  SkipIntros: TCheckBox;
  descSkipIntros: TNewStaticText;

  // Skipable cutscenes
  SkippableCutscenes: TCheckBox;
  descSkippableCutscenes: TNewStaticText;

  // Jump tunnel duration
  JumpTunnel10Sec: TRadioButton;
  JumpTunnel5Sec: TRadioButton;
  JumpTunnel2Sec: TRadioButton;
  JumpTunnelSkip: TRadioButton;
  descJumpTunnelDuration: TNewStaticText;

  // Single Player Command Console
  SinglePlayer: TCheckBox;
  descSinglePlayer: TNewStaticText;

  // Apply best options
  BestOptions: TCheckBox;
  descBestOptions: TNewStaticText;

  // Display mode
  lblDisplayMode: TLabel;
  DisplayMode: TComboBox;
  descDisplayMode: TNewStaticText;

  // Do not pause on alt tab
  DoNotPauseOnAltTab: TCheckBox;
  MusicInBackground: Boolean;

// Report on download progress
# if !AllInOneInstall
function OnDownloadProgress(const Url, FileName: String; const Progress, ProgressMax: Int64): Boolean;
begin
  DownloadPage.SetText('Downloading mod',(IntToStr(Progress/1048576)) + ' MB / ' + DownloadSize + ' MB');
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
  else if (Page.Id = VanillaPage.Id) and HasLightingBug then
    Result := not (VanillaGraphicsApi.Checked or LightingFixGraphicsApi.Checked)
  else if (Page.Id = VanillaPage.Id) then
    Result := not VanillaGraphicsApi.Checked;
end;

procedure DxWrapperReShadeCheckBoxClick(Sender: TObject);
begin
  DxWrapperSaturation.Enabled := DxWrapperReShade.Checked;
  DxWrapperSharpening.Enabled := DxWrapperReShade.Checked;
  DxWrapperHdr.Enabled := DxWrapperReShade.Checked;
  DxWrapperBloom.Enabled := DxWrapperReShade.Checked;
end;

procedure DgVoodooReShadeCheckBoxClick(Sender: TObject);
begin
  DgVoodooSaturation.Enabled := DgVoodooReShade.Checked;
  DgVoodooSharpening.Enabled := DgVoodooReShade.Checked;
  DgVoodooHdr.Enabled := DgVoodooReShade.Checked;
  DgVoodooBloom.Enabled := DgVoodooReShade.Checked;
end;

procedure InitializeUi();
var 
  dir : string;

  // Strings that are used more than once
  txtAa: String;
  txtAaDesc: String;
  txtAf: String;
  txtAfDesc: String;
  txtEnhancementsPage: String;
  txtReShade: String;
  txtReShadeDesc: String;
  txtSaturation: String;
  txtSaturationDesc: String;
  txtSharpening: String;
  txtSharpeningDesc: String;
  txtHdr: String;
  txtHdrDesc: String;
  txtBloom: String;
  txtBloomDesc: String;
  txtAuto: String;
begin
  txtAa := 'Anti-Aliasing';
  txtAaDesc := 'Anti-Aliasing removes jagged edges in-game, effectively making them appear smoother at a performance cost. Disable this option if you''re running low-end hardware.';
  txtAf := 'Anisotropic Filtering';
  txtAfDesc := 'Anisotropic Filtering improves the quality of textures when viewing them from the side with minimal performance overhead.';
  txtEnhancementsPage := 'Choose additional graphics enhancements.';
  txtReShade := 'Enable ReShade';
  txtReShadeDesc := 'This option enables ReShade, which allows for the use of various post-processing effects to improve the game''s appearance. If it''s been enabled, the configuration below can be adjusted at any time by pressing the ''Home'' key in-game.';
  txtSaturation := 'Add increased saturation (recommended)';
  txtSaturationDesc := 'Simply gives Freelancer a slightly more-saturated look.';
  txtSharpening := 'Add adaptive sharpening (recommended)';
  txtSharpeningDesc := 'Makes the game look slightly more crisp without oversharpening everything.';
  txtHdr := 'Add Fake HDR (High Dynamic Range)';
  txtHdrDesc := 'Makes darker areas a bit darker, and brighter areas a bit brighter.';
  txtBloom := 'Add Bloom';
  txtBloomDesc := 'Adds glow to brighter areas. May reduce detail.';
  txtAuto := ' "Auto" will automatically use the highest option your graphics card supports.'

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
  'Select the folder in which a fresh and completely unmodded copy of Freelancer is installed. This is usually "' + dir + '".' + #13#10 +
  'The folder you select here will be copied without modification.',
  False, '');
  DataDirPage.Add('');
  
  // If the Reg key exists, use its content to populate the folder location box. Use the default path if otherwise.
  RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Microsoft Games\Freelancer\1.0', 'AppPath', dir)
  DataDirPage.Values[0] := dir


  PageInstallType := CreateCustomPage(
    DataDirPage.ID,
    'Installation type',
    'Choose how you''d like to install {#MyModName}.'
  );

  descInstallType := TNewStaticText.Create(PageInstallType);
  descInstallType.Parent := PageInstallType.Surface;
  descInstallType.WordWrap := True;
  descInstallType.Width := PageInstallType.SurfaceWidth;
  descInstallType.Caption := 'The {#MyModName} installer offers custom options to improve the gameplay experience. The installation types below determine how these options should be applied during the installation process.';

  ExpressInstall := TRadioButton.Create(PageInstallType);
  ExpressInstall.Parent := PageInstallType.Surface;
  ExpressInstall.Top := ScaleY(60);
  ExpressInstall.Caption := 'Express install';
  ExpressInstall.Width := PageInstallType.SurfaceWidth - ScaleX(8);
  ExpressInstall.Checked := not WizardSilent;

  descExpressInstall := TNewStaticText.Create(PageInstallType);
  descExpressInstall.Parent := PageInstallType.Surface;
  descExpressInstall.WordWrap := True;
  descExpressInstall.Top := ExpressInstall.Top + ScaleY(20);
  descExpressInstall.Width := PageInstallType.SurfaceWidth;
  descExpressInstall.Caption := 'Install the mod with all recommended options automatically applied.';

  CustomInstall := TRadioButton.Create(PageInstallType);
  CustomInstall.Parent := PageInstallType.Surface;
  CustomInstall.Top := descExpressInstall.Top + ScaleY(29);
  CustomInstall.Caption := 'Custom install';
  CustomInstall.Width := PageInstallType.SurfaceWidth - ScaleX(8);
  CustomInstall.Checked := WizardSilent;

  descCustomInstall := TNewStaticText.Create(PageInstallType);
  descCustomInstall.Parent := PageInstallType.Surface;
  descCustomInstall.WordWrap := True;
  descCustomInstall.Top := CustomInstall.Top + ScaleY(20);
  descCustomInstall.Width := PageInstallType.SurfaceWidth;
  descCustomInstall.Caption := 'Install the mod but for every option manually select whether it should be applied. This may take some time as there are quite a few options to go through.';

  BasicInstall := TRadioButton.Create(PageInstallType);
  BasicInstall.Parent := PageInstallType.Surface;
  BasicInstall.Top := descCustomInstall.Top + ScaleY(42);
  BasicInstall.Caption := 'Basic install (not recommended)';
  BasicInstall.Width := PageInstallType.SurfaceWidth - ScaleX(8);

  descBasicInstall := TNewStaticText.Create(PageInstallType);
  descBasicInstall.Parent := PageInstallType.Surface;
  descBasicInstall.WordWrap := True;
  descBasicInstall.Top := BasicInstall.Top + ScaleY(20);
  descBasicInstall.Width := PageInstallType.SurfaceWidth;
  descBasicInstall.Caption := 'Install the mod without applying any options. Doing this is not recommended because you may miss out on improvements to the gameplay experience.';

  
  // Initialize CallSign page and add content
  CallSign := CreateInputOptionPage(PageInstallType.ID,
  'Single Player ID Code', 'Tired of being called Freelancer Alpha 1-1?',
  'You know when each time an NPC talks to you in-game, they call you Freelancer Alpha 1-1? This mod gives you the ability to change that ID code in Single Player. Select any option you like and the NPCs will call you by that.',
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

  // Initialize PitchVariations page and add content
  GameplayOptions := CreateCustomPage(CallSign.ID,
  'Gameplay customization', 'The NPC voices and shields options only affect Single Player and self-hosted Multiplayer games.');

  descPitchVariations := TNewStaticText.Create(GameplayOptions);
  descPitchVariations.Parent := GameplayOptions.Surface;
  descPitchVariations.WordWrap := True;
  descPitchVariations.Top := ScaleY(20);
  descPitchVariations.Width := GameplayOptions.SurfaceWidth;
  descPitchVariations.Caption :=
  'NPCs from a faction talking in space usually only have one or two different voices. This option adds more pitches to the NPC voices so there''s more variety.';

  PitchVariations := TCheckBox.Create(GameplayOptions);
  PitchVariations.Parent := GameplayOptions.Surface;
  PitchVariations.Caption := 'Add more voices for the NPCs';
  PitchVariations.Width := GameplayOptions.SurfaceWidth - ScaleX(8);

  descRegeneratableShields := TNewStaticText.Create(GameplayOptions);
  descRegeneratableShields.Parent := GameplayOptions.Surface;
  descRegeneratableShields.WordWrap := True;
  descRegeneratableShields.Top := descPitchVariations.Top + ScaleY(65);
  descRegeneratableShields.Width := GameplayOptions.SurfaceWidth;
  descRegeneratableShields.Caption := 'Generally NPC shields have a very low regeneration rate. As an extra challenge, this option makes it so that all NPCs use normal regeneratable shields.';

  RegeneratableShields := TCheckBox.Create(GameplayOptions);
  RegeneratableShields.Parent := GameplayOptions.Surface;
  RegeneratableShields.Top := descPitchVariations.Top + ScaleY(45);
  RegeneratableShields.Caption := 'Regeneratable NPC shields';
  RegeneratableShields.Width := GameplayOptions.SurfaceWidth - ScaleX(8);

  descNoCountermeasureRightClick := TNewStaticText.Create(GameplayOptions);
  descNoCountermeasureRightClick.Parent := GameplayOptions.Surface;
  descNoCountermeasureRightClick.WordWrap := True;
  descNoCountermeasureRightClick.Top := descRegeneratableShields.Top + ScaleY(65);
  descNoCountermeasureRightClick.Width := GameplayOptions.SurfaceWidth;
  descNoCountermeasureRightClick.Caption := 'When a Countermeasure dropper is active, it automatically activates whenever a missile is fired at your ship. It will also activate together with your active weapons when right-clicking. To prevent unintentional activations, this option makes Countermeasure droppers not activate when right-clicking.';

  NoCountermeasureRightClick := TCheckBox.Create(GameplayOptions);
  NoCountermeasureRightClick.Parent := GameplayOptions.Surface;
  NoCountermeasureRightClick.Top := descRegeneratableShields.Top + ScaleY(45);
  NoCountermeasureRightClick.Caption := 'Prevent Countermeasure dropper activation on right-click';
  NoCountermeasureRightClick.Width := GameplayOptions.SurfaceWidth - ScaleX(8);

  descAdvancedAudioOptions := TNewStaticText.Create(GameplayOptions);
  descAdvancedAudioOptions.Parent := GameplayOptions.Surface;
  descAdvancedAudioOptions.WordWrap := True;
  descAdvancedAudioOptions.Top := descNoCountermeasureRightClick.Top + ScaleY(90);
  descAdvancedAudioOptions.Width := GameplayOptions.SurfaceWidth;
  descAdvancedAudioOptions.Caption := 'Adds controls to the audio options for adjusting the interface and ambience volume.';

  AdvancedAudioOptions := TCheckBox.Create(GameplayOptions);
  AdvancedAudioOptions.Parent := GameplayOptions.Surface;
  AdvancedAudioOptions.Top := descNoCountermeasureRightClick.Top + ScaleY(70);
  AdvancedAudioOptions.Caption := 'Advanced audio options';
  AdvancedAudioOptions.Width := GameplayOptions.SurfaceWidth - ScaleX(8);


  // Initialize English Improvements page and add content
  PageEnglishImprovements := CreateCustomPage(GameplayOptions.ID,
  'Localization', 'Apply English improvements and other fixes.');
  
  descEnglishImprovements := TNewStaticText.Create(PageEnglishImprovements);
  descEnglishImprovements.Parent := PageEnglishImprovements.Surface;
  descEnglishImprovements.WordWrap := True;
  descEnglishImprovements.Top := ScaleY(20);
  descEnglishImprovements.Width := PageEnglishImprovements.SurfaceWidth;
  descEnglishImprovements.Caption := 
  'This option fixes many typos, grammar mistakes, inconsistencies, and more, in the English Freelancer text and audio resources. It also adds a higher quality Freelancer intro (1440x960 instead of 720x480), which is only available in English.' + #13#10#13#10 +  
  'NOTE: This option will set all of Freelancer''s text, voice lines, and the intro to English. Disable this option if you''d like to play Freelancer in a different language like German, French, or Russian.'
  + #13#10#13#10 + 'NOTE 2: Some text resources will remain English if this option is disabled.';

  EnglishImprovements := TCheckBox.Create(PageEnglishImprovements);
  EnglishImprovements.Parent := PageEnglishImprovements.Surface;
  EnglishImprovements.Caption := 'Apply English Freelancer improvements';
  EnglishImprovements.Width := PageEnglishImprovements.SurfaceWidth - ScaleX(8);
  
  descRussianFonts := TNewStaticText.Create(PageEnglishImprovements);
  descRussianFonts.Parent := PageEnglishImprovements.Surface;
  descRussianFonts.WordWrap := True;
  descRussianFonts.Top := descEnglishImprovements.Top + ScaleY(180);
  descRussianFonts.Width := PageEnglishImprovements.SurfaceWidth;
  descRussianFonts.Caption := 'This option adds a Cyrillic version of the Agency FB font for Freelancer.' + #13#10 + 'It also adds support for typing Cyrillic characters in the chat. Users with a Russian Freelancer installation may want to enable this option.';

  RussianFonts := TCheckBox.Create(PageEnglishImprovements);
  RussianFonts.Parent := PageEnglishImprovements.Surface;
  RussianFonts.Top := descEnglishImprovements.Top + ScaleY(160);
  RussianFonts.Caption := 'Use Russian fonts + Rus Chat';
  RussianFonts.Width := PageEnglishImprovements.SurfaceWidth - ScaleX(8);


  // Initialize Single Player page and add content
  PageSinglePlayer := CreateCustomPage(PageEnglishImprovements.ID, 
  'Single Player options', 'Choose how you''d like to play Single Player.');

  StoryMode := TComboBox.Create(PageSinglePlayer);
  StoryMode.Parent := PageSinglePlayer.Surface;
  StoryMode.Style := csDropDownList;
  StoryMode.Width := 200;
  StoryMode.Items.Add('Story Mode (default)');
  StoryMode.Items.Add('Open Single Player (Normal)');
  StoryMode.Items.Add('Open Single Player (Pirate)');

  lblSinglePlayerMode := TLabel.Create(PageSinglePlayer);
  lblSinglePlayerMode.Parent := PageSinglePlayer.Surface;
  lblSinglePlayerMode.Caption := 'Single Player mode';
  lblSinglePlayerMode.Left := ScaleX(210);
  
  descSinglePlayerMode := TNewStaticText.Create(PageSinglePlayer);
  descSinglePlayerMode.Parent := PageSinglePlayer.Surface;
  descSinglePlayerMode.WordWrap := True;
  descSinglePlayerMode.Width := PageSinglePlayer.SurfaceWidth;
  descSinglePlayerMode.Caption := 'This option allows you to choose the Single Player mode. Story Mode simply lets you play through the entire storyline, as usual. Both Open Single Player options skip the entire storyline and allow you to freely roam the universe right away. With OSP (Normal), you start in Manhattan with a basic loadout and a default reputation. The OSP (Pirate) option on the other hand, spawns you at Rochester with a similar loadout and an inverted reputation. NOTE: Both OSP options may cause existing storyline saves to not work correctly.';
  descSinglePlayerMode.Top := ScaleY(25);
  
  // Level requirements
  LevelRequirements := TCheckBox.Create(PageSinglePlayer);
  LevelRequirements.Parent := PageSinglePlayer.Surface;
  LevelRequirements.Top := descSinglePlayerMode.Top + ScaleY(108);
  LevelRequirements.Caption := 'Remove level requirements';
  LevelRequirements.Width := PageSinglePlayer.SurfaceWidth - ScaleX(8);
  
  descLevelRequirements := TNewStaticText.Create(PageSinglePlayer);
  descLevelRequirements.Parent := PageSinglePlayer.Surface;
  descLevelRequirements.WordWrap := True;
  descLevelRequirements.Top := LevelRequirements.Top + ScaleY(20);
  descLevelRequirements.Width := PageSinglePlayer.SurfaceWidth;
  descLevelRequirements.Caption := 'This option removes the level requirements for ships and equipment in Single Player.';

  // New save folder  
  descNewSaveFolder := TNewStaticText.Create(PageSinglePlayer);
  descNewSaveFolder.Parent := PageSinglePlayer.Surface;
  descNewSaveFolder.WordWrap := True;
  descNewSaveFolder.Top := descLevelRequirements.Top + ScaleY(50);
  descNewSaveFolder.Width := PageSinglePlayer.SurfaceWidth;
  descNewSaveFolder.Caption := 'Normally, Freelancer save games are stored in "Documents/My Games/Freelancer". This option ensures save games will be stored in "Documents/My Games/FreelancerHD" instead, which may help avoid conflicts when having multiple mods installed simultaneously.';
  
  NewSaveFolder := TCheckBox.Create(PageSinglePlayer);
  NewSaveFolder.Parent := PageSinglePlayer.Surface;
  NewSaveFolder.Top := descLevelRequirements.Top + ScaleY(30);
  NewSaveFolder.Caption := 'Store save game files in a different folder';
  NewSaveFolder.Width := PageSinglePlayer.SurfaceWidth - ScaleX(8);

  // Initialize StartupRes page and add content
  StartupRes := CreateInputOptionPage(PageSinglePlayer.ID,
  'Startup Screen Resolution', 'Choose your native resolution.',
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
  
  // Initialize LogoRes page and add content
  LogoRes := CreateInputOptionPage(StartupRes.ID,
  'Freelancer Logo Resolution', 'In the game''s main menu.',
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
  
  // Fix Small Text on 1440p/4K resolutions
  SmallText := CreateInputOptionPage(LogoRes.ID,
  'Fix small text on larger resolutions', 'Check to install.',
  'Many high-resolution Freelancer players have reported missing HUD text and misaligned buttons in menus. In 4K, the nav map text is too small and there are many missing text elements in the HUD. For 1440p and some 16:10 screens, the only apparent issue is the small nav map text.' + #13#10 + #13#10 +
  'Select the option corresponding to the resolution you''re going to play Freelancer in. If you play in 1920x1080 or lower, the "No" option is fine as the elements are configured correctly already.',
  True, False);
  SmallText.Add('No');
  SmallText.Add('Yes, apply fix for 2560x1440 and 1920x1200 screens');
  SmallText.Add('Yes, apply fix for 3840x2160 screens');

  if IsWine then
    SmallText.Add('Yes, apply fix for 3840x1600 screens');
  
  // Initialize HUD page and add content
  PageWidescreenHud := CreateCustomPage(
    SmallText.ID,
    'Advanced Widescreen HUD',
    'Check to install.'
  );
  
  descWidescreenHud := TNewStaticText.Create(PageWidescreenHud);
  descWidescreenHud.Parent := PageWidescreenHud.Surface;
  descWidescreenHud.WordWrap := True;
  descWidescreenHud.Top := ScaleY(20);
  descWidescreenHud.Width := PageWidescreenHud.SurfaceWidth;
  descWidescreenHud.Caption := 'This option adds two new useful widgets to your HUD. Next to your contact list, you will have a wireframe representation of your selected target. Next to your weapons list, you will have a wireframe of your own ship. Disable this option if you play in an aspect ratio narrower than 16:9.';
  
  WidescreenHud := TCheckBox.Create(PageWidescreenHud);
  WidescreenHud.Parent := PageWidescreenHud.Surface;
  WidescreenHud.Caption := 'Enable Advanced Widescreen HUD';
  WidescreenHud.Width := PageWidescreenHud.SurfaceWidth - ScaleX(8);
  
  descWeaponGroups := TNewStaticText.Create(PageWidescreenHud);
  descWeaponGroups.Parent := PageWidescreenHud.Surface;
  descWeaponGroups.WordWrap := True;
  descWeaponGroups.Top := descWidescreenHud.Top + ScaleY(105);
  descWeaponGroups.Width := PageWidescreenHud.SurfaceWidth;
  descWeaponGroups.Caption := 'This option adds buttons for selecting three different weapon groups in your ship info panel.';
  
  WeaponGroups := TCheckBox.Create(PageWidescreenHud);
  WeaponGroups.Parent := PageWidescreenHud.Surface;
  WeaponGroups.Top := descWidescreenHud.Top + ScaleY(85);
  WeaponGroups.Caption := 'Add Weapon Group buttons';
  WeaponGroups.Width := PageWidescreenHud.SurfaceWidth - ScaleX(8);

  // Initialize Dark HUD page and add content
  PageDarkHud := CreateCustomPage(
    PageWidescreenHud.ID,
    'Custom HUD, Icons, and Nav Map',
    'Check to install.'
  );
  
  descDarkHud := TNewStaticText.Create(PageDarkHud);
  descDarkHud.Parent := PageDarkHud.Surface;
  descDarkHud.WordWrap := True;
  descDarkHud.Top := ScaleY(20);
  descDarkHud.Width := PageDarkHud.SurfaceWidth;
  descDarkHud.Caption := 'This option replaces the default Freelancer HUD with a more darker-themed HUD. If this option is disabled, you''ll get the HD default HUD instead.';
  
  DarkHud := TCheckBox.Create(PageDarkHud);
  DarkHud.Parent := PageDarkHud.Surface;
  DarkHud.Caption := 'Enable Dark HUD';
  DarkHud.Width := PageDarkHud.SurfaceWidth - ScaleX(8);

  VanillaIcons := TRadioButton.Create(PageDarkHud);
  VanillaIcons.Parent := PageDarkHud.Surface;
  VanillaIcons.Top := descDarkHud.Top + ScaleY(45);
  VanillaIcons.Caption := 'HD Vanilla Icons';
  VanillaIcons.Width := PageDarkHud.SurfaceWidth - ScaleX(8);

  AlternativeIcons := TRadioButton.Create(PageDarkHud);
  AlternativeIcons.Parent := PageDarkHud.Surface;
  AlternativeIcons.Top := VanillaIcons.Top + ScaleY(20);
  AlternativeIcons.Caption := 'Custom Alternative Icons';
  AlternativeIcons.Width := PageDarkHud.SurfaceWidth - ScaleX(8);

  FlatIcons := TRadioButton.Create(PageDarkHud);
  FlatIcons.Parent := PageDarkHud.Surface;
  FlatIcons.Top := AlternativeIcons.Top + ScaleY(20);
  FlatIcons.Caption := 'Custom Flat Icons';
  FlatIcons.Width := PageDarkHud.SurfaceWidth - ScaleX(8);

  descCustomIcons := TNewStaticText.Create(PageDarkHud);
  descCustomIcons.Parent := PageDarkHud.Surface;
  descCustomIcons.WordWrap := True;
  descCustomIcons.Top := AlternativeIcons.Top + ScaleY(40);
  descCustomIcons.Width := PageDarkHud.SurfaceWidth;
  descCustomIcons.Caption := 'This option allows you to choose a set of icons for Freelancer. The HD Vanilla Icons option adds an HD version of the default Freelancer icons. The Custom Alternative Icons have a different look but a style similar to the vanilla icons. Lastly, the Custom Flat Icons option adds new icons that have a more flat and simple look.';

  descCustomNavMap := TNewStaticText.Create(PageDarkHud);
  descCustomNavMap.Parent := PageDarkHud.Surface;
  descCustomNavMap.WordWrap := True;
  descCustomNavMap.Top := FlatIcons.Top + ScaleY(112);
  descCustomNavMap.Width := PageDarkHud.SurfaceWidth;
  descCustomNavMap.Caption := 'Replaces the background of the in-game Nav Map with an alternative version. If this option is disabled, an HD version of the original Nav Map background will be used.';

  CustomNavMap := TCheckBox.Create(PageDarkHud);
  CustomNavMap.Parent := PageDarkHud.Surface;
  CustomNavMap.Caption := 'Use Custom Nav Map background';
  CustomNavMap.Top := FlatIcons.Top + ScaleY(92);
  CustomNavMap.Width := PageDarkHud.SurfaceWidth - ScaleX(8);

  
  // Fix clipping with 16:9 resolution planetscapes
  PagePlanetScape := CreateCustomPage(
    PageDarkHud.ID,
    'Fix clipping with 16:9 resolution planetscapes',
    'Check to install.'
  );
  
  descPlanetScape := TNewStaticText.Create(PagePlanetScape);
  descPlanetScape.Parent := PagePlanetScape.Surface;
  descPlanetScape.WordWrap := True;
  descPlanetScape.Top := ScaleY(20);
  descPlanetScape.Width := PagePlanetScape.SurfaceWidth;
  descPlanetScape.Caption := 'Since Freelancer was never optimized for 16:9 resolutions, there are several inconsistencies with planetscapes that occur while viewing them in 16:9, such as clipping and geometry issues.' + #13#10 + #13#10 +
  'This mod gives you the option of fixing this, as it adjusts the camera values in the planetscapes so the issues are no longer visible in 16:9 resolutions.' + #13#10 + #13#10 +
  'Disable this option if you play in 4:3. Also please note that the planetscape views may look zoomed in when using this option with an ultrawide resolution.'
  
  PlanetScape := TCheckBox.Create(PagePlanetScape);
  PlanetScape.Parent := PagePlanetScape.Surface;
  PlanetScape.Caption := 'Fix clipping with 16:9 resolution planetscapes';
  PlanetScape.Width := PagePlanetScape.SurfaceWidth - ScaleX(8);
  
  // Choose Graphics API
  PageGraphicsApi := CreateCustomPage(
    PagePlanetScape.ID,
    'Graphics API',
    'Choose the one that suits your needs.'
  );

  descGraphicsApi := TNewStaticText.Create(PageGraphicsApi);
  descGraphicsApi.Parent := PageGraphicsApi.Surface;
  descGraphicsApi.WordWrap := True;
  descGraphicsApi.Width := PageGraphicsApi.SurfaceWidth;
  descGraphicsApi.Caption := 'This page allows you to choose the graphics API. If you have no idea what this means, just go with the first or second option, since those offer the best graphics enhancements and fixes. If they cause issues for you, choose a different option.';

  DgVoodooGraphicsApi := TRadioButton.Create(PageGraphicsApi);
  DgVoodooGraphicsApi.Parent := PageGraphicsApi.Surface;
  DgVoodooGraphicsApi.Top := ScaleY(50);
  DgVoodooGraphicsApi.Caption := 'dgVoodoo (DirectX 11, recommended for NVIDIA and Intel GPUs)';
  DgVoodooGraphicsApi.Width := PageGraphicsApi.SurfaceWidth - ScaleX(8);

  descDgVoodooGraphicsApi := TNewStaticText.Create(PageGraphicsApi);
  descDgVoodooGraphicsApi.Parent := PageGraphicsApi.Surface;
  descDgVoodooGraphicsApi.WordWrap := True;
  descDgVoodooGraphicsApi.Top := DgVoodooGraphicsApi.Top + ScaleY(15);
  descDgVoodooGraphicsApi.Width := PageGraphicsApi.SurfaceWidth;
  descDgVoodooGraphicsApi.Caption := 'Fixes the lighting, stuttering, and glass bugs on Windows 10 and 11. Supports native Anti-Aliasing, Anisotropic Filtering, and ReShade.';

  // Refresh rate input is only required if the user has an AMD GPU
  if GpuManufacturer = AMD then
    descDgVoodooGraphicsApi.Caption := descDgVoodooGraphicsApi.Caption + ' Requires refresh rate input.';

  DxWrapperGraphicsApi := TRadioButton.Create(PageGraphicsApi);
  DxWrapperGraphicsApi.Parent := PageGraphicsApi.Surface;
  DxWrapperGraphicsApi.Top := descDgVoodooGraphicsApi.Top + ScaleY(37);
  DxWrapperGraphicsApi.Caption := 'DxWrapper + d3d8to9 (DirectX 9, recommended for all GPUs)';
  DxWrapperGraphicsApi.Width := PageGraphicsApi.SurfaceWidth - ScaleX(8);

  descDxWrapperGraphicsApi := TNewStaticText.Create(PageGraphicsApi);
  descDxWrapperGraphicsApi.Parent := PageGraphicsApi.Surface;
  descDxWrapperGraphicsApi.WordWrap := True;
  descDxWrapperGraphicsApi.Top := DxWrapperGraphicsApi.Top + ScaleY(15);
  descDxWrapperGraphicsApi.Width := PageGraphicsApi.SurfaceWidth;
  descDxWrapperGraphicsApi.Caption := 'Fixes the lighting and stuttering bugs on Windows 10 and 11. Supports native Anti-Aliasing, Anisotropic Filtering, and ReShade.';

  VanillaGraphicsApi := TRadioButton.Create(PageGraphicsApi);
  VanillaGraphicsApi.Parent := PageGraphicsApi.Surface;
  VanillaGraphicsApi.Top := descDxWrapperGraphicsApi.Top + ScaleY(37);
  VanillaGraphicsApi.Caption := 'Vanilla Freelancer (DirectX 8)';
  VanillaGraphicsApi.Width := PageGraphicsApi.SurfaceWidth - ScaleX(8);

  descVanillaGraphicsApi := TNewStaticText.Create(PageGraphicsApi);
  descVanillaGraphicsApi.Parent := PageGraphicsApi.Surface;
  descVanillaGraphicsApi.WordWrap := True;
  descVanillaGraphicsApi.Top := VanillaGraphicsApi.Top + ScaleY(15);
  descVanillaGraphicsApi.Width := PageGraphicsApi.SurfaceWidth;
  descVanillaGraphicsApi.Caption := 'Uses your PC''s default DirectX 8 API for Freelancer. You may experience compatibility issues when using it. Supports Anisotropic Filtering.';

  // Only display the Lighting Bug Fix option if the current operating system could potentially suffer from it. If it won't, enabling this option may cause the game to not launch.
  // On top of that, the Lighting Bug isn't present on such operating systems anyway (but the stuttering bug may be).
  if HasLightingBug then
  begin
    LightingFixGraphicsApi := TRadioButton.Create(PageGraphicsApi);
    LightingFixGraphicsApi.Parent := PageGraphicsApi.Surface;
    LightingFixGraphicsApi.Top := descVanillaGraphicsApi.Top + ScaleY(37);
    LightingFixGraphicsApi.Caption := 'Vanilla Freelancer + Lighting and Stuttering fix (DirectX 8)';
    LightingFixGraphicsApi.Width := PageGraphicsApi.SurfaceWidth - ScaleX(8);

    descLightingFixGraphicsApi := TNewStaticText.Create(PageGraphicsApi);
    descLightingFixGraphicsApi.Parent := PageGraphicsApi.Surface;
    descLightingFixGraphicsApi.WordWrap := True;
    descLightingFixGraphicsApi.Top := LightingFixGraphicsApi.Top + ScaleY(15);
    descLightingFixGraphicsApi.Width := PageGraphicsApi.SurfaceWidth;
    descLightingFixGraphicsApi.Caption := 'The same as the Vanilla Freelancer option but also fixes the lighting and stuttering bugs. NOTE: This option only works on Windows 10 and 11!';
  end;
  
  // DxWrapper options
  DxWrapperPage := CreateCustomPage(
    PageGraphicsApi.ID,
    'DxWrapper options',
    txtEnhancementsPage
  );

  lblDxWrapperAa := TLabel.Create(DxWrapperPage);
  lblDxWrapperAa.Parent := DxWrapperPage.Surface;
  lblDxWrapperAa.Caption := txtAA;
  
  DxWrapperAa := TComboBox.Create(DxWrapperPage);
  DxWrapperAa.Parent := DxWrapperPage.Surface;
  DxWrapperAa.Style := csDropDownList;
  DxWrapperAa.Items.Add('Off');
  DxWrapperAa.Items.Add('2x');
  DxWrapperAa.Items.Add('4x');
  DxWrapperAa.Items.Add('8x');
  DxWrapperAa.Items.Add('Auto (recommended)');
  DxWrapperAa.Top := ScaleY(20);
  DxWrapperAa.Width := 155;

  descDxWrapperAa := TNewStaticText.Create(DxWrapperPage);
  descDxWrapperAa.Parent := DxWrapperPage.Surface;
  descDxWrapperAa.WordWrap := True;
  descDxWrapperAa.Width := DxWrapperPage.SurfaceWidth;
  descDxWrapperAa.Caption := txtAaDesc + txtAuto;
  descDxWrapperAa.Top := DxWrapperAa.Top + ScaleY(25);

  lblDxWrapperAf := TLabel.Create(DxWrapperPage);
  lblDxWrapperAf.Parent := DxWrapperPage.Surface;
  lblDxWrapperAf.Caption := TxtAf;
  lblDxWrapperAf.Top := descDxWrapperAa.Top + ScaleY(80);

  DxWrapperAf := TComboBox.Create(DxWrapperPage);
  DxWrapperAf.Parent := DxWrapperPage.Surface;
  DxWrapperAf.Style := csDropDownList;
  DxWrapperAf.Items.Add('Off');
  DxWrapperAf.Items.Add('2x');
  DxWrapperAf.Items.Add('4x');
  DxWrapperAf.Items.Add('8x');
  DxWrapperAf.Items.Add('16x');
  DxWrapperAf.Items.Add('Auto (recommended)');
  DxWrapperAf.Top := lblDxWrapperAf.Top + ScaleY(20);
  DxWrapperAf.Width := 155;

  descDxWrapperAf := TNewStaticText.Create(DxWrapperPage);
  descDxWrapperAf.Parent := DxWrapperPage.Surface;
  descDxWrapperAf.WordWrap := True;
  descDxWrapperAf.Width := DxWrapperPage.SurfaceWidth;
  descDxWrapperAf.Caption := txtAfDesc + txtAuto;
  descDxWrapperAf.Top := DxWrapperAf.Top + ScaleY(25);

  // dgVoodoo options
  DgVoodooPage := CreateCustomPage(
    DxWrapperPage.ID,
    'dgVoodoo options',
    txtEnhancementsPage
  );

  lblDgVoodooAa := TLabel.Create(DgVoodooPage);
  lblDgVoodooAa.Parent := DgVoodooPage.Surface;
  lblDgVoodooAa.Caption := txtAa;
  
  DgVoodooAa := TComboBox.Create(DgVoodooPage);
  DgVoodooAa.Parent := DgVoodooPage.Surface;
  DgVoodooAa.Style := csDropDownList;
  DgVoodooAa.Items.Add('Off');
  DgVoodooAa.Items.Add('2x');
  DgVoodooAa.Items.Add('4x');
  DgVoodooAa.Items.Add('8x (recommended)');;
  DgVoodooAa.Top := ScaleY(20);
  DgVoodooAa.Width := 155;

  descDgVoodooAa := TNewStaticText.Create(DgVoodooPage);
  descDgVoodooAa.Parent := DgVoodooPage.Surface;
  descDgVoodooAa.WordWrap := True;
  descDgVoodooAa.Width := DgVoodooPage.SurfaceWidth;
  descDgVoodooAa.Caption := txtAaDesc;
  descDgVoodooAa.Top := DgVoodooAa.Top + ScaleY(25);

  lblDgVoodooAf := TLabel.Create(DgVoodooPage);
  lblDgVoodooAf.Parent := DgVoodooPage.Surface;
  lblDgVoodooAf.Caption := txtAf;
  lblDgVoodooAf.Top := descDgVoodooAa.Top + ScaleY(55);
  
  DgVoodooAf := TComboBox.Create(DgVoodooPage);
  DgVoodooAf.Parent := DgVoodooPage.Surface;
  DgVoodooAf.Style := csDropDownList;
  DgVoodooAf.Items.Add('Off');
  DgVoodooAf.Items.Add('2x');
  DgVoodooAf.Items.Add('4x');
  DgVoodooAf.Items.Add('8x');
  DgVoodooAf.Items.Add('16x (recommended)');
  DgVoodooAf.Top := lblDgVoodooAf.Top + ScaleY(20);
  DgVoodooAf.Width := 155;

  descDgVoodooAf := TNewStaticText.Create(DgVoodooPage);
  descDgVoodooAf.Parent := DgVoodooPage.Surface;
  descDgVoodooAf.WordWrap := True;
  descDgVoodooAf.Width := DgVoodooPage.SurfaceWidth;
  descDgVoodooAf.Caption := txtAfDesc;
  descDgVoodooAf.Top := DgVoodooAf.Top + ScaleY(25);

  if GpuManufacturer = AMD then
  begin
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
    DgVoodooRefreshRate.OnKeyPress := @DigitFieldKeyPress;

    descDgVoodooRefreshRate := TNewStaticText.Create(DgVoodooPage);
    descDgVoodooRefreshRate.Parent := DgVoodooPage.Surface;
    descDgVoodooRefreshRate.WordWrap := True;
    descDgVoodooRefreshRate.Width := DgVoodooPage.SurfaceWidth;
    descDgVoodooRefreshRate.Caption := 'Enter your monitor''s refresh rate here. Freelancer will run at this refresh rate.';
    descDgVoodooRefreshRate.Top := DgVoodooRefreshRate.Top + ScaleY(25);
  end;

  // DxWrapper options #2
  DxWrapperPage2 := CreateCustomPage(
    DgVoodooPage.ID,
    'DxWrapper options #2',
    txtEnhancementsPage
  );
  
  descDxWrapperReShade := TNewStaticText.Create(DxWrapperPage2);
  descDxWrapperReShade.Parent := DxWrapperPage2.Surface;
  descDxWrapperReShade.WordWrap := True;
  descDxWrapperReShade.Top := ScaleY(20);
  descDxWrapperReShade.Width := DxWrapperPage2.SurfaceWidth;
  descDxWrapperReShade.Caption := txtReShadeDesc;
  
  DxWrapperReShade := TCheckBox.Create(DxWrapperPage2);
  DxWrapperReShade.Parent := DxWrapperPage2.Surface;
  DxWrapperReShade.Caption := txtReShade;
  DxWrapperReShade.Width := DxWrapperPage2.SurfaceWidth - ScaleX(8);
  
  descDxWrapperSaturation := TNewStaticText.Create(DxWrapperPage2);
  descDxWrapperSaturation.Parent := DxWrapperPage2.Surface;
  descDxWrapperSaturation.WordWrap := True;
  descDxWrapperSaturation.Top := descDxWrapperReShade.Top + ScaleY(78);
  descDxWrapperSaturation.Width := DxWrapperPage2.SurfaceWidth;
  descDxWrapperSaturation.Caption := txtSaturationDesc
  
  DxWrapperSaturation := TCheckBox.Create(DxWrapperPage2);
  DxWrapperSaturation.Parent := DxWrapperPage2.Surface;
  DxWrapperSaturation.Top := descDxWrapperReShade.Top + ScaleY(58);
  DxWrapperSaturation.Caption := txtSaturation;
  DxWrapperSaturation.Width := DxWrapperPage2.SurfaceWidth - ScaleX(8);

  descDxWrapperSharpening := TNewStaticText.Create(DxWrapperPage2);
  descDxWrapperSharpening.Parent := DxWrapperPage2.Surface;
  descDxWrapperSharpening.WordWrap := True;
  descDxWrapperSharpening.Top := descDxWrapperSaturation.Top + ScaleY(48);
  descDxWrapperSharpening.Width := DxWrapperPage2.SurfaceWidth;
  descDxWrapperSharpening.Caption := txtSharpeningDesc

  DxWrapperSharpening := TCheckBox.Create(DxWrapperPage2);
  DxWrapperSharpening.Parent := DxWrapperPage2.Surface;
  DxWrapperSharpening.Top := descDxWrapperSaturation.Top + ScaleY(28);
  DxWrapperSharpening.Caption := txtSharpening;
  DxWrapperSharpening.Width := DxWrapperPage2.SurfaceWidth - ScaleX(8);
  
  descDxWrapperHdr := TNewStaticText.Create(DxWrapperPage2);
  descDxWrapperHdr.Parent := DxWrapperPage2.Surface;
  descDxWrapperHdr.WordWrap := True;
  descDxWrapperHdr.Top := descDxWrapperSharpening.Top + ScaleY(48);
  descDxWrapperHdr.Width := DxWrapperPage2.SurfaceWidth;
  descDxWrapperHdr.Caption := txtHdrDesc
  
  DxWrapperHdr := TCheckBox.Create(DxWrapperPage2);
  DxWrapperHdr.Parent := DxWrapperPage2.Surface;
  DxWrapperHdr.Top := descDxWrapperSharpening.Top + ScaleY(28);
  DxWrapperHdr.Caption := txtHdr;
  DxWrapperHdr.Width := DxWrapperPage2.SurfaceWidth - ScaleX(8);

  descDxWrapperBloom := TNewStaticText.Create(DxWrapperPage2);
  descDxWrapperBloom.Parent := DxWrapperPage2.Surface;
  descDxWrapperBloom.WordWrap := True;
  descDxWrapperBloom.Top := descDxWrapperHdr.Top + ScaleY(48);
  descDxWrapperBloom.Width := DxWrapperPage2.SurfaceWidth;
  descDxWrapperBloom.Caption := txtBloomDesc
  
  DxWrapperBloom := TCheckBox.Create(DxWrapperPage2);
  DxWrapperBloom.Parent := DxWrapperPage2.Surface;
  DxWrapperBloom.Top := descDxWrapperHdr.Top + ScaleY(28);
  DxWrapperBloom.Caption := txtBloom;
  DxWrapperBloom.Width := DxWrapperPage2.SurfaceWidth - ScaleX(8);

  // dgVoodoo options #2
  DgVoodooPage2 := CreateCustomPage(
    DxWrapperPage2.ID,
    'dgVoodoo options #2',
    txtEnhancementsPage
  );

  descDgVoodooReShade := TNewStaticText.Create(DgVoodooPage2);
  descDgVoodooReShade.Parent := DgVoodooPage2.Surface;
  descDgVoodooReShade.WordWrap := True;
  descDgVoodooReShade.Top := ScaleY(20);
  descDgVoodooReShade.Width := DgVoodooPage2.SurfaceWidth;
  descDgVoodooReShade.Caption := txtReShadeDesc;
  
  DgVoodooReShade := TCheckBox.Create(DgVoodooPage2);
  DgVoodooReShade.Parent := DgVoodooPage2.Surface;
  DgVoodooReShade.Caption := txtReShade;
  DgVoodooReShade.Width := DgVoodooPage2.SurfaceWidth - ScaleX(8);
  
  descDgVoodooSaturation := TNewStaticText.Create(DgVoodooPage2);
  descDgVoodooSaturation.Parent := DgVoodooPage2.Surface;
  descDgVoodooSaturation.WordWrap := True;
  descDgVoodooSaturation.Top := descDgVoodooReShade.Top + ScaleY(78);
  descDgVoodooSaturation.Width := DgVoodooPage2.SurfaceWidth;
  descDgVoodooSaturation.Caption := txtSaturationDesc
  
  DgVoodooSaturation := TCheckBox.Create(DgVoodooPage2);
  DgVoodooSaturation.Parent := DgVoodooPage2.Surface;
  DgVoodooSaturation.Top := descDgVoodooReShade.Top + ScaleY(58);
  DgVoodooSaturation.Caption := txtSaturation;
  DgVoodooSaturation.Width := DgVoodooPage2.SurfaceWidth - ScaleX(8);

  descDgVoodooSharpening := TNewStaticText.Create(DgVoodooPage2);
  descDgVoodooSharpening.Parent := DgVoodooPage2.Surface;
  descDgVoodooSharpening.WordWrap := True;
  descDgVoodooSharpening.Top := descDgVoodooSaturation.Top + ScaleY(48);
  descDgVoodooSharpening.Width := DgVoodooPage2.SurfaceWidth;
  descDgVoodooSharpening.Caption := txtSharpeningDesc

  DgVoodooSharpening := TCheckBox.Create(DgVoodooPage2);
  DgVoodooSharpening.Parent := DgVoodooPage2.Surface;
  DgVoodooSharpening.Top := descDgVoodooSaturation.Top + ScaleY(28);
  DgVoodooSharpening.Caption := txtSharpening;
  DgVoodooSharpening.Width := DgVoodooPage2.SurfaceWidth - ScaleX(8);
  
  descDgVoodooHdr := TNewStaticText.Create(DgVoodooPage2);
  descDgVoodooHdr.Parent := DgVoodooPage2.Surface;
  descDgVoodooHdr.WordWrap := True;
  descDgVoodooHdr.Top := descDgVoodooSharpening.Top + ScaleY(48);
  descDgVoodooHdr.Width := DgVoodooPage2.SurfaceWidth;
  descDgVoodooHdr.Caption := txtHdrDesc
  
  DgVoodooHdr := TCheckBox.Create(DgVoodooPage2);
  DgVoodooHdr.Parent := DgVoodooPage2.Surface;
  DgVoodooHdr.Top := descDgVoodooSharpening.Top + ScaleY(28);
  DgVoodooHdr.Caption := txtHdr;
  DgVoodooHdr.Width := DgVoodooPage2.SurfaceWidth - ScaleX(8);
  
  descDgVoodooBloom := TNewStaticText.Create(DgVoodooPage2);
  descDgVoodooBloom.Parent := DgVoodooPage2.Surface;
  descDgVoodooBloom.WordWrap := True;
  descDgVoodooBloom.Top := descDgVoodooHdr.Top + ScaleY(48);
  descDgVoodooBloom.Width := DgVoodooPage2.SurfaceWidth;
  descDgVoodooBloom.Caption := txtBloomDesc
  
  DgVoodooBloom := TCheckBox.Create(DgVoodooPage2);
  DgVoodooBloom.Parent := DgVoodooPage2.Surface;
  DgVoodooBloom.Top := descDgVoodooHdr.Top + ScaleY(28);
  DgVoodooBloom.Caption := txtBloom;
  DgVoodooBloom.Width := DgVoodooPage2.SurfaceWidth - ScaleX(8);

  // Vanilla Graphics options
  VanillaPage := CreateCustomPage(
    DgVoodooPage2.ID,
    'Vanilla Graphics options',
    txtEnhancementsPage
  );

  lblVanillaAf := TLabel.Create(VanillaPage);
  lblVanillaAf.Parent := VanillaPage.Surface;
  lblVanillaAf.Caption := txtAf;

  VanillaAf := TComboBox.Create(VanillaPage);
  VanillaAf.Parent := VanillaPage.Surface;
  VanillaAf.Style := csDropDownList;
  VanillaAf.Items.Add('Off');
  VanillaAf.Items.Add('2x');
  VanillaAf.Items.Add('4x');
  VanillaAf.Items.Add('8x');
  VanillaAf.Items.Add('16x (recommended)');
  VanillaAf.Top := lblVanillaAf.Top + ScaleY(20);
  VanillaAf.Width := 155;

  descVanillaAf := TNewStaticText.Create(VanillaPage);
  descVanillaAf.Parent := VanillaPage.Surface;
  descVanillaAf.WordWrap := True;
  descVanillaAf.Width := VanillaPage.SurfaceWidth;
  descVanillaAf.Caption := txtAfDesc;
  descVanillaAf.Top := VanillaAf.Top + ScaleY(25);

  // Add improved reflections
  PageEffects := CreateCustomPage(
    VanillaPage.ID,
    'Add custom effects',
    'Check to install.'
  );
  
  VanillaReflections := TRadioButton.Create(PageEffects);
  VanillaReflections.Parent := PageEffects.Surface;
  VanillaReflections.Caption := 'Use vanilla reflections';
  VanillaReflections.Width := PageEffects.SurfaceWidth - ScaleX(8);

  ShinyReflections := TRadioButton.Create(PageEffects);
  ShinyReflections.Parent := PageEffects.Surface;
  ShinyReflections.Top := ScaleY(20);
  ShinyReflections.Caption := 'Use shiny reflections (recommended)';
  ShinyReflections.Width := PageEffects.SurfaceWidth - ScaleX(8);
  
  ShiniestReflections := TRadioButton.Create(PageEffects);
  ShiniestReflections.Parent := PageEffects.Surface;
  ShiniestReflections.Top := ShinyReflections.Top + ScaleY(20);
  ShiniestReflections.Caption := 'Use shiniest reflections';
  ShiniestReflections.Width := PageEffects.SurfaceWidth - ScaleX(8);
  
  descReflections := TNewStaticText.Create(PageEffects);
  descReflections.Parent := PageEffects.Surface;
  descReflections.WordWrap := True;
  descReflections.Width := PageEffects.SurfaceWidth;
  descReflections.Caption := 'This option changes the way light reflects off ships, bases, etc. The shiny option is recommended since vanilla looks quite dull. Shiniest on the other hand makes all surfaces very reflective, which most users may not like.';
  descReflections.Top := ShiniestReflections.Top + ScaleY(20);
  
  // Add new missile effects
  descMissileEffects := TNewStaticText.Create(PageEffects);
  descMissileEffects.Parent := PageEffects.Surface;
  descMissileEffects.WordWrap := True;
  descMissileEffects.Top := descReflections.Top + ScaleY(100);
  descMissileEffects.Width := PageEffects.SurfaceWidth;
  descMissileEffects.Caption := 'These options add missile, torpedo, and ship explosion effects that have a different look. The torpedo effects are a lot larger than the normal ones.';
  
  ExplosionEffects := TCheckBox.Create(PageEffects);
  ExplosionEffects.Parent := PageEffects.Surface;
  ExplosionEffects.Top := descReflections.Top + ScaleY(60);
  ExplosionEffects.Caption := 'Add custom ship explosion effects';
  ExplosionEffects.Width := PageEffects.SurfaceWidth - ScaleX(8);

  MissileEffects := TCheckBox.Create(PageEffects);
  MissileEffects.Parent := PageEffects.Surface;
  MissileEffects.Top := descReflections.Top + ScaleY(80);
  MissileEffects.Caption := 'Add custom missile and torpedo effects';
  MissileEffects.Width := PageEffects.SurfaceWidth - ScaleX(8);
  
  // Add player ship engine trails
  descEngineTrails := TNewStaticText.Create(PageEffects);
  descEngineTrails.Parent := PageEffects.Surface;
  descEngineTrails.WordWrap := True;
  descEngineTrails.Top := descMissileEffects.Top + ScaleY(67);
  descEngineTrails.Width := PageEffects.SurfaceWidth;
  descEngineTrails.Caption := 'In vanilla Freelancer, NPC ships have engine trials while player ships don''t. This option adds engine trails to all player ships.';
  
  EngineTrails := TCheckBox.Create(PageEffects);
  EngineTrails.Parent := PageEffects.Surface;
  EngineTrails.Top := descMissileEffects.Top + ScaleY(47);
  EngineTrails.Caption := 'Add player ship engine trails';
  EngineTrails.Width := PageEffects.SurfaceWidth - ScaleX(8);

  // Draw distances
  PageDrawDistances := CreateInputOptionPage(PageEffects.ID,
  'Set draw distances', 'Check to install.',
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

  // Skips
  PageSkips := CreateCustomPage(
    PageDrawDistances.ID,
    'Skippable options',
    'Want to save time?'
  );

  // Jump tunnel duration
  JumpTunnel10Sec := TRadioButton.Create(PageSkips);
  JumpTunnel10Sec.Parent := PageSkips.Surface;
  JumpTunnel10Sec.Caption := '10 second jump tunnels (Vanilla)';
  JumpTunnel10Sec.Width := PageSkips.SurfaceWidth - ScaleX(8);

  JumpTunnel5Sec := TRadioButton.Create(PageSkips);
  JumpTunnel5Sec.Parent := PageSkips.Surface;
  JumpTunnel5Sec.Top := ScaleY(20);
  JumpTunnel5Sec.Caption := '5 second jump tunnels';
  JumpTunnel5Sec.Width := PageSkips.SurfaceWidth - ScaleX(8);
  
  JumpTunnel2Sec := TRadioButton.Create(PageSkips);
  JumpTunnel2Sec.Parent := PageSkips.Surface;
  JumpTunnel2Sec.Top := JumpTunnel5Sec.Top + ScaleY(20);
  JumpTunnel2Sec.Caption := '2.5 second jump tunnels';
  JumpTunnel2Sec.Width := PageSkips.SurfaceWidth - ScaleX(8);

  JumpTunnelSkip := TRadioButton.Create(PageSkips);
  JumpTunnelSkip.Parent := PageSkips.Surface;
  JumpTunnelSkip.Top := JumpTunnel2Sec.Top + ScaleY(20);
  JumpTunnelSkip.Caption := '0 second jump tunnels (skip them entirely)';
  JumpTunnelSkip.Width := PageSkips.SurfaceWidth - ScaleX(8);
  
  descJumpTunnelDuration := TNewStaticText.Create(PageSkips);
  descJumpTunnelDuration.Parent := PageSkips.Surface;
  descJumpTunnelDuration.WordWrap := True;
  descJumpTunnelDuration.Width := PageSkips.SurfaceWidth;
  descJumpTunnelDuration.Caption := 'This option allows you to change the duration of the jump tunnels which you go through when using any jump hole or jump gate.';
  descJumpTunnelDuration.Top := JumpTunnelSkip.Top + ScaleY(20);
  
  // Skip intros
  descSkipIntros := TNewStaticText.Create(PageSkips);
  descSkipIntros.Parent := PageSkips.Surface;
  descSkipIntros.WordWrap := True;
  descSkipIntros.Top := descJumpTunnelDuration.Top + ScaleY(60);
  descSkipIntros.Width := PageSkips.SurfaceWidth;
  descSkipIntros.Caption := 'This option skips the 3 movies that play when the game starts, which include the Microsoft logo, Digital Anvil logo, and Freelancer intro.';
  
  SkipIntros := TCheckBox.Create(PageSkips);
  SkipIntros.Parent := PageSkips.Surface;
  SkipIntros.Top := descJumpTunnelDuration.Top + ScaleY(40);
  SkipIntros.Caption := 'Skip startup intros';
  SkipIntros.Width := PageSkips.SurfaceWidth - ScaleX(8);

  descSkippableCutscenes := TNewStaticText.Create(PageSkips);
  descSkippableCutscenes.Parent := PageSkips.Surface;
  descSkippableCutscenes.WordWrap := True;
  descSkippableCutscenes.Top := descSkipIntros.Top + ScaleY(60);
  descSkippableCutscenes.Width := PageSkips.SurfaceWidth;
  descSkippableCutscenes.Caption := 'Normally, the cinematics you see during the storyline cannot be skipped. This option allows you to skip them by pressing the Esc key.'
  + #13#10 + 'NOTE: This does not apply to space cutscenes; it is not possible to skip these.';

  SkippableCutscenes := TCheckBox.Create(PageSkips);
  SkippableCutscenes.Parent := PageSkips.Surface;
  SkippableCutscenes.Top := descSkipIntros.Top + ScaleY(40);
  SkippableCutscenes.Caption := 'Skip story cutscenes with Esc key';
  SkippableCutscenes.Width := PageSkips.SurfaceWidth - ScaleX(8);
  
  // Single Player Command Console
  PageMiscOptions := CreateCustomPage(
    PageSkips.ID,
    'Misc options',
    'Check to install.'
  );
  
  descSinglePlayer := TNewStaticText.Create(PageMiscOptions);
  descSinglePlayer.Parent := PageMiscOptions.Surface;
  descSinglePlayer.WordWrap := True;
  descSinglePlayer.Top := ScaleY(20);
  descSinglePlayer.Width := PageMiscOptions.SurfaceWidth;
  descSinglePlayer.Caption := 'This option provides various console commands in Single Player to directly manipulate the environment. It also allows players to own more than one ship. To use it, press Enter while in-game and type "help" for a list of available commands.';
  
  SinglePlayer := TCheckBox.Create(PageMiscOptions);
  SinglePlayer.Parent := PageMiscOptions.Surface;
  SinglePlayer.Caption := 'Single Player Command Console';
  SinglePlayer.Width := PageMiscOptions.SurfaceWidth - ScaleX(8);
  
  descBestOptions := TNewStaticText.Create(PageMiscOptions);
  descBestOptions.Parent := PageMiscOptions.Surface;
  descBestOptions.WordWrap := True;
  descBestOptions.Top := descSinglePlayer.Top + ScaleY(75);
  descBestOptions.Width := PageMiscOptions.SurfaceWidth;
  descBestOptions.Caption := 'Automatically applies the highest video options available in Freelancer. Additionally, it''ll select your monitor''s native resolution ('
    + IntToStr(DesktopRes.Width) + 'x' + IntToStr(DesktopRes.Height) + '). Freelancer usually doesn''t do any of this by default.';
  
  BestOptions := TCheckBox.Create(PageMiscOptions);
  BestOptions.Parent := PageMiscOptions.Surface;
  BestOptions.Top := descSinglePlayer.Top + ScaleY(55);
  BestOptions.Caption := 'Apply Best Video Options';
  BestOptions.Width := PageMiscOptions.SurfaceWidth - ScaleX(8);

  DisplayMode := TComboBox.Create(PageMiscOptions);
  DisplayMode.Parent := PageMiscOptions.Surface;
  DisplayMode.Style := csDropDownList;
  DisplayMode.Width := 160;
  DisplayMode.Items.Add('Fullscreen (default)');
  DisplayMode.Items.Add('Windowed');
  DisplayMode.Items.Add('Borderless Windowed');
  DisplayMode.Top := BestOptions.Top + ScaleY(75);

  lblDisplayMode := TLabel.Create(PageMiscOptions);
  lblDisplayMode.Parent := PageMiscOptions.Surface;
  lblDisplayMode.Caption := 'Display Mode';
  lblDisplayMode.Top := DisplayMode.Top;
  lblDisplayMode.Left := ScaleX(170);

  // Make Borderless Windowed the recommended and selected option on Wine to fix the Alt-Tab bug
  if IsWine then
  begin
    lblDisplayMode.Left := ScaleX(240);
    DisplayMode.Width := 230;
    DisplayMode.Items[2] := 'Borderless Windowed (recommended)';
  end;

  descDisplayMode := TNewStaticText.Create(PageMiscOptions);
  descDisplayMode.Parent := PageMiscOptions.Surface;
  descDisplayMode.WordWrap := True;
  descDisplayMode.Width := PageMiscOptions.SurfaceWidth;
  descDisplayMode.Caption := 'In both Windowed modes, the Gamma slider from the options menu won''t work. To remedy this, Gamma will be applied using ReShade, if it''s been enabled.';
  descDisplayMode.Top := lblDisplayMode.Top + ScaleY(25);

  // Windowed and borderless windowed mode should work fine on Windows due to the snapping fix
  // On Linux/Wine however, there may be issues. At the same time though, there is an Alt-Tab bug with fullscreen windowed mode
  if IsWine then
    descDisplayMode.Caption := descDisplayMode.Caption + ' On Wine there is an Alt-Tab bug when playing in Fullscreen mode. The Windowed mode options may help, but they could also cause other issues.';
  
  DoNotPauseOnAltTab := TCheckBox.Create(PageMiscOptions);
  DoNotPauseOnAltTab.Parent := PageMiscOptions.Surface;
  DoNotPauseOnAltTab.Top := descDisplayMode.Top + ScaleY(60);
  DoNotPauseOnAltTab.Caption := 'Keep Freelancer running in the background when Alt-Tabbed';
  DoNotPauseOnAltTab.Width := PageMiscOptions.SurfaceWidth - ScaleX(8);

  with DxWrapperPage do
    OnShouldSkipPage := @PageHandler_ShouldSkipPage;

  with DgVoodooPage do
    OnShouldSkipPage := @PageHandler_ShouldSkipPage;

  with DxWrapperPage2 do
    OnShouldSkipPage := @PageHandler_ShouldSkipPage;

  with DgVoodooPage2 do
    OnShouldSkipPage := @PageHandler_ShouldSkipPage;

  with VanillaPage do
    OnShouldSkipPage := @PageHandler_ShouldSkipPage;

  with DxWrapperReShade do
    OnClick := @DxWrapperReShadeCheckBoxClick;

  with DgVoodooReShade do
    OnClick := @DgVoodooReShadeCheckBoxClick;

  if IsWine then
  begin
    // Give Wine users some tips on how to avoid compatibility issues; could be useful.
    MsgBox(ExpandConstant(
      'It seems you''re using Wine. It''s possible that {#MyAppName} won''t run out of the box on your setup due to incompatibilities. From our testing, {#MyAppName} works best on Linux when the mod is installed and launched with Lutris.'
      + #13#10#13#10 + 'This installer will automatically set the "native,builtin" d3d8 override in your environment to ensure the graphics-related DLLs provided by {#MyAppName} are loaded. However, this may or may not work on your setup.'
      + #13#10#13#10 + 'If you experience crashes, bad colors, or other compatibility issues during gameplay, you may need to remove/replace/override any of the following DLLs in the EXE folder:'
      + #13#10 + 'd3d8.dll (dgVoodoo or DxWrapper)'
      + #13#10 + 'd3d9.dll (DxWrapper ReShade)'
      + #13#10 + 'dxgi.dll (dgVoodoo ReShade)'
      + #13#10 + 'dinput8.dll (DirectInput)'), mbError, MB_OK);
  end;
end;

procedure SetDefaultOptions();
begin
  CallSign.Values[0] := True;
  PitchVariations.Checked := True;
  RegeneratableShields.Checked := False;
  NoCountermeasureRightClick.Checked := True;
  AdvancedAudioOptions.Checked := False;

  // Only check the English improvements option if the user's system language is set to English or other. If otherwise, it's likely the user would want to play FL in a different language.
  EnglishImprovements.Checked := SystemLanguage = S_EnglishOrOther;
  // Only check the Russian fonts + Rus Chat option if the user's system language is set to Russian
  RussianFonts.Checked := SystemLanguage = S_Russian;

  StoryMode.ItemIndex := 0;
  LevelRequirements.Checked := False;
  NewSaveFolder.Checked := False;

  // Determine best default startup resolution based on user's screen size
  if DesktopRes.Height >= 2160 then
    StartupRes.Values[8] := True
  else if DesktopRes.Height >= 1440 then
    StartupRes.Values[6] := True
  else
    StartupRes.Values[4] := True;

  // Determine best default logo resolution based on user's screen size
  if DesktopRes.Height >= 2160 then
    LogoRes.Values[9] := True
  else if DesktopRes.Height >= 1440 then
    LogoRes.Values[7] := True
  else
    LogoRes.Values[5] := True;

  // Determine best small text fix based on user's screen size
  if DesktopRes.Height >= 2160 then
    SmallText.Values[2] := True
  else if IsWine and (DesktopRes.Height >= 1600) then
    SmallText.Values[3] := True
  else if DesktopRes.Height >= 1200 then
    SmallText.Values[1] := True
  else
    SmallText.Values[0] := True;

  // Only check the wide screen HUD option if the user's aspect ratio is 16:9 or wider
  WidescreenHud.Checked := IsResWithinAspectRatioRange(Min16by9Factor, MaxGeneralFactor);
  WeaponGroups.Checked := True;

  DarkHud.Checked := False;
  VanillaIcons.Checked := True;
  CustomNavMap.Checked := False;

  // Only check the planetscapes fix option if the user's aspect ratio is 16:9
  PlanetScape.Checked := IsResWithinAspectRatioRange(Min16by9Factor, Max16by9Factor);

  DgVoodooGraphicsApi.Checked := GpuManufacturer = NVIDIAOrOther;
  DxWrapperGraphicsApi.Checked := GpuManufacturer = AMD;

  DxWrapperAa.ItemIndex := 4;
  DxWrapperAf.ItemIndex := 5;

  DgVoodooAa.ItemIndex := 3;
  DgVoodooAf.ItemIndex := 4;

  VanillaAf.ItemIndex := 4;

  if GpuManufacturer = AMD then
    DgVoodooRefreshRate.Text := IntToStr(RefreshRate);

  DxWrapperReShade.Checked := True;
  DxWrapperSaturation.Checked := True;
  DxWrapperSharpening.Checked := True;
  DxWrapperHdr.Checked := False;
  DxWrapperBloom.Checked := False;

  DgVoodooReShade.Checked := True;
  DgVoodooSaturation.Checked := True;
  DgVoodooSharpening.Checked := True;
  DgVoodooHdr.Checked := False;
  DgVoodooBloom.Checked := False;

  ShinyReflections.Checked := True;
  ExplosionEffects.Checked := False;
  MissileEffects.Checked := False;
  EngineTrails.Checked := True;

  PageDrawDistances.Values[8] := True;

  JumpTunnel5Sec.Checked := True;
  SkipIntros.Checked := True;
  SkippableCutscenes.Checked := True;

  SinglePlayer.Checked := True;
  BestOptions.Checked := True;
  DisplayMode.ItemIndex := 0;

  if IsWine then
    DisplayMode.ItemIndex := 2
  else
    DisplayMode.ItemIndex := 0;

  DoNotPauseOnAltTab.Checked := False;
  MusicInBackground := False;
end;

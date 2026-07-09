[Code]

procedure AddToReadyMemo(var Memo: string; TextToAdd: string; NewLine: string);
begin
  if TextToAdd <> '' then
    Memo := Memo + TextToAdd + NewLine + NewLine;
end;

procedure AddInfoToMemoStr(var MemoStr: string; InfoToAdd, NewLine, Space: string);
begin
  MemoStr := MemoStr + NewLine + Space + InfoToAdd; 
end;

procedure AddChosenOptionToMemoStr(var MemoStr: string; Options: TArrayOfString; SelectedIndex: Integer; NewLine, Space: string);
var
  ActualIndex: Integer;
begin
  if (SelectedIndex >= 0) and (SelectedIndex < GetArrayLength(Options)) then
    ActualIndex := SelectedIndex
  else
  begin
    ActualIndex := 0
    DebugMsg('Chosen option index is out of bounds.');
  end;

  AddInfoToMemoStr(MemoStr, Options[ActualIndex], NewLine, Space);
end;

procedure AddCheckedOptionToMemoStr(var MemoStr: string; CheckBoxOption: TCheckBox; NewLine, Space: string);
var
  Prefix: String;
begin
  // The heavy check mark and cross mark symbols didn't work on my Linux setup (showed up as blank boxes),
  // so for Wine I added non-unicode alternatives.
  if IsWine then begin
    if CheckBoxOption.Checked then
      Prefix := './'    // Non-unicode check mark
    else
      Prefix := 'X';    // Non-unicode cross
  end else begin
    if CheckBoxOption.Checked then
      Prefix := #$2714  // Heavy check mark
    else
      Prefix := #$274C; // Cross mark
  end;
  Prefix := Prefix + ' ';

  AddInfoToMemoStr(MemoStr, Prefix + CheckBoxOption.Caption, NewLine, Space);
end;

procedure AddChosenRadioOptionToMemoStr(var MemoStr: string; RadioButtons: array of TRadioButton; NewLine, Space: string);
var
  i, SelectedIndex: Integer;
  StringsArr: TArrayOfString;
  RadioButtonsLen: LongInt;
begin
  SelectedIndex := 0;
  RadioButtonsLen := Length(RadioButtons);
  SetArrayLength(StringsArr, RadioButtonsLen);

  for i := 0 to RadioButtonsLen - 1 do begin
    StringsArr[i] := RadioButtons[i].Caption

    if RadioButtons[i].Checked then
      SelectedIndex := i;
  end;

  AddChosenOptionToMemoStr(MemoStr, StringsArr, SelectedIndex, NewLine, Space);
end;

procedure AddChosenComboBoxOptionToMemoStr(var MemoStr: string; ComboBoxOption: TComboBox; NewLine, Space: string);
var
  i: Integer;
  ItemsArr: TArrayOfString;
begin
  SetArrayLength(ItemsArr, ComboBoxOption.Items.Count)
  for i := 0 to ComboBoxOption.Items.Count - 1 do
    ItemsArr[i] := ComboBoxOption.Items[i];

  AddChosenOptionToMemoStr(MemoStr, ItemsArr, ComboBoxOption.ItemIndex, NewLine, Space);
end;

procedure AddChosenComboBoxOptionToMemo(var Memo: string; CaptionLabel: TLabel; ComboBoxOption: TComboBox; NewLine, Space: string);
var
  MemoStr: String;
begin
  MemoStr := CaptionLabel.Caption + ':';
  AddChosenComboBoxOptionToMemoStr(MemoStr, ComboBoxOption, NewLine, Space);
  AddToReadyMemo(Memo, MemoStr, NewLine);
end;

procedure AddChosenInputOptionToMemo(var Memo: string; InputPage: TInputOptionWizardPage; NewLine, Space: string);
var
  i: Integer;
  ItemsArr: TArrayOfString;
  MemoStr: String;
begin
  SetArrayLength(ItemsArr, InputPage.CheckListBox.Items.Count)
  for i := 0 to InputPage.CheckListBox.Items.Count - 1 do
    ItemsArr[i] := InputPage.CheckListBox.Items[i];

  MemoStr := InputPage.Caption + ':';
  AddChosenOptionToMemoStr(MemoStr, ItemsArr, InputPage.SelectedValueIndex, NewLine, Space);
  AddToReadyMemo(Memo, MemoStr, NewLine);
end;

// Called automatically when the Ready to Install wizard page becomes the active page.
function UpdateReadyMemo(Space, NewLine, MemoUserInfoInfo, MemoDirInfo, MemoTypeInfo, MemoComponentsInfo, MemoGroupInfo, MemoTasksInfo: String): String;
var
  VanillaDirStr, InstallationTypeStr, GameplayStr, LocalizationStr, SinglePlayerStr,
  AdvWideStr, CustomHudStr, FixClippingStr, GraphicsRendererStr, DgVoodooRefreshRateStr, ReShadeStr, CustomEffectsStr, SkipsStr, MiscStr: string;
  GraphicsRendererArr: TArrayOfString;
  GraphicsRendererSelectedIndex: Integer;
begin
  // If the express install option is checked, select the default options right before the memo page is shown.
  // Otherwise the selected options will be the ones that the user selected which may be different from the defaults.
  if ExpressInstall.Checked then
  begin
    SetDefaultOptions;
    SelectBestLanguageOptions;
  end;

  // First add the info which Inno normally shows on the ready memo page.
  // We also show the location of the selected vanilla FL installation because it's the first thing the user selected.
  Result := '';
  AddToReadyMemo(Result, MemoUserInfoInfo, NewLine);
  
  VanillaDirStr := 'Freelancer location:';
  AddInfoToMemoStr(VanillaDirStr, DataDirPage.Values[0], NewLine, Space);
  AddToReadyMemo(Result, VanillaDirStr, NewLine);
  
  AddToReadyMemo(Result, MemoDirInfo, NewLine);
  AddToReadyMemo(Result, MemoTypeInfo, NewLine);
  AddToReadyMemo(Result, MemoComponentsInfo, NewLine);
  AddToReadyMemo(Result, MemoGroupInfo, NewLine);
  AddToReadyMemo(Result, MemoTasksInfo, NewLine);


  // Add all our custom options to the memo.
  // Installation type
  InstallationTypeStr := PageInstallType.Caption + ':';
  AddChosenRadioOptionToMemoStr(InstallationTypeStr, [ExpressInstall, CustomInstall, BasicInstall], NewLine, Space);
  
  // If the user chose a basic install, then the installer doesn't change the default selection of the options.
  // Instead, it simply makes it so that the options won't be applied.
  // Therefore, the selected options printed below will not be the correct ones. Just skip them in this case.
  // This makes the most sense anyway as none of the option code will be executed, so the user isn't missing out on any information.
  if BasicInstall.Checked then begin
    AddToReadyMemo(Result, InstallationTypeStr, '');
    exit;
  end else
    AddToReadyMemo(Result, InstallationTypeStr, NewLine);

  // Single Player ID Code
  AddChosenInputOptionToMemo(Result, CallSign, NewLine, Space);

  // Gameplay customization
  GameplayStr := GameplayOptions.Caption + ':';
  
  AddCheckedOptionToMemoStr(GameplayStr, PitchVariations, NewLine, Space);
  AddCheckedOptionToMemoStr(GameplayStr, RegeneratableShields, NewLine, Space);
  AddCheckedOptionToMemoStr(GameplayStr, AdvancedAudioOptions, NewLine, Space);
  
  AddToReadyMemo(Result, GameplayStr, NewLine);
  
  
  // Localization
  LocalizationStr := PageEnglishImprovements.Caption + ':';
  
  AddCheckedOptionToMemoStr(LocalizationStr, EnglishImprovements, NewLine, Space);
  AddCheckedOptionToMemoStr(LocalizationStr, RussianFonts, NewLine, Space);

  AddToReadyMemo(Result, LocalizationStr, NewLine);
  
  
  // Single Player options
  SinglePlayerStr := PageSinglePlayer.Caption + ':';
  AddChosenComboBoxOptionToMemoStr(SinglePlayerStr, StoryMode, NewLine, Space);
  AddCheckedOptionToMemoStr(SinglePlayerStr, LevelRequirements, NewLine, Space);
  AddCheckedOptionToMemoStr(SinglePlayerStr, NewSaveFolder, NewLine, Space);
  
  AddToReadyMemo(Result, SinglePlayerStr, NewLine);
  
  
  // Startup Screen Resolution
  AddChosenInputOptionToMemo(Result, StartupRes, NewLine, Space);

  // Freelancer Logo Resolution
  AddChosenInputOptionToMemo(Result, LogoRes, NewLine, Space);
  
  // Fix small text on larger resolutions
  AddChosenInputOptionToMemo(Result, SmallText, NewLine, Space);
  
  
  // Advanced Widescreen HUD
  AdvWideStr := PageWidescreenHud.Caption + ':';
  
  AddCheckedOptionToMemoStr(AdvWideStr, WidescreenHud, NewLine, Space);
  AddCheckedOptionToMemoStr(AdvWideStr, WeaponGroups, NewLine, Space);
  AddCheckedOptionToMemoStr(AdvWideStr, TopDownTargetView, NewLine, Space);
  
  AddToReadyMemo(Result, AdvWideStr, NewLine);
  
  
  // Custom HUD, Icons, and Nav Map
  CustomHudStr := PageDarkHud.Caption + ':';
  
  AddCheckedOptionToMemoStr(CustomHudStr, DarkHud, NewLine, Space);

  AddChosenRadioOptionToMemoStr(CustomHudStr, [VanillaIcons, AlternativeIcons, FlatIcons], NewLine, Space);
  
  AddCheckedOptionToMemoStr(CustomHudStr, CustomNavMap, NewLine, Space);
  AddToReadyMemo(Result, CustomHudStr, NewLine);
  
  
  // Fix clipping with 16:9 resolution planetscapes
  FixClippingStr := PagePlanetScape.Caption + ':';
  AddCheckedOptionToMemoStr(FixClippingStr, PlanetScape, NewLine, Space);
  AddToReadyMemo(Result, FixClippingStr, NewLine);

  // Graphics Renderer
  GraphicsRendererStr := PageGraphicsApi.Caption + ':';
  GraphicsRendererArr := [DgVoodooGraphicsApi.Caption, DxWrapperGraphicsApi.Caption, VanillaGraphicsApi.Caption];
  if HasLightingBug then begin
    SetLength(GraphicsRendererArr, Length(GraphicsRendererArr) + 1)
    GraphicsRendererArr[3] := LightingFixGraphicsApi.Caption
  end;

  if DgVoodooGraphicsApi.Checked then
    GraphicsRendererSelectedIndex := 0
  else if DxWrapperGraphicsApi.Checked then
    GraphicsRendererSelectedIndex := 1
  else if VanillaGraphicsApi.Checked then
    GraphicsRendererSelectedIndex := 2
  else if HasLightingBug and LightingFixGraphicsApi.Checked then
    GraphicsRendererSelectedIndex := 3;

  AddChosenOptionToMemoStr(GraphicsRendererStr, GraphicsRendererArr, GraphicsRendererSelectedIndex, NewLine, Space);
  AddToReadyMemo(Result, GraphicsRendererStr, NewLine);

  // Graphics Renderer options
  if DgVoodooGraphicsApi.Checked then begin
    // dgVoodoo AA & AF
    AddChosenComboBoxOptionToMemo(Result, lblDgVoodooAa, DgVoodooAa, NewLine, Space);
    AddChosenComboBoxOptionToMemo(Result, lblDgVoodooAf, DgVoodooAf, NewLine, Space);

    // dgVoodoo Refresh Rate
    if GpuManufacturer = AMDOrOther then begin
      DgVoodooRefreshRateStr := lblDgVoodooRefreshRate.Caption + ':';
      AddInfoToMemoStr(DgVoodooRefreshRateStr, DgVoodooRefreshRate.Text + ' ' + lblDgVoodooRefreshRateHz.Caption, NewLine, Space);
      AddToReadyMemo(Result, DgVoodooRefreshRateStr, NewLine);
    end;

    // dgVoodoo ReShade
    ReShadeStr := DgVoodooPage.Caption + ':';
    AddCheckedOptionToMemoStr(ReShadeStr, DgVoodooReShade, NewLine, Space);

    // dgVoodoo ReShade shaders
    if DgVoodooReShade.Checked then begin
      AddCheckedOptionToMemoStr(ReShadeStr, DgVoodooSaturation, NewLine, Space);
      AddCheckedOptionToMemoStr(ReShadeStr, DgVoodooSharpening, NewLine, Space);
      AddCheckedOptionToMemoStr(ReShadeStr, DgVoodooHdr, NewLine, Space);
      AddCheckedOptionToMemoStr(ReShadeStr, DgVoodooBloom, NewLine, Space);
    end;

    AddToReadyMemo(Result, ReShadeStr, NewLine);
  end else if DxWrapperGraphicsApi.Checked then begin
    // DxWrapper AA & AF
    AddChosenComboBoxOptionToMemo(Result, lblDxWrapperAa, DxWrapperAa, NewLine, Space);
    AddChosenComboBoxOptionToMemo(Result, lblDxWrapperAf, DxWrapperAf, NewLine, Space);

    // DxWrapper ReShade
    ReShadeStr := DxWrapperPage.Caption + ':';
    AddCheckedOptionToMemoStr(ReShadeStr, DxWrapperReShade, NewLine, Space);

    // DxWrapper ReShade shaders
    if DxWrapperReShade.Checked then begin
      AddCheckedOptionToMemoStr(ReShadeStr, DxWrapperSaturation, NewLine, Space);
      AddCheckedOptionToMemoStr(ReShadeStr, DxWrapperSharpening, NewLine, Space);
      AddCheckedOptionToMemoStr(ReShadeStr, DxWrapperHdr, NewLine, Space);
      AddCheckedOptionToMemoStr(ReShadeStr, DxWrapperBloom, NewLine, Space);
    end;

    AddToReadyMemo(Result, ReShadeStr, NewLine);
  end else if (VanillaGraphicsApi.Checked) or (HasLightingBug and LightingFixGraphicsApi.Checked) then begin
    // Vanilla and Lighting Fix AA & AF
    AddChosenComboBoxOptionToMemo(Result, lblVanillaAa, VanillaAa, NewLine, Space);
    AddChosenComboBoxOptionToMemo(Result, lblVanillaAf, VanillaAf, NewLine, Space);
  end;

  // Add custom effects
  CustomEffectsStr := PageEffects.Caption + ':';

  AddChosenRadioOptionToMemoStr(CustomEffectsStr, [VanillaReflections, ShinyReflections, ShiniestReflections], NewLine, Space);

  AddCheckedOptionToMemoStr(CustomEffectsStr, ExplosionEffects, NewLine, Space);
  AddCheckedOptionToMemoStr(CustomEffectsStr, MissileEffects, NewLine, Space);

  AddCheckedOptionToMemoStr(CustomEffectsStr, EngineTrails, NewLine, Space);

  AddToReadyMemo(Result, CustomEffectsStr, NewLine);


  // Adjust draw distances
  AddChosenComboBoxOptionToMemo(Result, lblGeneralDrawDistances, GeneralDrawDistances, NewLine, Space);
  AddChosenComboBoxOptionToMemo(Result, lblEffectDrawDistances, EffectDrawDistances, NewLine, Space);
  AddChosenComboBoxOptionToMemo(Result, lblCharacterDrawDistances, CharacterDrawDistances, NewLine, Space);


  // Skippable options
  SkipsStr := PageSkips.Caption + ':';

  AddChosenRadioOptionToMemoStr(SkipsStr, [JumpTunnel10Sec, JumpTunnel5Sec, JumpTunnel2Sec, JumpTunnelSkip], NewLine, Space);

  AddCheckedOptionToMemoStr(SkipsStr, SkipIntros, NewLine, Space);
  AddCheckedOptionToMemoStr(SkipsStr, SkippableCutscenes, NewLine, Space);

  AddToReadyMemo(Result, SkipsStr, NewLine);


  // Misc options
  MiscStr := PageMiscOptions.Caption + ':';

  AddCheckedOptionToMemoStr(MiscStr, SinglePlayer, NewLine, Space);
  AddCheckedOptionToMemoStr(MiscStr, BestOptions, NewLine, Space);

  AddChosenComboBoxOptionToMemoStr(MiscStr, DisplayMode, NewLine, Space);

  AddCheckedOptionToMemoStr(MiscStr, DoNotPauseOnAltTab, NewLine, Space);

  if DoNotPauseOnAltTab.Checked and MusicInBackground then
    AddInfoToMemoStr(MiscStr, 'Play Freelancer audio in the background when Alt-Tabbed', NewLine, Space);

  AddToReadyMemo(Result, MiscStr, '');

end;

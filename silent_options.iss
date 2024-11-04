[Code]

// Returns the value of the default parameter. If the parameter is not set, DefaultValue will be returned
function GetParamInt(Name: string; DefaultValue: Integer) : Integer;
begin
  Result := StrToIntDef(ExpandConstant('{param:' + Name + '|' + IntToStr(DefaultValue) + '}'), DefaultValue);
end;

// The same as above but returns a string instead of an Integer
function GetParamStr(Name: string; DefaultValue: string) : string;
begin
  Result := ExpandConstant('{param:' + Name + '|' + DefaultValue + '}');
end;

function CmdLineParamExists(const Value: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 1 to ParamCount do
    if CompareText(ParamStr(I), Value) = 0 then
    begin
      Result := True;
      Exit;
    end;
end;

// These options are mostly for debugging
procedure SetDebugOptions();
begin
  if CmdLineParamExists('/ForceWineOff') then
    IsWine := false;
  if CmdLineParamExists('/ForceWineOn') then
    IsWine := true;

  if CmdLineParamExists('/ForceNoLightingBug') then
    HasLightingBug := false;
  if CmdLineParamExists('/ForceHasLightingBug') then
    HasLightingBug := true;

  if CmdLineParamExists('/ForceNVIDIA') then
    GpuManufacturer := NVIDIAOrOther;
  if CmdLineParamExists('/ForceAMD') then
    GpuManufacturer := AMD;

  if CmdLineParamExists('/NoMsvcRedist') then
    NoMsvcRedist := True;

  if CmdLineParamExists('/LegacyDirCpy') then
    LegacyDirCpy := True;
end;

// Parses all selected options from the command line arguments and sets them directly in the UI elements
procedure SetSilentOptions();
var
  DefaultIcons, SelectedIcons: Integer;
  DefaultGraphicsApi, SelectedGraphicsApi: Integer;
  DefaultReflections, SelectedReflections: Integer;
  DefaultJumpTunnel, SelectedJumpTunnel: Integer;
begin
  // Installation type
  if CmdLineParamExists('/NoOptions') then
    BasicInstall.Checked := True;

  // Select Freelancer installation
  DataDirPage.Values[0] := GetParamStr('VanillaFlDir', DataDirPage.Values[0]);

  // Single Player ID Code
  CallSign.SelectedValueIndex := GetParamInt('CallSign', CallSign.SelectedValueIndex);

  // More NPC voices
  PitchVariations.Checked := GetParamInt('PitchVariations', Integer(PitchVariations.Checked)) = 1;

  // Regeneratable NPC shields
  RegeneratableShields.Checked := GetParamInt('RegeneratableShields', Integer(RegeneratableShields.Checked)) = 1;

  // No Countermeasure activation on right-click
  NoCountermeasureRightClick.Checked := GetParamInt('NoCountermeasureRightClick', Integer(NoCountermeasureRightClick.Checked)) = 1;

  // Advanced audio options
  AdvancedAudioOptions.Checked := GetParamInt('AdvancedAudioOptions', Integer(AdvancedAudioOptions.Checked)) = 1;

  // Localization
  EnglishImprovements.Checked := GetParamInt('EnglishImprovements', Integer(EnglishImprovements.Checked)) = 1;
  RussianFonts.Checked := GetParamInt('RussianFonts', Integer(RussianFonts.Checked)) = 1;

  // Single Player options
  StoryMode.ItemIndex := GetParamInt('StoryMode', Integer(StoryMode.ItemIndex));
  LevelRequirements.Checked := GetParamInt('LevelRequirements', Integer(LevelRequirements.Checked)) = 1;
  NewSaveFolder.Checked := GetParamInt('NewSaveFolder', Integer(NewSaveFolder.Checked)) = 1;

  // Startup Screen Resolution
  StartupRes.SelectedValueIndex := GetParamInt('StartupRes', StartupRes.SelectedValueIndex);

  // Freelancer Logo Resolution
  LogoRes.SelectedValueIndex := GetParamInt('LogoRes', LogoRes.SelectedValueIndex);

  // Small text on larger resolutions
  SmallText.SelectedValueIndex := GetParamInt('SmallText', SmallText.SelectedValueIndex);

  // Advanced Widescreen HUD
  WidescreenHud.Checked := GetParamInt('WidescreenHud', Integer(WidescreenHud.Checked)) = 1;
  WeaponGroups.Checked := GetParamInt('WeaponGroups', Integer(WeaponGroups.Checked)) = 1;

  // Custom HUD, Icons and NavMap
  DarkHud.Checked := GetParamInt('DarkHud', Integer(DarkHud.Checked)) = 1;

  if VanillaIcons.Checked then
    DefaultIcons := 0
  else if AlternativeIcons.Checked then
    DefaultIcons := 1
  else if FlatIcons.Checked then
    DefaultIcons := 2;

  SelectedIcons := GetParamInt('Icons', DefaultIcons);

  if SelectedIcons = 0 then
    VanillaIcons.Checked := True
  else if SelectedIcons = 1 then
    AlternativeIcons.Checked := True
  else if SelectedIcons = 2 then
    FlatIcons.Checked := True;

  CustomNavMap.Checked := GetParamInt('CustomNavMap', Integer(CustomNavMap.Checked)) = 1;

  // Fix clipping with 16:9 resolution planetspaces
  PlanetScape.Checked := GetParamInt('PlanetScape', Integer(PlanetScape.Checked)) = 1;

  // Graphics API
  if DgVoodooGraphicsApi.Checked then
    DefaultGraphicsApi := 0
  else if DxWrapperGraphicsApi.Checked then
    DefaultGraphicsApi := 1
  else if VanillaGraphicsApi.Checked then
    DefaultGraphicsApi := 2
  else if HasLightingBug and LightingFixGraphicsApi.Checked then
    DefaultGraphicsApi := 3;

  SelectedGraphicsApi := GetParamInt('GraphicsApi', DefaultGraphicsApi);

  if SelectedGraphicsApi = 0 then
    DgVoodooGraphicsApi.Checked := True
  else if SelectedGraphicsApi = 1 then
    DxWrapperGraphicsApi.Checked := True
  else if SelectedGraphicsApi = 2 then
    VanillaGraphicsApi.Checked := True
  else if (SelectedGraphicsApi = 3) and HasLightingBug then
    LightingFixGraphicsApi.Checked := True;

  // dgVoodoo options
  DgVoodooAa.ItemIndex := GetParamInt('DgVoodooAa', Integer(DgVoodooAa.ItemIndex));
  DgVoodooAf.ItemIndex := GetParamInt('DgVoodooAf', Integer(DgVoodooAf.ItemIndex));

  if GpuManufacturer = AMD then
    DgVoodooRefreshRate.Text := IntToStr(GetParamInt('DgVoodooRefreshRate', StrToIntDef(DgVoodooRefreshRate.Text, RefreshRate)));

  // dgVoodoo options #2
  DgVoodooReShade.Checked := GetParamInt('DgVoodooReShade', Integer(DgVoodooReShade.Checked)) = 1;
  DgVoodooSaturation.Checked := GetParamInt('DgVoodooSaturation', Integer(DgVoodooSaturation.Checked)) = 1;
  DgVoodooSharpening.Checked := GetParamInt('DgVoodooSharpening', Integer(DgVoodooSharpening.Checked)) = 1;
  DgVoodooHdr.Checked := GetParamInt('DgVoodooHdr', Integer(DgVoodooHdr.Checked)) = 1;
  DgVoodooBloom.Checked := GetParamInt('DgVoodooBloom', Integer(DgVoodooBloom.Checked)) = 1;

  // DxWrapper options
  DxWrapperAa.ItemIndex := GetParamInt('DxWrapperAa', Integer(DxWrapperAa.ItemIndex));
  DxWrapperAf.ItemIndex := GetParamInt('DxWrapperAf', Integer(DxWrapperAf.ItemIndex));

  // DxWrapper options #2
  DxWrapperReShade.Checked := GetParamInt('DxWrapperReShade', Integer(DxWrapperReShade.Checked)) = 1;
  DxWrapperSaturation.Checked := GetParamInt('DxWrapperSaturation', Integer(DxWrapperSaturation.Checked)) = 1;
  DxWrapperSharpening.Checked := GetParamInt('DxWrapperSharpening', Integer(DxWrapperSharpening.Checked)) = 1;
  DxWrapperHdr.Checked := GetParamInt('DxWrapperHdr', Integer(DxWrapperHdr.Checked)) = 1;
  DxWrapperBloom.Checked := GetParamInt('DxWrapperBloom', Integer(DxWrapperBloom.Checked)) = 1;

  // Vanilla graphics options
  VanillaAf.ItemIndex := GetParamInt('VanillaAf', Integer(VanillaAf.ItemIndex));
  VanillaAa.ItemIndex := GetParamInt('VanillaAa', Integer(VanillaAa.ItemIndex));

  // Add custom effects
  if VanillaReflections.Checked then
    DefaultReflections := 0
  else if ShinyReflections.Checked then
    DefaultReflections := 1
  else if ShiniestReflections.Checked then
    DefaultReflections := 2;

  SelectedReflections := GetParamInt('Reflections', DefaultReflections);

  if SelectedReflections = 0 then
    VanillaReflections.Checked := True
  else if SelectedReflections = 1 then
    ShinyReflections.Checked := True
  else if SelectedReflections = 2 then
    ShiniestReflections.Checked := True;

  ExplosionEffects.Checked := GetParamInt('ExplosionEffects', Integer(ExplosionEffects.Checked)) = 1;
  MissileEffects.Checked := GetParamInt('MissileEffects', Integer(MissileEffects.Checked)) = 1;
  EngineTrails.Checked := GetParamInt('EngineTrails', Integer(EngineTrails.Checked)) = 1;

  // Set draw distances
  GeneralDrawDistances.ItemIndex := GetParamInt('GeneralDrawDistances', GeneralDrawDistances.ItemIndex);
  EffectDrawDistances.ItemIndex := GetParamInt('EffectDrawDistances', EffectDrawDistances.ItemIndex);
  CharacterDrawDistances.ItemIndex := GetParamInt('CharacterDrawDistances', CharacterDrawDistances.ItemIndex);

  // Skippable options
  SkipIntros.Checked := GetParamInt('SkipIntros', Integer(SkipIntros.Checked)) = 1;

  SkippableCutscenes.Checked := GetParamInt('SkippableCutscenes', Integer(SkippableCutscenes.Checked)) = 1;

  if JumpTunnel10Sec.Checked then
    DefaultJumpTunnel := 0
  else if JumpTunnel5Sec.Checked then
    DefaultJumpTunnel := 1
  else if JumpTunnel2Sec.Checked then
    DefaultJumpTunnel := 2
  else if JumpTunnelSkip.Checked then
    DefaultJumpTunnel := 3;

  SelectedJumpTunnel := GetParamInt('JumpTunnel', DefaultJumpTunnel);

  if SelectedJumpTunnel = 0 then
    JumpTunnel10Sec.Checked := True
  else if SelectedJumpTunnel = 1 then
    JumpTunnel5Sec.Checked := True
  else if SelectedJumpTunnel = 2 then
    JumpTunnel2Sec.Checked := True
  else if SelectedJumpTunnel = 3 then
    JumpTunnelSkip.Checked := True;

  // Misc options
  SinglePlayer.Checked := GetParamInt('SinglePlayerConsole', Integer(SinglePlayer.Checked)) = 1;
  BestOptions.Checked := GetParamInt('BestOptions', Integer(BestOptions.Checked)) = 1;
  DisplayMode.ItemIndex := GetParamInt('DisplayMode', Integer(DisplayMode.ItemIndex));
  DoNotPauseOnAltTab.Checked := GetParamInt('DoNotPauseOnAltTab', Integer(DoNotPauseOnAltTab.Checked)) = 1;
  MusicInBackground := GetParamInt('MusicInBackground', Integer(NewSaveFolder.Checked)) = 1;

end;

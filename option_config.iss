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

// Called automatically when the Ready to Install wizard page becomes the active page.
function UpdateReadyMemo(Space, NewLine, MemoUserInfoInfo, MemoDirInfo, MemoTypeInfo, MemoComponentsInfo, MemoGroupInfo, MemoTasksInfo: String): String;
var
  i: Integer;
  VanillaDirStr, InstallationTypeStr, SinglePlayerIdCodeStr, GameplayStr, LocalizationStr, SinglePlayerStr: string;
  InstallTypeNameArr, SinglePlayerIdCodeArr, StoryModeNameArr: TArrayOfString;
  InstallTypeSelectedIndex: Integer; 
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
  InstallTypeNameArr := [ExpressInstall.Caption, CustomInstall.Caption, BasicInstall.Caption];

  if ExpressInstall.Checked then
    InstallTypeSelectedIndex := 0
  else if CustomInstall.Checked then
    InstallTypeSelectedIndex := 1
  else if BasicInstall.Checked then
    InstallTypeSelectedIndex := 2;

  InstallationTypeStr := PageInstallType.Caption + ':';
  AddChosenOptionToMemoStr(InstallationTypeStr, InstallTypeNameArr, InstallTypeSelectedIndex, NewLine, Space);
  
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
  SetArrayLength(SinglePlayerIdCodeArr, CallSign.CheckListBox.Items.Count)
  for i := 0 to CallSign.CheckListBox.Items.Count - 1 do
    SinglePlayerIdCodeArr[i] := CallSign.CheckListBox.Items[i];
  
  SinglePlayerIdCodeStr := CallSign.Caption + ':';
  AddChosenOptionToMemoStr(SinglePlayerIdCodeStr, SinglePlayerIdCodeArr, CallSign.SelectedValueIndex, NewLine, Space);
  AddToReadyMemo(Result, SinglePlayerIdCodeStr, NewLine);
  
  
  // Gameplay customization
  GameplayStr := GameplayOptions.Caption + ':';
  
  AddCheckedOptionToMemoStr(GameplayStr, PitchVariations, NewLine, Space);
  AddCheckedOptionToMemoStr(GameplayStr, RegeneratableShields, NewLine, Space);
  AddCheckedOptionToMemoStr(GameplayStr, NoCountermeasureRightClick, NewLine, Space);
  AddCheckedOptionToMemoStr(GameplayStr, AdvancedAudioOptions, NewLine, Space);
  
  AddToReadyMemo(Result, GameplayStr, NewLine);
  
  
  // Localization
  LocalizationStr := PageEnglishImprovements.Caption + ':';
  
  AddCheckedOptionToMemoStr(LocalizationStr, EnglishImprovements, NewLine, Space);
  AddCheckedOptionToMemoStr(LocalizationStr, RussianFonts, NewLine, Space);

  AddToReadyMemo(Result, LocalizationStr, NewLine);
  
  
  // Single Player options
  StoryModeNameArr := [StoryMode.Items[0], StoryMode.Items[1], StoryMode.Items[2]];
  
  SinglePlayerStr := PageSinglePlayer.Caption + ':';
  AddChosenOptionToMemoStr(SinglePlayerStr, StoryModeNameArr, StoryMode.ItemIndex, NewLine, Space);
  AddCheckedOptionToMemoStr(SinglePlayerStr, LevelRequirements, NewLine, Space);
  AddCheckedOptionToMemoStr(SinglePlayerStr, NewSaveFolder, NewLine, Space);
  
  AddToReadyMemo(Result, SinglePlayerStr, '');
  
end;

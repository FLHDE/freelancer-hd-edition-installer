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

// Called automatically when the Ready to Install wizard page becomes the active page.
function UpdateReadyMemo(Space, NewLine, MemoUserInfoInfo, MemoDirInfo, MemoTypeInfo, MemoComponentsInfo, MemoGroupInfo, MemoTasksInfo: String): String;
var
  VanillaDirStr, InstallationTypeStr, SinglePlayerIdCodeStr: string;
  InstallTypeNameArr, SinglePlayerIdCodeArr: TArrayOfString;
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
  AddToReadyMemo(Result, InstallationTypeStr, NewLine);
  
  // If the user chose a basic install, then the installer doesn't change the default selection of the options.
  // Instead, it simply makes it so that the options won't be applied.
  // Therefore, the selected options printed below will not be the correct ones. Just skip them in this case.
  // This makes the most sense anyway as none of the option code will be executed, so the user isn't missing out on any information.
  if BasicInstall.Checked then
    exit;
  

  // Single Player ID Code
  SinglePlayerIdCodeArr := ['Freelancer Alpha 1-1 (Default)', 'Navy Beta 2-5', 'Bretonia Police Iota 3-4', 'Military Epsilon 11-6', 
    'Naval Forces Matsu 4-9','IMG Red 18-6', 'Kishiro Yanagi 7-3', 'Outcasts Lambda 9-12', 'Dragons Green 16-13',
    'Spa and Cruise Omega 8-0', 'Daumann Zeta 11-17', 'Bowex Delta 5-7', 'Order Omicron 0-0', 'LSF Gamma 6-9', 'Hacker Kappa 4-20'];
  
  SinglePlayerIdCodeStr := CallSign.Caption + ':';
  AddChosenOptionToMemoStr(SinglePlayerIdCodeStr, SinglePlayerIdCodeArr, CallSign.SelectedValueIndex, NewLine, Space);
  AddToReadyMemo(Result, SinglePlayerIdCodeStr, NewLine);
  
end;
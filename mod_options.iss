[Code]
// Process CallSign option. Replaces strings in freelancer.ini depending on what the user clicks
function Process_CallSign():boolean;
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
function Process_StartUpLogo():boolean;
var
  FolderPath : string;
  OldFile : string;
  NewFile : string;
begin
  FolderPath := ExpandConstant('{app}\DATA\INTERFACE\INTRO\IMAGES\');
  NewFile := FolderPath + 'startupscreen_1280.tga';
  // If not the default
  if(not StartupRes.Values[2]) then begin
    // Rename old file away
    RenameFile(NewFile,FolderPath + 'startupscreen_1280_vanilla.tga');
    // Rename the correct startup res depending on option
    if(StartupRes.Values[1]) then
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
    // Actually rename the file
    RenameFile(OldFile,NewFile);
    end
end;

// Processes the Freelancer logo option. Renames files depending on what option is selected
function Process_FreelancerLogo():boolean;
var
  FolderPath : string;
  OldFile : string;
  NewFile : string;
begin
  FolderPath := ExpandConstant('{app}\DATA\INTERFACE\INTRO\IMAGES\');
  NewFile := FolderPath + 'front_freelancerlogo.tga';
  // If not the default
  if(not LogoRes.Values[1]) then begin
    // Rename old file away
    RenameFile(NewFile,FolderPath + 'front_freelancerlogo_vanilla.tga')
    // Rename correct logo res depending on option
    if(LogoRes.Values[2]) then
      OldFile := FolderPath + 'front_freelancerlogo_960x720.tga'
    else if(LogoRes.Values[3]) then
      OldFile := FolderPath + 'front_freelancerlogo_1280x720.tga'
    else if(LogoRes.Values[4]) then
      OldFile := FolderPath + 'front_freelancerlogo_1440x1080.tga'
    else if(LogoRes.Values[5]) then
      OldFile := FolderPath + 'front_freelancerlogo_1920x1080.tga'
    else if(LogoRes.Values[6]) then
      OldFile := FolderPath + 'front_freelancerlogo_1920x1440.tga'
    else if(LogoRes.Values[7]) then
      OldFile := FolderPath + 'front_freelancerlogo_2560x1440.tga'
    else if(LogoRes.Values[8]) then
      OldFile := FolderPath + 'front_freelancerlogo_2880x2160.tga'
    else if(LogoRes.Values[9]) then
      OldFile := FolderPath + 'front_freelancerlogo_3840x2160.tga';
    // Actually rename the file
    RenameFile(OldFile,NewFile);
  end
end;

// Replaces the SmallText strings in fonts.ini
function Process_SmallText():boolean;
  var
    FilePath : string;
begin
    FilePath := ExpandConstant('{app}\DATA\FONTS\fonts.ini');

    if SmallText.Values[1] then
      FileReplaceString(FilePath,
      'nickname = NavMap1600' + #13#10 +
      'font = Agency FB' + #13#10 +
      'fixed_height = 0.015',

      'nickname = NavMap1600' + #13#10 +
      'font = Agency FB' + #13#10 +
      'fixed_height = 0.025');

    if SmallText.Values[2] then begin
      FileReplaceString(FilePath,
        'nickname = HudSmall' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = 0.03',

        'nickname = HudSmall' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = 0.029');
      FileReplaceString(FilePath,
        'nickname = Normal' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = 0.035',

        'nickname = Normal' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = 0.029');
      FileReplaceString(FilePath,
        'nickname = NavMap1600' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = 0.015',

        'nickname = NavMap1600' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = 0.025');
    end;
end;

// SinglePlayer console processing logic
function Process_Console():boolean;
begin
  if SinglePlayer.Checked then FileReplaceString(ExpandConstant('{app}\EXE\dacom.ini'),';console.dll','console.dll')
end;

// Effects processing logic
function Process_Effects():boolean;
var
  MissilePath : string;
begin
if MissileEffects.Checked then
  begin
    MissilePath := ExpandConstant('{app}\DATA\FX\WEAPONS\')
    // Rename vanilla ones
    RenameFile(MissilePath + 'br_empmissile.ale',MissilePath + 'br_empmissile_vanilla.ale')
    RenameFile(MissilePath + 'br_missile01.ale',MissilePath + 'br_missile01_vanilla.ale')
    RenameFile(MissilePath + 'br_missile02.ale',MissilePath + 'br_missile02_vanilla.ale')
    RenameFile(MissilePath + 'ku_empmissile.ale',MissilePath + 'ku_empmissile_vanilla.ale')
    RenameFile(MissilePath + 'ku_missile01.ale',MissilePath + 'ku_missile01_vanilla.ale')
    RenameFile(MissilePath + 'ku_missile02.ale',MissilePath + 'ku_missile02_vanilla.ale')
    RenameFile(MissilePath + 'ku_torpedo01.ale',MissilePath + 'ku_torpedo01_vanilla.ale')
    RenameFile(MissilePath + 'li_empmissile.ale',MissilePath + 'li_empmissile_vanilla.ale')
    RenameFile(MissilePath + 'li_missile01.ale',MissilePath + 'li_missile01_vanilla.ale')
    RenameFile(MissilePath + 'li_missile02.ale',MissilePath + 'li_missile02_vanilla.ale')
    RenameFile(MissilePath + 'li_torpedo01.ale',MissilePath + 'li_torpedo01_vanilla.ale')
    RenameFile(MissilePath + 'pi_missile01.ale',MissilePath + 'pi_missile01_vanilla.ale')
    RenameFile(MissilePath + 'pi_missile02.ale',MissilePath + 'pi_missile02_vanilla.ale')
    RenameFile(MissilePath + 'rh_empmissile.ale',MissilePath + 'rh_empmissile_vanilla.ale')
    RenameFile(MissilePath + 'rh_missile01.ale',MissilePath + 'rh_missile01_vanilla.ale')
    RenameFile(MissilePath + 'rh_missile02.ale',MissilePath + 'rh_missile02_vanilla.ale')

    // Rename new effects
    RenameFile(MissilePath + 'br_empmissile_new.ale',MissilePath + 'br_empmissile.ale')
    RenameFile(MissilePath + 'br_missile01_new.ale',MissilePath + 'br_missile01.ale')
    RenameFile(MissilePath + 'br_missile02_new.ale',MissilePath + 'br_missile02.ale')
    RenameFile(MissilePath + 'ku_empmissile_new.ale',MissilePath + 'ku_empmissile.ale')
    RenameFile(MissilePath + 'ku_missile01_new.ale',MissilePath + 'ku_missile01.ale')
    RenameFile(MissilePath + 'ku_missile02_new.ale',MissilePath + 'ku_missile02.ale')
    RenameFile(MissilePath + 'ku_torpedo01_new.ale',MissilePath + 'ku_torpedo01.ale')
    RenameFile(MissilePath + 'li_empmissile_new.ale',MissilePath + 'li_empmissile.ale')
    RenameFile(MissilePath + 'li_missile01_new.ale',MissilePath + 'li_missile01.ale')
    RenameFile(MissilePath + 'li_missile02_new.ale',MissilePath + 'li_missile02.ale')
    RenameFile(MissilePath + 'li_torpedo01_new.ale',MissilePath + 'li_torpedo01.ale')
    RenameFile(MissilePath + 'pi_missile01_new.ale',MissilePath + 'pi_missile01.ale')
    RenameFile(MissilePath + 'pi_missile02_new.ale',MissilePath + 'pi_missile02.ale')
    RenameFile(MissilePath + 'rh_empmissile_new.ale',MissilePath + 'rh_empmissile.ale')
    RenameFile(MissilePath + 'rh_missile01_new.ale',MissilePath + 'rh_missile01.ale')
    RenameFile(MissilePath + 'rh_missile02_new.ale',MissilePath + 'rh_missile02.ale')
  end;

  if ShinyReflections.Checked then begin
    RenameFile(ExpandConstant('{app}\DATA\FX\envmapbasic.mat'),ExpandConstant('{app}\DATA\FX\envmapbasic_vanilla.mat'))
    RenameFile(ExpandConstant('{app}\DATA\FX\envmapbasic_shiny.mat'),ExpandConstant('{app}\DATA\FX\envmapbasic.mat'))
  end 
  else if ShiniestReflections.Checked then begin
    RenameFile(ExpandConstant('{app}\DATA\FX\envmapbasic.mat'),ExpandConstant('{app}\DATA\FX\envmapbasic_vanilla.mat'))
    RenameFile(ExpandConstant('{app}\DATA\FX\envmapbasic_shinier.mat'),ExpandConstant('{app}\DATA\FX\envmapbasic.mat'))
  end;
  
  if EngineTrails.Checked then begin
    RenameFile(ExpandConstant('{app}\DATA\EQUIPMENT\engine_equip.ini'),ExpandConstant('{app}\DATA\EQUIPMENT\engine_equip_vanilla.ini'))
    RenameFile(ExpandConstant('{app}\DATA\EQUIPMENT\engine_equip_player_trails.ini'),ExpandConstant('{app}\DATA\EQUIPMENT\engine_equip.ini'))
  end;
end;

function Process_Planetscape():boolean;
var
  PlanetscapePath: string;
begin
  if PlanetScape.Checked then
    begin
    PlanetscapePath := ExpandConstant('{app}\DATA\SCRIPTS\BASES\')
    // Rename vanilla ones
    RenameFile(PlanetscapePath + 'br_01_cityscape_hardpoint_01.thn',PlanetscapePath + 'br_01_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'br_02_cityscape_hardpoint_01.thn',PlanetscapePath + 'br_02_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'br_03_cityscape_hardpoint_01.thn',PlanetscapePath + 'br_03_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'bw_01_cityscape_hardpoint_01.thn',PlanetscapePath + 'bw_01_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'bw_02_cityscape_hardpoint_01.thn',PlanetscapePath + 'bw_02_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'hi_01_cityscape_hardpoint_01.thn',PlanetscapePath + 'hi_01_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'hi_02_cityscape_hardpoint_01.thn',PlanetscapePath + 'hi_02_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'ku_01_cityscape_hardpoint_01.thn',PlanetscapePath + 'ku_01_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'ku_02_cityscape_hardpoint_01.thn',PlanetscapePath + 'ku_02_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'ku_03_cityscape_hardpoint_01.thn',PlanetscapePath + 'ku_03_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'li_01_cityscape_hardpoint_01.thn',PlanetscapePath + 'li_01_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'li_02_cityscape_hardpoint_01.thn',PlanetscapePath + 'li_02_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'li_03_cityscape_hardpoint_01.thn',PlanetscapePath + 'li_03_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'li_04_cityscape_hardpoint_01.thn',PlanetscapePath + 'li_04_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'rh_01_cityscape_hardpoint_01.thn',PlanetscapePath + 'rh_01_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'rh_02_cityscape_hardpoint_01.thn',PlanetscapePath + 'rh_02_cityscape_hardpoint_01_vanilla.thn')
    RenameFile(PlanetscapePath + 'rh_03_cityscape_hardpoint_01.thn',PlanetscapePath + 'rh_03_cityscape_hardpoint_01_vanilla.thn')

    // Rename new PlanetScapes
    RenameFile(PlanetscapePath + 'br_01_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'br_01_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'br_02_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'br_02_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'br_03_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'br_03_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'bw_01_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'bw_01_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'bw_02_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'bw_02_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'hi_01_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'hi_01_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'hi_02_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'hi_02_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'ku_01_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'ku_01_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'ku_02_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'ku_02_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'ku_03_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'ku_03_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'li_01_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'li_01_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'li_02_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'li_02_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'li_03_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'li_03_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'li_04_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'li_04_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'rh_01_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'rh_01_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'rh_02_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'rh_02_cityscape_hardpoint_01.thn')
    RenameFile(PlanetscapePath + 'rh_03_cityscape_hardpoint_01_169.thn',PlanetscapePath + 'rh_03_cityscape_hardpoint_01.thn')
    end;
end;

function Process_Win10():boolean;
var
  EXEPath: string;
begin
  EXEPath := ExpandConstant('{app}\EXE\');
  if Win10.Checked then RenameFile(EXEPath + 'd3d8_dgvoodoo.dll',EXEPath + 'd3d8.dll')
  else RenameFile(EXEPath + 'd3d8_dxwrapper.dll',EXEPath + 'd3d8.dll')
end;

function Process_HUD():boolean;
var
  HudShiftPath: string;
begin
  if WidescreenHud.Checked then
  begin
      HudShiftPath := ExpandConstant('{app}\DATA\INTERFACE\HudShift.ini')

      FileReplaceString(
        ExpandConstant('{app}\EXE\dacom.ini')
        ,
        ';HudFacility.dll' + #13#10 +
        ';HudWeaponGroups.dll' + #13#10 +
        ';HudTarget.dll' + #13#10 +
        ';HudStatus.dll'
        ,
        'HudFacility.dll' + #13#10 +
        ';HudWeaponGroups.dll' + #13#10 +
        'HudTarget.dll' + #13#10 +
        'HudStatus.dll'
      )

      FileReplaceString(
        HudShiftPath
        ,
        'position = 4e0a80, -0.3630, 4e0a94, -0.3025		; wireframe' + #13#10 +
        'position = 4e0fe7, -0.4105, 4e0fef, -0.3700		; TargetMinimizedFrame' + #13#10 +
        'position = 4e10ff, -0.4820, 4e1107, -0.2000		; TargetShipName' + #13#10 +
        'position = 4e1145, -0.4820, 4e1158, -0.2000' + #13#10 +
        'position = 4e1180, -0.4820, 4e1188, -0.2180		; SubtargetName' + #13#10 +
        'position = 4e11e2, -0.4820, 4e11f0, -0.2180' + #13#10 +
        'position = 4e1247, -0.2605, 4e124f, -0.2695		; TargetPreviousButton' + #13#10 +
        'position = 4e12b4, -0.2645, 4e12bc, -0.3005		; TargetNextButton' + #13#10 +
        'position = 4e175c, -0.4940, 4e1764, -0.3610		; TargetRankText'
        ,
        'position = 4e0a80, -0.1245, 4e0a94, -0.2935		; wireframe' + #13#10 +
        'position = 4e0fe7, -0.4105, 4e0fef, -0.3700		; TargetMinimizedFrame' + #13#10 +
        'position = 4e10ff, -0.2430, 4e1107, -0.2030		; TargetShipName' + #13#10 +
        'position = 4e1145, -0.2430, 4e1158, -0.2030' + #13#10 +
        'position = 4e1180, -0.2430, 4e1188, -0.2210		; SubtargetName' + #13#10 +
        'position = 4e11e2, -0.2430, 4e11f0, -0.2210' + #13#10 +
        'position = 4e1247, -0.0595, 4e124f, -0.2780		; TargetPreviousButton' + #13#10 +
        'position = 4e12b4, -0.0595, 4e12bc, -0.3090		; TargetNextButton' + #13#10 +
        'position = 4e175c, -0.2550, 4e1764, -0.3610		; TargetRankText'
      )

     FileReplaceString(HudShiftPath,'position = 4da2fa,  0.4180, 4da30e, -0.2900','position = 4da2fa,  0.1765, 4da30e, -0.3025')
     FileReplaceString(HudShiftPath,'position = 4e14db, -0.2020, 4e14e3, -0.3700		; TargetTradeButton','position = 4e14db, -0.0180, 4e14e3, -0.3700		; TargetTradeButton')

     RenameFile(ExpandConstant('{app}\DATA\INTERFACE\HUD\hud_shipinfo.cmp'),ExpandConstant('{app}\DATA\INTERFACE\HUD\hud_shipinfo_vanilla.cmp'))
     RenameFile(ExpandConstant('{app}\DATA\INTERFACE\HUD\hud_target.cmp'),ExpandConstant('{app}\DATA\INTERFACE\HUD\hud_target_vanilla.cmp'))
     RenameFile(ExpandConstant('{app}\DATA\INTERFACE\HUD\hud_shipinfo_adv_wide_hud.cmp'),ExpandConstant('{app}\DATA\INTERFACE\HUD\hud_shipinfo.cmp'))
     RenameFile(ExpandConstant('{app}\DATA\INTERFACE\HUD\hud_target_adv_wide_hud.cmp'),ExpandConstant('{app}\DATA\INTERFACE\HUD\hud_target.cmp'))
  end
end;

function Process_WeaponGroups():boolean;
var
  HudShiftPath: string;
begin
  if WeaponGroups.Checked then
  begin
      HudShiftPath := ExpandConstant('{app}\DATA\INTERFACE\HudShift.ini')

      FileReplaceString(HudShiftPath,';HudWeaponGroups = true','HudWeaponGroups = true')

      FileReplaceString(
        ExpandConstant('{app}\EXE\dacom.ini')
        ,
        ';HudWeaponGroups.dll' + #13#10
        ,
        'HudWeaponGroups.dll' + #13#10
      )
  end
end;
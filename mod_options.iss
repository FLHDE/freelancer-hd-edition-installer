[Code]
// Process CallSign option. Replaces strings in freelancer.ini depending on what the user clicks
procedure Process_CallSign();
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
  else if(CallSign.Values[11]) then // Bowex Delta 5-7
    FileReplaceString(FilePath,'DLL = callsign.dll, player 1 1-1','DLL = callsign.dll, co_be 4 5-7')
  else if(CallSign.Values[12]) then // Order Omicron 0-0
    FileReplaceString(FilePath,'DLL = callsign.dll, player 1 1-1','DLL = callsign.dll, fc_or 11 0-0')
  else if(CallSign.Values[13]) then // LSF Gamma 6-9
    FileReplaceString(FilePath,'DLL = callsign.dll, player 1 1-1','DLL = callsign.dll, li_lsf 3 6-9')
  else if(CallSign.Values[14]) then // Hacker Kappa 4-20
    FileReplaceString(FilePath,'DLL = callsign.dll, player 1 1-1','DLL = callsign.dll, fc_lh 9 4-20')
end;

procedure Process_PitchVariations();
var
  FactionPropFile : string;
  legF01NewVoiceEntries : string;
begin
  // Option must be checked
  if not PitchVariations.Checked then
    exit;

  FactionPropFile := ExpandConstant('{app}\DATA\MISSIONS\faction_prop.ini');
  legF01NewVoiceEntries := 'voice = pilot_f_leg_f01a' #13#10 'voice = pilot_f_leg_f01b';

  FileReplaceString(FactionPropFile, 'voice = pilot_f_mil_m01', 
    'voice = pilot_f_mil_m01' #13#10 
    'voice = pilot_f_mil_m01a' #13#10
    'voice = pilot_f_mil_m01b');

  FileReplaceString(FactionPropFile, 'voice = pilot_f_mil_m02', 
    'voice = pilot_f_mil_m02' #13#10 
    'voice = pilot_f_mil_m02a' #13#10
    'voice = pilot_f_mil_m02b');

  FileReplaceString(FactionPropFile, 'voice = pilot_f_leg_f01a',
    legF01NewVoiceEntries);

  FileReplaceString(FactionPropFile, 'voice = pilot_f_leg_m01', 
    'voice = pilot_f_leg_m01' #13#10 
    'voice = pilot_f_leg_m01b');

  FileReplaceString(FactionPropFile, 'voice = pilot_f_ill_m01', 
    'voice = pilot_f_ill_m01' #13#10 
    'voice = pilot_f_ill_m01b');

  FileReplaceString(FactionPropFile, 'voice = pilot_f_ill_m02', 
    'voice = pilot_f_ill_m02' #13#10 
    'voice = pilot_f_ill_m02a' #13#10
    'voice = pilot_f_ill_m02b');

  // A few hacky fixes to make sure the modified file exactly matches the old faction_prop_extended_voices.ini
  FileReplaceString(FactionPropFile, 'voice = pilot_f_leg_f01' #13#10 'mc_costume', 
    'voice = pilot_f_leg_f01' + #13#10 +
    legF01NewVoiceEntries + #13#10 + 
    'mc_costume');

  FileReplaceString(FactionPropFile, 'voice = pilot_f_leg_m01b' #13#10 'voice = pilot_f_leg_f01a', 
    'voice = pilot_f_leg_m01b' + #13#10 + 
    'voice = pilot_f_leg_f01' + #13#10 +
    'voice = pilot_f_leg_f01a');
end;

procedure Process_RegeneratableShields();
var
  LoadoutsPath : string;
begin
  LoadoutsPath := ExpandConstant('{app}\DATA\SHIPS\');

  // Option is checked
  if RegeneratableShields.Checked then
    begin
    // Rename vanilla loadouts file
    RenameFile(LoadoutsPath + 'loadouts.ini', LoadoutsPath + 'loadouts_vanilla.ini')

    // Rename regen loadouts file
    RenameFile(LoadoutsPath + 'loadouts_regen.ini', LoadoutsPath + 'loadouts.ini')
    end;
end;

procedure Process_NoCountermeasureRightClick();
var
  ExePath : string;
begin
  ExePath := ExpandConstant('{app}\EXE\Freelancer.exe');

  // Prevent Countermeasure droppers from activating on right-click if checked
  if NoCountermeasureRightClick.Checked then
  begin
    WriteHexToFile(ExePath, $12D279, '39F1740330C0C3');
    WriteHexToFile(ExePath, $1DD5A8, '79');
  end;
end;

// Gets the path of a file in the My Games\Freelancer(HD) directory
function GetOptionsPath(FileName: string): string;
var
  OptionsFolder: string;
  MyGamesFolder: string;
begin
  MyGamesFolder := ExpandConstant('{userdocs}\My Games\')

  if NewSaveFolder.Checked then
    OptionsFolder := '{#MyCustomSaveFolderName}'
  else
    OptionsFolder := 'Freelancer';

  CreateDirIfNotExists(MyGamesFolder);
  CreateDirIfNotExists(MyGamesFolder + OptionsFolder);

  Result := MyGamesFolder + OptionsFolder + '\' + FileName + '.ini'
end;

procedure Process_AdvancedAudioOptions();
var
  ExePath: string;
  OptListPath: string;
  OptionsPath, InDirectoryOptionsPath: string;
begin
  if not AdvancedAudioOptions.Checked then begin
    OptionsPath := GetOptionsPath('PerfOptions')
    InDirectoryOptionsPath := ExpandConstant('{app}\SAVE\Accts\PerfOptions.ini')

    SetSimpleAudioOptions(OptionsPath)
    SetSimpleAudioOptions(InDirectoryOptionsPath)
    exit
  end;

  ExePath := ExpandConstant('{app}\EXE\Freelancer.exe');
  OptListPath := ExpandConstant('{app}\DATA\INTERFACE\optlist.ini');

  // The hex edits must succeed, otherwise a crash will occur when adjusting the added sliders

  if WriteHexToFile(ExePath, $0B1503, '83') then // Interface volume can be controlled independently
    FileReplaceString(OptListPath, ';option = 1411, 2454, 50, true, false', 'option = 1411, 2454, 50, true, false'); // Add interface volume slider

  if WriteHexToFile(ExePath, $0B1554, '84') then // Ambient volume can be controlled independently
    FileReplaceString(OptListPath, ';option = 1412, 2455, 50, true, false', 'option = 1412, 2455, 50, true, false'); // Add ambient volume slider
end;

procedure Process_EnglishImprovements();
var
  FreelancerIntroPath: string;
  TextStringsPath: string;
  AudioPath: string;
begin
  if EnglishImprovements.Checked then
    begin
    FreelancerIntroPath := ExpandConstant('{app}\DATA\MOVIES\')
    TextStringsPath := ExpandConstant('{app}\EXE\')
    AudioPath := ExpandConstant('{app}\DATA\AUDIO\')

    // Rename vanilla intro
    RenameFile(FreelancerIntroPath + 'fl_intro.wmv', FreelancerIntroPath + 'fl_intro_vanilla.wmv')

    // Rename new HD intro
    RenameFile(FreelancerIntroPath + 'fl_intro_en_hd.wmv', FreelancerIntroPath + 'fl_intro.wmv')

    // Rename vanilla resource files
    RenameFile(TextStringsPath + 'resources.dll', TextStringsPath + 'resources_vanilla.dll')
    RenameFile(TextStringsPath + 'offerbriberesources.dll', TextStringsPath + 'offerbriberesources_vanilla.dll')
    RenameFile(TextStringsPath + 'nameresources.dll', TextStringsPath + 'nameresources_vanilla.dll')
    RenameFile(TextStringsPath + 'misctextinfo2.dll', TextStringsPath + 'misctextinfo2_vanilla.dll')
    RenameFile(TextStringsPath + 'misctext.dll', TextStringsPath + 'misctext_vanilla.dll')
    RenameFile(TextStringsPath + 'infocards.dll', TextStringsPath + 'infocards_vanilla.dll')
    RenameFile(TextStringsPath + 'equipresources.dll', TextStringsPath + 'equipresources_vanilla.dll')

    // Rename new resource files
    RenameFile(TextStringsPath + 'resources_tsr.dll', TextStringsPath + 'resources.dll')
    RenameFile(TextStringsPath + 'offerbriberesources_tsr.dll', TextStringsPath + 'offerbriberesources.dll')
    RenameFile(TextStringsPath + 'nameresources_tsr.dll', TextStringsPath + 'nameresources.dll')
    RenameFile(TextStringsPath + 'misctextinfo2_tsr.dll', TextStringsPath + 'misctextinfo2.dll')
    RenameFile(TextStringsPath + 'misctext_tsr.dll', TextStringsPath + 'misctext.dll')
    RenameFile(TextStringsPath + 'infocards_tsr.dll', TextStringsPath + 'infocards.dll')
    RenameFile(TextStringsPath + 'equipresources_tsr.dll', TextStringsPath + 'equipresources.dll')

    // Rename vanilla audio files
    RenameFile(AudioPath + 'nnvoice.utf', AudioPath + 'nnvoice_vanilla.utf')
    RenameFile(AudioPath + 'pilot_f_ill_m02.utf', AudioPath + 'pilot_f_ill_m02_vanilla.utf')
    RenameFile(AudioPath + 'pilot_f_ill_m02a.utf', AudioPath + 'pilot_f_ill_m02a_vanilla.utf')
    RenameFile(AudioPath + 'pilot_f_ill_m02b.utf', AudioPath + 'pilot_f_ill_m02b_vanilla.utf')
    RenameFile(AudioPath + 'pilot_f_leg_m01.utf', AudioPath + 'pilot_f_leg_m01_vanilla.utf')

    // Rename new audio files
    RenameFile(AudioPath + 'nnvoice_eng.utf', AudioPath + 'nnvoice.utf')
    RenameFile(AudioPath + 'pilot_f_ill_m02_eng.utf', AudioPath + 'pilot_f_ill_m02.utf')
    RenameFile(AudioPath + 'pilot_f_ill_m02a_eng.utf', AudioPath + 'pilot_f_ill_m02a.utf')
    RenameFile(AudioPath + 'pilot_f_ill_m02b_eng.utf', AudioPath + 'pilot_f_ill_m02b.utf')
    RenameFile(AudioPath + 'pilot_f_leg_m01_eng.utf', AudioPath + 'pilot_f_leg_m01.utf')

    // The hex edits below add a custom message for the "You must be on friendlier terms to purchase this." notice in the dealer menus.
    // This custom version prints the actual reputation requirement too. However, this custom IDS is only available in English.
    // If the English text fixes are disabled, it'd be possible to disable the `print_rep_requirements` option in FLSharp.ini.
    // However, it doesn't hurt to leave it on if the feature isn't used.

    // Changes the IDS of the insufficient reputation message for equipment and commodities to an IDS in controls.dll with a custom message.
    WriteHexToFile(TextStringsPath + 'Freelancer.exe', $08073C, '1E000700'); // 1E000700 = 458782 in hexadecimal

    // Changes the IDS of the insufficient reputation message for ships to an IDS in controls.dll with a custom message.
    WriteHexToFile(TextStringsPath + 'Freelancer.exe', $0B9011, '1E000700'); // 1E000700 = 458782 in hexadecimal
    end;
end;

procedure EnableOpenSP(FileName: string);
var
  NewPlayerPath: string;
  Mission13Path: string;
begin
  NewPlayerPath := ExpandConstant('{app}\EXE\newplayer.fl')
  Mission13Path := ExpandConstant('{app}\DATA\MISSIONS\M13\')

  // Ensure the mission 13 script is used when starting a new game
  FileReplaceString(NewPlayerPath, 'Mission = Mission_01a', 'Mission = Mission_13')

  // Rename vanilla mission 13 file
  RenameFile(Mission13Path + 'm13.ini', Mission13Path + 'm13_vanilla.ini')

  // Rename new open sp file
  RenameFile(Mission13Path + 'm13_opensp_' + FileName + '.ini', Mission13Path + 'm13.ini')
end;

procedure Process_SinglePlayerMode();
begin
  if StoryMode.ItemIndex = 1 then // OSP Normal selected
    EnableOpenSP('normal')
  else if StoryMode.ItemIndex = 2 then // OSP Pirate selected
    EnableOpenSP('pirate');
end;

procedure Process_NewSaveFolder();
var
  FlPlusPlusPath: string;
begin
  FlPlusPlusPath := ExpandConstant('{app}\EXE\flplusplus.ini')

  if NewSaveFolder.Checked then
    begin
    FileReplaceString(FlPlusPlusPath, 'save_folder_name = Freelancer', 'save_folder_name = {#MyCustomSaveFolderName}')

    // The automatic restart file regeneration could be turned off in this case since other mods should now no longer interfere with HDE's save folder.
    // However, the user may have manually added custom content to their HDE installation, so leave the feature on just in case.
    //FileReplaceString(FlPlusPlusPath, 'always_regenerate_restart_file = true', 'always_regenerate_restart_file = false')
    end;
end;

procedure Process_LevelRequirements();
var
  ExePath: string;
begin
  if not LevelRequirements.Checked then
    exit;

  ExePath := ExpandConstant('{app}\EXE\')

  WriteHexToFile(ExePath + 'Freelancer.exe', $080499, 'EB'); // Allows the purchase of equipment below the required level
  WriteHexToFile(ExePath + 'Freelancer.exe', $082E95, 'EB'); // Changes the display of equipment below the required level
  WriteHexToFile(ExePath + 'Freelancer.exe', $0B948D, 'EB'); // Allows the purchase of ships below the required level

  // Enable a modified version of the MP Rep plugin because the MP level requirements feature is incompatible with the above patches
  FileReplaceString(ExePath + 'dacom.ini', 'MPRep.dll', 'MPRep_no_level_reqs.dll')
end;

// Processes the Startup Logo option. Renames files depending on what option is selected
procedure Process_StartUpLogo();
var
  FolderPath : string;
  OldFile : string;
  NewFile : string;
begin
  FolderPath := ExpandConstant('{app}\DATA\INTERFACE\INTRO\IMAGES\');
  NewFile := FolderPath + 'startupscreen_1280.tga';
  // If not the default
  if not StartupRes.Values[2] then begin
    // Rename old file away
    RenameFile(NewFile, FolderPath + 'startupscreen_1280_vanilla.tga');
    // Rename the correct startup res depending on the selected option
    if StartupRes.Values[1] then // 720p 16:9
      OldFile := 'startupscreen_1280_1280x720.tga'
    else if StartupRes.Values[3] then // 1080p 4:3
      OldFile := 'startupscreen_1280_1440x1080.tga'
    else if StartupRes.Values[4] then // 1080p 16:9
      OldFile := 'startupscreen_1280_1920x1080.tga'
    else if StartupRes.Values[5] then // 1440p 4:3
      OldFile := 'startupscreen_1280_1920x1440.tga'
    else if StartupRes.Values[6] then // 1440p 16:9
      OldFile := 'startupscreen_1280_2560x1440.tga'
    else if StartupRes.Values[7] then // 2160p 4:3
      OldFile := 'startupscreen_1280_2880x2160.tga'
    else if StartupRes.Values[8] then // 2160p 16:9
      OldFile := 'startupscreen_1280_3840x2160.tga';

    // Actually rename the file
    RenameFile(FolderPath + OldFile, NewFile);
    end
end;

// Processes the Freelancer logo option. Renames files depending on what option is selected
procedure Process_FreelancerLogo();
var
  FolderPath : string;
  OldFile : string;
  NewFile : string;
begin
  FolderPath := ExpandConstant('{app}\DATA\INTERFACE\INTRO\IMAGES\');
  NewFile := FolderPath + 'front_freelancerlogo.tga';
  // If not the default
  if not LogoRes.Values[1] then begin
    // Rename old file away
    RenameFile(NewFile, FolderPath + 'front_freelancerlogo_vanilla.tga')
    // Rename correct logo res depending on option
    if LogoRes.Values[2] then // 720p 4:3
      OldFile := 'front_freelancerlogo_960x720.tga'
    else if LogoRes.Values[3] then // 720p 16:9
      OldFile := 'front_freelancerlogo_1280x720.tga'
    else if LogoRes.Values[4] then // 1440p 4:3
      OldFile := 'front_freelancerlogo_1440x1080.tga'
    else if LogoRes.Values[5] then // 1440p 16:9
      OldFile := 'front_freelancerlogo_1920x1080.tga'
    else if LogoRes.Values[6] then // 1440p 4:3
      OldFile := 'front_freelancerlogo_1920x1440.tga'
    else if LogoRes.Values[7] then // 1440p 16:9
      OldFile := 'front_freelancerlogo_2560x1440.tga'
    else if LogoRes.Values[8] then // 2160p 4:3
      OldFile := 'front_freelancerlogo_2880x2160.tga'
    else if LogoRes.Values[9] then // 2160p 16:9
      OldFile := 'front_freelancerlogo_3840x2160.tga';

    // Actually rename the file
    RenameFile(FolderPath + OldFile, NewFile);
  end
end;

// Replaces the SmallText strings in fonts.ini
procedure Process_SmallText();
  var
    FilePath : string;
    New4KHeight: string;
begin
    FilePath := ExpandConstant('{app}\DATA\FONTS\fonts.ini');

    if not SmallText.Values[0] then // Fix for all resolutions except for the default option
      FileReplaceString(FilePath,
      'nickname = NavMap1600' + #13#10 +
      'font = Agency FB' + #13#10 +
      'fixed_height = 0.015',

      'nickname = NavMap1600' + #13#10 +
      'font = Agency FB' + #13#10 +
      'fixed_height = 0.025');

    if SmallText.Values[2] or (IsWine and SmallText.Values[4]) then begin // Fix for 3840x2160 screens and 1600p screens on Wine
      // On Wine/Luris the lowered fixed_height for HudSmall and Normal is not enough to fix the missing text. Therefore, it has to be lowered even more.
      if IsWine and SmallText.Values[2] then
        New4KHeight := '0.024'
      else
        New4KHeight := '0.029';

      FileReplaceString(FilePath,
        'nickname = HudSmall' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = 0.03',

        'nickname = HudSmall' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = ' + New4KHeight);
      FileReplaceString(FilePath,
        'nickname = Normal' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = 0.035',

        'nickname = Normal' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = ' + New4KHeight);
    end
    else if SmallText.Values[3] then begin
      FileReplaceString(FilePath,
        'nickname = HudSmall' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = 0.03',

        'nickname = HudSmall' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = 0.02');
      FileReplaceString(FilePath,
        'nickname = Normal' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = 0.035',

        'nickname = Normal' + #13#10 +
        'font = Agency FB' + #13#10 +
        'fixed_height = 0.02');
    end;
end;

procedure Process_RussianFonts();
  var
    FontsPath : string;
begin
    if not RussianFonts.Checked then
      exit;

    FontsPath := ExpandConstant('{app}\DATA\FONTS\');

    // Replace all 14 occurrences of Agency FB with Agency FB Cyrillic in fonts.ini
    FileReplaceString(FontsPath + 'fonts.ini', 'Agency FB', 'Agency FB Cyrillic');

    // Replace all 6 occurrences of Agency FB with Agency FB Cyrillic in rich_fonts.ini
    FileReplaceString(FontsPath + 'rich_fonts.ini', 'Agency FB', 'Agency FB Cyrillic');

    // Make sure the Cyrillic version of the font gets auto-loaded instead of the normal one
    FileReplaceString(FontsPath + 'fonts.ini', 'path = FONTS/AGENCYR.ttf', ';path = FONTS/AGENCYR.ttf')
    FileReplaceString(FontsPath + 'fonts.ini', ';path = FONTS/AGENCYR_CR.ttf', 'path = FONTS/AGENCYR_CR.ttf')

    // Enable Rus Chat plugin
    FileReplaceString(ExpandConstant('{app}\EXE\dacom.ini'), ';rus_chat.dll', 'rus_chat.dll')
end;

// SinglePlayer console processing logic
procedure Process_Console();
begin
  if not SinglePlayer.Checked then FileReplaceString(ExpandConstant('{app}\EXE\dacom.ini'), 'console.dll', ';console.dll')
end;

procedure SetBestOptions(OptionsPath: string; PreDefinedOptionsPath: string);
begin
  // If the options file exists, apply all the best known options in that file. If it doesn't exist, copy a pre-existing file with the best options already applied.
  // When modifying the existing values, every replacement effectively comments out the previous value, causing FL to ignore it
  if FileExists(OptionsPath) then begin
    FileReplaceString(OptionsPath, 'SkipMachineWarnings=',       'SkipMachineWarnings=TRUE;')
    FileReplaceString(OptionsPath, 'DitherControl =',            'DitherControl = 1.00;')
    FileReplaceString(OptionsPath, 'MipFilterControlCallback =', 'MipFilterControlCallback = 1.00;')
    FileReplaceString(OptionsPath, 'generic_effect_perf =',      'generic_effect_perf = 1.00;')
    FileReplaceString(OptionsPath, 'Nebula =',                   'Nebula = 1.00;')
    FileReplaceString(OptionsPath, 'SunEffect =',                'SunEffect = 1.00;')
    FileReplaceString(OptionsPath, 'Asteroids =',                'Asteroids = 1.00;')
    FileReplaceString(OptionsPath, 'space_dust_detail =',        'space_dust_detail = 1.00;')
    FileReplaceString(OptionsPath, 'star_sphere =',              'star_sphere = 1.00;')
    FileReplaceString(OptionsPath, 'AtmosphereMaterialConfig =', 'AtmosphereMaterialConfig = 1.00;')
    FileReplaceString(OptionsPath, 'HUDAnimConfig =',            'HUDAnimConfig = 1.00;')
    FileReplaceString(OptionsPath, 'level_of_detail =',          'level_of_detail = 1.00;')
    FileReplaceString(OptionsPath, 'use_environment_maps =',     'use_environment_maps = 1.00;')
    FileReplaceString(OptionsPath, 'high_detail_textures =',     'high_detail_textures = 1.00;')
    FileReplaceString(OptionsPath, 'sound_max_dist_scale =',     'sound_max_dist_scale = 1.00;')
    FileReplaceString(OptionsPath, 'sound_level_of_detail =',    'sound_level_of_detail = 1.00;')
    FileReplaceString(OptionsPath, 'rtc_performance =',          'rtc_performance = 1.00;')
    FileReplaceString(OptionsPath, 'general_graphics =',         'general_graphics = 1.00;')
    FileReplaceString(OptionsPath, 'advanced_graphics =',        'advanced_graphics = 1.00;')
    FileReplaceString(OptionsPath, 'USE_DYNAMIC_COMM_HEAD =',    'USE_DYNAMIC_COMM_HEAD = 1.00;')
    FileReplaceString(OptionsPath, 'max_submitted_sounds =',     'max_submitted_sounds = 1.20;')
    FileReplaceString(OptionsPath, 'color_bpp=',                 'color_bpp= 32;')
    FileReplaceString(OptionsPath, 'depth_bpp=',                 'depth_bpp= 32;')
  end
  else
    FileCopy(PreDefinedOptionsPath, OptionsPath, false);

  // Set the user's desktop resolution as the display size in the options file
  FileReplaceString(OptionsPath, 'size=', 'size= ' + IntToStr(DesktopRes.Width) + ', ' + IntToStr(DesktopRes.Height) + ';')
end;

// Best options processing logic
procedure Process_BestOptions();
var
  OptionsPath: string;
  InDirectoryOptionsPath: string;
  PreDefinedOptionsPath: string;
begin
  if not BestOptions.Checked then
    exit;

  CreateDirIfNotExists(ExpandConstant('{app}\SAVE'))

  OptionsPath := GetOptionsPath('PerfOptions')
  InDirectoryOptionsPath := ExpandConstant('{app}\SAVE\PerfOptions.ini')
  PreDefinedOptionsPath := ExpandConstant('{tmp}\PerfOptions.ini')

  // Set the best options in both PerfOptions.ini's from the regular save folder and the in-directory save folder
  SetBestOptions(OptionsPath, PreDefinedOptionsPath);
  SetBestOptions(InDirectoryOptionsPath, PreDefinedOptionsPath);
end;

// Effects processing logic
procedure Process_Effects();
var
  MissilePath : string;
  ExplosionsPath : string;
begin
  MissilePath := ExpandConstant('{app}\DATA\FX\WEAPONS\')
  ExplosionsPath := ExpandConstant('{app}\DATA\FX\')

  if MissileEffects.Checked then
  begin
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

  if ExplosionEffects.Checked then begin
    // Rename vanilla explosions file
    RenameFile(ExplosionsPath + 'effects_explosion.ini', ExplosionsPath + 'effects_explosion_vanilla.ini')

    // Rename new explosions file
    RenameFile(ExplosionsPath + 'effects_explosion_new.ini', ExplosionsPath + 'effects_explosion.ini')
  end;

  // Rename chosen reflection file
  if ShinyReflections.Checked then begin
    RenameFile(ExpandConstant('{app}\DATA\FX\envmapbasic.mat'),ExpandConstant('{app}\DATA\FX\envmapbasic_vanilla.mat'))
    RenameFile(ExpandConstant('{app}\DATA\FX\envmapbasic_shiny.mat'),ExpandConstant('{app}\DATA\FX\envmapbasic.mat'))
  end
  else if ShiniestReflections.Checked then begin
    RenameFile(ExpandConstant('{app}\DATA\FX\envmapbasic.mat'),ExpandConstant('{app}\DATA\FX\envmapbasic_vanilla.mat'))
    RenameFile(ExpandConstant('{app}\DATA\FX\envmapbasic_shinier.mat'),ExpandConstant('{app}\DATA\FX\envmapbasic.mat'))
  end;

  // Add player engine trails
  if EngineTrails.Checked then
    FileReplaceString(ExpandConstant('{app}\DATA\EQUIPMENT\engine_equip.ini'), 'playtrail', 'trail');
end;

procedure Process_Planetscape();
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

procedure Process_DrawDistances();
var
  FilePath : string;
begin
  FilePath := ExpandConstant('{app}\EXE\flplusplus.ini');

  // Set general draw distances
  if GeneralDrawDistances.ItemIndex = 0 then // 1x (Vanilla)
    FileReplaceString(FilePath, 'lod_scale = 15', 'lod_scale = 1')
  else if GeneralDrawDistances.ItemIndex = 1 then // 2x
    FileReplaceString(FilePath, 'lod_scale = 15', 'lod_scale = 2')
  else if GeneralDrawDistances.ItemIndex = 2 then // 3x
    FileReplaceString(FilePath, 'lod_scale = 15', 'lod_scale = 3')
  else if GeneralDrawDistances.ItemIndex = 3 then // 4x
    FileReplaceString(FilePath, 'lod_scale = 15', 'lod_scale = 4')
  else if GeneralDrawDistances.ItemIndex = 4 then // 5x
    FileReplaceString(FilePath, 'lod_scale = 15', 'lod_scale = 5')
  else if GeneralDrawDistances.ItemIndex = 5 then // 6x
    FileReplaceString(FilePath, 'lod_scale = 15', 'lod_scale = 6')
  else if GeneralDrawDistances.ItemIndex = 6 then // 7x
    FileReplaceString(FilePath, 'lod_scale = 15', 'lod_scale = 7')
  else if GeneralDrawDistances.ItemIndex = 7 then // 8x
    FileReplaceString(FilePath, 'lod_scale = 15', 'lod_scale = 8')
  else if GeneralDrawDistances.ItemIndex = 8 then // 10x
    FileReplaceString(FilePath, 'lod_scale = 15', 'lod_scale = 10')
  else if GeneralDrawDistances.ItemIndex = 9 then // 12x
    FileReplaceString(FilePath, 'lod_scale = 15', 'lod_scale = 12');

  // Set effect draw distances
  if EffectDrawDistances.ItemIndex = 0 then // 1x (Vanilla)
    FileReplaceString(FilePath, 'pbubble_scale = 15', 'pbubble_scale = 1')
  else if EffectDrawDistances.ItemIndex = 1 then // 2x
    FileReplaceString(FilePath, 'pbubble_scale = 15', 'pbubble_scale = 2')
  else if EffectDrawDistances.ItemIndex = 2 then // 3x
    FileReplaceString(FilePath, 'pbubble_scale = 15', 'pbubble_scale = 3')
  else if EffectDrawDistances.ItemIndex = 3 then // 4x
    FileReplaceString(FilePath, 'pbubble_scale = 15', 'pbubble_scale = 4')
  else if EffectDrawDistances.ItemIndex = 4 then // 5x
    FileReplaceString(FilePath, 'pbubble_scale = 15', 'pbubble_scale = 5')
  else if EffectDrawDistances.ItemIndex = 5 then // 6x
    FileReplaceString(FilePath, 'pbubble_scale = 15', 'pbubble_scale = 6')
  else if EffectDrawDistances.ItemIndex = 6 then // 7x
    FileReplaceString(FilePath, 'pbubble_scale = 15', 'pbubble_scale = 7')
  else if EffectDrawDistances.ItemIndex = 7 then // 8x
    FileReplaceString(FilePath, 'pbubble_scale = 15', 'pbubble_scale = 8')
  else if EffectDrawDistances.ItemIndex = 8 then // 10x
    FileReplaceString(FilePath, 'pbubble_scale = 15', 'pbubble_scale = 10')
  else if EffectDrawDistances.ItemIndex = 9 then // 12x
    FileReplaceString(FilePath, 'pbubble_scale = 15', 'pbubble_scale = 12');

  // Set character draw distances
  if CharacterDrawDistances.ItemIndex = 0 then // 1x (Vanilla)
    FileReplaceString(FilePath, 'character_detail_scale = 15', 'character_detail_scale = 1')
  else if CharacterDrawDistances.ItemIndex = 1 then // 2x
    FileReplaceString(FilePath, 'character_detail_scale = 15', 'character_detail_scale = 2')
  else if CharacterDrawDistances.ItemIndex = 2 then // 3x
    FileReplaceString(FilePath, 'character_detail_scale = 15', 'character_detail_scale = 3')
  else if CharacterDrawDistances.ItemIndex = 3 then // 4x
    FileReplaceString(FilePath, 'character_detail_scale = 15', 'character_detail_scale = 4')
  else if CharacterDrawDistances.ItemIndex = 4 then // 5x
    FileReplaceString(FilePath, 'character_detail_scale = 15', 'character_detail_scale = 5')
  else if CharacterDrawDistances.ItemIndex = 5 then // 6x
    FileReplaceString(FilePath, 'character_detail_scale = 15', 'character_detail_scale = 6')
  else if CharacterDrawDistances.ItemIndex = 6 then // 7x
    FileReplaceString(FilePath, 'character_detail_scale = 15', 'character_detail_scale = 7')
  else if CharacterDrawDistances.ItemIndex = 7 then // 8x
    FileReplaceString(FilePath, 'character_detail_scale = 15', 'character_detail_scale = 8')
  else if CharacterDrawDistances.ItemIndex = 8 then // 10x
    FileReplaceString(FilePath, 'character_detail_scale = 15', 'character_detail_scale = 10')
  else if CharacterDrawDistances.ItemIndex = 9 then // 12x
    FileReplaceString(FilePath, 'character_detail_scale = 15', 'character_detail_scale = 12');
end;

procedure Process_Win10();
var
  EXEPath: string;
begin
  EXEPath := ExpandConstant('{app}\EXE\');

  // If a d3d8.dll already exists in the vanilla installation, rename that away because otherwise the new d3d8.dll can't be activated.
  if FileExists(EXEPath + 'd3d8.dll') then
    RenameFile(EXEPath + 'd3d8.dll', EXEPath + 'd3d8_vanilla.dll');

  // Applies the correct graphics API
  if DxWrapperGraphicsApi.Checked then
    RenameFile(EXEPath + 'd3d8_dxwrapper.dll', EXEPath + 'd3d8.dll')
  else if dgVoodooGraphicsApi.Checked then
  begin
    RenameFile(EXEPath + 'd3d8_dgvoodoo.dll', EXEPath + 'd3d8.dll')
    // Rename correct dgVoodoo files based on whether or not the user has an AMD GPU for the best compatibility
    if GpuManufacturer = AMD then
      begin
      RenameFile(EXEPath + 'd3d8_dgvoodoo_old.dll', EXEPath + 'd3d8.dll')
      RenameFile(EXEPath + 'dgVoodoo_old.conf', EXEPath + 'dgVoodoo.conf')
      RenameFile(EXEPath + 'dgVoodooCpl_old.exe', EXEPath + 'dgVoodooCpl.exe')
      RenameFile(EXEPath + 'dgVoodooCpl_new.exe', EXEPath + 'dgVoodooCpl_new_exe') // Remove extension from other exe so people don't get confused with the 2 exes
      end
    else
      begin
      RenameFile(EXEPath + 'd3d8_dgvoodoo_new.dll', EXEPath + 'd3d8.dll')
      RenameFile(EXEPath + 'dgVoodoo_new.conf', EXEPath + 'dgVoodoo.conf')
      RenameFile(EXEPath + 'dgVoodooCpl_new.exe', EXEPath + 'dgVoodooCpl.exe')
      RenameFile(EXEPath + 'dgVoodooCpl_old.exe', EXEPath + 'dgVoodooCpl_old_exe') // Remove extension from other exe so people don't get confused with the 2 exes
    end;
  end
  else if HasLightingBug and LightingFixGraphicsApi.Checked then
    RenameFile(EXEPath + 'd3d8_legacy.dll', EXEPath + 'd3d8.dll')
end;

procedure Process_HUD();
var
  InterfacePath: string;
  HudShiftPath: string;
begin
  if not WidescreenHud.Checked then
    exit;

  InterfacePath := ExpandConstant('{app}\DATA\INTERFACE\')
  HudShiftPath := InterfacePath + 'HudShift.ini'

  // Enable plugins
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

  // Adjust target and player info positions
  FileReplaceString(
    HudShiftPath
    ,
    'position = 4e0a80, -0.3630, 4e0a94, -0.3025		; wireframe' + #13#10 +
    'position = 4e0fe7, -0.4105, 4e0fef, -0.3700		; TargetMinimizedFrame' + #13#10 +
    'position = 4e10ff, -0.4820, 4e1107, -0.2000		; TargetShipName' + #13#10 +
    'position = 4e1145, -0.4820, 4e1158, -0.2000' + #13#10 +
    'position = 4e1180, -0.4820, 4e1188, -0.2180		; SubtargetName' + #13#10 +
    'position = 4e11e2, -0.4820, 4e11f0, -0.2180' + #13#10 +
    'position = 4e1247, -0.2650, 4e124f, -0.2680		; TargetPreviousButton' + #13#10 +
    'position = 4e12b4, -0.2650, 4e12bc, -0.2990		; TargetNextButton' + #13#10 +
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

  // Adjust player wireframe and request trade button positions
  FileReplaceString(HudShiftPath, 'position = 4da2fa,  0.4180, 4da30e, -0.2900', 'position = 4da2fa,  0.1765, 4da30e, -0.3025')
  FileReplaceString(HudShiftPath, 'position = 4e14db, -0.2020, 4e14e3, -0.3700		; TargetTradeButton', 'position = 4e14db, -0.0180, 4e14e3, -0.3700		; TargetTradeButton')

  // Disable the "Target View" (Alt + T) key because it's obsolete with the Adv Wide HUD
  FileReplaceString(InterfacePath + 'keylist.ini',
    '[key]' + #13#10 +
    'id = USER_SWITCH_TO_TARGET',

    ';[key]' + #13#10 +
    ';id = USER_SWITCH_TO_TARGET'
  )

  FileReplaceString(InterfacePath + 'keymap.ini',
    '[KeyCmd]' + #13#10 +
    'nickname = USER_SWITCH_TO_TARGET' + #13#10 +
    'ids_name = 458757' + #13#10 +
    'ids_info = 2409' + #13#10 +
    'state = keydown' + #13#10 +
    'key = "T", ALT',

    ';[KeyCmd]' + #13#10 +
    ';nickname = USER_SWITCH_TO_TARGET' + #13#10 +
    ';ids_name = 458757' + #13#10 +
    ';ids_info = 2409' + #13#10 +
    ';state = keydown' + #13#10 +
    ';key = "T", ALT'
  )

  FileReplaceString(InterfacePath + 'keymap.ini', 'key = USER_SWITCH_TO_TARGET', ';key = USER_SWITCH_TO_TARGET')
end;

procedure Process_DarkHud();
var
  HudPath: string;
begin
  HudPath := ExpandConstant('{app}\DATA\INTERFACE\')

  if DarkHud.Checked then
    begin
    // Rename vanilla ones
    RenameFile(HudPath + 'BASESIDE\city_maneuvertab1.cmp', HudPath + 'BASESIDE\city_maneuvertab1_vanilla.cmp')
    RenameFile(HudPath + 'BASESIDE\city_maneuvertab2.cmp', HudPath + 'BASESIDE\city_maneuvertab2_vanilla.cmp')
    RenameFile(HudPath + 'BASESIDE\city_maneuvertab3.cmp', HudPath + 'BASESIDE\city_maneuvertab3_vanilla.cmp')
    RenameFile(HudPath + 'HUD\hud_guagewindow.cmp', HudPath + 'HUD\hud_guagewindow_vanilla.cmp')
    RenameFile(HudPath + 'HUD\hud_maneuverbox1.cmp', HudPath + 'HUD\hud_maneuverbox1_vanilla.cmp')
    RenameFile(HudPath + 'HUD\hud_maneuverbox2.cmp', HudPath + 'HUD\hud_maneuverbox2_vanilla.cmp')
    RenameFile(HudPath + 'HUD\hud_maneuverbox3.cmp', HudPath + 'HUD\hud_maneuverbox3_vanilla.cmp')
    RenameFile(HudPath + 'HUD\hud_maneuverbox4.cmp', HudPath + 'HUD\hud_maneuverbox4_vanilla.cmp')
    RenameFile(HudPath + 'HUD\hud_maneuverbox5.cmp', HudPath + 'HUD\hud_maneuverbox5_vanilla.cmp')
    RenameFile(HudPath + 'HUD\hud_maneuverbox6.cmp', HudPath + 'HUD\hud_maneuverbox6_vanilla.cmp')
    RenameFile(HudPath + 'HUD\hud_maneuverbox7.cmp', HudPath + 'HUD\hud_maneuverbox7_vanilla.cmp')
    RenameFile(HudPath + 'HUD\hud_maneuverbox8.cmp', HudPath + 'HUD\hud_maneuverbox8_vanilla.cmp')
    RenameFile(HudPath + 'HUD\hud_maneuverbox9.cmp', HudPath + 'HUD\hud_maneuverbox9_vanilla.cmp')
    RenameFile(HudPath + 'HUD\hud_nnbox4.cmp', HudPath + 'HUD\hud_nnbox4_vanilla.cmp')
    RenameFile(HudPath + 'HUD\hud_nnbox5.cmp', HudPath + 'HUD\hud_nnbox5_vanilla.cmp')
    RenameFile(HudPath + 'HUD\hud_nnbox6.cmp', HudPath + 'HUD\hud_nnbox6_vanilla.cmp')
    RenameFile(HudPath + 'HUD\hud_nnbox7.cmp', HudPath + 'HUD\hud_nnbox7_vanilla.cmp')
    RenameFile(HudPath + 'HUD\hud_numberboxes.cmp', HudPath + 'HUD\hud_numberboxes_vanilla.cmp')
    RenameFile(HudPath + 'HUD\hud_shipinfo_min.cmp', HudPath + 'HUD\hud_shipinfo_min_vanilla.cmp')
    RenameFile(HudPath + 'HUD\hud_shipinfo_min.3db', HudPath + 'HUD\hud_shipinfo_min_vanilla.3db')
    RenameFile(HudPath + 'HUD\hud_steeringarrow.3db', HudPath + 'HUD\hud_steeringarrow_vanilla.3db')
    RenameFile(HudPath + 'HUD\hud_target_min.cmp', HudPath + 'HUD\hud_target_min_vanilla.cmp')
    RenameFile(HudPath + 'INTRO\OBJECTS', HudPath + 'INTRO\OBJECTS_vanilla')
    RenameFile(HudPath + 'LOADSAVE\front_button.cmp', HudPath + 'LOADSAVE\front_button_vanilla.cmp')
    RenameFile(HudPath + 'LOADSAVE\front_infowindow.cmp', HudPath + 'LOADSAVE\front_infowindow_vanilla.cmp')
    RenameFile(HudPath + 'LOADSAVE\ls_background.cmp', HudPath + 'LOADSAVE\ls_background_vanilla.cmp')
    RenameFile(HudPath + 'MULTIPLAYER\CHAT\chat_chat_textbox.cmp', HudPath + 'MULTIPLAYER\CHAT\chat_chat_textbox_vanilla.cmp')
    RenameFile(HudPath + 'MULTIPLAYER\TRADE\trade_background.cmp', HudPath + 'MULTIPLAYER\TRADE\trade_background_vanilla.cmp')
    RenameFile(HudPath + 'MULTIPLAYER\TRADE\trade_backgroundold.cmp', HudPath + 'MULTIPLAYER\TRADE\trade_backgroundold_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\CHAT\chat_background.cmp', HudPath + 'NEURONET\CHAT\chat_background_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\char_infowindow.cmp', HudPath + 'NEURONET\INVENTORY\char_infowindow_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\front_button.cmp', HudPath + 'NEURONET\INVENTORY\front_button_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\front_options_box.cmp', HudPath + 'NEURONET\INVENTORY\front_options_box_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\front_options_box2.cmp', HudPath + 'NEURONET\INVENTORY\front_options_box2_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\front_shortoptions_box.cmp', HudPath + 'NEURONET\INVENTORY\front_shortoptions_box_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\front_shortoptions_box2.cmp', HudPath + 'NEURONET\INVENTORY\front_shortoptions_box2_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\hlp_window.cmp', HudPath + 'NEURONET\INVENTORY\hlp_window_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\inv_biginforcard.cmp', HudPath + 'NEURONET\INVENTORY\inv_biginforcard_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\inv_biginforcard_center.cmp', HudPath + 'NEURONET\INVENTORY\inv_biginforcard_center_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\partitionline.3db', HudPath + 'NEURONET\INVENTORY\partitionline_vanilla.3db')
    RenameFile(HudPath + 'NEURONET\INVENTORY\repair_bakgrnd.cmp', HudPath + 'NEURONET\INVENTORY\repair_bakgrnd_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\navmap_background.cmp', HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\navmap_background_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_info.cmp', HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_info_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_navmap_left.cmp', HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_navmap_left_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_navmap_right.cmp', HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_navmap_right_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_selector.3db', HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_selector_vanilla.3db')
    RenameFile(HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_selectorhand.cmp', HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_selectorhand_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_zoomin.cmp', HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_zoomin_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_zoomout.cmp', HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_zoomout_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\NEWSVENDOR\news_background.cmp', HudPath + 'NEURONET\NEWSVENDOR\news_background_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\NEWSVENDOR\news_headlineframe.3db', HudPath + 'NEURONET\NEWSVENDOR\news_headlineframe_vanilla.3db')
    RenameFile(HudPath + 'NEURONET\NEWSVENDOR\news_headlineicon.3db', HudPath + 'NEURONET\NEWSVENDOR\news_headlineicon_vanilla.3db')
    RenameFile(HudPath + 'NEURONET\NEWSVENDOR\news_textframe.3db', HudPath + 'NEURONET\NEWSVENDOR\news_textframe_vanilla.3db')
    RenameFile(HudPath + 'NEURONET\NEWSVENDOR\news_videowindow.3db', HudPath + 'NEURONET\NEWSVENDOR\news_videowindow_vanilla.3db')
    RenameFile(HudPath + 'NEURONET\OPTIONS\alt-f4window.cmp', HudPath + 'NEURONET\OPTIONS\alt-f4window_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\OPTIONS\escapewindow.3db', HudPath + 'NEURONET\OPTIONS\escapewindow_vanilla.3db')
    RenameFile(HudPath + 'NEURONET\OPTIONS\escapewindow2.cmp', HudPath + 'NEURONET\OPTIONS\escapewindow2_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\OPTIONS\gameoverwindow.cmp', HudPath + 'NEURONET\OPTIONS\gameoverwindow_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\OPTIONS\missionfailed.cmp', HudPath + 'NEURONET\OPTIONS\missionfailed_vanilla.cmp')
    RenameFile(HudPath + 'NEURONET\errorexplanation.cmp', HudPath + 'NEURONET\errorexplanation_vanilla.cmp')
    RenameFile(HudPath + 'TEXTOFFER\conversationoffer.cmp', HudPath + 'TEXTOFFER\conversationoffer_vanilla.cmp')

    // Rename new HUD files
    RenameFile(HudPath + 'BASESIDE\city_maneuvertab1_darkhud.cmp', HudPath + 'BASESIDE\city_maneuvertab1.cmp')
    RenameFile(HudPath + 'BASESIDE\city_maneuvertab2_darkhud.cmp', HudPath + 'BASESIDE\city_maneuvertab2.cmp')
    RenameFile(HudPath + 'BASESIDE\city_maneuvertab3_darkhud.cmp', HudPath + 'BASESIDE\city_maneuvertab3.cmp')
    RenameFile(HudPath + 'HUD\hud_guagewindow_darkhud.cmp', HudPath + 'HUD\hud_guagewindow.cmp')
    RenameFile(HudPath + 'HUD\hud_maneuverbox1_darkhud.cmp', HudPath + 'HUD\hud_maneuverbox1.cmp')
    RenameFile(HudPath + 'HUD\hud_maneuverbox2_darkhud.cmp', HudPath + 'HUD\hud_maneuverbox2.cmp')
    RenameFile(HudPath + 'HUD\hud_maneuverbox3_darkhud.cmp', HudPath + 'HUD\hud_maneuverbox3.cmp')
    RenameFile(HudPath + 'HUD\hud_maneuverbox4_darkhud.cmp', HudPath + 'HUD\hud_maneuverbox4.cmp')
    RenameFile(HudPath + 'HUD\hud_maneuverbox5_darkhud.cmp', HudPath + 'HUD\hud_maneuverbox5.cmp')
    RenameFile(HudPath + 'HUD\hud_maneuverbox6_darkhud.cmp', HudPath + 'HUD\hud_maneuverbox6.cmp')
    RenameFile(HudPath + 'HUD\hud_maneuverbox7_darkhud.cmp', HudPath + 'HUD\hud_maneuverbox7.cmp')
    RenameFile(HudPath + 'HUD\hud_maneuverbox8_darkhud.cmp', HudPath + 'HUD\hud_maneuverbox8.cmp')
    RenameFile(HudPath + 'HUD\hud_maneuverbox9_darkhud.cmp', HudPath + 'HUD\hud_maneuverbox9.cmp')
    RenameFile(HudPath + 'HUD\hud_nnbox4_darkhud.cmp', HudPath + 'HUD\hud_nnbox4.cmp')
    RenameFile(HudPath + 'HUD\hud_nnbox5_darkhud.cmp', HudPath + 'HUD\hud_nnbox5.cmp')
    RenameFile(HudPath + 'HUD\hud_nnbox6_darkhud.cmp', HudPath + 'HUD\hud_nnbox6.cmp')
    RenameFile(HudPath + 'HUD\hud_nnbox7_darkhud.cmp', HudPath + 'HUD\hud_nnbox7.cmp')
    RenameFile(HudPath + 'HUD\hud_numberboxes_darkhud.cmp', HudPath + 'HUD\hud_numberboxes.cmp')
    RenameFile(HudPath + 'HUD\hud_shipinfo_min_darkhud.cmp', HudPath + 'HUD\hud_shipinfo_min.cmp')
    RenameFile(HudPath + 'HUD\hud_shipinfo_min_darkhud.3db', HudPath + 'HUD\hud_shipinfo_min.3db')
    RenameFile(HudPath + 'HUD\hud_steeringarrow_darkhud.3db', HudPath + 'HUD\hud_steeringarrow.3db')
    RenameFile(HudPath + 'HUD\hud_target_min_darkhud.cmp', HudPath + 'HUD\hud_target_min.cmp')
    RenameFile(HudPath + 'INTRO\OBJECTS_darkhud', HudPath + 'INTRO\OBJECTS')
    RenameFile(HudPath + 'LOADSAVE\front_button_darkhud.cmp', HudPath + 'LOADSAVE\front_button.cmp')
    RenameFile(HudPath + 'LOADSAVE\front_infowindow_darkhud.cmp', HudPath + 'LOADSAVE\front_infowindow.cmp')
    RenameFile(HudPath + 'LOADSAVE\ls_background_darkhud.cmp', HudPath + 'LOADSAVE\ls_background.cmp')
    RenameFile(HudPath + 'MULTIPLAYER\CHAT\chat_chat_textbox_darkhud.cmp', HudPath + 'MULTIPLAYER\CHAT\chat_chat_textbox.cmp')
    RenameFile(HudPath + 'MULTIPLAYER\TRADE\trade_background_darkhud.cmp', HudPath + 'MULTIPLAYER\TRADE\trade_background.cmp')
    RenameFile(HudPath + 'MULTIPLAYER\TRADE\trade_backgroundold_darkhud.cmp', HudPath + 'MULTIPLAYER\TRADE\trade_backgroundold.cmp')
    RenameFile(HudPath + 'NEURONET\CHAT\chat_background_darkhud.cmp', HudPath + 'NEURONET\CHAT\chat_background.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\char_infowindow_darkhud.cmp', HudPath + 'NEURONET\INVENTORY\char_infowindow.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\front_button_darkhud.cmp', HudPath + 'NEURONET\INVENTORY\front_button.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\front_options_box_darkhud.cmp', HudPath + 'NEURONET\INVENTORY\front_options_box.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\front_options_box2_darkhud.cmp', HudPath + 'NEURONET\INVENTORY\front_options_box2.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\front_shortoptions_box_darkhud.cmp', HudPath + 'NEURONET\INVENTORY\front_shortoptions_box.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\front_shortoptions_box2_darkhud.cmp', HudPath + 'NEURONET\INVENTORY\front_shortoptions_box2.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\hlp_window_darkhud.cmp', HudPath + 'NEURONET\INVENTORY\hlp_window.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\inv_biginforcard_darkhud.cmp', HudPath + 'NEURONET\INVENTORY\inv_biginforcard.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\inv_biginforcard_center_darkhud.cmp', HudPath + 'NEURONET\INVENTORY\inv_biginforcard_center.cmp')
    RenameFile(HudPath + 'NEURONET\INVENTORY\partitionline_darkhud.3db', HudPath + 'NEURONET\INVENTORY\partitionline.3db')
    RenameFile(HudPath + 'NEURONET\INVENTORY\repair_bakgrnd_darkhud.cmp', HudPath + 'NEURONET\INVENTORY\repair_bakgrnd.cmp')
    RenameFile(HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\navmap_background_darkhud.cmp', HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\navmap_background.cmp')
    RenameFile(HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_info_darkhud.cmp', HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_info.cmp')
    RenameFile(HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_navmap_left_darkhud.cmp', HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_navmap_left.cmp')
    RenameFile(HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_navmap_right_darkhud.cmp', HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_navmap_right.cmp')
    RenameFile(HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_selector_darkhud.3db', HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_selector.3db')
    RenameFile(HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_selectorhand_darkhud.cmp', HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_selectorhand.cmp')
    RenameFile(HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_zoomin_darkhud.cmp', HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_zoomin.cmp')
    RenameFile(HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_zoomout_darkhud.cmp', HudPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_zoomout.cmp')
    RenameFile(HudPath + 'NEURONET\NEWSVENDOR\news_background_darkhud.cmp', HudPath + 'NEURONET\NEWSVENDOR\news_background.cmp')
    RenameFile(HudPath + 'NEURONET\NEWSVENDOR\news_headlineframe_darkhud.3db', HudPath + 'NEURONET\NEWSVENDOR\news_headlineframe.3db')
    RenameFile(HudPath + 'NEURONET\NEWSVENDOR\news_headlineicon_darkhud.3db', HudPath + 'NEURONET\NEWSVENDOR\news_headlineicon.3db')
    RenameFile(HudPath + 'NEURONET\NEWSVENDOR\news_textframe_darkhud.3db', HudPath + 'NEURONET\NEWSVENDOR\news_textframe.3db')
    RenameFile(HudPath + 'NEURONET\NEWSVENDOR\news_videowindow_darkhud.3db', HudPath + 'NEURONET\NEWSVENDOR\news_videowindow.3db')
    RenameFile(HudPath + 'NEURONET\OPTIONS\alt-f4window_darkhud.cmp', HudPath + 'NEURONET\OPTIONS\alt-f4window.cmp')
    RenameFile(HudPath + 'NEURONET\OPTIONS\escapewindow_darkhud.3db', HudPath + 'NEURONET\OPTIONS\escapewindow.3db')
    RenameFile(HudPath + 'NEURONET\OPTIONS\escapewindow2_darkhud.cmp', HudPath + 'NEURONET\OPTIONS\escapewindow2.cmp')
    RenameFile(HudPath + 'NEURONET\OPTIONS\gameoverwindow_darkhud.cmp', HudPath + 'NEURONET\OPTIONS\gameoverwindow.cmp')
    RenameFile(HudPath + 'NEURONET\OPTIONS\missionfailed_darkhud.cmp', HudPath + 'NEURONET\OPTIONS\missionfailed.cmp')
    RenameFile(HudPath + 'NEURONET\errorexplanation_darkhud.cmp', HudPath + 'NEURONET\errorexplanation.cmp')
    RenameFile(HudPath + 'TEXTOFFER\conversationoffer_darkhud.cmp', HudPath + 'TEXTOFFER\conversationoffer.cmp')

    RenameFile(HudPath + 'HUD\hud_shipinfo.cmp', HudPath + 'HUD\hud_shipinfo_vanilla.cmp')
    RenameFile(HudPath + 'HUD\hud_target.cmp', HudPath + 'HUD\hud_target_vanilla.cmp')

    if WidescreenHud.Checked then
      begin
        // If both the wide and dark hud have been enabled, use a merged version
        RenameFile(HudPath + 'HUD\hud_shipinfo_adv_wide_hud_darkhud.cmp', HudPath + 'HUD\hud_shipinfo.cmp')
        RenameFile(HudPath + 'HUD\hud_target_adv_wide_hud_darkhud.cmp', HudPath + 'HUD\hud_target.cmp')
      end
    else
      begin
        // If only the dark hud has been enabled, just use that
        RenameFile(HudPath + 'HUD\hud_shipinfo_darkhud.cmp', HudPath + 'HUD\hud_shipinfo.cmp')
        RenameFile(HudPath + 'HUD\hud_target_darkhud.cmp', HudPath + 'HUD\hud_target.cmp')
      end;
  end
  else if WidescreenHud.Checked then
    begin
      // If only the adv wide hud has been enabled, just use that
      RenameFile(HudPath + 'HUD\hud_shipinfo.cmp', HudPath + 'HUD\hud_shipinfo_vanilla.cmp')
      RenameFile(HudPath + 'HUD\hud_target.cmp', HudPath + 'HUD\hud_target_vanilla.cmp')

      RenameFile(HudPath + 'HUD\hud_shipinfo_adv_wide_hud.cmp', HudPath + 'HUD\hud_shipinfo.cmp')
      RenameFile(HudPath + 'HUD\hud_target_adv_wide_hud.cmp', HudPath + 'HUD\hud_target.cmp')
    end
end;

procedure Process_CustomIcons();
var
  IconsPath: string;
  CursorPath: string;
  HudShiftPath: string;
  IconName: string;
begin
  if VanillaIcons.Checked then
    exit;

  IconsPath := ExpandConstant('{app}\DATA\INTERFACE\')
  CursorPath := ExpandConstant('{app}\DATA\SCREENS\')
  HudShiftPath := ExpandConstant('{app}\DATA\INTERFACE\HudShift.ini')

  if FlatIcons.Checked then
  begin
    IconName := 'flaticons'

    // Rename vanilla icon files that are only replaced by the flat icons
    RenameFile(IconsPath + 'HUD\hud_damagebottom.3db', IconsPath + 'HUD\hud_damagebottom_vanilla.3db')
    RenameFile(IconsPath + 'HUD\hud_damageleft.3db', IconsPath + 'HUD\hud_damageleft_vanilla.3db')
    RenameFile(IconsPath + 'HUD\hud_damageright.3db', IconsPath + 'HUD\hud_damageright_vanilla.3db')
    RenameFile(IconsPath + 'HUD\hud_damagetop.3db', IconsPath + 'HUD\hud_damagetop_vanilla.3db')
    RenameFile(IconsPath + 'HUD\hud_grouprequest.3db', IconsPath + 'HUD\hud_grouprequest_vanilla.3db')
    RenameFile(IconsPath + 'HUD\hud_infocard.3db', IconsPath + 'HUD\hud_infocard_vanilla.3db')
    RenameFile(IconsPath + 'HUD\hud_trade.3db', IconsPath + 'HUD\hud_trade_vanilla.3db')
    RenameFile(IconsPath + 'NEURONET\INVENTORY\question.3db', IconsPath + 'NEURONET\INVENTORY\question_vanilla.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_allzonefilter.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_allzonefilter_vanilla.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_filter_physical.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_filter_physical_vanilla.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_filter_political.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_filter_political_vanilla.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_friendlyzonefilter.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_friendlyzonefilter_vanilla.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_hostilezonefilter.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_hostilezonefilter_vanilla.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_knownbases.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_knownbases_vanilla.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_labels.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_labels_vanilla.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_legendtoggle.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_legendtoggle_vanilla.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_minablezonefilter.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_minablezonefilter_vanilla.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_patrol.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_patrol_vanilla.3db')

    // Rename new flat icon files
    RenameFile(IconsPath + 'HUD\hud_damagebottom_' + IconName + '.3db', IconsPath + 'HUD\hud_damagebottom.3db')
    RenameFile(IconsPath + 'HUD\hud_damageleft_' + IconName + '.3db', IconsPath + 'HUD\hud_damageleft.3db')
    RenameFile(IconsPath + 'HUD\hud_damageright_' + IconName + '.3db', IconsPath + 'HUD\hud_damageright.3db')
    RenameFile(IconsPath + 'HUD\hud_damagetop_' + IconName + '.3db', IconsPath + 'HUD\hud_damagetop.3db')
    RenameFile(IconsPath + 'HUD\hud_grouprequest_' + IconName + '.3db', IconsPath + 'HUD\hud_grouprequest.3db')
    RenameFile(IconsPath + 'HUD\hud_infocard_' + IconName + '.3db', IconsPath + 'HUD\hud_infocard.3db')
    RenameFile(IconsPath + 'HUD\hud_trade_' + IconName + '.3db', IconsPath + 'HUD\hud_trade.3db')
    RenameFile(IconsPath + 'NEURONET\INVENTORY\question_' + IconName + '.3db', IconsPath + 'NEURONET\INVENTORY\question.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_allzonefilter_' + IconName + '.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_allzonefilter.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_filter_physical_' + IconName + '.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_filter_physical.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_filter_political_' + IconName + '.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_filter_political.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_friendlyzonefilter_' + IconName + '.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_friendlyzonefilter.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_hostilezonefilter_' + IconName + '.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_hostilezonefilter.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_knownbases_' + IconName + '.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_knownbases.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_labels_' + IconName + '.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_labels.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_legendtoggle_' + IconName + '.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_legendtoggle.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_minablezonefilter_' + IconName + '.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_minablezonefilter.3db')
    RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_patrol_' + IconName + '.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_patrol.3db')

    // Adjust next and previous target buttons slightly to position them correctly (those flat icons specifically have a slight offset from the vanilla positions.)
    if WidescreenHud.Checked then
      begin
        FileReplaceString(HudShiftPath, 'position = 4e1247, -0.0595, 4e124f, -0.2780		; TargetPreviousButton',  'position = 4e1247, -0.0565, 4e124f, -0.2780		; TargetPreviousButton')
        FileReplaceString(HudShiftPath, 'position = 4e12b4, -0.0595, 4e12bc, -0.3090		; TargetNextButton',      'position = 4e12b4, -0.0555, 4e12bc, -0.3090		; TargetNextButton')
      end
    else
      begin
        FileReplaceString(HudShiftPath, 'position = 4e1247, -0.2650, 4e124f, -0.2680		; TargetPreviousButton',  'position = 4e1247, -0.2620, 4e124f, -0.2680		; TargetPreviousButton')
        FileReplaceString(HudShiftPath, 'position = 4e12b4, -0.2650, 4e12bc, -0.2990		; TargetNextButton',      'position = 4e12b4, -0.2610, 4e12bc, -0.2990		; TargetNextButton')
      end
  end
  else
  begin
    IconName := 'alt';

    // Rename vanilla icon files only replaced by the alternative icons
    RenameFile(IconsPath + 'HUD\hud_radiationalert.3db', IconsPath + 'HUD\hud_radiationalert_vanilla.3db')

    // Rename icon files only used by the alternative icons
    RenameFile(IconsPath + 'HUD\hud_radiationalert_' + IconName + '.3db', IconsPath + 'HUD\hud_radiationalert.3db')
  end;

  // Rename vanilla icon files that will be replaced by both the alternative and flat icons
  RenameFile(CursorPath + 'cursor.txm', CursorPath + 'cursor_vanilla.txm')
  RenameFile(IconsPath + 'buttontextures.txm', IconsPath + 'buttontextures_vanilla.txm')
  RenameFile(IconsPath + 'BASESIDE\bar.3db', IconsPath + 'BASESIDE\bar_vanilla.3db')
  RenameFile(IconsPath + 'BASESIDE\cityscape.3db', IconsPath + 'BASESIDE\cityscape_vanilla.3db')
  RenameFile(IconsPath + 'BASESIDE\commod_trader.3db', IconsPath + 'BASESIDE\commod_trader_vanilla.3db')
  RenameFile(IconsPath + 'BASESIDE\deck.3db', IconsPath + 'BASESIDE\deck_vanilla.3db')
  RenameFile(IconsPath + 'BASESIDE\equipment_dealer.3db', IconsPath + 'BASESIDE\equipment_dealer_vanilla.3db')
  RenameFile(IconsPath + 'BASESIDE\equiproomarrow.3db', IconsPath + 'BASESIDE\equiproomarrow_vanilla.3db')
  RenameFile(IconsPath + 'BASESIDE\frontdesk.3db', IconsPath + 'BASESIDE\frontdesk_vanilla.3db')
  RenameFile(IconsPath + 'BASESIDE\mission_vendor.3db', IconsPath + 'BASESIDE\mission_vendor_vanilla.3db')
  RenameFile(IconsPath + 'BASESIDE\news_vendor.3db', IconsPath + 'BASESIDE\news_vendor_vanilla.3db')
  RenameFile(IconsPath + 'BASESIDE\repair.3db', IconsPath + 'BASESIDE\repair_vanilla.3db')
  RenameFile(IconsPath + 'BASESIDE\salesman.3db', IconsPath + 'BASESIDE\salesman_vanilla.3db')
  RenameFile(IconsPath + 'BASESIDE\ship_dealer.3db', IconsPath + 'BASESIDE\ship_dealer_vanilla.3db')
  RenameFile(IconsPath + 'BASESIDE\take_off.3db', IconsPath + 'BASESIDE\take_off_vanilla.3db')
  RenameFile(IconsPath + 'HUD\hud_loot_bw.3db', IconsPath + 'HUD\hud_loot_bw_vanilla.3db')
  RenameFile(IconsPath + 'HUD\hud_missilealert.3db', IconsPath + 'HUD\hud_missilealert_vanilla.3db')
  RenameFile(IconsPath + 'HUD\hud_shipinfo_button.3db', IconsPath + 'HUD\hud_shipinfo_button_vanilla.3db')
  RenameFile(IconsPath + 'HUD\hud_shiptarget.3db', IconsPath + 'HUD\hud_shiptarget_vanilla.3db')
  RenameFile(IconsPath + 'HUD\hud_trailalert.3db', IconsPath + 'HUD\hud_trailalert_vanilla.3db')
  RenameFile(IconsPath + 'NEURONET\ICONS', IconsPath + 'NEURONET\ICONS_vanilla')
  RenameFile(IconsPath + 'NEURONET\INVENTORY\ammo.3db', IconsPath + 'NEURONET\INVENTORY\ammo_vanilla.3db')
  RenameFile(IconsPath + 'NEURONET\INVENTORY\cargobay.3db', IconsPath + 'NEURONET\INVENTORY\cargobay_vanilla.3db')
  RenameFile(IconsPath + 'NEURONET\INVENTORY\commodities.3db', IconsPath + 'NEURONET\INVENTORY\commodities_vanilla.3db')
  RenameFile(IconsPath + 'NEURONET\INVENTORY\equipmenticon.3db', IconsPath + 'NEURONET\INVENTORY\equipmenticon_vanilla.3db')
  RenameFile(IconsPath + 'NEURONET\INVENTORY\inv_dump.3db', IconsPath + 'NEURONET\INVENTORY\inv_dump_vanilla.3db')
  RenameFile(IconsPath + 'NEURONET\INVENTORY\weaponsicon.3db', IconsPath + 'NEURONET\INVENTORY\weaponsicon_vanilla.3db')
  RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_universebutton.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_universebutton_vanilla.3db')

  // Rename new icon files for either the alternative or flat icons
  RenameFile(CursorPath + 'cursor_' + IconName + '.txm', CursorPath + 'cursor.txm')
  RenameFile(IconsPath + 'buttontextures_' + IconName + '.txm', IconsPath + 'buttontextures.txm')
  RenameFile(IconsPath + 'BASESIDE\bar_' + IconName + '.3db', IconsPath + 'BASESIDE\bar.3db')
  RenameFile(IconsPath + 'BASESIDE\cityscape_' + IconName + '.3db', IconsPath + 'BASESIDE\cityscape.3db')
  RenameFile(IconsPath + 'BASESIDE\commod_trader_' + IconName + '.3db', IconsPath + 'BASESIDE\commod_trader.3db')
  RenameFile(IconsPath + 'BASESIDE\deck_' + IconName + '.3db', IconsPath + 'BASESIDE\deck.3db')
  RenameFile(IconsPath + 'BASESIDE\equipment_dealer_' + IconName + '.3db', IconsPath + 'BASESIDE\equipment_dealer.3db')
  RenameFile(IconsPath + 'BASESIDE\equiproomarrow_' + IconName + '.3db', IconsPath + 'BASESIDE\equiproomarrow.3db')
  RenameFile(IconsPath + 'BASESIDE\frontdesk_' + IconName + '.3db', IconsPath + 'BASESIDE\frontdesk.3db')
  RenameFile(IconsPath + 'BASESIDE\mission_vendor_' + IconName + '.3db', IconsPath + 'BASESIDE\mission_vendor.3db')
  RenameFile(IconsPath + 'BASESIDE\news_vendor_' + IconName + '.3db', IconsPath + 'BASESIDE\news_vendor.3db')
  RenameFile(IconsPath + 'BASESIDE\repair_' + IconName + '.3db', IconsPath + 'BASESIDE\repair.3db')
  RenameFile(IconsPath + 'BASESIDE\salesman_' + IconName + '.3db', IconsPath + 'BASESIDE\salesman.3db')
  RenameFile(IconsPath + 'BASESIDE\ship_dealer_' + IconName + '.3db', IconsPath + 'BASESIDE\ship_dealer.3db')
  RenameFile(IconsPath + 'BASESIDE\take_off_' + IconName + '.3db', IconsPath + 'BASESIDE\take_off.3db')
  RenameFile(IconsPath + 'HUD\hud_loot_bw_' + IconName + '.3db', IconsPath + 'HUD\hud_loot_bw.3db')
  RenameFile(IconsPath + 'HUD\hud_missilealert_' + IconName + '.3db', IconsPath + 'HUD\hud_missilealert.3db')
  RenameFile(IconsPath + 'HUD\hud_shipinfo_button_' + IconName + '.3db', IconsPath + 'HUD\hud_shipinfo_button.3db')
  RenameFile(IconsPath + 'HUD\hud_shiptarget_' + IconName + '.3db', IconsPath + 'HUD\hud_shiptarget.3db')
  RenameFile(IconsPath + 'HUD\hud_trailalert_' + IconName + '.3db', IconsPath + 'HUD\hud_trailalert.3db')
  RenameFile(IconsPath + 'NEURONET\ICONS_' + IconName + '', IconsPath + 'NEURONET\ICONS')
  RenameFile(IconsPath + 'NEURONET\INVENTORY\ammo_' + IconName + '.3db', IconsPath + 'NEURONET\INVENTORY\ammo.3db')
  RenameFile(IconsPath + 'NEURONET\INVENTORY\cargobay_' + IconName + '.3db', IconsPath + 'NEURONET\INVENTORY\cargobay.3db')
  RenameFile(IconsPath + 'NEURONET\INVENTORY\commodities_' + IconName + '.3db', IconsPath + 'NEURONET\INVENTORY\commodities.3db')
  RenameFile(IconsPath + 'NEURONET\INVENTORY\equipmenticon_' + IconName + '.3db', IconsPath + 'NEURONET\INVENTORY\equipmenticon.3db')
  RenameFile(IconsPath + 'NEURONET\INVENTORY\inv_dump_' + IconName + '.3db', IconsPath + 'NEURONET\INVENTORY\inv_dump.3db')
  RenameFile(IconsPath + 'NEURONET\INVENTORY\weaponsicon_' + IconName + '.3db', IconsPath + 'NEURONET\INVENTORY\weaponsicon.3db')
  RenameFile(IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_universebutton_' + IconName + '.3db', IconsPath + 'NEURONET\NAVMAP\NEWNAVMAP\nav_universebutton.3db')
end;

procedure Process_CustomNavMap();
var
  NavMapPath : string;
begin
  NavMapPath := ExpandConstant('{app}\DATA\INTERFACE\NEURONET\NAVMAP\NEWNAVMAP\');

  // Option is checked
  if CustomNavMap.Checked then
    begin
    // Rename vanilla nav map file
    RenameFile(NavMapPath + 'nav_prettymap.3db', NavMapPath + 'nav_prettymap_vanilla.3db')

    // Rename custom nav map file
    RenameFile(NavMapPath + 'nav_prettymap_custom.3db', NavMapPath + 'nav_prettymap.3db')
    end;
end;

procedure Process_JumpTunnelDurations();
var
  FilePath : string;
begin
  FilePath := ExpandConstant('{app}\DATA\FX\jumpeffect.ini');

  // Modify jump in and out tunnel time based on selected option
  if JumpTunnel5Sec.Checked then
    begin
      FileReplaceString(FilePath, 'jump_out_tunnel_time = 7' + #13#10
                                  'jump_in_tunnel_time = 3'  + #13#10,

                                  'jump_out_tunnel_time = 3.5' + #13#10
                                  'jump_in_tunnel_time = 1.5'  + #13#10)
  end
  else if JumpTunnel2Sec.Checked then
    begin
      FileReplaceString(FilePath, 'jump_out_tunnel_time = 7' + #13#10
                                  'jump_in_tunnel_time = 3'  + #13#10,

                                  'jump_out_tunnel_time = 1.75' + #13#10
                                  'jump_in_tunnel_time = 0.75'  + #13#10)
    end
  else if JumpTunnelSkip.Checked then
    begin
      FileReplaceString(FilePath, 'jump_out_tunnel_time = 7' + #13#10
                                  'jump_in_tunnel_time = 3'  + #13#10,

                                  'jump_out_tunnel_time = 0' + #13#10
                                  'jump_in_tunnel_time = 0'  + #13#10)
    end
end;

procedure Process_SkipIntros();
var
  FilePath : string;
begin
  FilePath := ExpandConstant('{app}\EXE\freelancer.ini');

  // Skip intros if selected
  if SkipIntros.Checked then
    begin
      FileReplaceString(FilePath, 'movie_file = movies\MGS_Logo_Final.wmv' + #13#10
                                  'movie_file = movies\DA_Logo_Final.wmv'  + #13#10
                                  'movie_file = movies\FL_Intro.wmv'  + #13#10,

                                  ';movie_file = movies\MGS_Logo_Final.wmv' + #13#10
                                  ';movie_file = movies\DA_Logo_Final.wmv'  + #13#10
                                  ';movie_file = movies\FL_Intro.wmv'  + #13#10)
  end
end;

procedure Process_SkippableCutscenes();
var
  ExePath : string;
begin
  ExePath := ExpandConstant('{app}\EXE\Freelancer.exe');

  // Make story cutscenes skippable if selected
  if SkippableCutscenes.Checked then
    WriteHexToFile(ExePath, $05685F, 'EB0C');
end;

procedure Process_WeaponGroups();
begin
  if WeaponGroups.Checked then
  begin
      // Enable weapon groups
      FileReplaceString(
        ExpandConstant('{app}\EXE\dacom.ini'),
        ';HudWeaponGroups.dll' + #13#10,
        'HudWeaponGroups.dll' + #13#10
      )
  end
end;

procedure Process_DxWrapper();
var
  DxWrapperPath: string;
begin
  if not DxWrapperGraphicsApi.Checked then
    exit;

  DxWrapperPath := ExpandConstant('{app}\EXE\dxwrapper.ini');

  if DxWrapperAa.ItemIndex = 0 then
    // Disable AA
    FileReplaceString(DxWrapperPath, 'AntiAliasing               = 1', 'AntiAliasing               = 0');
  if DxWrapperAa.ItemIndex = 1 then
    // Enable 2x AA
    FileReplaceString(DxWrapperPath, 'AntiAliasing               = 1', 'AntiAliasing               = 2');
  if DxWrapperAa.ItemIndex = 2 then
    // Enable 4x AA
    FileReplaceString(DxWrapperPath, 'AntiAliasing               = 1', 'AntiAliasing               = 4');
  if DxWrapperAa.ItemIndex = 3 then
    // Enable 8x AA
    FileReplaceString(DxWrapperPath, 'AntiAliasing               = 1', 'AntiAliasing               = 8');

  if DxWrapperAf.ItemIndex = 0 then
    // Disable AF
    FileReplaceString(DxWrapperPath, 'AnisotropicFiltering       = 1', 'AnisotropicFiltering       = 0');
  if DxWrapperAf.ItemIndex = 1 then
    // Enable 2x AF
    FileReplaceString(DxWrapperPath, 'AnisotropicFiltering       = 1', 'AnisotropicFiltering       = 2');
  if DxWrapperAf.ItemIndex = 2 then
    // Enable 4x AF
    FileReplaceString(DxWrapperPath, 'AnisotropicFiltering       = 1', 'AnisotropicFiltering       = 4');
  if DxWrapperAf.ItemIndex = 3 then
    // Enable 8x AF
    FileReplaceString(DxWrapperPath, 'AnisotropicFiltering       = 1', 'AnisotropicFiltering       = 8');
  if DxWrapperAf.ItemIndex = 4 then
    // Enable 16x AF
    FileReplaceString(DxWrapperPath, 'AnisotropicFiltering       = 1', 'AnisotropicFiltering       = 16');
end;

procedure ApplyOldDgVoodooOptions(DgVoodooPath: string);
var
  RefreshRateBinary: string;
  RefreshRateInt: Integer;
begin
  RefreshRateInt := StrToInt(DgVoodooRefreshRate.Text)

  if DgVoodooAa.ItemIndex = 1 then
    // Enable AA 2x
    WriteHexToFile(DgVoodooPath, $6A, '02');
  if DgVoodooAa.ItemIndex = 2 then
    // Enable AA 4x
    WriteHexToFile(DgVoodooPath, $6A, '04');
  if DgVoodooAa.ItemIndex = 3 then
    // Enable AA 8x
    WriteHexToFile(DgVoodooPath, $6A, '08');

  // It's possible to use AA 16x by setting $6A to '10'. Unfortunately this'll cause the game to crash on AMD (and also NVIDIA?) GPUs for some reason...

  if DgVoodooAf.ItemIndex = 1 then
    // Enable AF 2x
    WriteHexToFile(DgVoodooPath, $86, '02');
  if DgVoodooAf.ItemIndex = 2 then
    // Enable AF 4x
    WriteHexToFile(DgVoodooPath, $86, '04');
  if DgVoodooAf.ItemIndex = 3 then
    // Enable AF 8x
    WriteHexToFile(DgVoodooPath, $86, '08');
  if DgVoodooAf.ItemIndex = 4 then
    // Enable AF 16x
    WriteHexToFile(DgVoodooPath, $86, '10');

  // Get the correct refresh rate as 1 or 2 byte hexadecimals
  if RefreshRateInt <= 255 then
    RefreshRateBinary := IntToHex(RefreshRateInt, 2)
  else
    // If the value is above 255, that means we have to work with 2 bytes instead of 1.
    // Since we want to write these hexadecimal values to a binary file, we have to express the bytes in a different order by swapping them, because LIFO.
    RefreshRateBinary := SwapBytes(IntToHex(RefreshRateInt, 4));

  // Set refresh rate
  WriteHexToFile(DgVoodooPath, $6E, RefreshRateBinary);
end;

procedure ApplyNewDgVoodooOptions(DgVoodooPath: string);
begin
  if DgVoodooAa.ItemIndex = 1 then
    // Enable AA 2x
    FileReplaceString(DgVoodooPath, 'Antialiasing                        = appdriven', 'Antialiasing                        = 2x');
  if DgVoodooAa.ItemIndex = 2 then
    // Enable AA 4x
    FileReplaceString(DgVoodooPath, 'Antialiasing                        = appdriven', 'Antialiasing                        = 4x');
  if DgVoodooAa.ItemIndex = 3 then
    // Enable AA 8x
    FileReplaceString(DgVoodooPath, 'Antialiasing                        = appdriven', 'Antialiasing                        = 8x');

  if DgVoodooAf.ItemIndex = 1 then
    // Enable AF 2x
    FileReplaceString(DgVoodooPath, 'Filtering                           = appdriven', 'Filtering                           = 2');
  if DgVoodooAf.ItemIndex = 2 then
    // Enable AF 4x
    FileReplaceString(DgVoodooPath, 'Filtering                           = appdriven', 'Filtering                           = 4');
  if DgVoodooAf.ItemIndex = 3 then
    // Enable AF 8x
    FileReplaceString(DgVoodooPath, 'Filtering                           = appdriven', 'Filtering                           = 8');
  if DgVoodooAf.ItemIndex = 4 then
    // Enable AF 16x
    FileReplaceString(DgVoodooPath, 'Filtering                           = appdriven', 'Filtering                           = 16');
end;

procedure Process_DgVoodoo();
var
  DgVoodooPath: string;
begin
  if not DgVoodooGraphicsApi.Checked then
    exit;

  DgVoodooPath := ExpandConstant('{app}\EXE\dgVoodoo.conf');

  // Apply correct settings for the activated dgVoodoo versions
  if GpuManufacturer = AMD then
    ApplyOldDgVoodooOptions(DgVoodooPath)
  else
    ApplyNewDgVoodooOptions(DgVoodooPath);
end;

procedure ApplyReShadeOptions(ReShadeDllName: string; BloomChecked: Boolean; HdrChecked: Boolean; SaturationChecked: Boolean; SharpeningChecked: Boolean);
var
  ReShadePath: string;
  Techniques: string;
begin
  ReShadePath := ExpandConstant('{app}\EXE\');

  // If a ReShade dll already exists in the vanilla installation, rename that away because otherwise the new ReShade file can't be activated.
  if FileExists(ReShadePath + ReShadeDllName + '.dll') then
    RenameFile(ReShadePath + ReShadeDllName + '.dll', ReShadePath + ReShadeDllName + '_vanilla.dll');

  // Rename the other DLL if it already exists because they can cause conflicts
  if (CompareText(ReshadeDllName, 'd3d9') = 0) and FileExists(ReShadePath + 'dxgi.dll') then
    RenameFile(ReShadePath + 'dxgi.dll', ReShadePath + 'dxgi_vanilla.dll')
  else if (CompareText(ReshadeDllName, 'dxgi') = 0) and FileExists(ReShadePath + 'd3d9.dll') then
    RenameFile(ReShadePath + 'd3d9.dll', ReShadePath + 'd3d9_vanilla.dll');

  // Activate ReShade by renaming the file
  RenameFile(ReShadePath + ReShadeDllName + '_reshade.dll', ReShadePath + ReShadeDllName + '.dll')

  // Enable desired ReShade options
  Techniques := 'Techniques=';

  if SaturationChecked then
    Techniques := Techniques + 'Colourfulness@Colourfulness.fx,';
  if HdrChecked then
    Techniques := Techniques + 'HDR@FakeHDR.fx,';
  if BloomChecked then
    Techniques := Techniques + 'MagicBloom@MagicBloom.fx,';
  if (DisplayMode.ItemIndex = 1) or (DisplayMode.ItemIndex = 2) then
    // Use Tonemap only if windowed or fullscreen windowed have been checked
    Techniques := Techniques + 'Tonemap@Tonemap.fx,';
  if SharpeningChecked then
    Techniques := Techniques + 'ContrastAdaptiveSharpen@CAS.fx,';

  // Enable the Deband shader by default because it's crucial for Freelancer
  Techniques := Techniques + 'Deband@Deband.fx,';

  // Removes a trailing comma at the end of the techniques if it's there
  if (LENGTH(Techniques) > 0) and (Techniques[LENGTH(Techniques)] = ',') then
    SetLength(Techniques, LENGTH(Techniques) - 1);

  // Set the techniques
  FileReplaceString(ReShadePath + 'ReShadePreset.ini', 'Techniques=', Techniques);
end;

procedure Process_DxWrapperReShade();
begin
  if DxWrapperGraphicsApi.Checked and DxWrapperReShade.Checked then
    ApplyReShadeOptions('d3d9', DxWrapperBloom.Checked, DxWrapperHdr.Checked, DxWrapperSaturation.Checked, DxWrapperSharpening.Checked); // d3d9 is for DirectX 9 (DxWrapper)
end;

procedure Process_DgVoodooReShade();
begin
  if DgVoodooGraphicsApi.Checked and DgVoodooReShade.Checked then
    ApplyReShadeOptions('dxgi', DgVoodooBloom.Checked, DgVoodooHdr.Checked, DgVoodooSaturation.Checked, DgVoodooSharpening.Checked); // dxgi is for DirectX 11 (dgVoodoo)
end;

procedure Process_VanillaGraphics();
var
  Rp8Path: string;
begin
  // Do not apply anything if neither the Vanilla graphics API nor the Lighting fix graphics API has been selected
  if HasLightingBug and (not VanillaGraphicsApi.Checked) and (not LightingFixGraphicsApi.Checked) then
    exit;

  if (not HasLightingBug) and (not VanillaGraphicsApi.Checked) then
    exit;

  Rp8Path := ExpandConstant('{app}\EXE\rp8.dll');

  if VanillaAf.ItemIndex <> 0 then
  begin
    WriteHexToFile(Rp8Path, $01A48C, '03'); // Magnification filtering mode = "anisotropic"
    WriteHexToFile(Rp8Path, $01A4C5, '03'); // Minification filtering mode = "anisotropic"
    WriteHexToFile(Rp8Path, $01A4FE, '03'); // Mipmap filtering mode = "anisotropic"
  end;

  if VanillaAf.ItemIndex = 1 then
    // Maximum anisotropy = 2x
    WriteHexToFile(Rp8Path, $01A5B8, '02');
  if VanillaAf.ItemIndex = 2 then
    // Maximum anisotropy = 4x
    WriteHexToFile(Rp8Path, $01A5B8, '04');
  if VanillaAf.ItemIndex = 3 then
    // Maximum anisotropy = 8x
    WriteHexToFile(Rp8Path, $01A5B8, '08');
  if VanillaAf.ItemIndex = 4 then
    // Maximum anisotropy = 16x
    WriteHexToFile(Rp8Path, $01A5B8, '10');

  if VanillaAa.ItemIndex <> 0 then
  begin
    // Sets the swap effect to "discard" (required for anti-aliasing to work).
    WriteHexToFile(Rp8Path, $008E75, '01');
    WriteHexToFile(Rp8Path, $008E87, '01');
    WriteHexToFile(Rp8Path, $008E90, '01');
    WriteHexToFile(Rp8Path, $008ED2, '01');
    WriteHexToFile(Rp8Path, $008EE4, '01');
    WriteHexToFile(Rp8Path, $008EED, '01');
  end;

  if VanillaAa.ItemIndex = 1 then
    // Multisample anti-aliasing = 2x
    WriteHexToFile(Rp8Path, $008F5F, '02');
  if VanillaAa.ItemIndex = 2 then
    // Multisample anti-aliasing = 4x
    WriteHexToFile(Rp8Path, $008F5F, '04');
  if VanillaAa.ItemIndex = 3 then
    // Multisample anti-aliasing = 8x
    WriteHexToFile(Rp8Path, $008F5F, '08');
end;

procedure Process_DisplayMode();
var
  ExeFolderPath: string;
  ExePath, JflpPath: string;
begin
  ExeFolderPath := ExpandConstant('{app}\EXE\');
  ExePath := ExeFolderPath + 'Freelancer.exe';
  JflpPath := ExeFolderPath + 'jflp.dll';

  if (DisplayMode.ItemIndex = 1) or (DisplayMode.ItemIndex = 2) then // Windowed or borderless windowed selected
    WriteHexToFile(ExePath, $1B16CC, '00'); // Windowed mode

  if DisplayMode.ItemIndex = 2 then // Borderless windowed selected
  begin
    WriteHexToFile(ExePath, $02477A, '0000'); // Borderless window #1
    WriteHexToFile(ExePath, $02490D, '0000'); // Borderless window #2
  end;

  if DoNotPauseOnAltTab.Checked then
  begin
    if DisplayMode.ItemIndex = 0 then // Fullscreen selected
      WriteHexToFile(ExePath, $1B2665, 'EB') // Keep Freelancer running in the background when Alt-Tabbed
    else begin
      WriteHexToFile(ExePath, $1B264C, 'BA0100000090'); // Keep Freelancer and its window running in the background when Alt-Tabbed

      // Prevents the JFLP dll from making USER_FULLSCREEN work.
      // This is important because with the above Alt-Tab patch, the game must never run in fullscreen mode.
      // Every time you Alt-Tab in fullscreen mode with this patch, the window will continuously regain focus.
      // Running the game in fullscreen is still possible with the "-f" flag, but that's up to the user to decide.
      // Keep in mind that whenever the JFLP dll gets updated, this patch may need to be adjusted too.
      WriteHexToFile(JflpPath, $001528, '04');
    end;

    if MusicInBackground then
      begin
        WriteHexToFile(ExeFolderPath + 'soundmanager.dll', $0A021, '80'); // Continue playing the game's audio when Alt-Tabbed #1
        WriteHexToFile(ExeFolderPath + 'soundstreamer.dll', $018A9, '80'); // Continue playing the game's audio when Alt-Tabbed #2
      end;
  end;
end;

[Code]
// Used to store values used across numerous files and functions so they don't have to be requested multiple times
var
  DesktopRes: DesktopResolution;
  RefreshRate: Integer;
  IsWine: Boolean;
  HasLightingBug: Boolean;
  GpuManufacturer: TGpuManufacturer;
  SystemLanguage: TSystemLanguage;
  EDD_GET_DEVICE_INTERFACE_NAME, DISPLAY_DEVICE_PRIMARY_DEVICE: integer;

  HORZRES, VERTRES, VREFRESH: Integer;

  Min5by4Factor, Max5by4Factor,
  Min4by3Factor, Max4by3Factor,
  Min16by10Factor, Max16by10Factor,
  Min16by9Factor, Max16by9Factor,
  MinGeneralFactor, MaxGeneralFactor : Single;

  // Used to store the names of all edited config files
  EditedConfigFiles: TStringList;

procedure InitConstants();
begin
  EDD_GET_DEVICE_INTERFACE_NAME := 1;
  DISPLAY_DEVICE_PRIMARY_DEVICE := 4;
  HORZRES := 8;
  VERTRES := 10;
  VREFRESH := 116;

  Min5by4Factor := (5.0 / 4.0) - 0.02;
  Max5by4Factor := (5.0 / 4.0) + 0.02;

  Min4by3Factor := (4.0 / 3.0) - 0.02;
  Max4by3Factor := (4.0 / 3.0) + 0.02;

  Min16by10Factor := (16.0 / 10.0) - 0.02;
  Max16by10Factor := (16.0 / 10.0) + 0.02;

  Min16by9Factor := (16.0 / 9.0) - 0.02;
  Max16by9Factor := (16.0 / 9.0) + 0.02;

  MinGeneralFactor := 0.01;
  MaxGeneralFactor := 100.0;
end;

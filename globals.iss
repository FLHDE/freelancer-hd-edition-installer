[Code]
// Used to store values used across numerous files and functions so they don't have to be requested multiple times
var
  DesktopRes: DesktopResolution;
  IsWine: Boolean;
  HasLightingBug: Boolean;
  GpuManufacturer: TGpuManufacturer;
  SystemLanguage: TSystemLanguage;
  EDD_GET_DEVICE_INTERFACE_NAME, DISPLAY_DEVICE_PRIMARY_DEVICE: integer;

  HORZRES, VERTRES, VREFRESH: Integer;

  // Used to store the names of all edited config files
  EditedConfigFiles: TStringList;

procedure InitConstants();
begin
  EDD_GET_DEVICE_INTERFACE_NAME := 1;
  DISPLAY_DEVICE_PRIMARY_DEVICE := 4;
  HORZRES := 8;
  VERTRES := 10;
  VREFRESH := 116;
end;

(*------------------------------SystemWorks.pas--------------------------
 V1.0.98 - 08.07.2002 current release
*------------------------------------------------------------------------*)
unit SystemWorks;

interface

uses Windows, Graphics;

type
  TDWBootOption = (dwboNormal, //Normaler Systemstart
    dwboFailSafe, //Abgesicherter Modus
    dwboFailSaveNet); //Abgesicherter Modus mit Netzwerk
  TDWComPort = (dwcptCOM1,
    dwcptCOM2,
    dwcptCOM3,
    dwcptCOM4,
    dwcptCOM5,
    dwcptCOM6,
    dwcptCOM7,
    dwcptUnknown);
  TDWDimension = packed record
    Height,
      Width: Integer;
  end;
  TDWFileFlags = (dwffDebug,
    dwffInfoInferred,
    dwffPatched,
    dwffPrerelease,
    dwffPrivateBuild,
    dwffSpecialBuild);
  TDWFileInfo = packed record
    dwSignature: DWORD;
    dwStrucVersion: DWORD;
    dwFileVersionMS: DWORD;
    dwFileVersionLS: DWORD;
    dwProductVersionMS: DWORD;
    dwProductVersionLS: DWORD;
    dwFileFlagsMask: DWORD;
    dwFileFlags: DWORD;
    dwFileOS: DWORD;
    dwFileType: DWORD;
    dwFileSubtype: DWORD;
    dwFileDateMS: DWORD;
    dwFileDateLS: DWORD;
    dwFileLanguage: Word;
    dwFileCharSet: Word;
    dwComments,
      dwCompanyName,
      dwFileDescription,
      dwFileVersion,
      dwInternalName,
      dwLegalCopyright,
      dwLegalTrademarks,
      dwOriginalFilename,
      dwPrivateBuild,
      dwProductName,
      dwProductVersion,
      dwSpecialBuild: string;
  end;
  TDWFileOS = (dwfosDOS,
    dwfosDOS_Windows16,
    dwfosDOS_Windows32,
    dwfosNT,
    dwfosNT_Windows32,
    dwfosWindows16,
    dwfosWindows32,
    dwfosOS2_16,
    dwfosOS2_16_PM16,
    dwfosOS2_32,
    dwfosOS2_32_PM32,
    dwfosPM16,
    dwfosPM32,
    dwfosUnknown);
  TDWFileOSSet = set of TDWFileOS;
  TDWFileSubType = (dwfstCOMM,
    dwfstDisplay,
    dwfstFontRaster,
    dwfstFontTruetype,
    dwfstFontVector,
    dwfstInstallable,
    dwfstKeyboard,
    dwfstLanguage,
    dwfstMouse,
    dwfstNetwork,
    dwfstPrinter,
    dwfstSound,
    dwfstSystem,
    dwfstUnknown,
    dwfstVersionedPrinter);
  TDWFileType = (dwftApp,
    dwftDLL,
    dwftDRV,
    dwftFont,
    dwftStaticLib,
    dwftUnknown,
    dwftVXD);
  TDWFixedFileInfo = packed record
    dwSignature: DWORD;
    dwStrucVersion: DWORD;
    dwFileVersionMS: DWORD;
    dwFileVersionLS: DWORD;
    dwProductVersionMS: DWORD;
    dwProductVersionLS: DWORD;
    dwFileFlagsMask: DWORD;
    dwFileFlags: DWORD;
    dwFileOS: DWORD;
    dwFileType: DWORD;
    dwFileSubtype: DWORD;
    dwFileDateMS: DWORD;
    dwFileDateLS: DWORD;
  end;
  TDWLangCharSet = packed record
    dwLang,
      dwCharSet: Word;
  end;
  TDWMenuAlignment =
    (dwmaLeft, //Menü links unter MenuItem
    dwmaRight); //Menü rechts unter MenuItem
  TDWMinimizedWindowArrangement =
    (dwmwaBottomLeft, //Unten links
    dwmwaBottomRight, //Unten rechts
    dwmwaHide, //Verborgen ( außerhalb sichtbarer Bereich )
    dwmwaTopLeft, //Open links
    dwmwaTopRight); //Oben rechts
  TDWScreenType = (dwscrtAll, //Jeder Bildschirm
    dwscrtDesktop, //Alle, die ein Teil des Desktops sind
    dwscrtMirror, //Alle, die einen Bildschirm spiegeln
    dwscrtModeSpruned, //Grafikkarte kann mehr als der Monitor
    dwscrtPrimary, //Primäre Grafikkarte
    dwscrtRemovable, //Auswechselbare
    dwscrtVGA); //VGA-kompatible
  TDWScreenTypes = set of TDWScreenType;
  TDWSpecialFolder =
    (dwspfAdminTools,
    dwspfAppData,
    dwspfRecycleBin,
    dwspfCommonAdminTools,
    dwspfCommonAppData,
    dwspfCommonDesktop,
    dwspfCommonDocuments,
    dwspfCommonFavorites,
    dwspfCommonMusic,
    dwspfCommonPictures,
    dwspfCommonProgramFiles,
    dwspfCommonPrograms,
    dwspfCommonStartmenu,
    dwspfCommonStartup,
    dwspfCommonTemplates,
    dwspfCommonVideo,
    dwspfControls,
    dwspfCookies,
    dwspfDesktop,
    dwspfDrives,
    dwspfFavorites,
    dwspfFonts,
    dwspfHistory,
    dwspfInternetCache,
    dwspfLocalAppData,
    dwspfMyMusic,
    dwspfMyPictures,
    dwspfMyVideo,
    dwspfNetHood,
    dwspfNetwork,
    dwspfPersonal,
    dwspfPrinters,
    dwspfPrintHood,
    dwspfProfile,
    dwspfProgramFiles,
    dwspfProgramFilesX86,
    dwspfPrograms,
    dwspfRecent,
    dwspfSendTo,
    dwspfStartMenu,
    dwspfStartUp,
    dwspfSystem,
    dwspfSystemX86,
    dwspfTemplates,
    dwspfWindows);
  TDWACLineStatus =
    (dwalsOffline,
    dwalsOnline,
    dwalsUnknownState);
  TDWBatteryState =
    (dwbtsHigh,
    dwbtsLow,
    dwbtsCritical,
    dwbtsCharging,
    dwbtsNoSystemBattery,
    dwbtsUnknownState);
  TDWBatteryStates = set of TDWBatteryState;
  TDWVersionBlock = packed record
    dwVersionMajor,
      dwVersionMinor: Integer;
  end;
  TDWWindowsDialog =
    (dwwdAccessibilityProperties,
    dwwdBDEProperties,
    dwwdControlPanel,
    dwwdCopyFloppy,
    dwwdDialProperties,
    dwwdDisplayProperties,
    dwwdExecute,
    dwwdFindFiles,
    dwwdFontsProperties,
    dwwdGamecontrollerProperties,
    dwwdHardwareDetect,
    dwwdInternetProperties,
    dwwdKeyboardProperties,
    dwwdLocaleProperties,
    dwwdMailProperties,
    dwwdModemProperties,
    dwwdMouseProperties,
    dwwdMultimediaProperties,
    dwwdNetworkProperties,
    dwwdODBCProperties,
    dwwdPasswordsProperties,
    dwwdPowerManagementProperties,
    dwwdPrinterProperties,
    dwwdRASWizard,
    dwwdScanCamProperties,
    dwwdSoftwareProperties,
    dwwdSystemProperties,
    dwwdThemesProperties,
    dwwdTime,
    dwwdTweakUIProperties,
    dwwdWindowsShutdownDialog);
  _devicemodeA_0500 = packed record
    dmDeviceName: array[0..CCHDEVICENAME - 1] of AnsiChar;
    dmSpecVersion: Word;
    dmDriverVersion: Word;
    dmSize: Word;
    dmDriverExtra: Word;
    dmFields: DWORD;
    case Integer of // sequence rearranged (to have the biggest as last)
      1: (dmPosition: TPointL; );
      2: (dmDisplayOrientation: DWORD; );
      3: (dmDisplayFixedOutput: DWORD; );
      0: (
        dmOrientation: SHORT;
        dmPaperSize: SHORT;
        dmPaperLength: SHORT;
        dmPaperWidth: SHORT;
        dmScale: SHORT;
        dmCopies: SHORT;
        dmDefaultSource: SHORT;
        dmPrintQuality: SHORT; // );
    { end; }
        dmColor: SHORT;
        dmDuplex: SHORT;
        dmYResolution: SHORT;
        dmTTOption: SHORT;
        dmCollate: SHORT;
        dmFormName: array[0..CCHFORMNAME - 1] of AnsiChar;
        dmLogPixels: Word;
        dmBitsPerPel: DWORD;
        dmPelsWidth: DWORD;
        dmPelsHeight: DWORD;
        case Integer of
          0: (dmDisplayFlags: DWORD; );
          1: (dmNup: DWORD; // );
    { end; }
            dmDisplayFrequency: DWORD;
            dmICMMethod: DWORD;
            dmICMIntent: DWORD;
            dmMediaType: DWORD;
            dmDitherType: DWORD;
            dmReserved1: DWORD;
            dmReserved2: DWORD;
            dmPanningWidth: DWORD;
            dmPanningHeight: DWORD; ); ); // end of 'union's above
  end;

(*V1.0.98*)
function ActiveDesktopEnabled: Boolean;
function AppExec(const CmdLine, CmdParams: string; const CmdShow: Integer): Boolean;
function AppIsResponding(const ClassName: string; const TimeOut: Cardinal): Boolean;
procedure AppRestart;
procedure EmptyKeyboardQueue;
procedure EmptyMouseQueue;
procedure ExecAndWait(const FileName, Params: string; const CmdShow: Integer);
procedure FileOpenWithDialog(const Filename: string);
procedure FilePropertiesDialog(const Filename: string);
function FontAdd(const FontFilename: string): Boolean;
function FontRemove(const FontFilename: string): Boolean;
function GetACLineStatus: TDWACLineStatus;
function GetAssociatedProgram(const Ext: string): string;
function GetBatteryFullLifeTime: Integer;
function GetBatteryLifePercent: Byte;
function GetBatteryLifeTime: Integer;
function GetBatteryState: TDWBatteryStates;
function GetIconDimension(const Filename: string; const Index: Integer): TDWDimension;
function GetNumberOfIcons(const Filename: string): Integer;
function GetWindowsLanguageStr: string;
procedure MinimizeAllWindows;
procedure ProcessMessages;
function ScreenColorDepth(const Index: Byte): Byte;
function ScreenDeviceName(const Index: Byte): string;
function ScreenDeviceString(const Index: Byte): string;
function ScreenDeviceType(const Index: Byte): TDWScreenTypes;
function ScreenFrequency(const Index: Byte): Integer;
function ScreenMonitorName(const Index: Byte): string;
function ScreenMonitorPosition(const Index: Byte; var Point: TPoint): Boolean;
function ScreenMonitorString(const Index: Byte): string;
function ScreenResolution(const Index: Byte): TDWDimension;
procedure ShowDesktop;
procedure ShowSpecialDialog(const SpecialDialog: TDWWindowsDialog);
procedure ShowFormatDriveDialog(const Drive: Char);
procedure StartNewBrowserWindow(const URL: string);

(*V1.0.97*)
function GetFileCharSetName(const FileInfo: TDWFileInfo): string;
function GetFileFlags(const FileInfo: TDWFileInfo): TDWFileFlags;
function GetFileInfo(const Filename: string): TDWFileInfo;
function GetFileLanguageName(const FileInfo: TDWFileInfo): string;
function GetFileOS(const FileInfo: TDWFileInfo): TDWFileOSSet;
function GetFileProductVersionMS(const FileInfo: TDWFileInfo): TDWVersionBlock;
function GetFileProductVersionLS(const FileInfo: TDWFileInfo): TDWVersionBlock;
function GetFileStrucVersion(const FileInfo: TDWFileInfo): TDWVersionBlock;
function GetFileSubType(const FileInfo: TDWFileInfo): TDWFileSubType;
function GetFileType(const FileInfo: TDWFileInfo): TDWFileType;
function GetFileVersionLS(const FileInfo: TDWFileInfo): TDWVersionBlock;
function GetFileVersionMS(const FileInfo: TDWFileInfo): TDWVersionBlock;

(*V1.0.96*)
function AvailablePageMemory: Int64;
function AvailablePhysicalMemory: Int64;
function AvailableVirtualMemory: Int64;
function GetBootOption: TDWBootOption;
procedure DisableCaptionCloseButton(const FormHandle: THandle);
function EmptyRecycleBin(const Confirmation, GUI, Sound: Boolean): Boolean;
procedure EnableCaptionCloseButton(const FormHandle: THandle);
function FilesInRecycleBin(var FileCount: Int64): Boolean;
function GetCapsLock: Boolean;
function GetMenuAlignment: TDWMenuAlignment;
function GetMinimizedWindowArrangement: TDWMinimizedWindowArrangement;
function GetMouseButtons: Integer;
function GetNumLock: Boolean;
function GetScrollLock: Boolean;
//procedure GetVideoModes(var ModeList: TStringList);
function MemoryUsedPercentage: Integer;
function MouseButtonsSwaped: Boolean;
function MouseIsPresent: Boolean;
function MouseHasWheel: Boolean;
function NetworkIsPresent: Boolean;
procedure SetCapsLock(const CapsLockOn: Boolean);
procedure SetNumLock(const NumLockOn: Boolean);
procedure SetScrollLock(const ScrollLockOn: Boolean);
function SoundCardInstalled: Boolean;
function TotalPageMemory: Int64;
function TotalPhysicalMemory: Int64;
function TotalVirtualMemory: Int64;

(*V1.0.95*)
function CPUClock: Double;
procedure MonitorOff;
procedure MonitorOn;
procedure SetSystemClock(Year, Month, Day, Hour, Minute, Second, MSecond: Integer);

implementation

uses SysUtils, Registry, MMSystem, Dialogs, Messages, DDEMan, ShellApi,
  MultiMon, ShlObj;
const
  DISPLAY_DEVICE_ACTIVE = $00000001;
  DISPLAY_DEVICE_ATTACHED_TO_DESKTOP = $00000001;
  DISPLAY_DEVICE_MULTI_DRIVER = $00000002;
  DISPLAY_DEVICE_PRIMARY_DEVICE = $00000004;
  DISPLAY_DEVICE_MIRRORING_DRIVER = $00000008;
  DISPLAY_DEVICE_VGA_COMPATIBLE = $00000010;
  DISPLAY_DEVICE_REMOVABLE = $00000020;
  DISPLAY_DEVICE_MODESPRUNED = $08000000;
  DISPLAY_DEVICE_REMOTE = $04000000;
  DISPLAY_DEVICE_DISCONNECT = $02000000;
  ENUM_CURRENT_SETTINGS = $FFFFFFFF;

function _FormatDriveDlg(h: hwnd; lw, df, op: word):
  longint stdcall; external 'Shell32.dll' name 'SHFormatDrive';

procedure ShowFormatDriveDialog(const Drive: Char);
begin
  _FormatDriveDlg(0, Ord(UpCase(Drive)) - 65, $FFFF, 0);
end;

procedure ShowSpecialDialog(const SpecialDialog: TDWWindowsDialog);
  procedure opencpl(const cpl: string);
  begin
    shellexecute(GetCurrentProcess, 'open', 'rundll32.exe',
      pchar('shell32.dll,Control_RunDLL' + #32 + cpl), nil, sw_shownormal);
  end;
begin
  case SpecialDialog of
    dwwdCopyFloppy:
      begin
        ShellExecute(GetCurrentProcess, 'open', 'rundll32.exe',
          PChar('diskcopy,DiskCopyRunDll'), nil, SW_SHOWNORMAL);
      end;
    dwwdHardwareDetect:
      begin
        ShellExecute(GetCurrentProcess, 'open', 'rundll32.exe',
          'sysdm.cpl,installdevice_rundll', nil, SW_SHOWNORMAL);
      end;
    dwwdControlPanel:
      begin
        ShellExecute(GetCurrentProcess, 'open', 'rundll32.exe',
          'shell32,Control_RunDLL', nil, SW_SHOWNORMAL);
      end;
    dwwdRASWizard:
      begin
        ShellExecute(GetCurrentProcess, 'open', 'rundll32.exe',
          'rnaui.dll,RnaWizard /1', nil, SW_SHOWNORMAL);
      end;
    dwwdWindowsShutdownDialog:
      begin
        PostMessage(FindWindow('Progman', nil), WM_CLOSE, 0, 0);
      end;
    dwwdExecute:
      begin
        keybd_event(VK_LWIN, MapVirtualKey(VK_LWIN, 0), 0, 0);
        keybd_event(Ord('R'), MapVirtualKey(Ord('R'), 0), 0, 0);
        keybd_event(Ord('R'), MapVirtualKey(Ord('R'), 0), KEYEVENTF_KEYUP, 0);
        keybd_event(VK_LWIN, MapVirtualKey(VK_LWIN, 0), KEYEVENTF_KEYUP, 0);
      end;
    dwwdFindFiles:
      begin
        keybd_event(VK_LWIN, MapVirtualKey(VK_LWIN, 0), 0, 0);
        keybd_event(Ord('F'), MapVirtualKey(Ord('F'), 0), 0, 0);
        keybd_event(Ord('F'), MapVirtualKey(Ord('F'), 0), KEYEVENTF_KEYUP, 0);
        keybd_event(VK_LWIN, MapVirtualKey(VK_LWIN, 0), KEYEVENTF_KEYUP, 0);
      end;
    dwwdTime:
      begin
        ShellExecute(GetCurrentProcess, 'open', 'control',
          'date/time', nil, SW_SHOW)
      end;
    dwwdMouseProperties:
      begin
        OpenCpl('MAIN.CPL @0');
      end;
    dwwdKeyboardProperties:
      begin
        OpenCpl('MAIN.CPL @1');
      end;
    dwwdPrinterProperties:
      begin
        OpenCpl('MAIN.CPL @2');
      end;
    dwwdFontsProperties:
      begin
        OpenCpl('MAIN.CPL @3');
      end;
    dwwdSoftwareProperties:
      begin
        OpenCpl('APPWIZ.CPL');
      end;
    dwwdDisplayProperties:
      begin
        OpenCpl('DESK.CPL');
      end;
    dwwdInternetProperties:
      begin
        OpenCpl('INETCPL.CPL');
      end;
    dwwdLocaleProperties:
      begin
        OpenCpl('INTL.CPL');
      end;
    dwwdMultimediaProperties:
      begin
        OpenCpl('MMSYS.CPL');
      end;
    dwwdModemProperties:
      begin
        OpenCpl('MODEM.CPL');
      end;
    dwwdNetworkProperties:
      begin
        OpenCpl('NETCPL.CPL');
      end;
    dwwdPasswordsProperties:
      begin
        OpenCpl('PASSWORD.CPL');
      end;
    dwwdScanCamProperties:
      begin
        OpenCpl('STICPL.CPL');
      end;
    dwwdSystemProperties:
      begin
        OpenCpl('SYSDM.CPL');
      end;
    dwwdDialProperties:
      begin
        OpenCpl('TELEPHON.CPL');
      end;
    dwwdGamecontrollerProperties:
      begin
        OpenCpl('JOY.CPL');
      end;
    dwwdAccessibilityProperties:
      begin
        OpenCpl('ACCESS.CPL');
      end;
    dwwdTweakUIProperties:
      begin
        OpenCpl('TWEAKUI.CPL');
      end;
    dwwdODBCProperties:
      begin
        OpenCpl('ODBCCP32.CPL');
      end;
    dwwdPowerManagementProperties:
      begin
        OpenCpl('POWERCFG.CPL');
      end;
    dwwdThemesProperties:
      begin
        OpenCpl('THEMES.CPL');
      end;
    dwwdBDEProperties:
      begin
        OpenCpl('BDEADMIN.CPL');
      end;
    dwwdMailProperties:
      begin
        OpenCpl('MLCFG32.CPL');
      end;
  end;
end;

function ActiveDesktopEnabled: Boolean;
var
  h: HWND;
begin
  h := FindWindow('Progman', nil);
  h := FindWindowEx(h, 0, 'SHELLDLL_DefView', nil);
  h := FindWindowEx(h, 0, 'Internet Explorer_Server', nil);
  Result := h <> 0;
end;

function AppExec(const CmdLine, CmdParams: string; const CmdShow: Integer): Boolean;
begin
  result := (ShellExecute(GetCurrentProcess,
    'open',
    PChar(CmdLine),
    PChar(CmdParams),
    '',
    CmdShow) > 32);
end;

function AppIsResponding(const ClassName: string; const TimeOut: Cardinal): Boolean;
var
  Res: DWORD;
  h: HWND;
  bClassFound,
    bSendMessage: Boolean;
begin
  bSendMessage := FALSE;
  h := FindWindow(PChar(ClassName), nil);
  bClassFound := (h <> 0);
  if bClassFound then
    bSendMessage := (SendMessageTimeout(H,
      WM_NULL,
      0,
      0,
      SMTO_NORMAL or SMTO_ABORTIFHUNG,
      TIMEOUT,
      Res) <> 0);
  result := (bClassFound and bSendMessage);
end;

procedure AppRestart;
begin
  AppExec(ParamStr(0), '', SW_SHOW);
  TerminateProcess(GetCurrentProcess, 0);
end;

procedure EmptyKeyboardQueue;
var
  Msg: TMsg;
begin
  while PeekMessage(Msg, 0, WM_KEYFIRST, WM_KEYLAST,
    PM_REMOVE or PM_NOYIELD) do ;
end;

procedure EmptyMouseQueue;
var
  Msg: TMsg;
begin
  while PeekMessage(Msg, 0, WM_MOUSEFIRST, WM_MOUSELAST,
    PM_REMOVE or PM_NOYIELD) do ;
end;

procedure ExecAndWait(const FileName, Params: string; const CmdShow: Integer);
var
  exInfo: TShellExecuteInfo;
  Ph: DWORD;
begin
  FillChar(exInfo, SizeOf(exInfo), 0);
  with exInfo do
  begin
    cbSize := SizeOf(exInfo);
    fMask := SEE_MASK_NOCLOSEPROCESS or SEE_MASK_FLAG_DDEWAIT;
    Wnd := GetActiveWindow();
    ExInfo.lpVerb := 'open';
    ExInfo.lpParameters := PChar(Params);
    lpFile := PChar(FileName);
    nShow := CmdShow;
  end;
  if ShellExecuteEx(@exInfo) then
    Ph := exInfo.HProcess
  else
  begin
    ShowMessage(SysErrorMessage(GetLastError));
    Exit;
  end;
  while WaitForSingleObject(ExInfo.hProcess, 50) <> WAIT_OBJECT_0 do
    ProcessMessages;
  CloseHandle(Ph);
end;

function GetBatteryLifePercent: Byte;
var
  Sps: TSystemPowerStatus;
begin
  GetSystemPowerStatus(Sps);
  result := Sps.BatteryLifePercent;
end;

function GetBatteryLifeTime: Integer;
var
  Sps: TSystemPowerStatus;
begin
  GetSystemPowerStatus(Sps);
  result := Sps.BatteryLifeTime;
end;

function GetBatteryFullLifeTime: Integer;
var
  Sps: TSystemPowerStatus;
begin
  GetSystemPowerStatus(Sps);
  result := Sps.BatteryFullLifeTime;
end;

function GetBatteryState: TDWBatteryStates;
var
  Sps: TSystemPowerStatus;
begin
  GetSystemPowerStatus(Sps);
  with Sps do begin
    if ((BatteryFlag and 1) = 1) then Include(result, dwbtsHigh);
    if ((BatteryFlag and 2) = 2) then Include(result, dwbtsLow);
    if ((BatteryFlag and 4) = 4) then Include(result, dwbtsCritical);
    if ((BatteryFlag and 8) = 8) then Include(result, dwbtsCharging);
    if ((BatteryFlag and 128) = 128) then Include(result, dwbtsNoSystemBattery);
    if ((BatteryFlag and 255) = 255) then Include(result, dwbtsUnknownState);
  end;
end;

function GetIconDimension(const Filename: string; const Index: Integer): TDWDimension;
var
  iIcon: TIcon;
begin
  iIcon := TIcon.Create;
  iIcon.Handle := ExtractIcon(GetCurrentProcess, PChar(Filename), Index);
  with result do begin
    Height := iIcon.Height;
    Width := iIcon.Width;
  end;
  iIcon.free;
end;

function GetNumberOfIcons(const Filename: string): Integer;
begin
  result := ExtractIcon(GetCurrentProcess, PChar(Filename), UINT(-1));
end;

function GetWindowsLanguageStr: string;
var
  WinLanguage: array[0..50] of char;
begin
  VerLanguageName(GetSystemDefaultLangID, WinLanguage, 50);
  Result := StrPas(WinLanguage);
end;

procedure ProcessMessages;
var
  Msg: TMsg;
begin
  while PeekMessage(Msg, GetCurrentProcess, 0, 0, PM_REMOVE) do
    //if not IsDialogMessage(Dlg, Msg) then
  begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;
end;

procedure FileOpenWithDialog(const Filename: string);
begin
  ShellExecute(GetCurrentProcess, 'open', PChar('rundll32.exe'),
    PChar('shell32.dll,OpenAs_RunDLL ' + FileName), nil, SW_SHOWNORMAL);
end;

procedure FilePropertiesDialog(const Filename: string);
var
  sei: TShellExecuteInfo;
begin
  FillChar(sei, SizeOf(sei), 0);
  sei.cbSize := SizeOf(sei);
  sei.lpFile := PChar(FileName);
  sei.lpVerb := 'properties';
  sei.fMask := SEE_MASK_INVOKEIDLIST;
  ShellExecuteEx(@sei);
end;

function FontAdd(const FontFilename: string): Boolean;
begin
  result := (AddFontResource(PChar(ExtractFilePath(ParamStr(0) + FontFilename))) <> 0);
  SendMessage(HWND_BROADCAST, WM_FONTCHANGE, 0, 0);
end;

function FontRemove(const FontFilename: string): Boolean;
begin
  result := RemoveFontResource(PChar(ExtractFilePath(ParamStr(0) + FontFilename)));
  SendMessage(HWND_BROADCAST, WM_FONTCHANGE, 0, 0);
end;

procedure StartNewBrowserWindow(const URL: string);
var
  DDEConv: TDDEClientConv;
  URLFired: bool;
  App: string;
  UpApp: string;
  p: array[0..MAX_PATH] of Char;
begin
  UrlFired := False;
  App := GetAssociatedProgram('HTM');
  UpApp := Uppercase(App);
  Delete(App, Pos('.EXE', UpAPP), Length(App));
  if Pos('NETSCAPE.EXE',
    UpApp) > 0 then
  begin
    DDEConv := TDDEClientConv.Create(nil);
    DDEConv.ServiceApplication := App;
    if DDEConv.SetLink('NETSCAPE', 'WWW_OpenURL') then
      if DDEConv.RequestData(URL + ',,0x0,0x0') <> nil then
        if DDEConv.SetLink('NETSCAPE', 'WWW_Activate') then
          URLFired := DDEConv.RequestData('0xFFFFFFFF,0x0') <> nil;
    DDEConv.Free;
  end
  else if Pos('IEXPLORE.EXE',
    UpApp) > 0 then
  begin
    DDEConv := TDDEClientConv.Create(nil);
    DDEConv.ServiceApplication := App;
    if DDEConv.SetLink('iexplore', 'WWW_OpenURL') then
      if DDEConv.RequestData(URL + ',,0') <> nil then
        if DDEConv.SetLink('iexplore', 'WWW_Activate') then
          URLFired := DDEConv.RequestData('0,0') <> nil;
    DDEConv.Free;
  end;
  if UrlFired = False then
    WinExec(StrPCopy(@p, URL), SW_SHOWNORMAL);
end;

procedure MinimizeAllWindows;
begin
  keybd_event(VK_LWIN, MapVirtualKey(VK_LWIN, 0), 0, 0);
  keybd_event(Ord('M'), MapVirtualKey(Ord('M'), 0), 0, 0);
  keybd_event(Ord('M'), MapVirtualKey(Ord('M'), 0), KEYEVENTF_KEYUP, 0);
  keybd_event(VK_LWIN, MapVirtualKey(VK_LWIN, 0), KEYEVENTF_KEYUP, 0);
end;

procedure ShowDesktop;
begin
  keybd_event(VK_LWIN, MapVirtualKey(VK_LWIN, 0), 0, 0);
  keybd_event(Ord('D'), MapVirtualKey(Ord('D'), 0), 0, 0);
  keybd_event(Ord('D'), MapVirtualKey(Ord('D'), 0), KEYEVENTF_KEYUP, 0);
  keybd_event(VK_LWIN, MapVirtualKey(VK_LWIN, 0), KEYEVENTF_KEYUP, 0);
end;

function GetACLineStatus: TDWACLineStatus;
var
  Sps: TSystemPowerStatus;
begin
  GetSystemPowerStatus(Sps);
  case Sps.ACLineStatus of
    0: result := dwalsOffline;
    1: result := dwalsOnline;
  else result := dwalsUnknownState;
  end;
end;

function GetAssociatedProgram(const Ext: string): string;
var
{$IFDEF WIN32}
  reg: TRegistry;
  s: string;
{$ELSE}
  WinIni: TIniFile;
  WinIniFileName: array[0..MAX_PATH] of Char;
  s: string;
{$ENDIF}
begin
{$IFDEF WIN32}
  s := '';
  reg := TRegistry.Create;
  reg.RootKey := HKEY_CLASSES_ROOT;
  if reg.OpenKey('.' + ext + '\shell\open\command',
    False) <> False then
  begin
    {The open command has been found}
    s := reg.ReadString('');
    reg.CloseKey;
  end
  else
  begin
    {perhaps thier is a system file pointer}
    if reg.OpenKey('.' + ext,
      False) <> False then
    begin
      s := reg.ReadString('');
      reg.CloseKey;
      if s <> '' then
      begin
        {A system file pointer was found}
        if reg.OpenKey(s + '\shell\open\command',
          False) <> False then
          {The open command has been found}
          s := reg.ReadString('');
        reg.CloseKey;
      end;
    end;
  end;
  {Delete any command line, quotes and spaces}
  if Pos('%', s) > 0 then
    Delete(s, Pos('%', s), Length(s));
  if ((Length(s) > 0) and
    (s[1] = '"')) then
    Delete(s, 1, 1);
  if ((Length(s) > 0) and
    (Pos('"', s) > 0)) then
    Delete(s, Pos('"', s), Length(s));
  while ((Length(s) > 0) and
    (s[Length(s)] = #32)) do
    Delete(s, Length(s), 1);
{$ELSE}
  GetWindowsDirectory(WinIniFileName, SizeOf(WinIniFileName));
  StrCat(WinIniFileName, '\win.ini');
  WinIni := TIniFile.Create(WinIniFileName);
  s := WinIni.ReadString('Extensions', ext, '');
  WinIni.Free;
  {Delete any command line}
  if Pos(' ^', s) > 0 then
    Delete(s, Pos(' ^', s), Length(s));
{$ENDIF}
  Result := s;
end;

function GetFileCharSetName(const FileInfo: TDWFileInfo): string;
var
  LngName: array[0..255] of Char;
begin
  LngName := '';
  VerLanguageName(FileInfo.dwFileCharSet, LngName, Length(LngName));
  result := LngName;
end;

function GetFileFlags(const FileInfo: TDWFileInfo): TDWFileFlags;
begin
  case FileInfo.dwFileFlags of
    VS_FF_DEBUG: result := dwffDebug;
    VS_FF_INFOINFERRED: result := dwffInfoInferred;
    VS_FF_PATCHED: result := dwffPatched;
    VS_FF_PRERELEASE: result := dwffPrerelease;
    VS_FF_PRIVATEBUILD: result := dwffPrivateBuild;
    VS_FF_SPECIALBUILD: result := dwffSpecialBuild;
  else result := dwffPrivateBuild;
  end;
end;

function GetFileInfo(const Filename: string): TDWFileInfo;
type
  pFixedFileInfo = ^TDWFixedFileInfo;
  pLangCharSet = ^TDWLangCharSet;
var
  Size, TmpSize: DWord;
  cFilename,
    Buffer: PChar;
  Ptr: Pointer;
  FixedInfo: TDWFixedFileInfo;
  PLCSet: pLangCharSet;
  Translation: string;

  function QueryCopyrightString(const EntryName, Translation: string; pInfoBuffer: Pointer): string;
  var
    Buffer: array[0..255] of Char;
    FuncSize: UINT;
    Ptr: Pointer;
  begin
    result := '';
    StrPCopy(Buffer, '\StringFileInfo\' + Translation + '\' + EntryName);
    if VerQueryValue(pInfoBuffer, Buffer, Ptr, FuncSize) then
      Result := StrPas(PChar(Ptr));
  end;
begin
  cFilename := StrAlloc(Length(FileName) + 1);
  StrPCopy(cFilename, FileName);
  Size := GetFileVersionInfoSize(cFilename, TmpSize);
  if Size > 0 then
  begin
    Buffer := StrAlloc(Size);
    if GetFileVersionInfo(cFilename, TmpSize, Size, Buffer) then
    begin
      VerQueryValue(Buffer, '\', Ptr, Size);
      FixedInfo := pFixedFileInfo(Ptr)^;
      VerQueryValue(Buffer, '\VarFileInfo\Translation', Ptr, Size);
      PLCSet := pLangCharSet(Ptr);
      Translation := Format('%4.4x%4.4x', [PLCSet^.dwLang, PLCSet^.dwCharSet]);
      with result do begin
        dwComments := QueryCopyrightString('Comments',
          Translation,
          Buffer);
        dwCompanyName := QueryCopyrightString('CompanyName',
          Translation,
          Buffer);
        dwFileDescription := QueryCopyrightString('FileDescription',
          Translation,
          Buffer);
        dwFileVersion := QueryCopyrightString('FileVersion',
          Translation,
          Buffer);
        dwInternalName := QueryCopyrightString('InternalName',
          Translation,
          Buffer);
        dwLegalCopyright := QueryCopyrightString('LegalCopyright',
          Translation,
          Buffer);
        dwLegalTrademarks := QueryCopyrightString('LegalTrademarks',
          Translation,
          Buffer);
        dwOriginalFilename := QueryCopyrightString('OriginalFilename',
          Translation,
          Buffer);
        dwPrivateBuild := QueryCopyrightString('PrivateBuild',
          Translation,
          Buffer);
        dwProductName := QueryCopyrightString('ProductName',
          Translation,
          Buffer);
        dwProductVersion := QueryCopyrightString('ProductVersion',
          Translation,
          Buffer);
        dwSpecialBuild := QueryCopyrightString('SpecialBuild',
          Translation,
          Buffer);
      end;
    end;
  end;
  StrDispose(cFilename);
  with result do begin
    dwSignature := FixedInfo.dwSignature;
    dwStrucVersion := FixedInfo.dwStrucVersion;
    dwFileVersionMS := FixedInfo.dwFileVersionMS;
    dwFileVersionLS := FixedInfo.dwFileVersionLS;
    dwProductVersionMS := FixedInfo.dwProductVersionMS;
    dwProductVersionLS := FixedInfo.dwProductVersionLS;
    dwFileFlagsMask := FixedInfo.dwFileFlagsMask;
    dwFileFlags := FixedInfo.dwFileFlags;
    dwFileOS := FixedInfo.dwFileOS;
    dwFileType := FixedInfo.dwFileType;
    dwFileSubtype := FixedInfo.dwFileSubtype;
    dwFileDateMS := FixedInfo.dwFileDateMS;
    dwFileDateLS := FixedInfo.dwFileDateLS;
    dwFileLanguage := PLCSet^.dwLang;
    dwFileCharSet := PLCSet^.dwCharSet;
  end;
end;

function GetFileLanguageName(const FileInfo: TDWFileInfo): string;
var
  LngName: array[0..255] of Char;
begin
  LngName := '';
  VerLanguageName(FileInfo.dwFileLanguage, LngName, Length(LngName));
  result := LngName;
end;

function GetFileOS(const FileInfo: TDWFileInfo): TDWFileOSSet;
begin
  if (FileInfo.dwFileOS and VOS_DOS) > 0
    then Include(result, dwfosDOS);
  if (FileInfo.dwFileOS and VOS_DOS_WINDOWS16) > 0
    then Include(result, dwfosDOS_Windows16);
  if (FileInfo.dwFileOS and VOS_DOS_WINDOWS32) > 0
    then Include(result, dwfosDOS_Windows32);
  if (FileInfo.dwFileOS and VOS_NT) > 0
    then Include(result, dwfosNT);
  if (FileInfo.dwFileOS and VOS_NT_WINDOWS32) > 0
    then Include(result, dwfosNT_Windows32);
  if (FileInfo.dwFileOS and VOS_OS216) > 0
    then Include(result, dwfosOS2_16);
  if (FileInfo.dwFileOS and VOS_OS216_PM16) > 0
    then Include(result, dwfosOS2_16_PM16);
  if (FileInfo.dwFileOS and VOS_OS232) > 0
    then Include(result, dwfosOS2_32);
  if (FileInfo.dwFileOS and VOS_OS232_PM32) > 0
    then Include(result, dwfosOS2_32_PM32);
  if (FileInfo.dwFileOS and VOS__WINDOWS16) > 0
    then Include(result, dwfosWindows16);
  if (FileInfo.dwFileOS and VOS__WINDOWS32) > 0
    then Include(result, dwfosWindows32);
  if (FileInfo.dwFileOS and VOS__PM16) > 0
    then Include(result, dwfosPM16);
  if (FileInfo.dwFileOS and VOS__PM32) > 0
    then Include(result, dwfosPM32);
  if result = [] then result := [dwfosUnknown];
end;

function GetFileProductVersionMS(const FileInfo: TDWFileInfo): TDWVersionBlock;
begin
  result.dwVersionMajor := (FileInfo.dwProductVersionMS and $FFFF0000) shr $10;
  result.dwVersionMinor := FileInfo.dwProductVersionMS and $FFFF;
end;

function GetFileProductVersionLS(const FileInfo: TDWFileInfo): TDWVersionBlock;
begin
  result.dwVersionMajor := (FileInfo.dwProductVersionLS and $FFFF0000) shr $10;
  result.dwVersionMinor := FileInfo.dwProductVersionLS and $FFFF;
end;

function GetFileSubType(const FileInfo: TDWFileInfo): TDWFileSubType;
begin
  if (FileInfo.dwFileType = VFT_FONT) then begin
    case FileInfo.dwFileSubtype of
      VFT2_FONT_RASTER: result := dwfstFontRaster;
      VFT2_FONT_TRUETYPE: result := dwfstFontTruetype;
      VFT2_FONT_VECTOR: result := dwfstFontVector;
    else result := dwfstUnknown;
    end;
    exit;
  end;
  case FileInfo.dwFileSubtype of
    VFT2_DRV_COMM: result := dwfstCOMM;
    VFT2_DRV_DISPLAY: result := dwfstDisplay;
    VFT2_DRV_INSTALLABLE: result := dwfstInstallable;
    VFT2_DRV_KEYBOARD: result := dwfstKeyboard;
    VFT2_DRV_LANGUAGE: result := dwfstLanguage;
    VFT2_DRV_MOUSE: result := dwfstMouse;
    VFT2_DRV_NETWORK: result := dwfstNetwork;
    VFT2_DRV_PRINTER: result := dwfstPrinter;
    VFT2_DRV_SOUND: result := dwfstSound;
    VFT2_DRV_SYSTEM: result := dwfstSystem;
    VFT2_UNKNOWN: result := dwfstUnknown;
  else result := dwfstUnknown;
  end;
end;

function GetFileType(const FileInfo: TDWFileInfo): TDWFileType;
begin
  case FileInfo.dwFileType of
    VFT_UNKNOWN: result := dwftUnknown;
    VFT_APP: result := dwftApp;
    VFT_DLL: result := dwftDLL;
    VFT_DRV: result := dwftDRV;
    VFT_FONT: result := dwftFont;
    VFT_VXD: result := dwftVXD;
    VFT_STATIC_LIB: result := dwftStaticLib
  else result := dwftUnknown;
  end;
end;

function GetFileStrucVersion(const FileInfo: TDWFileInfo): TDWVersionBlock;
begin
  result.dwVersionMajor := (FileInfo.dwStrucVersion and $FFFF0000) shr $10;
  result.dwVersionMinor := FileInfo.dwStrucVersion and $FFFF;
end;

function GetFileVersionLS(const FileInfo: TDWFileInfo): TDWVersionBlock;
begin
  result.dwVersionMajor := (FileInfo.dwFileVersionLS and $FFFF0000) shr $10;
  result.dwVersionMinor := FileInfo.dwFileVersionLS and $FFFF;
end;

function GetFileVersionMS(const FileInfo: TDWFileInfo): TDWVersionBlock;
begin
  result.dwVersionMajor := (FileInfo.dwFileVersionMS and $FFFF0000) shr $10;
  result.dwVersionMinor := FileInfo.dwFileVersionMS and $FFFF;
end;

{procedure GetVideoModes(var ModeList: TStringList);
var
  ModeNumber, j: Integer;
  MyMode: TDeviceModeA;
  Check, Need: Boolean;
  Str: string;
begin
  ModeNumber:=0;
  Check:=True;
  while(Check) do
  begin
    Check:=EnumDisplaySettings(nil, ModeNumber, MyMode);
    Str:=IntToStr(MyMode.dmPelsWidth)+'-'+IntToStr(MyMode.dmPelsHeight);
    Need:=False;
    for j:=0 to ModeList.Count-1 do
      if ModeList[j]=Str then
        Need:=True;
    if Need=False then ModeList.Add(Str);
    Inc(ModeNumber);
  end;
end;  }

procedure DisableCaptionCloseButton(const FormHandle: THandle);
var
  hMnu: THandle;
begin
  hMnu := GetSystemMenu(FormHandle, FALSE);
  EnableMenuItem(hMnu, SC_MINIMIZE, SC_CLOSE or MF_GRAYED);
end;

procedure EnableCaptionCloseButton(const FormHandle: THandle);
var
  hMnu: THandle;
begin
  hMnu := GetSystemMenu(FormHandle, FALSE);
  EnableMenuItem(hMnu, SC_MINIMIZE, SC_CLOSE or MF_ENABLED);
end;

function ScreenColorDepth(const Index: Byte): Byte;
var
  DevMode: TDeviceMode;
begin
  result := 0;
  if EnumDisplaySettings(PChar(ScreenDeviceName(Index)), ENUM_CURRENT_SETTINGS,
    DevMode) then begin
    result := DevMode.dmBitsPerPel;
  end;
end;

function ScreenDeviceName(const Index: Byte): string;
var
  DisplayDevice: TDisplayDevice;
begin
  result := '';
  DisplayDevice.cb := SizeOf(DisplayDevice);
  if EnumDisplayDevices(nil, Index, DisplayDevice, 0) then begin
    result := DisplayDevice.DeviceName;
  end;
end;

function ScreenDeviceString(const Index: Byte): string;
var
  DisplayDevice: TDisplayDevice;
begin
  result := '';
  DisplayDevice.cb := SizeOf(DisplayDevice);
  if EnumDisplayDevices(nil, Index, DisplayDevice, 0) then begin
    result := DisplayDevice.DeviceString;
  end;
end;

function ScreenDeviceType(const Index: Byte): TDWScreenTypes;
var
  DisplayDevice: TDisplayDevice;
begin
  result := [];
  DisplayDevice.cb := SizeOf(DisplayDevice);
  if EnumDisplayDevices(nil, Index, DisplayDevice, 0) then begin
    with DisplayDevice do begin
      if ((StateFlags and DISPLAY_DEVICE_ATTACHED_TO_DESKTOP) =
        DISPLAY_DEVICE_ATTACHED_TO_DESKTOP) then Include(result, dwscrtDesktop);

      if ((StateFlags and DISPLAY_DEVICE_MIRRORING_DRIVER) =
        DISPLAY_DEVICE_MIRRORING_DRIVER) then Include(result, dwscrtMirror);

      if ((StateFlags and DISPLAY_DEVICE_MODESPRUNED) =
        DISPLAY_DEVICE_MODESPRUNED) then Include(result, dwscrtModeSpruned);

      if ((StateFlags and DISPLAY_DEVICE_PRIMARY_DEVICE) =
        DISPLAY_DEVICE_PRIMARY_DEVICE) then Include(result, dwscrtPrimary);

      if ((StateFlags and DISPLAY_DEVICE_REMOVABLE) =
        DISPLAY_DEVICE_REMOVABLE) then Include(result, dwscrtRemovable);

      if ((StateFlags and DISPLAY_DEVICE_VGA_COMPATIBLE) =
        DISPLAY_DEVICE_VGA_COMPATIBLE) then Include(result, dwscrtVGA);
    end;
  end;
end;

function ScreenFrequency(const Index: Byte): Integer;
var
  DevMode: TDeviceMode;
begin
  result := 0;
  if EnumDisplaySettings(PChar(ScreenDeviceName(Index)), ENUM_CURRENT_SETTINGS,
    DevMode) then begin
    result := DevMode.dmDisplayFrequency;
  end;
end;

function ScreenResolution(const Index: Byte): TDWDimension;
var
  DevMode: TDeviceMode;
begin
  with result do begin
    Height := 0;
    Width := 0;
  end;
  if EnumDisplaySettings(PChar(ScreenDeviceName(Index)), ENUM_CURRENT_SETTINGS,
    DevMode) then begin
    with result do begin
      Height := DevMode.dmPelsHeight;
      Width := DevMode.dmPelsWidth;
    end;
  end;
end;

function ScreenMonitorString(const Index: Byte): string;
var
  DisDev, DisDevMon: TDisplayDevice;
begin
  result := '';
  DisDev.cb := SizeOf(TDisplayDevice);
  DisDevMon.cb := SizeOf(TDisplayDevice);
  if EnumDisplayDevices(nil, Index, DisDev, 0) then begin
    if DisDev.StateFlags = DISPLAY_DEVICE_MIRRORING_DRIVER then exit;
    while EnumDisplayDevices(@DisDev.DeviceName, 0, DisDevMon, 0) do begin
      result := DisDevMon.DeviceString;
      if (DisDevMon.StateFlags <> DISPLAY_DEVICE_ACTIVE) then break;
    end;
  end;
end;

function ScreenMonitorName(const Index: Byte): string;
var
  DisDev, DisDevMon: TDisplayDevice;
begin
  result := '';
  DisDev.cb := SizeOf(TDisplayDevice);
  DisDevMon.cb := SizeOf(TDisplayDevice);
  if EnumDisplayDevices(nil, Index, DisDev, 0) then begin
    if DisDev.StateFlags = DISPLAY_DEVICE_MIRRORING_DRIVER then exit;
    while EnumDisplayDevices(@DisDev.DeviceName, 0, DisDevMon, 0) do begin
      result := DisDevMon.DeviceName;
      if (DisDevMon.StateFlags <> DISPLAY_DEVICE_ACTIVE) then break;
    end;
  end;
end;
function EnumDisplaySettingsExW(lpszDeviceName: PChar;
  iModeNum: DWord;
  lpDevMode: _devicemodeA_0500;
  dwFlags: DWord): Boolean; external 'user32.dll';

function ScreenMonitorPosition(const Index: Byte; var Point: TPoint): Boolean;

type
{   _EnumDisplaySettingsEx = function(lpszDeviceName: PChar;
                                    iModeNum: DWord;
                                    lpDevMode: _devicemodeA_0500;
                                    dwFlags: DWord):Boolean; StdCall;}
  MONITORINFO = record
    cbSize: DWord;
    rcMonitor,
      rcWork: TRect;
    dwFlags: Dword;
  end;
const
  DLLName: PChar = 'User32.dll';
  FcnName: PChar = 'EnumDisplaySettingsExW';
var
//   DLLHndl: THandle;
  bCanLoadDLL,
    bCanLoadFcn,
    bCanEnumDevice,
    bCanEnumExMonitor: Boolean;
//   EnumDisplaySettingsEx: _EnumDisplaySettingsEx;
  DisDev, DisDevMon: TDisplayDevice;
  DevMode: _devicemodeA_0500;
  MI: MONITORINFO;
  HM: THandle;
begin
  with Point do begin
    x := 0;
    y := 0;
  end;
  bCanLoadFcn := FALSE;
  bCanEnumDevice := FALSE;
  bCanEnumExMonitor := FALSE;
  ZeroMemory(@DisDev, SizeOf(TDisplayDevice));
  DisDev.cb := SizeOf(TDisplayDevice);
//   DLLHndl:= LoadLibrary(DLLName);
//   bCanLoadDLL:= (DLLHndl <> 0);
  if bCanLoadDLL then begin
//      EnumDisplaySettingsEx:= GetProcAddress(DLLHndl, FcnName);
//      if Assigned(EnumDisplaySettingsEx) then begin
//          bCanLoadFcn:= Assigned(EnumDisplaySettingsEx);
    bCanEnumDevice := EnumDisplayDevices(nil, Index, DisDev, 0);
    DisDevMon.cb := SizeOf(TDisplayDevice);
    EnumDisplayDevices(@DisDev.DeviceName, 0, DisDevMon, 0);
    ZeroMemory(@DevMode, SizeOf(_devicemodeA_0500));
    DevMode.dmSize := SizeOf(_devicemodeA_0500);
    {ERR!} bCanEnumExMonitor := EnumDisplaySettingsExW(@DisDev.DeviceName[0], ENUM_CURRENT_SETTINGS, DevMode, 0);
    if bCanEnumExMonitor then begin
      ZeroMemory(@MI, SizeOf(MONITORINFO));
      MI.cbSize := SizeOf(MONITORINFO);
      if DisDev.StateFlags = DISPLAY_DEVICE_ATTACHED_TO_DESKTOP then begin
        Point.x := DevMode.dmPosition.x;
        Point.y := DevMode.dmPosition.y;
        hm := MonitorFromPoint(Point, MONITOR_DEFAULTTONULL);
        if (hm <> 0) then GetMonitorInfo(hm, @mi);
      end;
    end;
  end;
//   end;
//   FreeLibrary(DLLHndl);
  result := bCanLoadDLL and bCanLoadFcn and bCanEnumDevice and bCanEnumExMonitor;
end;

function MouseButtonsSwaped: Boolean;
begin
  result := GetSystemMetrics(SM_SWAPBUTTON) <> 0;
end;

function GetMenuAlignment: TDWMenuAlignment;
begin
  if GetSystemMetrics(SM_MENUDROPALIGNMENT) <> 0 then
    result := dwmaRight else
    result := dwmaLeft;
end;

function GetMouseButtons: Integer;
begin
  result := GetSystemMetrics(SM_CMOUSEBUTTONS);
end;

function GetMinimizedWindowArrangement: TDWMinimizedWindowArrangement;
begin
  case GetSystemMetrics(SM_ARRANGE) of
    ARW_BOTTOMRIGHT: result := dwmwaBottomRight;
    ARW_HIDE: result := dwmwaHide;
    ARW_TOPLEFT: result := dwmwaTopLeft;
    ARW_TOPRIGHT: result := dwmwaTopRight
  else result := dwmwaBottomLeft;
  end;
end;

function NetworkIsPresent: Boolean;
begin
  result := (GetSystemMetrics(SM_NETWORK) <> 0);
end;

function GetCapslock: Boolean;
var
  KS: TKeyboardState;
begin
  GetKeyboardState(KS);
  result := (KS[VK_CAPITAL] <> 0);
end;

function GetNumLock: Boolean;
var
  KS: TKeyboardState;
begin
  GetKeyboardState(KS);
  result := (KS[VK_NUMLOCK] <> 0);
end;

function GetScrollLock: Boolean;
var
  KS: TKeyboardState;
begin
  GetKeyboardState(KS);
  result := (KS[VK_SCROLL] <> 0);
end;

procedure SetCapsLock(const CapsLockOn: Boolean);
var
  KS: TKeyboardState;
begin
  GetKeyboardState(KS);
  if CapsLockOn then KS[VK_CAPITAL] := 1 else KS[VK_CAPITAL] := 0;
  SetKeyboardState(KS);
end;

procedure SetNumLock(const NumLockOn: Boolean);
var
  KS: TKeyboardState;
begin
  GetKeyboardState(KS);
  if NumLockOn then KS[VK_NUMLOCK] := 1 else KS[VK_NUMLOCK] := 0;
  SetKeyboardState(KS);
end;

procedure SetScrollLock(const ScrollLockOn: Boolean);
var
  KS: TKeyboardState;
begin
  GetKeyboardState(KS);
  if ScrollLockOn then KS[VK_SCROLL] := 1 else KS[VK_SCROLL] := 0;
  SetKeyboardState(KS);
end;

function GetBootOption: TDWBootOption;
begin
  case GetSystemMetrics(SM_CLEANBOOT) of
    1: result := dwboFailSafe;
    2: result := dwboFailSaveNet;
  else result := dwboNormal;
  end;
end;

function MouseHasWheel: Boolean;
begin
  result := (GetSystemMetrics(SM_MOUSEWHEELPRESENT) <> 0);
end;

function MouseIsPresent: Boolean;
begin
  result := (GetSystemMetrics(SM_MOUSEPRESENT) <> 0);
end;

function AvailablePageMemory: Int64;
var
  MemStat: TMemoryStatus;
begin
  MemStat.dwLength := SizeOf(MemStat);
  GlobalMemoryStatus(MemStat);
  result := MemStat.dwAvailPageFile;
end;

function AvailablePhysicalMemory: Int64;
var
  MemStat: TMemoryStatus;
begin
  MemStat.dwLength := SizeOf(MemStat);
  GlobalMemoryStatus(MemStat);
  result := MemStat.dwAvailPhys;
end;

function AvailableVirtualMemory: Int64;
var
  MemStat: TMemoryStatus;
begin
  MemStat.dwLength := SizeOf(MemStat);
  GlobalMemoryStatus(MemStat);
  result := MemStat.dwAvailVirtual;
end;

function MemoryUsedPercentage: Integer;
var
  MemStat: TMemoryStatus;
begin
  MemStat.dwLength := SizeOf(MemStat);
  GlobalMemoryStatus(MemStat);
  result := MemStat.dwMemoryLoad;
end;

function SoundCardInstalled: Boolean;
begin
  result := WaveOutGetNumDevs > 0;
end;

function TotalPageMemory: Int64;
var
  MemStat: TMemoryStatus;
begin
  MemStat.dwLength := SizeOf(MemStat);
  GlobalMemoryStatus(MemStat);
  result := MemStat.dwTotalPageFile;
end;

function TotalPhysicalMemory: Int64;
var
  MemStat: TMemoryStatus;
begin
  MemStat.dwLength := SizeOf(MemStat);
  GlobalMemoryStatus(MemStat);
  result := MemStat.dwTotalPhys;
end;

function TotalVirtualMemory: Int64;
var
  MemStat: TMemoryStatus;
begin
  MemStat.dwLength := SizeOf(MemStat);
  GlobalMemoryStatus(MemStat);
  result := MemStat.dwTotalVirtual;
end;

function EmptyRecycleBin(const Confirmation, GUI, Sound: Boolean): Boolean;
const
  SHERB_NOCONFIRMATION = $00000001;
  SHERB_NOPROGRESSUI = $00000002;
  SHERB_NOSOUND = $00000004;
type
  TSHEmptyRecycleBin = function(Wnd: HWND;
    pszRootPath: PChar;
    dwFlags: DWORD): HRESULT; stdcall;
var
  SHEmptyRecycleBin: TSHEmptyRecycleBin;
  LibHandle: THandle;
  Flags: DWord;
begin { EmptyRecycleBin }
  result := FALSE;
  Flags := 0;
  if not Confirmation then Flags := Flags or SHERB_NOCONFIRMATION;
  if not GUI then Flags := Flags or SHERB_NOPROGRESSUI;
  if not Sound then Flags := Flags or SHERB_NOSOUND;
  LibHandle := LoadLibrary(PChar('Shell32.dll'));
  if LibHandle <> 0 then @SHEmptyRecycleBin :=
    GetProcAddress(LibHandle, 'SHEmptyRecycleBinA')
  else
  begin
    MessageDlg('Shell32.dll konnte nicht geladen werden.', mtError, [mbOK], 0);
    Exit;
  end;
  if @SHEmptyRecycleBin <> nil then result := (SHEmptyRecycleBin(GetCurrentProcess, nil, Flags) = S_OK);
  FreeLibrary(LibHandle); @SHEmptyRecycleBin := nil;
end;

function FilesInRecycleBin(var FileCount: Int64): Boolean;
type
  _SHQUERYRBINFO = record
    cbSize: DWord;
    i64Sizelow, i64Sizehigh,
      i64NumItemslow, i64NumItemshigh: DWord;
  end;
  TPSHQUERYRBINFO = ^_SHQUERYRBINFO;
  TSHQueryRecycleBin = function(pszRootPath: PChar;
    var pSHQueryRBInfo: TPSHQUERYRBINFO): HRESULT; stdcall;
var
  SHQueryRecycleBin: TSHQueryRecycleBin;
  SHQueryRBInfo: _SHQUERYRBINFO;
  pSHQueryRBInfo: TPSHQUERYRBINFO;
  LibHandle: THandle;
begin { EmptyRecycleBin }
  result := FALSE;
  SHQueryRBInfo.cbSize := SizeOf(SHQueryRBInfo);
  LibHandle := LoadLibrary(PChar('Shell32.dll'));
  if LibHandle <> 0 then @SHQueryRecycleBin :=
    GetProcAddress(LibHandle, 'SHQueryRecycleBinA')
  else
  begin
    MessageDlg('Shell32.dll konnte nicht geladen werden.', mtError, [mbOK], 0);
    Exit;
  end;
  if not Assigned(SHQueryRecycleBin) then begin
    MessageDlg('Shell32.dll konnte nicht geladen werden.', mtError, [mbOK], 0);
    Exit;
  end;

  pSHQueryRBInfo := @SHQueryRBInfo;
  SHQueryRBInfo.cbSize := sizeof(SHQueryRBInfo);
  SHQueryRBInfo.i64numitemslow := 0;
  SHQueryRBInfo.i64numitemshigh := 0;

  result := (SHQueryRecycleBin(PChar('c:'), pSHQueryRBInfo) = S_OK);
  filecount := SHQueryRBInfo.i64numitemslow;
  FreeLibrary(LibHandle); @SHQueryRecycleBin := nil;
end;

function CPUClock: Double;
const
  DelayTime = 500;
var
  TimerHigh, TimerLow: DWORD;
begin
  SetPriorityClass(GetCurrentProcess, REALTIME_PRIORITY_CLASS);
  SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_TIME_CRITICAL);
  Sleep(10);
  asm
    dw 310Fh
    mov TimerLow,eax
    mov TimerHigh,edx
  end;
  Sleep(DelayTime);
  asm
    dw 310Fh
    sub eax,TimerLow
    sbb edx,TimerHigh
    mov TimerLow,eax
    mov TimerHigh,edx
  end;
  Result := TimerLow / (1000.0 * DelayTime);
end;

procedure MonitorOff;
begin
  SendMessage(GetCurrentProcess, WM_SYSCOMMAND, SC_MONITORPOWER, 0);
end;

procedure MonitorOn;
begin
  SendMessage(GetCurrentProcess, WM_SYSCOMMAND, SC_MONITORPOWER, -1);
end;

procedure SetSystemClock(Year, Month, Day, Hour, Minute, Second, MSecond: Integer);
var
  SysTime: TSystemTime;
  DayTime: TDateTime;
begin
  DayTime := EncodeDate(Year, Month, Day) +
    EncodeTime(Hour, Minute, Second, MSecond);
  DateTimeToSystemTime(DayTime, SysTime);
  SetLocalTime(SysTime);
end;

end.

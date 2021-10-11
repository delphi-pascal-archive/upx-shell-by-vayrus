//В файле проекта дополнительные функции
unit Utils;

interface

uses
Windows,
Classes,
ComCtrls,
SysUtils,
ShellAPI,
IniFiles,
ShlObj,
Controls,
Graphics,
Dialogs,
ActiveX,
ComObj,
TlHelp32;

type
TFileDateTimeStamp = packed record
Creation,
LastAccess,
LastWrite: TDateTime;
end;

function ChangeFileExtToINI(FN:string):string;
procedure DesktopUpdate;
procedure KillUPX;
procedure AppRestart;
function AppInCD:boolean;
function DriveIsCDROM(FileName: string): boolean;
function FileIsOpen(const FileName:String):Boolean;
procedure CreateLink(const AppName,LinkLocation,LinkDesc,RunParam:string);
function DelXPStyle(AppName:string):boolean;
procedure ApplyXPStyle(AppName:string;ReplExists:boolean=True);
function OpenAny(FileName:string; Params: string=''; Maximized:boolean=False; Hidden: Boolean=False): Boolean;
procedure FilePropertiesDialog(const Filename: string);
procedure MinimizeAllWindows;
procedure ProcessMessages;
function WinRunTime:string;
function WinWorkTime:string;
function ResolveShortcut(Wnd: HWND; ShortcutPath: string): string;
function FullRepairString(str:string):string;
function  GetFileSize(Datei: String): Int64;
function GetSelectedFile(LV:TListView):string;
procedure SaveStringToFile(const Str, Filename: String);
function GetFileCRC32Hex(const Filename: String): String;
procedure AddFiles(OD:TOpenDialog;LB:TListView);//
function TranslateExeInfo(BinaryType, Subsystem: DWORD): String;
procedure GetExecutableInfo( const Filename: String; var BinaryType, Subsystem: DWORD);
function ExecConsoleApp(const ApplicationName, Parameters: String;
                        AppOutput: TStrings;     {will receive output of child process}
                        OnNewLine: TNotifyEvent  {if assigned called on each new line}
                        ): DWORD;
procedure ListViewAdd(FN:string;Entries:TListView);
procedure DelSel(LB:TListView);//
function GetSystemIconIndex(const AFileName: string): integer;
procedure AssignSystemImageList(AImageList: TImageList);
function BiteToKBite(Bite:integer):string;
function CompareLVStrings(NewFN:string;Entries: TListView):boolean;
function ItemsToString(Entries: TListView):string;
function RemoveString(source,target:string):string;
function FileVersion(NameApp : string) : string;
function RepairPathName(d1:String):String;
function DelTwoSpace(s:string):string;
procedure ExtractRes(ResType, ResName, ResNewName : String);
function GetDirectory(St:string):String;
function GSD(I: integer): string;
procedure DeleteInvalidEntries(Entries: TListView);
function SelDir(TITLE:string;FHandle:thandle):string;
procedure FileCopy(const SourceFileName, TargetFileName: string);
function GetFileCRC32Int(const Filename: String): DWord;
function EXEINFO(FN:string):string;
function KillTask(ExeFileName:string):integer;
function GetCurDir:string;
procedure CRC64Next(const Data; const Count:
  Cardinal; var CRC64: Int64);
function CRC64Full(const Data; const Count:
  Cardinal): Int64;
function  CRC64Stream(const Source:
  TStream; Count: Integer; const BufSize:
  Cardinal = 1024): Int64;

const
  SCS_VXD_BINARY = 6;  {linear executable. Could be OS/2. NT thinks DOS!}
  SCS_WIN32_DLL = 7;
  SCS_DPMI_BINARY = 8; {guessing a bit here. Based on NE header loader flags}

const
  // ----------------------------------------------------
  VER_NT_WORKSTATION                 = $0000001;	     //Система является Windows XP Professional, Windows XP Home Edition,
  {$EXTERNALSYM VER_NT_WORKSTATION}                    //                 Windows 2000 Professional, или Windows NT 4.0 Workstation.
  VER_NT_DOMAIN_CONTROLLER           = $0000002;	     // Система является контроллером домена.
  {$EXTERNALSYM VER_NT_DOMAIN_CONTROLLER}              //
  VER_NT_SERVER	               	     = $0000003;       // Система является сервером.
  {$EXTERNALSYM VER_NT_SERVER}                         //
  // Флаги установленных компонентов Windows ------------
  VER_SUITE_BACKOFFICE               = $00000004;      // Установлены компоненты Microsoft BackOffice.
  {$EXTERNALSYM VER_SUITE_BACKOFFICE}                  //
  VER_SUITE_BLADE                    = $00000400;      // Установлен Windows Server 2003, Web Edition.
  {$EXTERNALSYM VER_SUITE_BLADE}                       //
  VER_SUITE_DATACENTER               = $00000080;      // Установлен Windows Server 2003, Datacenter Edition или Windows 2000 Datacenter Server.
  {$EXTERNALSYM VER_SUITE_DATACENTER}                  //
  VER_SUITE_ENTERPRISE               = $00000002;      // Установлен Windows Server 2003, Enterprise Edition, Windows 2000 Advanced Server, или Windows NT 4.0 Enterprise Edition.
  {$EXTERNALSYM VER_SUITE_ENTERPRISE}                  //
  VER_SUITE_EMBEDDEDNT               = $00000040;      // Установлена Windows XP Embedded.
  {$EXTERNALSYM VER_SUITE_EMBEDDEDNT}                  //
  VER_SUITE_PERSONAL                 = $00000200;      // Установлена Windows XP Home Edition.
  {$EXTERNALSYM VER_SUITE_PERSONAL}                    //
  VER_SUITE_SINGLEUSERTS             = $00000100;      // Установлены службы терминалов, но поддерживается только одна интерактивная сесия.
  {$EXTERNALSYM VER_SUITE_SINGLEUSERTS}                //
  VER_SUITE_SMALLBUSINESS            = $00000001;      // Microsoft Small Business Server устанавливались в системе, but may have been upgraded to another version of Windows.
  {$EXTERNALSYM VER_SUITE_SMALLBUSINESS}               //
  VER_SUITE_SMALLBUSINESS_RESTRICTED = $00000020;      // Установлен Microsoft Small Business Server with the restrictive client license in force..
  {$EXTERNALSYM VER_SUITE_SMALLBUSINESS_RESTRICTED}    //
  VER_SUITE_TERMINAL                 = $00000010;      // Установлены Terminal Services.
  {$EXTERNALSYM VER_SUITE_TERMINAL}                    //
// ------------------------------------------------------
type                                                   //
  POSVersionInfoExA = ^TOSVersionInfoExA;              //
  POSVersionInfoExW = ^TOSVersionInfoExW;              //
  POSVersionInfoEx = POSVersionInfoExA;                //
  _OSVERSIONINFOEXA = record                           //
    dwOSVersionInfoSize : DWORD;                       // Размер структуры (утсанавливается перед вызовом)
    dwMajorVersion      : DWORD;                       // Основной номер версии ОС
    dwMinorVersion      : DWORD;                       // Дополнительный номер версии ОС
    dwBuildNumber       : DWORD;                       // Номер сборки
    dwPlatformId        : DWORD;                       // Идентификатор платформы
    szCSDVersion        : array[0..127] of AnsiChar;   // Maintenance string for PSS usage
    wServicePackMajor   : WORD;                        // Основной номер Service Pack
    wServicePackMinor   : WORD;                        // Дополнительный номер Service Pack
    wSuiteMask          : WORD;                        // Флаги установленных компонентов
    wProductType        : Byte;                        // Тип продукта
    wReserved           : Byte;                        // Зарезервировано
  end;                                                 //
  {$EXTERNALSYM _OSVERSIONINFOEXA}                     //
  _OSVERSIONINFOEXW = record                           //
    dwOSVersionInfoSize : DWORD;                       // Размер структуры (утсанавливается перед вызовом)
    dwMajorVersion      : DWORD;                       // Основной номер версии ОС
    dwMinorVersion      : DWORD;                       // Дополнительный номер версии ОС
    dwBuildNumber       : DWORD;                       // Номер сборки
    dwPlatformId        : DWORD;                       // Идентификатор платформы
    szCSDVersion        : array[0..127] of WideChar;   // Maintenance string for PSS usage
    wServicePackMajor   : WORD;                        // Основной номер Service Pack
    wServicePackMinor   : WORD;                        // Дополнительный номер Service Pack
    wSuiteMask          : WORD;                        // Флаги установленных компонентов
    wProductType        : Byte;                        // Тип продукта
    wReserved           : Byte;                        // Зарезервировано
  end;                                                 //
  {$EXTERNALSYM _OSVERSIONINFOEXW}                     //
  _OSVERSIONINFOEX = _OSVERSIONINFOEXA;                //
  TOSVersionInfoExA = _OSVERSIONINFOEXA;               //
  TOSVersionInfoExW = _OSVERSIONINFOEXW;               //
  TOSVersionInfoEx = TOSVersionInfoExA;                //
  OSVERSIONINFOEXA = _OSVERSIONINFOEXA;                //
  {$EXTERNALSYM OSVERSIONINFOEXA}                      //
  {$EXTERNALSYM OSVERSIONINFOEX}                       //
  OSVERSIONINFOEXW = _OSVERSIONINFOEXW;                //
  {$EXTERNALSYM OSVERSIONINFOEXW}                      //
  {$EXTERNALSYM OSVERSIONINFOEX}                       //
  OSVERSIONINFOEX = OSVERSIONINFOEXA;                  //

  // Перекрытие GetVersionEx, объявленной в Windows.pas, для
  // возможности работы как с TOSVersionInfo, так и с TOSVersionInfoEx
  function GetVersionEx(lpVersionInformation: Pointer): BOOL; stdcall;
  {$EXTERNALSYM GetVersionEx}

  function GetWindowsVersionEx(out AName, AVersion, ABuild, ASPack: string): LongBool;

var
TIF : TIniFile;
T   : array[Byte] of Int64;

resourcestring
XPMan='<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'+
'<assembly xmlns="urn:schemas-microsoft-com:asm.v1" manifestVersion="1.0">'+
'<assemblyIdentity version="1.0.0.0" processorArchitecture="*" name="UPXShell" type="win32"/>'+
'<description>UPXShell</description><dependency> <dependentAssembly><assemblyIdentity type="win32" '+
'name="Microsoft.Windows.Common-Controls" version="6.0.0.0" processorArchitecture="*" publicKeyToken='+
'"6595b64144ccf1df" language="*"/></dependentAssembly></dependency></assembly>';

implementation

function ChangeFileExtToINI(FN:string):string;
const
INIExt='.ini';
begin
RESULT:=ChangeFileExt(FN,INIExt);
end;

procedure DesktopUpdate;
begin
keybd_event(VK_LWIN, MapVirtualKey(VK_LWIN, 0), 0, 0);
keybd_event(Ord('D'), MapVirtualKey(Ord('D'), 0), 0, 0);
keybd_event(Ord('D'), MapVirtualKey(Ord('D'), 0), KEYEVENTF_KEYUP, 0);
keybd_event(VK_LWIN, MapVirtualKey(VK_LWIN, 0), KEYEVENTF_KEYUP, 0);
end;

procedure KillUPX;
begin
ProcessMessages;
KillTask('upx.exe');
end;

function AppExec(const CmdLine, CmdParams: String; const CmdShow: Integer): Boolean;
begin
Result:=ShellExecute(GetCurrentProcess,'open',PChar(CmdLine),PChar(CmdParams),'',CmdShow)>32;
end;

procedure AppRestart;
begin
AppExec(ParamStr(0), '', SW_SHOWNORMAL);
TerminateProcess(GetCurrentProcess, 0);
end;

function AppInCD:boolean;
begin
RESULT:=DriveIsCDROM(ParamStr(0));
end;

function DriveIsCDROM(FileName: string): boolean;
var
s: string;
i: integer;
begin
s := ExtractFileDrive(FileName);
if (s = '') then
s := ExtractFileDrive(ExpandFileName(FileName));
i := GetDriveType(PChar(s));
//0-Unknown, 1-NoDrive, 2-Floppy, 3-Fixed, 4-Network, 5-CDROM, 6-RAM
Result := (i = 5);
end;

function FileIsOpen(const FileName:String):Boolean;
var
Datei:TFileStream;
begin
Result:=FALSE;
if FileExists(Filename) then begin
try
Datei:=TFileStream.Create(FileName,fmOpenRead or fmShareDenyWrite);
Datei.Free;
except
on EFOpenError do result:=True;
{on EWriteError do result:= true;}
end;
end;
end;

procedure CreateLink(const AppName,LinkLocation,LinkDesc,RunParam:string);
var
IObject:IUnknown;
SLink:IShellLink;
PFile:IPersistFile;
begin
IObject:=CreateComObject(CLSID_ShellLink);
SLink:=IObject as IShellLink;
PFile:=IObject as IPersistFile;
with SLink do
begin
SetArguments(PChar(RunParam));
SetDescription(PChar(LinkDesc));
SetPath(PChar(AppName));
SetWorkingDirectory(Pchar(IncludeTrailingPathDelimiter(ExtractFilePath(AppName))));
end;
PFile.Save(PWChar(WideString(LinkLocation)),FALSE);
end;

procedure SaveStringToFile(const Str, FileName: String);
var
TF:TextFile;
begin
AssignFile(TF,FileName);
try
Rewrite(TF);
ProcessMessages;
Write(TF,Str);
finally
Close(TF);
end;
end;

procedure ApplyXPStyle(AppName:string;ReplExists:boolean=True);
const
manifest='.manifest';
begin
if (FileExists(AppName+manifest)) and not ReplExists then EXIT;
SaveStringToFile(XPMan,AppName+manifest);
end;

function DelXPStyle(AppName:string):boolean;
const
manifest='.manifest';
begin
RESULT:=False;
if FileExists(AppName+manifest) then
RESULT:=DeleteFile(AppName+manifest);
end;

function OpenAny(FileName:string; Params: string=''; Maximized:boolean=False; Hidden: Boolean=False): Boolean;
const
SHOW_FLAGS: array[Boolean] of Integer = (SW_SHOWNORMAL, SW_SHOWMAXIMIZED);
begin
if Maximized then
Result:=ShellExecute(0, nil, PChar(FileName), PChar(Params), nil, SW_SHOWMAXIMIZED) > 32 else
if Hidden then
Result:=ShellExecute(0, nil, PChar(FileName), PChar(Params), nil, SW_HIDE) > 32 else
Result:=ShellExecute(0, nil, PChar(FileName), PChar(Params), nil, SW_SHOWNORMAL) > 32;
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

procedure MinimizeAllWindows;
begin
  keybd_event(VK_LWIN, MapVirtualKey(VK_LWIN, 0), 0, 0);
  keybd_event(Ord('M'), MapVirtualKey(Ord('M'), 0), 0, 0);
  keybd_event(Ord('M'), MapVirtualKey(Ord('M'), 0), KEYEVENTF_KEYUP, 0);
  keybd_event(VK_LWIN, MapVirtualKey(VK_LWIN, 0), KEYEVENTF_KEYUP, 0);
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

// -----------------------------------------------------------------------------
function GetVersionEx; external kernel32 name 'GetVersionExA';
// -----------------------------------------------------------------------------
function GetWindowsVersionEx(out AName, AVersion, ABuild, ASPack: string): LongBool;
const                                                //
  BUFSIZE = 80;                                      //
var                                                  //
  OSVIEx           : TOSVersionInfoEx;               //
  bOsVersionInfoEx : BOOL;                           //
  hkKey            : HKEY;                           //
  szProductType    : array[0..BUFSIZE - 1] of Char;  //
  dwBufLen         : DWORD;                          // DWORD = BUFSIZE;
  lRet             : Integer;                        // LONG;
begin                                                //
   // Инициализировать структуру ------------------------------
   ZeroMemory(@OSVIEx,
              SizeOf(TOSVersionInfoEx));
   // Важно! Указать в структуре ее размер перед вызовом функции
   // РазмерСтруктуры = Размер структуры TOSVersionInfoEx -----------
   OSVIEx.dwOSVersionInfoSize := SizeOf(TOSVersionInfoEx);
   // Вызвать GetVersionEx с использованием структуры OSVERSIONINFOEX
   bOsVersionInfoEx := GetVersionEx(@OSVIEx);
   Result := bOsVersionInfoEx;
   // Если не удалось, то попробуем использовать структуру OSVERSIONINFO
   if (not Result) then
     begin
       // Изменить значение РазмерСтруктуры перед вызовом функции
       // Теперь РазмерСтруктуры = Размер структуры TOSVersionInfo
       OSVIEx.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
       Result := GetVersionEx(@OSVIEx);
       if (not Result) then                                  // В случае неудачи
         Exit;                                               //  выходим из функции
     end;
  // Обработка полученных данных ------------------------------------
  case OSVIEx.dwPlatformId of
    // Проверка семейства продуктов Windows NT ----------------------
    VER_PLATFORM_WIN32_NT :
      begin
        // Проверка на определенный продукт -------------------------
        case OSVIEx.dwMajorVersion of
             5 : case OSVIEx.dwMinorVersion of
                   0 : AName := 'Microsoft Windows 2000 ';
                   1 : AName := 'Microsoft Windows XP ';
                   2 : AName := 'Microsoft Windows Server 2003, ';
                 end;
          3, 4 : AName := 'Microsoft Windows NT ';
        end;
        // Если данные загружены в структуру TOSVersionInfoEx, значит
        // у нас Windows NT 4.0 SP6 и выше --------------------------
        if Result then
          begin
            case OSVIEx.wProductType of
              // Если ТипПродукта = РабочаяСтанция ------------
              VER_NT_WORKSTATION :
                begin
                  // ------------------------------------------
                  case OSVIEx.dwMajorVersion of
                    // Windows NT 4 ---------------------------
                    4 : AName := AName + 'Workstation 4.0';  // Если ОсновнойНомерВерсии = 4, то Windows NT WorkStation 4.0
                    // Windows XP -----------------------------
                    5 : if (OSVIEx.wSuiteMask and            // Если же ОсновнойНомерВерсии = 5 и ФлагиУстановленныхКомпонентов
                            VER_SUITE_PERSONAL) <> 0 then    //  содержат флаг VER_SUITE_PERSONAL, то
                          AName := AName + 'Home Edition'    //    Windows XP Home Edition
                        else                                 //  если же не содержат флаг VER_SUITE_PERSONAL, то
                          AName := AName + 'Professional';   //    Windows XP Professional
                  end;                                       //  конец "case OSVIEx.dwMajorVersion of..."
                end;                                         // конец "Если ТипПродукта = РабочаяСтанция..."
              // Если же ТипПродукта = Сервер или КонтроллерДомена ----------
              VER_NT_SERVER,                                               //
              VER_NT_DOMAIN_CONTROLLER:                                    //
                begin                                                      //
                  case OSVIEx.dwMajorVersion of                            //
                    // Windows 2000 Server, Windows Server 2003 ----------------
                    5 : case OSVIEx.dwMinorVersion of
                          // Windows Server 2003 -------------------------------
                          2 : begin
                                // Windows Server 2003 Datacenter Edition ------
                                if (OSVIEx.wSuiteMask and
                                    VER_SUITE_DATACENTER) <> 0 then
                                  AName := AName + 'Datacenter Edition'
                                // Windows Server 2003 Enterprise Edition ------
                                else if (OSVIEx.wSuiteMask and
                                         VER_SUITE_ENTERPRISE) <> 0 then
                                  AName := AName + 'Enterprise Edition '
                                // Windows Server 2003 Web Edition -------------
                                else if (OSVIEx.wSuiteMask = VER_SUITE_BLADE) then
                                  AName := AName + 'Web Edition '
                                // Windows Server 2003 Standard Edition --------
                                else
                                  AName := AName + 'Standard Edition';
                              end;
                          // Windows 2000 Server -------------------------------
                          0 : begin
                                // Windows 2000 Datacenter Server --------------
                                if (OSVIEx.wSuiteMask and
                                    VER_SUITE_DATACENTER) <> 0 then
                                  AName := AName + 'Datacenter Server'
                                // Windows 2000 Advanced Server ----------------
                                else if (OSVIEx.wSuiteMask and
                                         VER_SUITE_ENTERPRISE) <> 0 then
                                  AName := AName + 'Advanced Server'
                                // Windows 2000 Server -------------------------
                                else
                                  AName := AName + 'Server';
                              end;
                        end;                                  // case OSVIEx.dwMinorVersion of
                    // Windows NT 4.0 ------------------------------------------
                    4 : begin
                          // Windows NT Server 4.0, Enterprise Edition  --------
                          if (OSVIEx.wSuiteMask and
                              VER_SUITE_ENTERPRISE) <> 0 then
                            AName := AName + 'Server 4.0, Enterprise Edition'
                          // Windows NT Server 4.0 -----------------------------
                          else
                            AName := AName + 'Server 4.0';
                        end;
                    end;                                        // case OSVIEx.dwMajorVersion of
                end;                                            // case OSVIEx.wProductType of
             end;
          end                                                   // TOSVersionInfoEx
        // Если же данные загружены в структуру TOSVersionInfo, значит у нас
        // Windows NT 4.0 Service Pack 5 и ниже, и придется читать данные из реестра
        else
          begin
            // Попытаемся открыть ключ реестра -------------------
            lRet := RegOpenKeyEx(HKEY_LOCAL_MACHINE,
                                 'SYSTEM\CurrentControlSet\Control\ProductOptions',
                                 0,
                                 KEY_QUERY_VALUE,
                                 hkKey);
            if (lRet <> ERROR_SUCCESS) then             // Если не удалось прочитать ключ, то
              Exit;                                     //  больше нам искать нечего...
            // Прочитать из открытого ключа значение ТипПродукта -
            lRet := RegQueryValueEx(hkKey,
                                    'ProductType',
                                    nil,
                                    nil,
                                    @szProductType,
                                    @dwBufLen);
            if ((lRet <> ERROR_SUCCESS) or
                (dwBufLen > BUFSIZE)) then
              Exit;
            // Закрыть ключ реестра ------------------------------
            RegCloseKey(hkKey);
            // И обработать полученное из ключа значения ---------
            // Windows NT Workstation ----------------------------
            if szProductType = 'WINNT' then
              AName := AName + 'Workstation'
            // Windows NT Server ---------------------------------
            else if szProductType = 'LANMANNT' then
              AName := AName + 'Server'
            // Windows NT Advanced Server ------------------------
            else if szProductType = 'SERVERNT' then
              AName := AName + 'Advanced Server';
            // Добавить номер версии к имени ---------------------
            AName := AName + Format('%d.%d ',
                                    [OSVIEx.dwMajorVersion,
                                     OSVIEx.dwMinorVersion]);
          end;                                                  // TOSVersionInfo
        // Получить версию Service Pack (если есть) и номер сборки ---
        // Windows NT 4.0 --------------------------------------------
        if ((OSVIEx.dwMajorVersion = 4) and
            (OSVIEx.szCSDVersion = 'Service Pack 6')) then
          begin
            // Проверить Service Pack 6 или Service Pack 6a ----------
            lRet := RegOpenKeyEx(HKEY_LOCAL_MACHINE,
                                 'SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\Q246009',
                                 0,
                                 KEY_QUERY_VALUE,
                                 hkKey);
            if (lRet = ERROR_SUCCESS) then              // Если удалось открыть ключ, то
              ASPack := 'Service Pack 6a'               //  Windows NT 4.0 до Service Pack 6a
            else
              ASPack := OSVIEx.szCSDVersion;
            // Сформировать номер сборки -----------------------------
            ABuild := Format('%d',
                             [OSVIEx.dwBuildNumber and $FFFF]);
            // Закрыть ключ реестра ----------------------------------
            RegCloseKey(hkKey);
          end
        // Выше Windows NT 4.0 ---------------------------------------
        else
          begin
            // Service Pack ------------------------------------------
            ASPack := OSVIEx.szCSDVersion;
            // Версия Windows ----------------------------------------
            AVersion := Format('%d.%d.%d',
                               [OSVIEx.dwMajorVersion,
                                OSVIEx.dwMinorVersion,
                                OSVIEx.dwBuildNumber and $FFFF]);
            // Номер сборки ------------------------------------------
            ABuild := Format('%d',
                             [OSVIEx.dwBuildNumber and $FFFF]);
          end;
      end;                                                          // VER_PLATFORM_WIN32_NT
     // Проверка семейства продуктов Windows Me/98/95 ----------------
     VER_PLATFORM_WIN32_WINDOWS :
       begin
         case OSVIEx.dwMajorVersion of
           4 : case OSVIEx.dwMinorVersion of
                 // Windows 95 --------------------------------------
                  0 : begin
                        AName := 'Microsoft Windows 95';
                        if ((OSVIEx.szCSDVersion[1] = 'C') or
                            (OSVIEx.szCSDVersion[1] = 'B')) then
                          AName := AName +
                                   'OSR2 (OEM Service Release 2) ';
                      end;
                 // Windows 98 ---------------------------------------
                 10 : begin
                        AName := AName + 'Microsoft Windows 98';
                        if (OSVIEx.szCSDVersion[1] = 'A') then
                           AName := AName + 'Second Edition';
                      end;
                 // Windows Millenium ---------------------------------
                 90 : begin
                         AName := 'Microsoft Windows Millennium Edition';
                      end;
               end;                           // case OSVIEx.dwMinorVersion of
           end;                               // case OSVIEx.dwMajorVersion of
         // Номер версии -----------------------------------------
         AVersion := Format('%d.%d.%d %s',
                            [OSVIEx.dwMajorVersion,
                             OSVIEx.dwMinorVersion and $FF,
                             OSVIEx.dwBuildNumber and $FFFF,
                             OSVIEx.szCSDVersion]);
         // Номер сборки ------------------------------------------
         ABuild := Format('%d.',
                          [OSVIEx.dwBuildNumber and $FFFF]);
         // Service Pack ------------------------------------------
         ASPack := OSVIEx.szCSDVersion;
       end;                                   // VER_PLATFORM_WIN32_WINDOWS
    // ------------------------------------------------------------
    VER_PLATFORM_WIN32s :
      begin
        AName := 'Microsoft Win32s';
      end;                                    // VER_PLATFORM_WIN32s
  end;                                        // OSVIEx.dwPlatformId of
end;                   

/////////////////////////////////////////////////////////////////////////////////
//Убиваем приложение по имени исполняемого модуля                              //
/////////////////////////////////////////////////////////////////////////////////
function KillTask(ExeFileName:string):integer;
const
PROCESS_TERMINATE=$0001;
var
ContinueLoop   : BOOL;
FSnapshotHandle: THandle;
FProcessEntry32: TProcessEntry32;
begin 
Result:=0;
FSnapshotHandle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
FProcessEntry32.dwSize:=Sizeof(FProcessEntry32);
ContinueLoop:=Process32First(FSnapshotHandle,FProcessEntry32);
while integer(ContinueLoop) <> 0 do
begin
if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))=UpperCase(ExeFileName))
or (UpperCase(FProcessEntry32.szExeFile)=UpperCase(ExeFileName))) then
Result:=Integer(TerminateProcess(OpenProcess(PROCESS_TERMINATE,BOOL(0),
FProcessEntry32.th32ProcessID),0));
ContinueLoop:=Process32Next(FSnapshotHandle,FProcessEntry32);
end;
CloseHandle(FSnapshotHandle);
end;

/////////////////////////////////////////////////////////////////////////////////
//Время запуска и работы компа                                                 //
/////////////////////////////////////////////////////////////////////////////////
function WinRunTime:string;
const
MS					=	1000;
HOURSPERDAY	=	24;
MINPERHOUR	=	60;
SECPERMIN		=	60;
SECPERHOUR	=	MINPERHOUR * SECPERMIN;
SECPERDAY		=	HOURSPERDAY * SECPERHOUR;
begin
Result:=DateTimeToStr(Now-GetTickCount/(SECPERDAY*MS));
end;

function WinWorkTime:string;
const
MS					=	1000;
HOURSPERDAY	=	24;
MINPERHOUR	=	60;
SECPERMIN		=	60;
SECPERHOUR	=	MINPERHOUR * SECPERMIN;
SECPERDAY		=	HOURSPERDAY * SECPERHOUR;
var
Uptime	:	Cardinal;
TmpStr	:	string;
begin
Uptime := GetTickCount div MS;
// DAYS
TmpStr := IntToStr(Uptime div SECPERDAY) + ' дней ';
UpTime := Uptime mod SECPERDAY;
// HOURS
TmpStr := TmpStr + IntToStr(Uptime div SECPERHOUR) + ' часов ';
UpTime := Uptime mod SECPERHOUR;
// MINUTES
TmpStr := TmpStr + IntToStr(Uptime div SECPERMIN) + ' минут ';
UpTime := Uptime mod SECPERMIN;
// SECONDS
TmpStr := TmpStr + IntToStr(Uptime) + ' секунд';
// RESULY
Result	:= TmpStr;
end;

//Из ярлыка получаем путь к файлу
function ResolveShortcut(Wnd: HWND; ShortcutPath: string): string;
var
obj:IUnknown;
isl:IShellLink;
ipf:IPersistFile;
pfd:TWin32FindDataA;
begin
Result:='';
obj:=CreateComObject(CLSID_ShellLink);
isl:=obj as IShellLink;
ipf:=obj as IPersistFile;
ipf.Load(PWChar(WideString(ShortcutPath)),STGM_READ);
with isl do
begin
Resolve(Wnd,SLR_ANY_MATCH);
SetLength(Result,MAX_PATH);
GetPath(PChar(Result),Length(Result),pfd,SLGP_UNCPRIORITY);
Result:=PChar(Result);
end;
If RESULT='' then RESULT:=ExpandFileName(ShortcutPath);//Если не удалось получить путь к файлу, то оставляем исходный
end;                                                   //и на всякий случай преобразуем относительный путь в полный

//GSD($0000);раб стол
//GSD($0026);программы
//GSD($0007);автозагр
//GSD($0024);винда
function GSD(I: integer): string;                                              //
var
PIDL: PItemIDList;
Path: LPSTR;
begin
result:='';
Path:=StrAlloc(MAX_PATH);
SHGetSpecialFolderLocation(GetDesktopWindow, I, PIDL);
if SHGetPathFromIDList(PIDL, Path) then
result:=StrPas(Path);
StrDispose(Path);
end;

/////////////////////////////////////////////////////////////////////////////////
// Добавляет "\" к имени директории, если это нужно // Альтернатива            //
/////////////////////////////////////////////////////////////////////////////////
function GetDirectory(St:string):String;
begin
Result := St;
if Length(st) > 0 then
if not (st[Length(st)] in ['\', '/', ':']) then
Result := Result + '\';
end;

procedure GetExecutableInfo( const Filename: String; var BinaryType, Subsystem: DWORD);
var
  f: File;
  ImageDosHeader: IMAGE_DOS_HEADER;
  ImageFileHeader: IMAGE_FILE_HEADER;
  ImageOptionalHeader: IMAGE_OPTIONAL_HEADER;
  Signature: DWORD;
  NEType: Byte;

begin
  AssignFile(f, Filename);
  Reset(f, 1); {note that this will fail if file is open. this is a bug really,
                but not a big one. Use Api File calls to work around}
  try
    BlockRead(f, ImageDosHeader, Sizeof(ImageDosHeader));
    if (ImageDosHeader.e_magic <> IMAGE_DOS_SIGNATURE) then {not executable}
      raise EInOutError.Create('Dos сигнатура не настоящая');
    Seek(f, ImageDosHeader._lfanew);
    BlockRead(f, Signature, SizeOf(Signature));
    Signature:= Signature and $FFFF;
    case Signature of
      IMAGE_OS2_SIGNATURE: {New Executable}
      begin
        Seek(f, FilePos(f) + $32); {loader flags are $36 bytes into NE header, but we
                                    have already read 4 bytes for PE signature}
        BlockRead(f, NEType, SizeOf(NEType));
        case NEType of
          1: BinaryType:= SCS_DPMI_BINARY;  {guessing a bit here}
          2: BinaryType:= SCS_WOW_BINARY;
        else
          BinaryType:= SCS_OS216_BINARY; {presumably. I don't have one to check the loader flags!}
        end
      end;
      IMAGE_OS2_SIGNATURE_LE: BinaryType:= SCS_VXD_BINARY;
      IMAGE_NT_SIGNATURE: BinaryType:= SCS_32BIT_BINARY;
    else
      BinaryType:= SCS_DOS_BINARY;
    end;
    Subsystem:= IMAGE_SUBSYSTEM_UNKNOWN;
    if (BinaryType = SCS_32BIT_BINARY)then
    begin
      BlockRead(f, ImageFileHeader, SizeOf(ImageFileHeader));
      if (ImageFileHeader.Characteristics and IMAGE_FILE_EXECUTABLE_IMAGE) = 0 then
        raise EInOutError.Create('Файл не является исполняемым');  {could be COFF obj}
      if (ImageFileHeader.Characteristics and IMAGE_FILE_DLL) = IMAGE_FILE_DLL then
      begin
        BinaryType:= SCS_WIN32_DLL
      end else
      begin
        BlockRead(f, ImageOptionalHeader, SizeOf(ImageOptionalHeader));
        Subsystem:= ImageOptionalHeader.Subsystem
      end
    end
  finally
    CloseFile(f)
  end
end;

function TranslateExeInfo(BinaryType, Subsystem: DWORD): String;
begin
  case BinaryType of
    SCS_32BIT_BINARY:
    begin
      Result:= 'SCS_32BIT_BINARY';
      case Subsystem of
        IMAGE_SUBSYSTEM_UNKNOWN: Result:= Result + ' <подсистема образа неизвестна>';
        IMAGE_SUBSYSTEM_NATIVE: Result:= Result + ' (IMAGE_SUBSYSTEM_NATIVE)';
        IMAGE_SUBSYSTEM_WINDOWS_GUI: Result:= Result + ' (IMAGE_SUBSYSTEM_WINDOWS_GUI)';
        IMAGE_SUBSYSTEM_WINDOWS_CUI: Result:= Result + ' (IMAGE_SUBSYSTEM_WINDOWS_CUI)';
        IMAGE_SUBSYSTEM_OS2_CUI: Result:= Result + ' (IMAGE_SUBSYSTEM_OS2_CUI)';
        IMAGE_SUBSYSTEM_POSIX_CUI: Result:= Result + ' (IMAGE_SUBSYSTEM_POSIX_CUI)';
        IMAGE_SUBSYSTEM_RESERVED8: Result:= Result + ' (IMAGE_SUBSYSTEM_RESERVED8)';
      end;
    end;
    SCS_DOS_BINARY: Result:= 'SCS_DOS_BINARY';
    SCS_WOW_BINARY: Result:= 'SCS_WOW_BINARY';
    SCS_PIF_BINARY: Result:= 'SCS_PIF_BINARY';
    SCS_POSIX_BINARY: Result:= 'SCS_POSIX_BINARY';
    SCS_OS216_BINARY: Result:= 'SCS_OS216_BINARY';
    SCS_VXD_BINARY: Result:= 'SCS_VXD_BINARY';
    SCS_WIN32_DLL: Result:= 'SCS_WIN32_DLL';
    SCS_DPMI_BINARY: Result:= 'SCS_DPMI_BINARY';
  else
    Result:= '<неизвестный двоичный файл>';
  end
end;


function ExecConsoleApp(const ApplicationName, Parameters: String;
                        AppOutput: TStrings;     {will receive output of child process}
                        OnNewLine: TNotifyEvent  {if assigned called on each new line}
                        ): DWORD;
const
  CR = #$0D;
  LF = #$0A;
  TerminationWaitTime = 5000;
  ExeExt = '.EXE';
  ComExt = '.COM'; {the original dot com}

var
  StartupInfo:TStartupInfo;
  ProcessInfo:TProcessInformation;
  SecurityAttributes: TSecurityAttributes;

  TempHandle,
  WriteHandle,
  ReadHandle: THandle;
  ReadBuf: array[0..$100] of Char;
  BytesRead: Cardinal;
  LineBuf: array[0..$100] of Char;
  LineBufPtr: Integer;
  Newline: Boolean;
  i: Integer;
  BinType, SubSyst: DWORD;

  Ext, CommandLine: String;
  AppNameBuf: array[0..MAX_PATH] of Char;
  ExeName: PChar;

{$IFDEF DEBUG}
  ReadCount: Integer;
  StartExec,
  EndExec,
  PerfFreq: Int64;
{$ENDIF}

procedure OutputLine;
begin
  LineBuf[LineBufPtr]:= #0;
  with AppOutput do
  if Newline then
    Add(LineBuf)
  else
    Strings[Count-1]:= LineBuf; {should never happen with count = 0}
  Newline:= false;
  LineBufPtr:= 0;
  if Assigned(OnNewLine) then
    OnNewLine(AppOutput);
  ProcessMessages;
end;

begin
  {Find out about app}
  Ext:= UpperCase(ExtractFileExt(ApplicationName));
  if (Ext = '.BAT') or ((Win32Platform = VER_PLATFORM_WIN32_NT) and (Ext = '.CMD')) then
  begin {just have a bash}
    FmtStr(CommandLine, '"%s" %s', [ApplicationName, Parameters])
  end else
  if (Ext = '') or (Ext = ExeExt) or (Ext = ComExt) then  {locate and test the application}
  begin
    if SearchPath(nil, PChar(ApplicationName), ExeExt, SizeOf(AppNameBuf), AppNameBuf, ExeName) = 0 then
      raise EInOutError.CreateFmt('Файл %s не найден', [ApplicationName]);
    if Ext = ComExt then
      BinType:= SCS_DOS_BINARY
      {in fact, there is no way of telling, but we will just try to run the program. NT is
      equally ignorant and will blindly run anything with a .COM extension}
    else
      GetExecutableInfo(AppNameBuf, BinType, SubSyst);
    if ((BinType = SCS_DOS_BINARY) or (BinType = SCS_DPMI_BINARY)) and
        (Win32Platform = VER_PLATFORM_WIN32_NT) then
      FmtStr(CommandLine, 'cmd /c""%s" %s"', [AppNameBuf, Parameters])
    else
    if (BinType = SCS_32BIT_BINARY) and (SubSyst = IMAGE_SUBSYSTEM_WINDOWS_CUI) then
      FmtStr(CommandLine, '"%s" %s', [AppNameBuf, Parameters])
    else
      raise EInOutError.Create('Образ исполняемого файла не является поддерживаемым типом')
            {Supported types are Win32 Console or MSDOS under Windows NT only}
  end else
  begin
    raise EInOutError.CreateFmt('Файл %s имеет неправильное расширение', [ApplicationName])
  end;

  FillChar(StartupInfo,SizeOf(StartupInfo), 0);
  FillChar(ReadBuf, SizeOf(ReadBuf), 0);
  FillChar(SecurityAttributes, SizeOf(SecurityAttributes), 0);
{$IFDEF DEBUG}
  ReadCount:= 0;
  if QueryPerformanceFrequency(PerfFreq) then
    QueryPerformanceCounter(StartExec);
{$ENDIF}
  LineBufPtr:= 0;
  Newline:= true;
  with SecurityAttributes do
  begin
    ProcessMessages;
    nLength:= Sizeof(SecurityAttributes);
    bInheritHandle:= true
  end;
  if not CreatePipe(ReadHandle, WriteHandle, @SecurityAttributes, 0) then
    RaiseLastOSError;
  {create a pipe to act as StdOut for the child. The write end will need
   to be inherited by the child process}
  try
    {Read end should not be inherited by child process}
    if Win32Platform = VER_PLATFORM_WIN32_NT then
    begin
      if not SetHandleInformation(ReadHandle, HANDLE_FLAG_INHERIT, 0) then
        RaiseLastOSError
    end else
    begin
      ProcessMessages;
      {SetHandleInformation does not work under Window95, so we
      have to make a copy then close the original}
      if not DuplicateHandle(GetCurrentProcess, ReadHandle,
        GetCurrentProcess, @TempHandle, 0, True, DUPLICATE_SAME_ACCESS) then
        RaiseLastOSError;
      CloseHandle(ReadHandle);
      ReadHandle:= TempHandle
    end;

    with StartupInfo do
    begin
      ProcessMessages;
      cb:= SizeOf(StartupInfo);
      dwFlags:= STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
      wShowWindow:= SW_HIDE;
      hStdOutput:= WriteHandle
    end;
    if not CreateProcess(nil, PChar(CommandLine),
       nil, nil,
       true,                   {inherit kernel object handles from parent}
       CREATE_NO_WINDOW,
       nil,
       nil,
       StartupInfo,
       ProcessInfo) then
     RaiseLastOSError;

    CloseHandle(ProcessInfo.hThread);
    {not interested in threadhandle - close it}

    CloseHandle(WriteHandle);
    try
      while ReadFile(ReadHandle, ReadBuf, SizeOf(ReadBuf), BytesRead, nil) do
      begin
        ProcessMessages;
        {There are much more efficient ways of doing this: we don't really
        need two buffers, but we do need to scan for CR & LF &&&}
{$IFDEF Debug}
        Inc(ReadCount);
{$ENDIF}
        for  i:= 0 to BytesRead - 1 do
        begin
          ProcessMessages;
          if (ReadBuf[i] = LF) then
          begin
            Newline:= true
          end else
          if (ReadBuf[i] = CR) then
          begin
            OutputLine
          end else
          begin
            LineBuf[LineBufPtr]:= ReadBuf[i];
            Inc(LineBufPtr);
            if LineBufPtr >= (SizeOf(LineBuf) - 1) then {line too long - force a break}
            begin
              Newline:= true;
              OutputLine
            end
          end
        end
      end;
      WaitForSingleObject(ProcessInfo.hProcess, TerminationWaitTime);
      GetExitCodeProcess(ProcessInfo.hProcess, Result);
      OutputLine {flush the line buffer}

{$IFDEF DEBUG} ;  {that's how much I dislike null statements!
                   Is there a nobel prize for pedantry?}
      if PerfFreq > 0 then
      begin
        QueryPerformanceCounter(EndExec);
        AppOutput.Add(Format('Отладка: (readcount = %d), ExecTime = %.3f мс',
          [ReadCount, ((EndExec - StartExec)*1000.0)/PerfFreq]))
      end else
      begin
        AppOutput.Add(Format('Отладка: (readcount = %d)', [ReadCount]))
      end
{$ENDIF}
    finally
      CloseHandle(ProcessInfo.hProcess)
    end
  finally
    CloseHandle(ReadHandle)
  end
end;

procedure DelSel(LB:TListView);//
var
m: integer;
begin
if LB.Items.Count>0 then
begin
m:= 0;
while m<LB.Items.Count do
begin
if LB.Items.Item[m].Selected then
begin
LB.Items.Delete(m);
end
else
inc(m);
end;
end;
if LB.items.Count>0 then LB.ItemIndex:=0;//
end;

function GetSystemIconIndex(const AFileName: string): integer;
var shfi: TshFileInfo;
begin
if (SHGetFileInfo(pchar(AFileName), FILE_ATTRIBUTE_NORMAL, shfi, sizeOf(shfi),
SHGFI_USEFILEATTRIBUTES or SHGFI_SMALLICON or SHGFI_ICON)) = 1 then
result := shfi.iIcon
else
result := -1;
end;

procedure AssignSystemImageList(AImageList: TImageList);
var
sysImageList: Uint;
sfi: TshFileInfo;
begin
//get the windows system image list, and assign it to appropriate components
sysImageList := SHGetFileInfo('', 0, sfi, SizeOf(sfi),
SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
if sysImageList <> 0 then begin
AImageList.Handle := sysImageList;
AImageList.ShareImages := TRUE;  //do not delete system imagelist!
AImageList.BkColor := clNone;
end;
end;

procedure ListViewAdd(FN:string;Entries:TListView);
var
ListItem: TListItem;
begin
if not (CompareLVStrings(FN,Entries)) and not (FileIsOpen(FN)) then
begin
Entries.Items.BeginUpdate;
ListItem := Entries.Items.Add;
ListItem.Caption:=extractfilename(FN);
ListItem.ImageIndex:= GetSystemIconIndex(FN);
ListItem.SubItems.Add(ExtractFilePath(FN));
Entries.Items.EndUpdate;
end;
end;

function BiteToKBite(Bite:integer):string;
begin
Result:=IntToStr(Bite div 1024);
end;

function FileVersion(NameApp : string) : string;
var
dump: DWORD;
size: integer;
buffer: PChar;
VersionPointer, TransBuffer: PChar;
Temp: integer;
CalcLangCharSet: string;
begin
size := GetFileVersionInfoSize(PChar(NameApp), dump);
buffer := StrAlloc(size+1);
try
GetFileVersionInfo(PChar(NameApp), 0, size, buffer);
VerQueryValue(buffer,'\VarFileInfo\Translation',pointer(TransBuffer),dump);
if dump >= 4 then
begin
temp:=0;
StrLCopy(@temp, TransBuffer, 2);
CalcLangCharSet:=IntToHex(temp, 4);
StrLCopy(@temp, TransBuffer+2, 2);
CalcLangCharSet := CalcLangCharSet+IntToHex(temp, 4);
end;
VerQueryValue(buffer,pchar('\StringFileInfo\'+CalcLangCharSet
+'\'+'FileVersion'),pointer(VersionPointer),dump);
if (dump > 1) then
begin
SetLength(Result, dump);
StrLCopy(Pchar(Result), VersionPointer, dump);
end
else Result := '0.0.0.0';
finally
StrDispose(Buffer);
end;
end;

procedure AddFiles(OD:TOpenDialog;LB:TListView);//
var
n : integer;
NFN:string;
bt, sst: DWORD;
begin
OD.Options:=[ofAllowMultiSelect,ofPathMustExist,ofFileMustExist,ofEnableSizing];
if OD.Execute then
for n := 0 to OD.Files.Count-1 do
begin
try
ProcessMessages;
NFN:=ExpandFilename(OD.Files[n]);
GetExecutableInfo(NFN, bt, sst);
if not (CompareLVStrings(NFN,LB)) and not (FileIsOpen(NFN)) then ListViewAdd(NFN,LB);
except
end;
end;
if LB.Items.Count>0 then LB.ItemIndex:=0;//
end;

//Удаление двойных \ и /
function RepairPathName(d1:String):String;
var
i,p : Integer;
prevCh :Char;
begin
Result := d1;
p := 0;
prevCh := #0;
for i := 1 to Length(d1) do
begin
inc(p);
Result[p] := d1[i];
if d1[i] = '/' then Result[p] := '\';
if d1[i] in ['\', '/'] then
if PrevCh in ['\', '/'] then dec(p);
PrevCh := d1[i];
end;
SetLength(Result, p);
end;

//Удаляем двойные и т. п. пробелы из строки
function DelTwoSpace(s:string):string;
begin
while POS('  ',s)>0 do
Delete(s,POS('  ',s),1);
Result:=s;
end;

//Удаление двойных пробелов и косых слэшей
function FullRepairString(str:string):string;
begin
RESULT:=RepairPathName(DelTwoSpace(str));
end;

function RemoveString(source,target:string):string;
begin
While POS(target,source)>0 do
DELETE(source,POS(target,source),Length(target));
result:=source;
end;

//Удаляем несуществующие пути и сипользуемые файлы
procedure DeleteInvalidEntries(Entries: TListView);
var
j:integer;
ListItem: TListItem;
s: string;
begin
if Entries.Items.Count=0 then Exit;
for j:=0 to Entries.Items.Count-1 do
begin
ProcessMessages;
ListItem:=Entries.Items.Item[j];          //ПРОВЕРИТЬ
s:=listitem.SubItems[0]+listitem.Caption;
if not (FileExists(s)) and not (FileIsOpen(s)) then Entries.Items.Delete(j);
end;
end;

function GetCurDir:string;
begin
Result:=ExtractFilePath(ParamStr(0));
end;

function GetSelectedFile(LV:TListView):string;
var
ListItem: TListItem;
begin
if (LV.SelCount=0) or (LV.SelCount>1) then EXIT;
ListItem:=LV.Selected;//  ПРОВЕРИТЬ
RESULT:=ListItem.SubItems[0]+ListItem.Caption;
//Отладка
//ShowMessage(s);
//ListItem.Selected:=False;//
//result:=s;
end;

//Преобразуем строки в ЛистВиев в одну
function ItemsToString(Entries: TListView):string;
var
i: Integer;
s: string;
ListItem:TListItem;
begin
for i:=0 to Entries.Items.Count-1 do
begin
//Entries.Items.Item[i].Selected:=True;
ListItem:=Entries.Items[I];   //      ПРОВЕРИТЬ
//s:=s+'"'+ListItem.SubItems[0]+ListItem.Caption+'"'+' ';
s:=Format('%s"%s" ',[s,ListItem.SubItems[0]+ListItem.Caption]);
end;
result:=s;
end;

// Сравнение кэпшэнов
function CompareLVStrings(NewFN:string;Entries: TListView):boolean;
var
LVCount:integer;
ListItem:TListItem;
Test:string;
begin
Result:=False;
if Entries.Items.Count=0 then EXIT;
with Entries do
begin
ProcessMessages;
for LVCount:=0 to Items.Count-1 do
begin
ProcessMessages;

ListItem:=Items.Item[LVCount];   // ПРОВЕРИТЬ
Test:=ListItem.SubItems[0]+ListItem.Caption;
Result:=CompareStr(UpperCase(Test),UpperCase(NewFn))=0;

//Test:=Items.Item[LVCount].Caption;
//Result:=Test=NewFn;
if Result then EXIT;
end;
end;
end;

//Извлечение ресурса
procedure ExtractRes(ResType, ResName, ResNewName : String);
var
Res : TResourceStream;
begin
Res := TResourceStream.Create(Hinstance, Resname, Pchar(ResType));
Res.SavetoFile(ResNewName);
Res.Free;
end;

function SelDir(TITLE:string;FHandle:thandle):string;
var
lpItemID: PItemIDList;
BrowseInfo: TBrowseInfo;
DisplayName: array[0..MAX_PATH] of char;
TempPath: array[0..MAX_PATH] of char;
begin
FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
BrowseInfo.hwndOwner := FHandle;
BrowseInfo.pszDisplayName := @DisplayName;
BrowseInfo.lpszTitle := PChar(title);
BrowseInfo.ulFlags := BIF_RETURNONLYFSDIRS;
lpItemID := SHBrowseForFolder(BrowseInfo);
if lpItemId <> nil then begin
SHGetPathFromIDList(lpItemID, TempPath);
result := GetDirectory(TempPath);
GlobalFreePtr(lpItemID);
end;
end;

procedure FileCopy(const SourceFileName, TargetFileName: string);
var
S, T: TFileStream;
begin
S := TFileStream.Create(sourcefilename, fmOpenRead);
try
T := TFileStream.Create(targetfilename, fmOpenWrite or fmCreate);
try
T.CopyFrom(S, S.Size);
FileSetDate(T.Handle, FileGetDate(S.Handle));
finally
T.Free;
end;
finally
S.Free;
end;
end;

function EXEINFO(FN:string):string;
var
bt,sst:dword;
begin
GetExecutableInfo(FN, bt, sst);
result:= TranslateExeInfo(bt, sst);
end;

function GetFileCRC32Int(const Filename: String): DWord;
const
  dwCRC32Table: array[0..255] of DWORD =
   ($00000000, $77073096, $EE0E612C, $990951BA,
    $076DC419, $706AF48F, $E963A535, $9E6495A3,
    $0EDB8832, $79DCB8A4, $E0D5E91E, $97D2D988,
    $09B64C2B, $7EB17CBD, $E7B82D07, $90BF1D91,
    $1DB71064, $6AB020F2, $F3B97148, $84BE41DE,
    $1ADAD47D, $6DDDE4EB, $F4D4B551, $83D385C7,
    $136C9856, $646BA8C0, $FD62F97A, $8A65C9EC,
    $14015C4F, $63066CD9, $FA0F3D63, $8D080DF5,
    $3B6E20C8, $4C69105E, $D56041E4, $A2677172,
    $3C03E4D1, $4B04D447, $D20D85FD, $A50AB56B,
    $35B5A8FA, $42B2986C, $DBBBC9D6, $ACBCF940,
    $32D86CE3, $45DF5C75, $DCD60DCF, $ABD13D59,
    $26D930AC, $51DE003A, $C8D75180, $BFD06116,
    $21B4F4B5, $56B3C423, $CFBA9599, $B8BDA50F,
    $2802B89E, $5F058808, $C60CD9B2, $B10BE924,
    $2F6F7C87, $58684C11, $C1611DAB, $B6662D3D,
    $76DC4190, $01DB7106, $98D220BC, $EFD5102A,
    $71B18589, $06B6B51F, $9FBFE4A5, $E8B8D433,
    $7807C9A2, $0F00F934, $9609A88E, $E10E9818,
    $7F6A0DBB, $086D3D2D, $91646C97, $E6635C01,
    $6B6B51F4, $1C6C6162, $856530D8, $F262004E,
    $6C0695ED, $1B01A57B, $8208F4C1, $F50FC457,
    $65B0D9C6, $12B7E950, $8BBEB8EA, $FCB9887C,
    $62DD1DDF, $15DA2D49, $8CD37CF3, $FBD44C65,
    $4DB26158, $3AB551CE, $A3BC0074, $D4BB30E2,
    $4ADFA541, $3DD895D7, $A4D1C46D, $D3D6F4FB,
    $4369E96A, $346ED9FC, $AD678846, $DA60B8D0,
    $44042D73, $33031DE5, $AA0A4C5F, $DD0D7CC9,
    $5005713C, $270241AA, $BE0B1010, $C90C2086,
    $5768B525, $206F85B3, $B966D409, $CE61E49F,
    $5EDEF90E, $29D9C998, $B0D09822, $C7D7A8B4,
    $59B33D17, $2EB40D81, $B7BD5C3B, $C0BA6CAD,
    $EDB88320, $9ABFB3B6, $03B6E20C, $74B1D29A,
    $EAD54739, $9DD277AF, $04DB2615, $73DC1683,
    $E3630B12, $94643B84, $0D6D6A3E, $7A6A5AA8,
    $E40ECF0B, $9309FF9D, $0A00AE27, $7D079EB1,
    $F00F9344, $8708A3D2, $1E01F268, $6906C2FE,
    $F762575D, $806567CB, $196C3671, $6E6B06E7,
    $FED41B76, $89D32BE0, $10DA7A5A, $67DD4ACC,
    $F9B9DF6F, $8EBEEFF9, $17B7BE43, $60B08ED5,
    $D6D6A3E8, $A1D1937E, $38D8C2C4, $4FDFF252,
    $D1BB67F1, $A6BC5767, $3FB506DD, $48B2364B,
    $D80D2BDA, $AF0A1B4C, $36034AF6, $41047A60,
    $DF60EFC3, $A867DF55, $316E8EEF, $4669BE79,
    $CB61B38C, $BC66831A, $256FD2A0, $5268E236,
    $CC0C7795, $BB0B4703, $220216B9, $5505262F,
    $C5BA3BBE, $B2BD0B28, $2BB45A92, $5CB36A04,
    $C2D7FFA7, $B5D0CF31, $2CD99E8B, $5BDEAE1D,
    $9B64C2B0, $EC63F226, $756AA39C, $026D930A,
    $9C0906A9, $EB0E363F, $72076785, $05005713,
    $95BF4A82, $E2B87A14, $7BB12BAE, $0CB61B38,
    $92D28E9B, $E5D5BE0D, $7CDCEFB7, $0BDBDF21,
    $86D3D2D4, $F1D4E242, $68DDB3F8, $1FDA836E,
    $81BE16CD, $F6B9265B, $6FB077E1, $18B74777,
    $88085AE6, $FF0F6A70, $66063BCA, $11010B5C,
    $8F659EFF, $F862AE69, $616BFFD3, $166CCF45,
    $A00AE278, $D70DD2EE, $4E048354, $3903B3C2,
    $A7672661, $D06016F7, $4969474D, $3E6E77DB,
    $AED16A4A, $D9D65ADC, $40DF0B66, $37D83BF0,
    $A9BCAE53, $DEBB9EC5, $47B2CF7F, $30B5FFE9,
    $BDBDF21C, $CABAC28A, $53B39330, $24B4A3A6,
    $BAD03605, $CDD70693, $54DE5729, $23D967BF,
    $B3667A2E, $C4614AB8, $5D681B02, $2A6F2B94,
    $B40BBE37, $C30C8EA1, $5A05DF1B, $2D02EF8D);
var
  F: file;
  BytesRead: DWORD;
  Buffer: array[1..65521] of Byte;
  i: Word;
begin
  FileMode := 0;
  result    := $ffffffff;
  {$I-}
  AssignFile(F, FileName); 
  Reset(F, 1);
  if IOResult = 0 then 
  begin
    repeat
      BlockRead(F, Buffer, SizeOf(Buffer), BytesRead);
      for i := 1 to BytesRead do
        result := (result shr 8) xor dwCRC32Table[Buffer[i] xor (result and $000000FF)];
    until BytesRead = 0;
  end;
  CloseFile(F);
  {$I+}
  result := not result;
end;

function GetFileCRC32Hex(const Filename: String): String;
begin
   result:= IntToHex(GetFileCRC32Int(Filename), 6);
end;

function  GetFileSize(Datei: String): Int64;
var
   TempFileSize: Int64;
   SR: TSearchRec;
begin
     TempFileSize:= 0;
     if FindFirst(Datei,faAnyFile,SR) = 0 then
     TempFileSize:= SR.Size;
     FindClose(SR);
     result:= TempFileSize;
end;

procedure CRC64Next(const Data; const Count:
  Cardinal; var CRC64: Int64);
var 
   MyCRC64: Int64;
 I: Cardinal;
 PData: ^Byte;
begin
   PData := @Data;
   MyCRC64 := CRC64;
   for I := 1 to Count do
  begin
      MyCRC64 := MyCRC64 shr 8 xor T[Cardinal(MyCRC64)
      and $FF xor PData^];
      Inc(PData);
     end;
     CRC64 := MyCRC64;
  end;
   

  function CRC64Full(const Data; const Count:
  Cardinal): Int64;
begin
   Result := not 0;
   CRC64Next(Data, Count, Result);
end;
 

  function  CRC64Stream(const Source:
  TStream; Count: Integer;
   const BufSize: Cardinal = 1024): Int64;
var 
   N: Cardinal;
 Buffer: Pointer;
begin
   if Count<0
     then Count := Source.Size;
   GetMem(Buffer, BufSize);
  try
     Result := not 0;
     while Count<>0 do
    begin
        if Cardinal(Count)>BufSize
          then
        N := BufSize
           
        else
        N := Count;
        Source.ReadBuffer(Buffer^, N);
        CRC64Next(Buffer^, N, Result);
        Dec(Count, N);
       end;
       finally FreeMem(Buffer);
    end;
  end;
   
  var 
    I, J: Byte;
    D: Int64;

initialization

  for I := 0 to 255 do
  begin
      D := I;
      for J := 1 to 8 do
         if Odd(D)
           then D := D shr 1 xor $C96C5795D7870F42
           else D := D shr 1;
      T[I] := D;
     end;

end.

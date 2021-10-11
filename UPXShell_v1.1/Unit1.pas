unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Menus, ImgList, ComCtrls,
  ShellApi,
  IniFiles,
  Utils;

type
  TForm1 = class(TForm)
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    OpenDialog1: TOpenDialog;
    BitBtn6: TBitBtn;
    BitBtn5: TBitBtn;
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    ComboBox1: TComboBox;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    Bevel1: TBevel;
    GroupBox3_: TGroupBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    RadioGroup3: TRadioGroup;
    Bevel2: TBevel;
    GroupBox4: TGroupBox;
    Bevel3: TBevel;
    RadioGroup4: TRadioGroup;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    SaveDialog1: TSaveDialog;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    PopupMenu2: TPopupMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    BitBtn7: TBitBtn;
    ListView1: TListView;
    ImageList1: TImageList;
    ListBox1: TListBox;
    N7: TMenuItem;
    N8: TMenuItem;
    Timer3: TTimer;
    BitBtn1: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    GroupBox2: TGroupBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    BitBtn10: TBitBtn;
    Bevel4: TBevel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure XPManApply;
    procedure EDXPManOnCreate;
    procedure EDXPManOnClose;
    procedure RunningUpdate(Sender: TObject);
    procedure WMDropFiles(var Msg: TMessage); message WM_DROPFILES;
    procedure RestartApp(AppName:string);
  public
    { Public declarations }
    procedure Compress(arg:string);
    procedure Uncompress;
    procedure Testing;
    procedure WriteOptions;
    procedure ReadOptions;
  end;

var
  Form1      : TForm1;
  CAExitCode : Integer;
  ITOG, EC   : string;
  TIF        : TIniFile;

implementation

{$R *.dfm}

resourcestring
AppTitle='UPXShell';
FormCap='UPXShell by Vayrus v1.1 beta 4 - Версия UPX: ';
Wait='Ждите...';
UPXRun='Идёт обработка файлов... Пожалуйста, ждите...';
OperationOK='Обработка завершена успешно!';
OperationFailed='Внимание: один или более файлов в списке не обработаны!';
//UnpackOK='Распаковка успешно завершена!';
//TestOK='Тестирование успешно завершено!';
PackError='Ошибка: один или более файлов в списке не обработаны!'#13#10'Возможно, они уже упакованы другим пакером, не найдены или выполняются/используются.';
//FNoPacked='Внимание: один или более файлов в списке не упакованы!';
Err='Ошибка';
UPXNotFound='Файл UPX.exe не найден в папке UPXShell !'+
#13'Найдите и разместите файл в папке программы !';
Version   ='/// UPXShell by Vayrus v1.1 beta 4 (2007) ///';
Company   ='///////////////////// ArtStudio Software /////////////////////';
EMAIL     ='/////////// Email: ArtStudio1@yandex.ru ////////////';
Separator ='////////////////////////////////////////////////////////////////////////////////';
CommandLineSyntax='Параметры командной строки:'#13#10'UPXShell /P file1 file2 ... fileN - упаковка'#13#10'UPXShell /U file1 file2 ... fileN - распаковка'#13#10'UPXShell /T file1 file2 ... fileN - тестирование';
Warning='Подтверждение';
RestoreOptions='Вы точно хотите восстановить опции по умолчанию?';
OPT='Options';
Analysis='Идёт анализ и добавление файлов... Пожалуйста, ждите...';

procedure TForm1.RestartApp(AppName:string);
const
BatName='restart.bat';
BatLines='%s'#13#10'del %s';
begin
Application.ProcessMessages;
SaveStringToFile(Format(BatLines,[ExtractFileName(AppName),BatName]),BatName);
WinExec(BatName,SW_HIDE);//
Close;
end;

procedure AddFile(FN:string);
var
NFN:string;
bt, sst: DWORD;
begin
with Form1 do
begin
try
NFN:=ResolveShortcut(Handle,FN);  
Application.ProcessMessages;
GetExecutableInfo(NFN,bt,sst);
ListViewAdd(NFN,ListView1);
except
end;
if ListView1.Items.Count>0 then ListView1.ItemIndex:=ListView1.Items.Count-1;
end;
end;

procedure AddFiles;
var
n : integer;
begin
with Form1 do
begin
if OpenDialog1.Execute then
begin
ListBox1.Clear;
ListBox1.Items.Add(Analysis);
for n := 0 to OpenDialog1.Files.Count-1 do
begin
Application.ProcessMessages;
AddFile(OpenDialog1.Files[n]);
end;
end;
ListBox1.Clear;
end;
end;

procedure TForm1.WMDropFiles(var Msg: TMessage);
Var
Hnd: THandle;
Count, C: Integer;
FN, NFN: String;
bt, sst: DWORD;
//ListItem: TListItem;
begin
ListBox1.Clear;
ListBox1.Items.Add(Analysis);
Hnd := THandle(Msg.WParam);
try
Count := DragQueryFile(Hnd, UINT(-1), nil, 0);
for C := 0 to Count - 1 do
begin
Application.ProcessMessages;
SetLength(FN, MAX_PATH);
SetLength(FN, DragQueryFile(Hnd, C, PChar(FN), MAX_PATH));
try
NFN:=ResolveShortcut(Handle,FN);
GetExecutableInfo(NFN, bt, sst);
ListViewAdd(NFN,ListView1);
except
end;
end;
finally
Msg.Result := 0;
DragFinish(Hnd);
FN         := '';
ListBox1.Clear;
end;
end;

//Сохраняем опции программы
procedure TForm1.WriteOptions;
var
IniName,SavePath:string;
begin
if checkbox6.Checked then
begin
IniName:=ChangeFileExtToINI(ParamStr(0));
if AppInCD then SavePath:=ExtractFileName(IniName) else SavePath:=IniName;
TIF:=TIniFile.Create(SavePath);
//////////////////////////////////////////////////////////
with TIF do
begin
WriteBool(OPT,'SaveOptions',CheckBox6.Checked);
WriteInteger(OPT,'Compress',combobox1.ItemIndex);
WriteBool(OPT,'Backup',CheckBox1.Checked);
WriteBool(OPT,'Force',CheckBox5.Checked);
WriteBool(OPT,'NoResources',CheckBox4.Checked);
WriteBool(OPT,'8086',CheckBox3.Checked);
WriteBool(OPT,'NoRelocsInExeHeader',CheckBox2.Checked);
WriteBool(OPT,'8086',CheckBox3.Checked);
WriteInteger(OPT,'Export',RadioGroup2.ItemIndex);
WriteInteger(OPT,'Relocs',RadioGroup4.ItemIndex);
WriteInteger(OPT,'Overlay',RadioGroup1.ItemIndex);
WriteInteger(OPT,'Icons',RadioGroup3.ItemIndex);
/////////////////////////////////////////////////////////
Free;
end;
end
else
begin
DELETEFILE(IniName);
DELETEFILE(IncludeTrailingPathDelimiter(GSD($0024))+ExtractFileName(ParamStr(0)));
end;
end;

//Читаем опции программы
procedure TForm1.ReadOptions;
var
IniName,OpenPath:string;
begin
IniName:=ChangeFileExtToINI(ParamStr(0));
if AppInCD then OpenPath:=ExtractFileName(IniName) else OpenPath:=IniName;
if FileExists(OpenPath) then
begin
TIF:=TIniFile.Create(OpenPath);
//////////////////////////////////////////////////////////
with TIF do
begin
CheckBox6.Checked:=ReadBool(OPT,'SaveOptions',CheckBox6.Checked);
combobox1.ItemIndex:=ReadInteger(OPT,'Compress',combobox1.ItemIndex);
CheckBox1.Checked:=ReadBool(OPT,'Backup',CheckBox1.Checked);
CheckBox5.Checked:=ReadBool(OPT,'Force',CheckBox5.Checked);
CheckBox4.Checked:=ReadBool(OPT,'NoResources',CheckBox4.Checked);
CheckBox3.Checked:=ReadBool(OPT,'8086',CheckBox3.Checked);
CheckBox2.Checked:=ReadBool(OPT,'NoRelocsInExeHeader',CheckBox2.Checked);
CheckBox3.Checked:=ReadBool(OPT,'8086',CheckBox3.Checked);
RadioGroup2.ItemIndex:=ReadInteger(OPT,'Export',RadioGroup2.ItemIndex);
RadioGroup4.ItemIndex:=ReadInteger(OPT,'Relocs',RadioGroup4.ItemIndex);
RadioGroup1.ItemIndex:=ReadInteger(OPT,'Overlay',RadioGroup1.ItemIndex);
RadioGroup3.ItemIndex:=ReadInteger(OPT,'Icons',RadioGroup3.ItemIndex);
/////////////////////////////////////////////////////////
Free;
end;
end;
end;

//Обновляем ЛистБокс
procedure TForm1.RunningUpdate(Sender: TObject);
begin
Application.ProcessMessages;
listbox1.Update
end;

procedure Prepare;
begin
with Form1.ListBox1 do
begin
Clear;
Items.Add(UPXRun); //доделать
Items.Add(''); //доделать
Application.Title:=Wait;
Application.Minimize;
Application.ProcessMessages;
Sleep(1000);
FlashWindow(Application.Handle,True);// Только так
Application.ProcessMessages;
end;
end;

procedure Ending;
var
TempList:TStringList;
begin
TempList:=TStringList.Create;
with Form1.ListBox1 do
begin
case CAExitCode of
0:EC:=OperationOK;
1:EC:=PackError;
2:EC:=OperationFailed;
end;
if CAExitCode=1 then
begin
TempList.SetText(PChar(EC));
Items.AddStrings(TempList);
end else
Items.Add(EC);
ItemIndex:=Count-1;
Application.Title:=AppTitle;
MinimizeAllWindows;
DesktopUpdate;
Application.ProcessMessages;
Sleep(1000);
Application.Restore;
end;
TempList.Free;
//Отладка
//ShowMessage(IntToStr(CAExitCode));
end;

//Процедура сжатия с параметрами
procedure TForm1.Compress(arg:string);
var
FullCommandLine:string;
begin
Prepare;
FullCommandLine:=Format('%s %s',[FullRepairString(arg),ItemsToString(ListView1)]);
//Отладка
//ShowMessage(FullCommandLine);
CAExitCode:= ExecConsoleApp('upx.exe',FullCommandLine,listbox1.items,RunningUpdate);
Ending;
end;

//Процедура распаковки
procedure TForm1.Uncompress;
begin
Prepare;
Application.ProcessMessages;
CAExitCode:= ExecConsoleApp('upx.exe',Format('-d %s',[FullRepairString(ItemsToString(ListView1))]),listbox1.items,RunningUpdate);
Ending;
end;

//Процедура тестирования
procedure TForm1.Testing;
begin
Prepare;
Application.ProcessMessages;
CAExitCode:= ExecConsoleApp('upx.exe',Format('-t %s',[FullRepairString(ItemsToString(ListView1))]),listbox1.items,RunningUpdate);
Ending;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
Close;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
AddFiles;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
var
backup,complevel,anyproc,relocs,norelocs,
_export,overlay,icons,forcecomp,nores:string;
begin
if listView1.Items.Count=0 then bitbtn1.Click;//Так надо
DeleteInvalidEntries(ListView1);//Так надо
if listView1.Items.Count=0 then EXIT;//Так надо

case combobox1.ItemIndex of
0:complevel:='-3';
1:complevel:='-6';
2:complevel:='-9';
end;

if checkbox1.Checked then backup:='-k';

if checkbox5.Checked then forcecomp:='--force';

if checkbox4.Checked then nores:='--compress-resources=0';

if checkbox3.Checked then anyproc:='--8086';

if checkbox2.Checked then norelocs:='--no-reloc';

if radiogroup4.ItemIndex=0 then relocs:='--strip-relocs=0';

if radiogroup2.ItemIndex=0 then _export:='--compress-exports=0';

case radiogroup1.ItemIndex of
0:overlay:='--overlay=strip';
1:overlay:='--overlay=skip';
end;

case radiogroup3.ItemIndex of
0:icons:='--compress-icons=0';
1:icons:='--compress-icons=1';
end;

ITOG:=Format('%s %s %s %s %s %s %s %s',[complevel,backup,norelocs,relocs,_export,icons,nores,forcecomp]);
Compress(ITOG);
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
DeleteInvalidEntries(ListView1);//Так надо
if listView1.Items.Count=0 then
begin
bitbtn1.Click;//Так надо
Exit;//Так надо
end;

Testing;
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
DeleteInvalidEntries(ListView1);//Так надо
if listView1.Items.Count=0 then
begin
bitbtn1.Click;//Так надо
Exit;//Так надо
end;

Uncompress;
end;

procedure TForm1.BitBtn8Click(Sender: TObject);
begin
DelSel(listView1);
end;

procedure TForm1.BitBtn9Click(Sender: TObject);
begin
listView1.Clear;
//ListBox1.Clear;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
listbox1.Clear;
with listbox1.Items do
begin
Add(' ');
Add(separator);
Add(version);
Add(company);
Add(email);
Add(separator);
Add(' ');
end;
listbox1.ItemIndex:=listbox1.Count-1;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
listbox1.Clear;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
if listbox1.Items.count=0 then EXIT;
savedialog1.FileName:='';
savedialog1.Execute;
if savedialog1.FileName<>'' then
listbox1.Items.SaveToFile(savedialog1.filename);
end;

procedure TForm1.EDXPManOnCreate;
begin
if FileExists(ParamStr(0)+'.manifest') then
begin
CheckBox7.Checked:=True;
XPManApply;
end;
end;

procedure TForm1.EDXPManOnClose;
begin
if Checkbox7.Checked then ApplyXPStyle(ParamStr(0)) else DelXPStyle(ParamStr(0));
end;

{if Components[i] is TCheckBox then
(Components[i] as TCheckBox).Checked then
begin
... сюда поместите ваш код ...
end;}

procedure TForm1.XPManApply;
var
i:integer;
begin
Form1.Color:=clBtnFace;
ListView1.Color:=CLWhite;
ComBoBox1.Color:=clWhite;
ListBox1.Color:=clSkyBlue;
ListBox1.Font.Color:=clBlack;
for i:=0 to ComponentCount-1 do
begin
if Components[i] is TCheckBox then (Components[i] as TCheckBox).Font.Color:=clBlack;
if Components[i] is TGroupBox then (Components[i] as TGroupBox).Font.Color:=clBlack;
end;
end;

procedure ConsoleEnding;
begin
MinimizeAllWindows;
if EC<>'' then ShowMessage(EC);//Так надо
Application.Terminate;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
name,ver,build,pack,PS:string;
L:integer;
begin
//Консольный блок
if ParamCount>0 then
begin
Application.ShowMainForm:=False;
for L:=2 to ParamCount do
begin
Application.ProcessMessages;
AddFile(ParamStr(L));
end;
PS:=ParamStr(1);
if PS='/P' then
begin
BitBtn4.Click;
ConsoleEnding;
end else
if PS='/U' then
begin
BitBtn6.Click;
ConsoleEnding;
end else
if PS='/T' then
begin
BitBtn5.Click;
ConsoleEnding;
end else
if FileExists(PS) then
begin
AddFile(PS);
//Отладка
//Showmessage(PS);
MinimizeAllWindows;
Application.ShowMainForm:=True;
end else
begin
MinimizeAllWindows;
ShowMessage(CommandLineSyntax);
Application.ShowMainForm:=True;
end;
end;
//Блок GUI
//OnlyOneCopy;//Обязательно здесь
EDXPManOnCreate;
GetWindowsVersionEx(name,ver,build,pack);
ListBox1.Items.Add(Format('ОС: %s| Версия: %s| Сборка: %s (%s)',[name,ver,build,pack]));
ListBox1.Items.Add(Format('Дата запуска Windows: %s',[WinRunTime]));
ListBox1.Items.Add(Format('Время работы Windows: %s',[WinWorkTime]));
ListBox1.Items.Add(Format('Дата запуска программы: %s',[DateTimeToStr(now)]));
AssignSystemImageList(imagelist1);
DragAcceptFiles(Handle,True);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
ReadOptions;
if FileExists(GetCurDir+'upx.exe') then
begin
Form1.Caption:=FormCap+FileVersion(GetCurDir+'upx.exe');
Application.Title:=AppTitle;
//exit;
end else
begin
Application.MessageBox(PChar(UPXNotFound),PChar(Err),MB_OK);
Close;
end;
{if fileexists(GSD($0024)+'\upx.exe') then
begin
Form1.Caption:=FormCap+FileVersion(GSD($0024)+'\upx.exe');
Application.Title:=AppTitle;
exit;
end;
if Application.MessageBox(UPXNotFound,'Подтверждение',MB_YESNO)=IDNO then
ExtractRes('upxfile','upx',GetCurDir+'upx.exe') else
ExtractRes('upxfile','upx',GSD($0024)+'upx.exe');}
end;

procedure TForm1.N4Click(Sender: TObject);
begin
if listView1.Items.Count=0 then
begin
bitbtn1.Click;
EXIT;
end;

OpenAny(GetSelectedFile(listview1));
end;

procedure TForm1.N6Click(Sender: TObject);
begin
OpenAny(ExtractFilePath(GetSelectedFile(listview1)));
end;

procedure TForm1.BitBtn7Click(Sender: TObject);
var
i:integer;
begin
if Application.MessageBox(PChar(RestoreOptions),PChar(Warning),MB_YESNO)=IDYES then
begin
Combobox1.ItemIndex:=0;
for i:=0 to ComponentCount-1 do
if Components[i] is TCheckBox then (Components[i] as TCheckBox).Checked:=false;
radiogroup2.ItemIndex:=1;
radiogroup4.ItemIndex:=1;
radiogroup1.ItemIndex:=2;
radiogroup3.ItemIndex:=2;
end;
end;

procedure TForm1.ListView1DblClick(Sender: TObject);
begin
OpenAny(GetSelectedFile(ListView1));
end;

procedure TForm1.N8Click(Sender: TObject);
var
FileN:string;
begin
if listView1.Items.Count=0 then
begin
bitbtn1.Click;
EXIT;
end;

FileN:=GetSelectedFile(ListView1);
FilePropertiesDialog(FileN);
end;

procedure TForm1.Timer3Timer(Sender: TObject);
const
IdleThreshold = 15;
var
LII : TLastInputInfo;
CurrentIdleInterval : DWORD;
begin
Application.ProcessMessages;
FillChar(LII, SizeOf(LII), 0);
LII.cbSize := SizeOf(LII);
Win32Check(GetLastInputInfo(LII));
CurrentIdleInterval := GetTickCount - LII.dwTime;
if CurrentIdleInterval > 1000*IdleThreshold then
begin
if Form1.AlphaBlendValue=255 then Form1.AlphaBlendValue:=0//;
end else
Form1.AlphaBlendValue:=255;
end;

procedure TForm1.BitBtn10Click(Sender: TObject);
begin
RestartApp(ParamStr(0));
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
KillUPX;
WriteOptions;
EDXPManOnClose;
end;

end.



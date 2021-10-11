program Project1;

uses
  Forms,
  Windows,
  Unit1 in 'Unit1.pas' {Form1};

var
  MutexHandle : THandle;
  hPrevInst   : Boolean;

{$R *.res}

  function ShowPrevInstance(Name: string): boolean;
  var
  PrevInstance: HWND;
  begin
  Result := False;
  PrevInstance := FindWindow('TApplication', PChar(Name));
  if PrevInstance <> 0 then
  begin
  if IsIconic(PrevInstance) then ShowWindow(PrevInstance, SW_RESTORE);
  SetForegroundWindow(PrevInstance);
  Result := True;
  end;
  end;

begin

 	MutexHandle := CreateMutex(nil, TRUE, 'Luzer');
 	if MutexHandle <> 0 then
  begin
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
  hPrevInst := TRUE;
  CloseHandle(MutexHandle);
  ShowPrevInstance('UPXShell');
  Halt;
  end else
  hPrevInst := FALSE;
  end else
  hPrevInst := FALSE;

  Application.Initialize;
  Application.Title := 'UPXShell';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

program MBTest;

uses
  Forms,
  unMain in 'unMain.pas' {Form1},
  unNBS in 'unNBS.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

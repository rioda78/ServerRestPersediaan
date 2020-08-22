program ServiceData;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  RestDWServerFormU in 'RestDWServerFormU.pas' {RestDWForm},
  uDmService in 'uDmService.pas' {ServerBest: TDataModule},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  reportmemoryleaksonshutdown:=true;
  Application.Initialize;
  TStyleManager.TrySetStyle('Aqua Light Slate');
  Application.CreateForm(TRestDWForm, RestDWForm);
  Application.Run;
end.

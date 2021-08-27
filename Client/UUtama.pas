unit UUtama;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDWAbout,
  uRESTDWPoolerDB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  serverutils, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uDWConstsData, system.DateUtils, Vcl.StdCtrls, RzEdit, Vcl.Grids, Vcl.DBGrids,
  uDWResponseTranslator, uRESTDWBase, uRESTDWServerEvents, Vcl.ExtCtrls,
  uDWConstsCharset, system.IniFiles;

type
  TForm1 = class(TForm)
    RESTDWDataBase1: TRESTDWDataBase;
    RESTDWClientSQL1: TRESTDWClientSQL;
    DWClientEvents1: TDWClientEvents;
    RESTClientPooler1: TRESTClientPooler;
    Panel1: TPanel;
    BtnSeting: TButton;
    edUsername: TLabeledEdit;
    EdPassword: TLabeledEdit;
    Edport: TLabeledEdit;
    EdServer: TLabeledEdit;
    Panel2: TPanel;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    mcommand: TRzMemo;
    Button1: TButton;
    chHttp: TCheckBox;
    procedure BtnSetingClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RESTDWClientSQL1PostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
    procedure RESTDWClientSQL1AfterOpen(DataSet: TDataSet);
    procedure Button2Click(Sender: TObject);
  private
    procedure SetHost;
    procedure SetAuth;
    procedure LoadSeting;
    procedure TulisSeting;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BtnSetingClick(Sender: TObject);
begin
  TulisSeting;
  SetHost;
  SetAuth;

  restdwdatabase1.Active := true;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  commando: string;
  Verror: string;
  INICIO, FIM: TDateTime;
  komando : string ;
begin
  INICIO := Now;

  if not RestdwDatabase1.Active then
  begin
    sethost;
    setauth;
  end;

  RESTDWClientSQL1.BinaryRequest := true;
  RESTDWClientSQL1.BinaryCompatibleMode := true;

  RESTDWClientSQL1.Close;
  RESTDWClientSQL1.SQL.Clear;
  RESTDWClientSQL1.SQL.Add(mcommand.Text);
  try
    komando := Uppercase(copy(Trim(mcommand.Text), 0, 6)) ;
    if komando = 'SELECT' then
    begin
      RESTDWClientSQL1.open;
    end
    else
    begin
      if not RESTDWClientSQL1.ExecSQL(Verror) then
        Application.MessageBox(PChar('Error Eksekusi ' +' '+ komando + RESTDWClientSQL1.SQL.Text), 'Error...', Mb_IconError + Mb_Ok)
      else
        Application.MessageBox(PChar(Format('Eksekusi Command berhasil %d', [RESTDWClientSQL1.RowsAffected])), 'Informasi !', Mb_iconinformation + Mb_Ok);

    end;

  except
    on E: Exception do
    begin
      raise Exception.Create('Error eksekusi : ' + sLineBreak + E.Message);
    end;
  end;
  FIM := Now;
  if RESTDWClientSQL1.Active then
  begin
    Showmessage(IntToStr(RESTDWClientSQL1.Recordcount) + ' register(s) receive(s) ' + IntToStr(MilliSecondsBetween(FIM, INICIO)) + ' Milis.');
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
ShowMessage(Uppercase(copy(Trim(mcommand.Text), 0, 6)));
end;

procedure TForm1.FormShow(Sender: TObject);
var
  nama: string;
begin
  nama := getcurrentdir + '\seting.ini';
  if fileexists(nama) then
  begin
    LoadSeting;
  end
  else
  begin
    TulisSeting;
  end;
end;

procedure TForm1.LoadSeting;
var
  ini: TInifile;
  nama: string;
begin
  nama := getcurrentdir + '\seting.ini';
  ini := Tinifile.Create(nama);
  try
    edserver.Text := ini.ReadString('Seting', 'Host', '127.0.0.1');
    edusername.Text := ini.ReadString('Seting', 'Username', 'testserver');
    edpassword.Text := ini.ReadString('Seting', 'Password', 'testserver');
    edport.Text := ini.ReadString('Seting', 'Port', '8082');

  finally
    ini.Free;
  end;
end;

procedure TForm1.RESTDWClientSQL1AfterOpen(DataSet: TDataSet);
begin
//
end;

procedure TForm1.RESTDWClientSQL1PostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  showmessage(E.Message);
end;

procedure TForm1.SetAuth;
begin
  RESTDWDataBase1.AuthenticationOptions.AuthorizationOption := rdwAOBasic;
  TRDWAuthOptionBasic(RESTDWDataBase1.AuthenticationOptions.OptionParams).Username := edUserName.Text;
  TRDWAuthOptionBasic(RESTDWDataBase1.AuthenticationOptions.OptionParams).Password := edPassword.Text;
  TRDWAuthOptionBasic(RESTClientPooler1.AuthenticationOptions.OptionParams).Username := TRDWAuthOptionBasic(RESTDWDataBase1.AuthenticationOptions.OptionParams).Username;
  TRDWAuthOptionBasic(RESTClientPooler1.AuthenticationOptions.OptionParams).Password := TRDWAuthOptionBasic(RESTDWDataBase1.AuthenticationOptions.OptionParams).Password;
end;

procedure TForm1.SetHost;
begin
  restdwdatabase1.PoolerService := edServer.Text;
  restdwdatabase1.PoolerPort := StrToInt(EdPort.Text);
  RESTDWDataBase1.Compression := true;
  RESTClientPooler1.DataCompression := true;
  if chhttp.Checked then
    RESTDWDataBase1.TypeRequest := TTyperequest.trHttps
  else
    RESTDWDataBase1.TypeRequest := TTyperequest.trHttp;
 //RESTClientPooler1.AccessTag       := eAccesstag.Text;
 //RESTClientPooler1.WelcomeMessage  := eWelcomemessage.Text;
  RESTClientPooler1.BinaryRequest := true;
end;

procedure TForm1.TulisSeting;
var
  ini: TInifile;
  nama: string;
begin
  nama := getcurrentdir + '\seting.ini';
  ini := Tinifile.Create(nama);
  try
    ini.WriteString('Seting', 'Host', edserver.Text);
    ini.WriteString('Seting', 'Username', edusername.Text);
    ini.WriteString('Seting', 'Password', edpassword.Text);
    ini.WriteString('Seting', 'Port', edport.Text);

  finally
    ini.Free;
  end;

end;

end.


unit uDmService;

interface

uses
  SysUtils, Classes, SysTypes, UDWDatamodule, System.JSON, UDWJSONObject,
  Dialogs, ServerUtils, UDWConsts,  UDWConstsData,  frxClass, frxExportPDF, uDWAbout,
  uRESTDWServerEvents, frxExportBaseDialog,  DBAccess, Uni, UniProvider, MySQLUniProvider,
  uRESTDWDriverUNIDAC, MemDS, Data.DB, uRESTDWPoolerDB, PostgreSQLUniProvider,
  InterBaseUniProvider, SQLServerUniProvider;

type
  TServerBest = class(TServerMethodDataModule)
    frxReport1: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    DWServerEvents1: TDWServerEvents;
    RESTDWPoolerDB2: TRESTDWPoolerDB;
    KoneksiDb: TUniConnection;
    RESTDWDriverUNIDAC1: TRESTDWDriverUNIDAC;
    InterBaseUniProvider1: TInterBaseUniProvider;
    PostgreSQLUniProvider1: TPostgreSQLUniProvider;
    MySQLUniProvider1: TMySQLUniProvider;
    UniQuery1: TUniQuery;
    SQLServerUniProvider1: TSQLServerUniProvider;
    procedure ServerMethodDataModuleCreate(Sender: TObject);
    procedure ServerMethodDataModuleWelcomeMessage(Welcomemsg: string);
    procedure Server_FDConnectionError(ASender, AInitiator: TObject; var AException: Exception);
    function DownloadFile(var Params: TDWParams): string; overload;
    procedure KoneksiDbBeforeConnect(Sender: TObject);
  private
    { Private declarations }
    function ConsultaBanco(var Params: TDWParams): string; overload;
    function GerarPDF: TmemoryStream;
  public
    { Public declarations }
  end;

var
  ServerBest: TServerBest;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses RestDWServerFormU;
{$R *.dfm}
function TServerBest.GerarPDF: TmemoryStream;
begin

  result:= Tmemorystream.Create;
  try
  frxPDFExport1.Stream :=       result;
  frxPDFExport1.ShowDialog      := False;
  frxPDFExport1.ShowProgress    := False;
  frxPDFExport1.OverwritePrompt := False;

  frxReport1.PrepareReport(true);
  frxReport1.Export(frxPDFExport1);
  finally
    //frxPDFExport1.Stream := NIL;
  end;

end;

procedure TServerBest.KoneksiDbBeforeConnect(Sender: TObject);
var
  Port_db: Integer;
  Servis_db: string;
  DataBase: string;
  User_db: string;
  pass_db: string;
  provider_db : string ;
begin
  DataBase := RestDWForm.edDatabase.Text;
  provider_db := restdwform.ProviderDb ;
  Port_db:= StrToInt(RestDWForm.EdPortDb.Text);
  User_db := RestDWForm.edUsernameDb.Text;
  pass_db := RestDWForm.EdPasswordDb.Text;
  Servis_db := RestDWForm.edServer.Text ;

  TUniConnection(Sender).LoginPrompt := FALSE;
  {Microsoft Sql Server
Mariadb
Firebird SQL
Postgre SQL
  }
  TUniConnection(Sender).ProviderName := provider_db;
  TUniConnection(Sender).Server := Servis_db;
  TUniConnection(Sender).Port := Port_db;
  TUniConnection(Sender).Database := DataBase;
  TUniConnection(Sender).Username := User_db ;
  TUniConnection(Sender).Password := pass_db;

   {
  TFDConnection(Sender).Params.Clear;
  TFDConnection(Sender).Params.Add('DriverID= Mysql');
  TFDConnection(Sender).Params.Add('Server=' + Servis_db);
  TFDConnection(Sender).Params.Add('Port=3306');
  TFDConnection(Sender).Params.Add('Database=' + DataBase);
  TFDConnection(Sender).Params.Add('User_Name=' + User_db);
  TFDConnection(Sender).Params.Add('Password=' + pass_db);
  TFDConnection(Sender).Params.Add('Protocol=TCPIP');
  TFDConnection(Sender).DriverName := 'Mysql';
  TFDConnection(Sender).LoginPrompt := FALSE;
  TFDConnection(Sender).UpdateOptions.CountUpdatedRecords := False;
  }

end;

function TServerBest.ConsultaBanco(var Params: TDWParams): string;
var
  VSQL: string;
  JSONValue: TJSONValue;
  FdQuery: TuniQuery;
begin
  if Params.ItemsString['SQL'] <> NIL then
  begin
    JSONValue := UDWJSONObject.TJSONValue.Create;
    JSONValue.Encoding := Encoding;
    if Params.ItemsString['SQL'].Value <> '' then
    begin
      if Params.ItemsString['TESTPARAM'] <> NIL then
        Params.ItemsString['TESTPARAM'].SetValue('OK, OK');
      VSQL := Params.ItemsString['SQL'].Value;
      {$IFDEF FPC}
      {$ELSE}
      FdQuery := TuniQuery.Create(NIL);
      try
        FdQuery.Connection := koneksidb;
        FdQuery.SQL.Add(VSQL);
        JSONValue.LoadFromDataset('sql', FdQuery, RestDWForm.CbEncode.Checked);
        Result := JSONValue.ToJSON;
      finally
        JSONValue.Free;
        FdQuery.Free;
      end;
      {$ENDIF}
    end;
  end;
end;

function TServerBest.DownloadFile(var Params: TDWParams): string;
var
//JSONValue: TJSONValue;
  vFile: TMemoryStream;
  vFileExport: TStringStream;
begin
  if (Params.ItemsString['Relatorio'] <> Nil) then
  begin
      try
          //vFile := TMemoryStream.Create;
          try
            vFile:=GerarPDF;
            vFile.Position := 0;
          except

          end;
       Params.ItemsString['Relatorio'].LoadFromStream(vFile);
//        JSONValue.LoadFromStream(vFile);
      finally
        FreeAndNil(vFile);
//        FreeAndNil(JSONValue);
      end;
  end;
end;

procedure TServerBest.ServerMethodDataModuleCreate(Sender: TObject);
begin
  RESTDWPoolerDB2.Active := RestDWForm.CbPoolerState.Checked;
end;

procedure TServerBest.ServerMethodDataModuleWelcomeMessage(Welcomemsg: string);
begin
  RestDWForm.edDatabase.Text := Welcomemsg;
end;

procedure TServerBest.Server_FDConnectionError(ASender, AInitiator: TObject; var AException: Exception);
begin
  RestDWForm.memoResp.Lines.Add(AException.Message);
end;

end.


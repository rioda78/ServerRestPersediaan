unit uDmService;

interface

uses
  SysUtils, Classes, SysTypes, UDWDatamodule, System.JSON, UDWJSONObject,
  Dialogs, ServerUtils, UDWConsts, FireDAC.Dapt, UDWConstsData,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys,Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Stan.StorageJSON,
  RestDWServerFormU, URESTDWPoolerDB, URestDWDriverFD, FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, frxClass, frxExportPDF, uDWAbout,
  uRESTDWServerEvents, frxExportBaseDialog, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.PGDef, FireDAC.Phys.PG, FireDAC.Phys.MySQL;

type
  TServerMethodDM = class(TServerMethodDataModule)
    RESTDWPoolerDB1: TRESTDWPoolerDB;
    RESTDWDriverFD1: TRESTDWDriverFD;
    Server_FDConnection: TFDConnection;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    frxReport1: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    DWServerEvents1: TDWServerEvents;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    procedure ServerMethodDataModuleCreate(Sender: TObject);
    procedure Server_FDConnectionBeforeConnect(Sender: TObject);
    procedure ServerMethodDataModuleWelcomeMessage(Welcomemsg: string);
    procedure Server_FDConnectionError(ASender, AInitiator: TObject; var AException: Exception);
    function DownloadFile(var Params: TDWParams): string; overload;
  private
    { Private declarations }
    function ConsultaBanco(var Params: TDWParams): string; overload;
    function GerarPDF: TmemoryStream;
  public
    { Public declarations }
  end;

var
  ServerMethodDM: TServerMethodDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
function TServerMethodDM.GerarPDF: TmemoryStream;
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

function TServerMethodDM.ConsultaBanco(var Params: TDWParams): string;
var
  VSQL: string;
  JSONValue: TJSONValue;
  FdQuery: TFDQuery;
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
      FdQuery := TFDQuery.Create(NIL);
      try
        FdQuery.Connection := Server_FDConnection;
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

function TServerMethodDM.DownloadFile(var Params: TDWParams): string;
var
//JSONValue: TJSONValue;
  vFile: TMemoryStream;
  vFileExport: TStringStream;
begin
  if (Params.ItemsString['Relatorio'] <> Nil) then
  begin
 // JSONValue := TJSONValue.Create;
//  JSONValue.Encoding := Params.Encoding;
//  JSONValue.ObjectValue := ovBlob;
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

procedure TServerMethodDM.ServerMethodDataModuleCreate(Sender: TObject);
begin
  RESTDWPoolerDB1.Active := RestDWForm.CbPoolerState.Checked;
end;

procedure TServerMethodDM.ServerMethodDataModuleWelcomeMessage(Welcomemsg: string);
begin
  RestDWForm.EdDatabase.Text := Welcomemsg;
end;

procedure TServerMethodDM.Server_FDConnectionBeforeConnect(Sender: TObject);
var
  Driver_Db: string;
  Port_Db: string;
  Servis_Db: string;
  DataBase: string;
  User_Db: string;
  Pass_Db: string;
begin
  DataBase := RestDWForm.EdDatabase.Text;

  Driver_Db := RestDWForm.CbDriver.Text;

  Servis_Db := RestDwForm.EdServerDb.Text ;


  DataBase := RestDWForm.Eddatabase.Text;

  Port_Db := RestDWForm.EdPortDb.Text;
  User_Db := RestDWForm.EdUserNameDb.Text;
  Pass_Db := RestDWForm.EdPasswordDb.Text;

  TFDConnection(Sender).Params.Clear;
  TFDConnection(Sender).Params.Add('DriverID=' + Driver_Db);
  TFDConnection(Sender).Params.Add('Server=' + Servis_Db);
  TFDConnection(Sender).Params.Add('Port=' + Port_Db);
  TFDConnection(Sender).Params.Add('Database=' + DataBase);
  TFDConnection(Sender).Params.Add('User_Name=' + User_Db);
  TFDConnection(Sender).Params.Add('Password=' + Pass_Db);
  TFDConnection(Sender).Params.Add('Protocol=TCPIP');
  TFDConnection(Sender).DriverName := Driver_db;
  TFDConnection(Sender).LoginPrompt := FALSE;
  TFDConnection(Sender).UpdateOptions.CountUpdatedRecords := False;
end;

procedure TServerMethodDM.Server_FDConnectionError(ASender, AInitiator: TObject; var AException: Exception);
begin
  RestDWForm.memoResp.Lines.Add(AException.Message);
end;

end.


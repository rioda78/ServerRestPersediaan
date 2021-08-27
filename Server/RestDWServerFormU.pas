unit RestDWServerFormU;

Interface

Uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Winsock,
  Winapi.Iphlpapi,
  Winapi.IpTypes,
  USock,
  System.IniFiles,
  Vcl.AppEvnts,
  Vcl.StdCtrls,
  Web.HTTPApp,
  Vcl.ExtCtrls,
  Vcl.Imaging.Jpeg,
  Vcl.Imaging.Pngimage,
  Vcl.Mask,
  Vcl.Menus,
  URESTDWBase,
  Vcl.ComCtrls,
  FireDAC.Phys.FBDef,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.Phys.IBBase,
  FireDAC.Stan.StorageJSON,
  IdComponent,
  IdBaseComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP, uDWJSONObject, uDWAbout, dwCGIRunner, dwISAPIRunner;

type
  TRestDWForm = class(TForm)
    Label8: TLabel;
    Bevel3: TBevel;
    PageControl1: TPageControl;
    TsConfigs: TTabSheet;
    TsLogs: TTabSheet;
    ApplicationEvents1: TApplicationEvents;
    CtiPrincipal: TTrayIcon;
    PmMenu: TPopupMenu;
    RestaurarAplicao1: TMenuItem;
    N5: TMenuItem;
    SairdaAplicao1: TMenuItem;
    MemoReq: TMemo;
    MemoResp: TMemo;
    Label19: TLabel;
    Label18: TLabel;
    RESTServicePooler1: TRESTServicePooler;
    Tupdatelogs: TTimer;
    paTopo: TPanel;
    Image2: TImage;
    paEspanhol: TPanel;
    paIngles: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    lSeguro: TLabel;
    ButtonStart: TButton;
    ButtonStop: TButton;
    cbPoolerState: TCheckBox;
    labSistema: TLabel;
    Panel6: TPanel;
    Panel5: TPanel;
    Label6: TLabel;
    Label10: TLabel;
    Label17: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    labSSL: TLabel;
    eHostCertFile: TEdit;
    eCertFile: TEdit;
    ePrivKeyFile: TEdit;
    ePrivKeyPass: TMaskEdit;
    cbForceWelcome: TCheckBox;
    cbUpdateLog: TCheckBox;
    edPasswordDW: TEdit;
    edPortaDW: TEdit;
    edUserNameDW: TEdit;
    labConexao: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Panel7: TPanel;
    cbAdaptadores: TComboBox;
    cbDriver: TComboBox;
    cbOsAuthent: TCheckBox;
    ckUsaURL: TCheckBox;
    edBD: TEdit;
    edPasswordBD: TEdit;
    edPortaBD: TEdit;
    edURL: TEdit;
    edUserNameBD: TEdit;
    labDBConfig: TLabel;
    Label14: TLabel;
    labNomeBD: TLabel;
    labPorta: TLabel;
    labSenha: TLabel;
    labUsuario: TLabel;
    labVersao: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CbAdaptadoresChange(Sender: TObject);
    procedure CtiPrincipalDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SairdaAplicao1Click(Sender: TObject);
    procedure RestaurarAplicao1Click(Sender: TObject);
    procedure RESTServicePooler1LastRequest(Value: string);
    procedure RESTServicePooler1LastResponse(Value: string);
    procedure TupdatelogsTimer(Sender: TObject);
    procedure CbDriverCloseUp(Sender: TObject);
    procedure CkUsaURLClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
  Private
    { Private declarations }
    VLastRequest,
    VLastRequestB,
    VDatabaseName,
    FCfgName,
    VDatabaseIP,
    VUsername,
    VPassword    : string;
    procedure StartServer;
    Function  GetHandleOnTaskBar: THandle;
    procedure ChangeStatusWindow;
    procedure HideApplication;
  Public
    { Public declarations }
    procedure ShowBalloonTips(IconMessage: Integer = 0; MessageValue: string = '');
    procedure ShowApplication;
    Property  Username     : String Read   VUsername     Write  VUsername;
    Property  Password     : String Read   VPassword     Write  VPassword;
    Property  DatabaseIP   : String Read   VDatabaseIP   Write  VDatabaseIP;
    Property  DatabaseName : String Read   VDatabaseName Write  VDatabaseName;
    procedure Locale_Portugues( pLocale : String );
  End;

var
  RestDWForm: TRestDWForm;

implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

Uses
  Winapi.ShellApi, uDWConsts, UDmService, ServerUtils;

Function ServerIpIndex(Items: TStrings; ChooseIP: string): Integer;
Var
 I : Integer;
Begin
 Result := -1;
 For I  := 0 To Items.Count - 1 Do
  Begin
   If Pos(ChooseIP, Items[I]) > 0 Then
    Begin
     Result := I;
     Break;
    End;
  End;
End;

Function TRestDWForm.GetHandleOnTaskBar: THandle;
Begin
 {$IFDEF COMPILER11_UP}
 If Application.MainFormOnTaskBar And Assigned(Application.MainForm) Then
  Result := Application.MainForm.Handle
 Else
 {$ENDIF COMPILER11_UP}
  Result := Application.Handle;
End;

procedure TRestDWForm.ChangeStatusWindow;
Begin
  If Self.Visible Then
    SairdaAplicao1.Caption := 'Minimalkan'
  Else
    SairdaAplicao1.Caption := 'Keluar';
  Application.ProcessMessages;
End;

procedure TRestDWForm.CkUsaURLClick(Sender: TObject);
Begin
  If CkUsaURL.Checked Then
  Begin
    CbAdaptadores.Visible := False;

    EdURL.Visible         := True;
  End
  Else
  Begin
    EdURL.Visible         := False;
    CbAdaptadores.Visible := True;
  End;
End;

procedure TRestDWForm.CbDriverCloseUp(Sender: TObject);
Var
 Ini : TIniFile;
Begin
  Ini                     := TIniFile.Create(FCfgName);
  Try
   CbAdaptadores.ItemIndex := ServerIpIndex(CbAdaptadores.Items,
                                            Ini.ReadString('SettingDb', 'Servidor', '127.0.0.1'));
   EdBD.Text               := Ini.ReadString('SettingDb', 'BD',         'EMPLOYEE.FDB');
   EdPortaBD.Text          := Ini.ReadString('SettingDb', 'PortaBD',    '3050');
   EdUserNameBD.Text       := Ini.ReadString('SettingDb', 'UsuarioBD',  'SYSDBA');
   EdPasswordBD.Text       := Ini.ReadString('SettingDb', 'SenhaBD',    'masterkey');
   EdPortaDW.Text          := Ini.ReadString('SettingDb', 'PortaDW',    '8082');
   EdUserNameDW.Text       := Ini.ReadString('SettingDb', 'UsuarioDW',  'testserver');
   EdPasswordDW.Text       := Ini.ReadString('SettingDb', 'SenhaDW',    'testserver');

    EdBD.Text         := 'seubanco';
        EdPortaBD.Text    := '1433';
        EdUserNameBD.Text := 'sa';
        EdPasswordBD.Text := EmptyStr;
        DatabaseName      := EdBD.Text;

  Finally
   Ini.Free;
  End;
End;

procedure TRestDWForm.CtiPrincipalDblClick(Sender: TObject);
Begin
  ShowApplication;
End;

procedure TRestDWForm.HideApplication;
Begin
  CtiPrincipal.Visible     := True;
  Application.ShowMainForm := False;
  If Self <> Nil Then
    Self.Visible := False;
  Application.Minimize;
  ShowWindow(GetHandleOnTaskBar, SW_HIDE);
  ChangeStatusWindow;
End;

procedure TRestDWForm.Image3Click(Sender: TObject);
begin
 Locale_Portugues( 'portugues' );
end;

procedure TRestDWForm.Image4Click(Sender: TObject);
begin
 Locale_Portugues( 'espanhol' );
end;

procedure TRestDWForm.Image5Click(Sender: TObject);
begin
 Locale_Portugues( 'ingles' );
end;

procedure TRestDWForm.Locale_Portugues(pLocale: String);
begin

end;

procedure TRestDWForm.RestaurarAplicao1Click(Sender: TObject);
Begin
  ShowApplication;
End;

procedure TRestDWForm.RESTServicePooler1LastRequest(Value: string);
Begin
  VLastRequest := Value;
End;

procedure TRestDWForm.RESTServicePooler1LastResponse(Value: string);
Begin
  VLastRequestB := Value;
End;

procedure TRestDWForm.SairdaAplicao1Click(Sender: TObject);
Begin
  Close;
End;

procedure TRestDWForm.ShowApplication;
Begin
  CtiPrincipal.Visible     := False;
  Application.ShowMainForm := True;
  If Self <> Nil Then
  Begin
    Self.Visible     := True;
    Self.WindowState := WsNormal;
  End;
  ShowWindow(GetHandleOnTaskBar, SW_SHOW);
  ChangeStatusWindow;
End;

procedure TRestDWForm.ShowBalloonTips(IconMessage: Integer = 0; MessageValue: string = '');
Begin
  case IconMessage of
    0:
      CtiPrincipal.BalloonFlags := BfInfo;
    1:
      CtiPrincipal.BalloonFlags := BfWarning;
    2:
      CtiPrincipal.BalloonFlags := BfError;
  Else
    CtiPrincipal.BalloonFlags := BfInfo;
  End;
  CtiPrincipal.BalloonTitle := RestDWForm.Caption;
  CtiPrincipal.BalloonHint  := MessageValue;
  CtiPrincipal.ShowBalloonHint;
  Application.ProcessMessages;
End;

procedure TRestDWForm.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
Begin
  ButtonStart.Enabled   := Not RESTServicePooler1.Active;
  ButtonStop.Enabled    := RESTServicePooler1.Active;
  EdPortaDW.Enabled     := ButtonStart.Enabled;
  EdUserNameDW.Enabled  := ButtonStart.Enabled;
  EdPasswordDW.Enabled  := ButtonStart.Enabled;
  CbAdaptadores.Enabled := ButtonStart.Enabled;
  EdPortaBD.Enabled     := ButtonStart.Enabled;
  EdBD.Enabled          := ButtonStart.Enabled;
  EdUserNameBD.Enabled  := ButtonStart.Enabled;
  EdPasswordBD.Enabled  := ButtonStart.Enabled;
  cbOsAuthent.Enabled   := ButtonStart.Enabled;
  EPrivKeyFile.Enabled  := ButtonStart.Enabled;
  EPrivKeyPass.Enabled  := ButtonStart.Enabled;
  ECertFile.Enabled     := ButtonStart.Enabled;
End;

procedure TRestDWForm.ButtonStartClick(Sender: TObject);
var
  Ini: TIniFile;
Begin
//  DWCGIRunner1.BaseFiles  := ExtractFilePath(ParamSTR(0));
//  DWCGIRunner1.PHPIniPath := ExtractFilePath(ParamSTR(0)) + 'php5\';
  If FileExists(FCfgName) Then
    DeleteFile(FCfgName);
  Ini := TIniFile.Create(FCfgName);
  If CkUsaURL.Checked Then
  Begin
    Ini.WriteString('SettingDb', 'ServerDb', EdURL.Text);
  End
  Else
  Begin
    Ini.WriteString('SettingDb', 'ServerDb', CbAdaptadores.Text);
    cbAdaptadores.onChange(cbAdaptadores);
  End;
  Ini.WriteInteger('SettingDb', 'DRIVER', cbDriver.ItemIndex);
  If ckUsaURL.Checked Then
   Ini.WriteInteger('SettingDb', 'USEDNS', 1)
  Else
   Ini.WriteInteger('SettingDb', 'USEDNS', 0);
  If cbUpdateLog.Checked Then
   Ini.WriteInteger('Configs', 'UPDLOG', 1)
  Else
   Ini.WriteInteger('Configs', 'UPDLOG', 0);
  Ini.WriteString('SettingDb', 'Database', EdBD.Text);
  Ini.WriteString('SettingDb', 'PortDb', EdPortaBD.Text);
  Ini.WriteString('SettingDb', 'PortDW', EdPortaDW.Text);
  Ini.WriteString('SettingDb', 'UserDb', EdUserNameBD.Text);
  Ini.WriteString('SettingDb', 'PassDb', EdPasswordBD.Text);
  Ini.WriteString('SettingDb', 'UserDW', EdUserNameDW.Text);
  Ini.WriteString('SettingDb', 'PassDW', EdPasswordDW.Text);
  Ini.WriteInteger('SettingDb', 'OsAuthent', cbOsAuthent.Checked.ToInteger);
  Ini.WriteString('SSL', 'PKF', EPrivKeyFile.Text);
  Ini.WriteString('SSL', 'PKP', EPrivKeyPass.Text);
  Ini.WriteString('SSL', 'CF', ECertFile.Text);
  Ini.WriteString('SSL', 'HostCF', eHostCertFile.Text);
  If cbForceWelcome.Checked Then
   Ini.WriteInteger('Configs', 'ForceWelcomeAccess', 1)
  Else
   Ini.WriteInteger('Configs', 'ForceWelcomeAccess', 0);
  Ini.Free;
  VUsername := EdUserNameDW.Text;
  VPassword := EdPasswordDW.Text;
  StartServer;
End;

procedure TRestDWForm.ButtonStopClick(Sender: TObject);
Begin
  Tupdatelogs.Enabled       := False;
  RESTServicePooler1.Active := False;
  PageControl1.ActivePage   := TsConfigs;
  ShowApplication;
End;

procedure TRestDWForm.CbAdaptadoresChange(Sender: TObject);
Begin
  VDatabaseIP := Trim(Copy(CbAdaptadores.Text, Pos('-', CbAdaptadores.Text) + 1, 100));
End;

procedure TRestDWForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
Begin
 CanClose := Not RESTServicePooler1.Active;
 If Not CanClose Then
  Begin
    CanClose := Not Self.Visible;
    If CanClose Then
      CanClose := Application.MessageBox('Apakah yakin akan keluar ?', 'Pertanyaan ?', Mb_IconQuestion + Mb_YesNo) = MrYes
    Else
      HideApplication;
  End;
End;

procedure TRestDWForm.FormCreate(Sender: TObject);
Begin
  labVersao.Caption := uDWConsts.DWVERSAO;
  FCfgName                             := StringReplace(ExtractFileName(ParamStr(0)), '.exe', '', [RfReplaceAll]);
  FCfgName                             := ExtractFilePath(ParamSTR(0)) + 'Config_' + FCfgName + '.ini';
//  RESTServicePooler1.AddDataRoute('datadm',  TServerMethodDM);
//  RESTServicePooler1.AddDataRoute('datadm2', TServerMethodDMCopia);
  RESTServicePooler1.ServerMethodClass := TServerMethodDM;
  RESTServicePooler1.RootPath          := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
  PageControl1.ActivePage              := TsConfigs;
End;

procedure TRestDWForm.FormShow(Sender: TObject);
var
  Ini:               TIniFile;
  VTag, I:           Integer;
  ANetInterfaceList: TNetworkInterfaceList;
Begin
//set english
image5Click(sender);
 VTag := 0;
 If (GetNetworkInterfaces(ANetInterfaceList)) Then
  Begin
    CbAdaptadores.Items.Clear;
    For I := 0 To High(ANetInterfaceList) Do
    Begin
      CbAdaptadores.Items.Add('Lokasi #' + IntToStr(I) + ' - ' + ANetInterfaceList[I].AddrIP);
      If (I <= 1) or (Pos('127.0.0.1', ANetInterfaceList[I].AddrIP) > 0) Then
      Begin
        VDatabaseIP := ANetInterfaceList[I].AddrIP;
        VTag        := 1;
      End;
    End;
    CbAdaptadores.ItemIndex := VTag;
  End;
 Ini                     := TIniFile.Create(FCfgName);
 cbDriver.ItemIndex      := Ini.ReadInteger('SettingDb', 'DRIVER', 0);
 ckUsaURL.Checked        := Ini.ReadInteger('SettingDb', 'USEDNS', 0) = 1;
 If ServerIpIndex(CbAdaptadores.Items, Ini.ReadString('SettingDb', 'ServerDb', '')) > -1 Then
  CbAdaptadores.ItemIndex := ServerIpIndex(CbAdaptadores.Items, Ini.ReadString('SettingDb', 'Servidor', ''))
 Else
  Begin
   If Ini.ReadString('SettingDb', 'ServerDb', '') <> '' Then
    Begin
     cbAdaptadores.Items.Add(Ini.ReadString('SettingDb', 'Servidor', ''));
     cbAdaptadores.ItemIndex := cbAdaptadores.Items.Count -1;
    End;
  End;
 EdBD.Text                := Ini.ReadString('SettingDb',  'Database', 'EMPLOYEE.FDB');

 EdPortaBD.Text           := Ini.ReadString('SettingDb',  'PortDb', '3050');
 EdPortaDW.Text           := Ini.ReadString('SettingDb',  'PortDW', '8082');
 EdUserNameBD.Text        := Ini.ReadString('SettingDb',  'UserDb', 'SYSDBA');
 EdPasswordBD.Text        := Ini.ReadString('SettingDb',  'PassDb', 'masterkey');
 EdUserNameDW.Text        := Ini.ReadString('SettingDb',  'UserDW', 'testserver');
 EdPasswordDW.Text        := Ini.ReadString('SettingDb',  'PassDW', 'testserver');
 //EdMonitor.Text           := Ini.ReadString('SettingDb',  'MonitorBy', 'Remote');  // ICO Menezes
 //EdDataSource.Text        := Ini.ReadString('SettingDb',  'DataSource', 'SQL');
 cbOsAuthent.Checked      := Ini.ReadInteger('SettingDb', 'OsAuthent', 0) = 1;
 cbUpdateLog.Checked      := Ini.ReadInteger('Configs',    'UPDLOG', 1) = 1;
 EPrivKeyFile.Text        := Ini.ReadString('SSL',         'PKF', '');
 EPrivKeyPass.Text        := Ini.ReadString('SSL',         'PKP', '');
 ECertFile.Text           := Ini.ReadString('SSL',         'CF', '');
 eHostCertFile.Text       := Ini.ReadString('SSL',         'HostCF', '');
 cbForceWelcome.Checked   := Ini.ReadInteger('Configs',    'ForceWelcomeAccess', 0) = 1;
 Ini.Free;
End;

procedure TRestDWForm.StartServer;
Begin
 If Not RESTServicePooler1.Active Then
  Begin
   RESTServicePooler1.AuthenticationOptions.AuthorizationOption := rdwAOBasic;
   TRDWAuthOptionBasic(RESTServicePooler1.AuthenticationOptions.OptionParams).Username := EdUserNameDW.Text;
    TRDWAuthOptionBasic(RESTServicePooler1.AuthenticationOptions.OptionParams).Password := EdPasswordDW.Text;


   RESTServicePooler1.ServicePort           := StrToInt(EdPortaDW.Text);
   RESTServicePooler1.SSLPrivateKeyFile     := EPrivKeyFile.Text;
   RESTServicePooler1.SSLPrivateKeyPassword := EPrivKeyPass.Text;
   RESTServicePooler1.SSLCertFile           := ECertFile.Text;
   RESTServicePooler1.SSLRootCertFile       := eHostCertFile.Text;
   RESTServicePooler1.ForceWelcomeAccess    := cbForceWelcome.Checked;
   RESTServicePooler1.Active                := True;
   If Not RESTServicePooler1.Active Then
     Exit;
   PageControl1.ActivePage := TsLogs;
   HideApplication;
   Tupdatelogs.Enabled := cbUpdateLog.Checked;
  End;
 If RESTServicePooler1.Secure Then
  Begin
   LSeguro.Font.Color := ClBlue;
   LSeguro.Caption    := 'Aman : Ya';
  End
 Else
  Begin
   LSeguro.Font.Color := ClRed;
   LSeguro.Caption    := 'Aman : Tidak';
  End;
End;

procedure TRestDWForm.TupdatelogsTimer(Sender: TObject);
var
 VTempLastRequest, VTempLastRequestB: string;
Begin
 Tupdatelogs.Enabled := False;
 Try
  VTempLastRequest  := VLastRequest;
  VTempLastRequestB := VLastRequestB;
  If (VTempLastRequest <> '') Then
   Begin
    If MemoReq.Lines.Count > 0 Then
     If MemoReq.Lines[MemoReq.Lines.Count - 1] = VTempLastRequest Then
      Exit;
    If MemoReq.Lines.Count = 0 Then
     MemoReq.Lines.Add(Copy(VTempLastRequest, 1, 100))
    Else
     MemoReq.Lines[MemoReq.Lines.Count - 1] := Copy(VTempLastRequest, 1, 100);
    If Length(VTempLastRequest) > 1000 Then
     MemoReq.Lines[MemoReq.Lines.Count - 1] := MemoReq.Lines[MemoReq.Lines.Count - 1] + '...';
    If MemoResp.Lines.Count > 0 Then
     If MemoResp.Lines[MemoResp.Lines.Count - 1] = VTempLastRequestB Then
      Exit;
    If MemoResp.Lines.Count = 0 Then
     MemoResp.Lines.Add(Copy(VTempLastRequestB, 1, 100))
    Else
     MemoResp.Lines[MemoResp.Lines.Count - 1] := Copy(VTempLastRequestB, 1, 100);
    If Length(VTempLastRequest) > 1000 Then
     MemoResp.Lines[MemoResp.Lines.Count - 1] := MemoResp.Lines[MemoResp.Lines.Count - 1] + '...';
   End;
  Finally
   Tupdatelogs.Enabled := True;
  End;
End;

End.
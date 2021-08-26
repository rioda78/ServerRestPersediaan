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
  ServerUtils,
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
  IdHTTP, uDWAbout;

type
  TRestDWForm = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    Label8: TLabel;
    Bevel3: TBevel;
    LSeguro: TLabel;
    CbPoolerState: TCheckBox;
    PageControl1: TPageControl;
    TsConfigs: TTabSheet;
    TsLogs: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label13: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label6: TLabel;
    Image1: TImage;
    Bevel4: TBevel;
    Label4: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    EdPortaDW: TEdit;
    EdUserNameDW: TEdit;
    EdPasswordDW: TEdit;
    EPrivKeyFile: TEdit;
    ECertFile: TEdit;
    EPrivKeyPass: TMaskEdit;
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
    CbEncode: TCheckBox;
    RESTServicePooler1: TRESTServicePooler;
    CheckBox1: TCheckBox;
    Tupdatelogs: TTimer;
    CbDriver: TComboBox;
    Label20: TLabel;
    EdServerDb: TLabeledEdit;
    EdUsernameDb: TLabeledEdit;
    EdPasswordDb: TLabeledEdit;
    EdDatabase: TLabeledEdit;
    EdPortDb: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CtiPrincipalDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SairdaAplicao1Click(Sender: TObject);
    procedure RestaurarAplicao1Click(Sender: TObject);
    procedure RESTServicePooler1LastRequest(Value: string);
    procedure RESTServicePooler1LastResponse(Value: string);
    procedure TupdatelogsTimer(Sender: TObject);
  Private
    { Private declarations }
    VLastRequest, VLastRequestB, VDatabaseName, FCfgName, VDatabaseIP, VUsername, VPassword: string;
    procedure StartServer;
    Function GetHandleOnTaskBar: THandle;
    procedure ChangeStatusWindow;
    procedure HideApplication;
    procedure BacaSetting;
    procedure TulisSetting;
  Public
    { Public declarations }
    procedure ShowBalloonTips(IconMessage: Integer = 0; MessageValue: string = '');
    procedure ShowApplication;
    Property Username: string
      Read   VUsername
      Write  VUsername;
    Property Password: string
      Read   VPassword
      Write  VPassword;
    Property DatabaseIP: string
      Read   VDatabaseIP
      Write  VDatabaseIP;
    Property DatabaseName: string
      Read   VDatabaseName
      Write  VDatabaseName;
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
  Winapi.ShellApi,
  UDmService;

Function ServerIpIndex(Items: TStrings; ChooseIP: string): Integer;
var
  I: Integer;
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
    SairdaAplicao1.Caption := 'Keluar dari App';
  Application.ProcessMessages;
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

procedure TRestDWForm.BacaSetting;
var
ini : TInifile ;
driver : String ;
begin

  Ini                     := TIniFile.Create(FCfgName);
  Try
   EdServerdb.Text     := Ini.ReadString('SettingDb', 'Server', '127.0.0.1');
   EdDatabase.Text      := Ini.ReadString('SettingDb', 'Database', 'EMPLOYEE.FDB');
   EdPortDb.Text          := Ini.ReadString('SettingDb', 'PortDb', '3050');
   EdUserNameDb.Text       := Ini.ReadString('SettingDb', 'UserDb', 'SYSDBA');
   EdPasswordDb.Text       := Ini.ReadString('SettingDb', 'PassDb', 'masterkey');
   driver := uppercase(ini.ReadString('SettingDb', 'Driver', 'MSSQL'));
   EdPortaDW.Text          := Ini.ReadString('SettingDb', 'PortDW', '8082');
   EdUserNameDW.Text       := Ini.ReadString('SettingDb', 'UserDW', 'testserver');
   EdPasswordDW.Text       := Ini.ReadString('SettingDb', 'PassDW', 'testserver');

   if driver = 'MSSQL' then
   begin
     cbdriver.ItemIndex := 0 ;
   end
   else if driver = 'MYSQL' then
   BEGIN
     cbdriver.ItemIndex := 1 ;
   END
   else
   begin
     cbdriver.ItemIndex := 2 ;
   end;
  //
  EPrivKeyFile.Text := Ini.ReadString('SSL', 'PKF', '');
  EPrivKeyPass.Text := Ini.ReadString('SSL', 'PKP', '');
  ECertFile.Text    := Ini.ReadString('SSL', 'CF', '');
  Finally
   Ini.Free;
  End;
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
  EdPortDb.Enabled     := ButtonStart.Enabled;
  EdServerDb.Enabled       := ButtonStart.Enabled;
  EdDatabase.Enabled      := ButtonStart.Enabled;
  EdUserNameDb.Enabled  := ButtonStart.Enabled;
  EdPasswordDb.Enabled  := ButtonStart.Enabled;
  EPrivKeyFile.Enabled  := ButtonStart.Enabled;
  EPrivKeyPass.Enabled  := ButtonStart.Enabled;
  ECertFile.Enabled     := ButtonStart.Enabled;
End;

procedure TRestDWForm.ButtonStartClick(Sender: TObject);
Begin


  TulisSetting ;
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

procedure TRestDWForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
Begin
  CanClose := Not RESTServicePooler1.Active;
  If Not CanClose Then
  Begin
    CanClose := Not Self.Visible;
    If CanClose Then
      CanClose := Application.MessageBox('Apakah anda ingin keluar ?', 'Pertanyaan ?', Mb_IconQuestion + Mb_YesNo) = MrYes
    Else
      HideApplication;
  End;
End;

procedure TRestDWForm.FormCreate(Sender: TObject);
Begin
  // define o nome do .ini de acordo c o EXE
  // dessa forma se quiser testar várias instâncias do servidor em
  // portas diferentes os arquivos não irão conflitar
  FCfgName                             := StringReplace(ExtractFileName(ParamStr(0)), '.exe', '', [RfReplaceAll]);
  FCfgName                             := ExtractFilePath(ParamSTR(0)) + 'Config_' + FCfgName + '.ini';
  RESTServicePooler1.ServerMethodClass := TServerMethodDM;
  PageControl1.ActivePage              := TsConfigs;
End;

procedure TRestDWForm.FormShow(Sender: TObject);
Begin
  BacaSetting ;
End;

procedure TRestDWForm.StartServer;
Begin
  If Not RESTServicePooler1.Active Then
  Begin
    //RestServicePooler1.AuthenticationOptions.AuthorizationOption :=
   // RESTServicePooler1.ServerParams.UserName := EdUserNameDW.Text;
   // RESTServicePooler1.ServerParams.Password := EdPasswordDW.Text;
    TRDWAuthOptionBasic(RESTServicePooler1.AuthenticationOptions.OptionParams).Username := EdUserNameDW.Text;
     TRDWAuthOptionBasic(RESTServicePooler1.AuthenticationOptions.OptionParams).Password := EdPasswordDW.Text;
    RESTServicePooler1.ServicePort           := StrToInt(EdPortaDW.Text);
    RESTServicePooler1.SSLPrivateKeyFile     := EPrivKeyFile.Text;
    RESTServicePooler1.SSLPrivateKeyPassword := EPrivKeyPass.Text;
    RESTServicePooler1.SSLCertFile           := ECertFile.Text;
    RESTServicePooler1.Active                := True;
    If Not RESTServicePooler1.Active Then
      Exit;
    PageControl1.ActivePage := TsLogs;
    HideApplication;
    Tupdatelogs.Enabled := True;
  End;
  If RESTServicePooler1.Secure Then
  Begin
    LSeguro.Font.Color := ClGreen;
    LSeguro.Caption    := 'Aman : Ya';
  End
  Else
  Begin
    LSeguro.Font.Color := ClRed;
    LSeguro.Caption    := 'Aman : Tidak';
  End;
End;

procedure TRestDWForm.TulisSetting;
var
ini : TInifile ;
begin
  If FileExists(FCfgName) Then
    DeleteFile(FCfgName);
  Ini := TIniFile.Create(FCfgName);
  try
  Ini.WriteString('SettingDb', 'DRIVER', cbDriver.Text);
  ini.WriteString('SettingDb', 'Server', edserverdb.Text);
  Ini.WriteString('SettingDb', 'Database', EdDatabase.Text);
  Ini.WriteString('SettingDb', 'PortDB', EdPortDb.Text);
  Ini.WriteString('SettingDb', 'PortDW', EdPortaDW.Text);
  Ini.WriteString('SettingDb', 'UserDb', EdUserNameDb.Text);
  Ini.WriteString('SettingDb', 'PassDb', EdPasswordDb.Text);
  //RestDW
  Ini.WriteString('SettingDb', 'UserDW', EdUserNameDW.Text);
  Ini.WriteString('SettingDb', 'PassDW', EdPasswordDW.Text);
  //SSL
  Ini.WriteString('SSL', 'PKF', EPrivKeyFile.Text);
  Ini.WriteString('SSL', 'PKP', EPrivKeyPass.Text);
  Ini.WriteString('SSL', 'CF', ECertFile.Text);
  finally
      Ini.Free;
  end;

end;

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

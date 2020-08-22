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

  Winapi.IpTypes,

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




  DBAccess, Uni,
  Data.DB,
  ServerUtils,
  uDWAbout,
  uRESTDWDriverUNIDAC;

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
    Label7: TLabel;
    Label13: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel4: TBevel;
    Label4: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
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
    edServer: TLabeledEdit;
    edDatabase: TLabeledEdit;
    edUsernameDb: TLabeledEdit;
    EdPasswordDb: TLabeledEdit;
    EdPortDw: TLabeledEdit;
    EdUserDw: TLabeledEdit;
    EdPassDw: TLabeledEdit;
    EdPortDb: TLabeledEdit;
    RESTDWServiceNotification1: TRESTDWServiceNotification;
    CbProvider: TComboBox;
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
    procedure CbProviderChange(Sender: TObject);
  Private
    { Private declarations }
    VLastRequest, VLastRequestB, VDatabaseName, FCfgName, VDatabaseIP, VUsername, VPassword: string;
    FRdms: string;
    FProviderDb: string;
    procedure StartServer;
    Function GetHandleOnTaskBar: THandle;
    procedure ChangeStatusWindow;
    procedure HideApplication;
    procedure setRdms(const Value: string);
  protected
    procedure WriteState(Writer: TWriter); override;
  Public
    { Public declarations }
    procedure ShowBalloonTips(IconMessage: Integer = 0; MessageValue: string = '');
    procedure ShowApplication;
    property Rdms: string read FRdms write setRdms;
    property ProviderDb: string read FProviderDb write FProviderDb;
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
  uDmService;

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

procedure TRestDWForm.CbProviderChange(Sender: TObject);
begin
providerdb := cbprovider.Items[cbprovider.ItemIndex];
end;

procedure TRestDWForm.ChangeStatusWindow;
Begin
  If Self.Visible Then
    SairdaAplicao1.Caption := 'Minimalkan'
  Else
    SairdaAplicao1.Caption := 'Tutup Aplikasi';
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

procedure TRestDWForm.setRdms(const Value: string);
begin
  FRdms := Value;
end;

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
  EdPortDW.Enabled     := ButtonStart.Enabled;
  EdUserDw.Enabled  := ButtonStart.Enabled;
  EdPassDw.Enabled  := ButtonStart.Enabled;
  EdPortDb.Enabled     := ButtonStart.Enabled;
  edDatabase.Enabled          := ButtonStart.Enabled;
  edUsernameDb.Enabled  := ButtonStart.Enabled;
  EdPasswordDb.Enabled  := ButtonStart.Enabled;
  EPrivKeyFile.Enabled  := ButtonStart.Enabled;
  EPrivKeyPass.Enabled  := ButtonStart.Enabled;
  ECertFile.Enabled     := ButtonStart.Enabled;
End;

procedure TRestDWForm.ButtonStartClick(Sender: TObject);
var
  Ini: TIniFile;
  fdkon : TUniConnection ;
Begin

  fdkon := TuniConnection.Create(nil);
  try

    fdkon.ProviderName := providerdb ;
    fdkon.Server :=  edServer.Text;
    fdkon.Port :=  StrToInt(EdPortDb.Text);
    fdkon.Database :=  edDatabase.Text;
    fdkon.Username :=  edUsernameDb.Text ;
    fdkon.Password := EdPasswordDb.Text ;

    {
    fdkon.Params.Clear;
    fdkon.Params.Add('DriverID= Mysql');
    fdkon.Params.Add('Server=' + edServer.Text);
    fdkon.Params.Add('Port=3306');
    fdkon.Params.Add('Database=' + edDatabase.Text);
    fdkon.Params.Add('User_Name=' + edUsernameDb.Text);
    fdkon.Params.Add('Password=' + EdPasswordDb.Text);
    fdkon.Params.Add('Protocol=TCPIP');
    fdkon.DriverName := 'Mysql';
    }
    fdkon.LoginPrompt := FALSE;
   // TFDConnection(Sender).Params.Add('Protocol=TCPIP');
    try
     fdkon.Connected := True ;
     if fdkon.Connected = True then
      begin
       If FileExists(FCfgName) Then
        DeleteFile(FCfgName);
      Ini := TIniFile.Create(FCfgName);
      Ini.WriteString('Konfigurasi', 'Server', edServer.Text);
      ini.WriteString('Konfigurasi', 'Provider', providerdb);
      Ini.WriteString('Konfigurasi', 'database', edDatabase.Text);
      Ini.WriteString('Konfigurasi', 'PortDB', EdPortDb.Text);

      Ini.WriteString('Konfigurasi', 'UserDb', edUsernameDb.Text);
      Ini.WriteString('Konfigurasi', 'PassDb', EdPasswordDb.Text);

      Ini.WriteString('Konfigurasi', 'PortDW', EdPortDw.Text);
      Ini.WriteString('Konfigurasi', 'UserDw', EdUserDw.Text);
      Ini.WriteString('Konfigurasi', 'PassDw', EdPassDw.Text);

      Ini.WriteString('SSL', 'PKF', EPrivKeyFile.Text);
      Ini.WriteString('SSL', 'PKP', EPrivKeyPass.Text);
      Ini.WriteString('SSL', 'CF', ECertFile.Text);
      Ini.Free;

        VUsername := EdUserDw.Text;
        VPassword := EdPassDw.Text;

        StartServer;

    end;
    except on e:exception do
    begin
       raise Exception.Create('Error Message '+ e.Message);
    end;

    end;

  finally
   FreeAndNil(fdkon);
  end;
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
      CanClose := Application.MessageBox('Apakah yakin akan menutup?', 'Informasi ?', Mb_IconQuestion + Mb_YesNo) = MrYes
    Else
      HideApplication;
  End;
End;

procedure TRestDWForm.FormCreate(Sender: TObject);
Begin
  FCfgName                             := StringReplace(ExtractFileName(ParamStr(0)), '.exe', '', [RfReplaceAll]);
  FCfgName                             := ExtractFilePath(ParamSTR(0)) + 'Config_' + FCfgName + '.ini';
  RESTServicePooler1.ServerMethodClass := TServerBest;
  PageControl1.ActivePage              := TsConfigs;
End;

procedure TRestDWForm.FormShow(Sender: TObject);
var
  Ini:               TIniFile;
Begin

  Ini                     := TIniFile.Create(FCfgName);
  providerdb := Ini.ReadString('Konfigurasi', 'Provider', 'sql server');

  if lowercase(providerdb) = 'sql server' then
  begin
    cbprovider.ItemIndex := 0 ;
  end
  else if lowercase(providerdb) = 'mysql' then
  begin
     cbprovider.ItemIndex := 1 ;
  end
  else if lowercase(providerdb) = 'interbase' then
  begin
     cbprovider.ItemIndex := 2 ;
  end
  else if lowercase(providerdb) = 'postgresql' then
  begin
     cbprovider.ItemIndex := 3 ;
  end
  else
    cbprovider.ItemIndex := 0 ;

  edServer.Text           := Ini.ReadString('Konfigurasi', 'Server', '127.0.0.1');
  edDatabase.Text               := Ini.ReadString('Konfigurasi', 'Database', 'EMPLOYEE.FDB');
  EdPortDb.Text          := Ini.ReadString('Konfigurasi', 'PortDB', '3050');
  EdPortDW.Text          := Ini.ReadString('Konfigurasi', 'PortDW', '8082');
  edUsernameDb.Text       := Ini.ReadString('Konfigurasi', 'UserDb', 'SYSDBA');
  EdPasswordDb.Text       := Ini.ReadString('Konfigurasi', 'PassDb', 'masterkey');
  EdUserDw.Text       := Ini.ReadString('Konfigurasi', 'UserDw', 'testserver');
  EdPassDw.Text     := Ini.ReadString('Konfigurasi', 'PassDw', 'testserver');
  EPrivKeyFile.Text := Ini.ReadString('SSL', 'PKF', '');
  EPrivKeyPass.Text := Ini.ReadString('SSL', 'PKP', '');
  ECertFile.Text    := Ini.ReadString('SSL', 'CF', '');
  Ini.Free;
End;

procedure TRestDWForm.StartServer;
Begin
  If Not RESTServicePooler1.Active Then
  Begin
    RESTServicePooler1.AuthenticationOptions.AuthorizationOption :=  rdwAOBasic ;

   // RESTServicePooler1.AuthenticationOptions.OptionParams := EdPassDw.Text;
    RESTServicePooler1.ServicePort           := StrToInt(EdPortDW.Text);
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


procedure TRestDWForm.WriteState(Writer: TWriter);
begin
  inherited;

end;

End.

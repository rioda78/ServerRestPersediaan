object RestDWForm: TRestDWForm
  Left = 271
  Top = 114
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Servis Rest'
  ClientHeight = 445
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    520
    445)
  PixelsPerInch = 96
  TextHeight = 13
  object Label8: TLabel
    Left = 8
    Top = 15
    Width = 3
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel3: TBevel
    Left = 13
    Top = 341
    Width = 496
    Height = 2
    Shape = bsTopLine
  end
  object lSeguro: TLabel
    Left = 13
    Top = 416
    Width = 73
    Height = 13
    Anchors = []
    Caption = 'Aman : Tidak'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitTop = 383
  end
  object ButtonStart: TButton
    Left = 259
    Top = 411
    Width = 121
    Height = 25
    Cursor = crHandPoint
    Anchors = []
    Caption = 'Mulai'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 386
    Top = 411
    Width = 121
    Height = 25
    Cursor = crHandPoint
    Anchors = []
    Caption = 'Stop'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = ButtonStopClick
  end
  object cbPoolerState: TCheckBox
    Left = 157
    Top = 415
    Width = 97
    Height = 17
    Anchors = []
    Caption = 'Pooler Active?'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 2
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 520
    Height = 405
    ActivePage = tsConfigs
    Align = alTop
    Anchors = []
    TabOrder = 3
    object tsConfigs: TTabSheet
      Caption = 'Configuration'
      DesignSize = (
        512
        377)
      object Label7: TLabel
        Left = 3
        Top = 7
        Width = 101
        Height = 13
        Caption = 'Konfigurasi Servis'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label13: TLabel
        Left = 3
        Top = 71
        Width = 120
        Height = 13
        Caption = 'Konfigurasi Database'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Bevel1: TBevel
        Left = 4
        Top = 26
        Width = 360
        Height = 2
        Shape = bsTopLine
      end
      object Bevel2: TBevel
        Left = 3
        Top = 90
        Width = 498
        Height = 2
        Shape = bsTopLine
      end
      object Bevel4: TBevel
        Left = 8
        Top = 281
        Width = 498
        Height = 2
        Anchors = [akLeft, akBottom]
        Shape = bsTopLine
        ExplicitTop = 245
      end
      object Label4: TLabel
        Left = 7
        Top = 265
        Width = 86
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'Konfigurasi SSL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 234
      end
      object Label15: TLabel
        Left = 7
        Top = 284
        Width = 87
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'Private Key File'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 253
      end
      object Label16: TLabel
        Left = 357
        Top = 284
        Width = 122
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'Private Key Password'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 253
      end
      object Label17: TLabel
        Left = 7
        Top = 321
        Width = 49
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'Cert. File'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 290
      end
      object ePrivKeyFile: TEdit
        Left = 7
        Top = 300
        Width = 344
        Height = 21
        Anchors = [akLeft, akBottom]
        TabOrder = 7
      end
      object eCertFile: TEdit
        Left = 7
        Top = 337
        Width = 344
        Height = 21
        Anchors = [akLeft, akBottom]
        TabOrder = 12
      end
      object ePrivKeyPass: TMaskEdit
        Left = 358
        Top = 300
        Width = 148
        Height = 21
        Anchors = [akLeft, akBottom]
        PasswordChar = '*'
        TabOrder = 10
        Text = ''
      end
      object cbEncode: TCheckBox
        Left = 286
        Top = 27
        Width = 101
        Height = 19
        Caption = 'Encode Strings'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        State = cbChecked
        TabOrder = 9
      end
      object CheckBox1: TCheckBox
        Left = 286
        Top = 52
        Width = 91
        Height = 19
        Caption = 'Compression'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        State = cbChecked
        TabOrder = 11
      end
      object edServer: TLabeledEdit
        Left = 3
        Top = 150
        Width = 195
        Height = 21
        EditLabel.Width = 32
        EditLabel.Height = 13
        EditLabel.Caption = 'Server'
        TabOrder = 3
      end
      object edDatabase: TLabeledEdit
        Left = 3
        Top = 238
        Width = 195
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Database'
        TabOrder = 8
      end
      object edUsernameDb: TLabeledEdit
        Left = 3
        Top = 193
        Width = 195
        Height = 21
        EditLabel.Width = 48
        EditLabel.Height = 13
        EditLabel.Caption = 'Username'
        TabOrder = 5
      end
      object EdPasswordDb: TLabeledEdit
        Left = 219
        Top = 193
        Width = 195
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Password'
        PasswordChar = '*'
        TabOrder = 6
      end
      object EdPortDw: TLabeledEdit
        Left = 211
        Top = 44
        Width = 59
        Height = 21
        EditLabel.Width = 20
        EditLabel.Height = 13
        EditLabel.Caption = 'Port'
        NumbersOnly = True
        TabOrder = 2
      end
      object EdUserDw: TLabeledEdit
        Left = 3
        Top = 44
        Width = 91
        Height = 21
        EditLabel.Width = 48
        EditLabel.Height = 13
        EditLabel.Caption = 'Username'
        TabOrder = 0
      end
      object EdPassDw: TLabeledEdit
        Left = 100
        Top = 44
        Width = 91
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Password'
        TabOrder = 1
      end
      object EdPortDb: TLabeledEdit
        Left = 219
        Top = 150
        Width = 66
        Height = 21
        EditLabel.Width = 20
        EditLabel.Height = 13
        EditLabel.Caption = 'Port'
        NumbersOnly = True
        TabOrder = 4
      end
      object CbProvider: TComboBox
        Left = 5
        Top = 105
        Width = 145
        Height = 21
        TabOrder = 13
        Text = 'Provider'
        OnChange = CbProviderChange
        Items.Strings = (
          'Sql Server'
          'Mysql'
          'Interbase'
          'PostgreSQL')
      end
    end
    object tsLogs: TTabSheet
      Caption = 'Logs'
      ImageIndex = 1
      object Label19: TLabel
        Left = 7
        Top = 147
        Width = 47
        Height = 13
        Caption = 'Response'
        Color = clBtnFace
        ParentColor = False
      end
      object Label18: TLabel
        Left = 7
        Top = 10
        Width = 40
        Height = 13
        Caption = 'Request'
        Color = clBtnFace
        ParentColor = False
      end
      object memoReq: TMemo
        Left = 7
        Top = 29
        Width = 495
        Height = 112
        TabOrder = 0
      end
      object memoResp: TMemo
        Left = 7
        Top = 166
        Width = 495
        Height = 145
        TabOrder = 1
      end
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 140
    Top = 14
  end
  object ctiPrincipal: TTrayIcon
    Hint = 'REST Servis'
    PopupMenu = pmMenu
    OnDblClick = ctiPrincipalDblClick
    Left = 180
    Top = 8
  end
  object pmMenu: TPopupMenu
    Left = 176
    Top = 144
    object RestaurarAplicao1: TMenuItem
      Caption = 'Restore Aplikasi'
      OnClick = RestaurarAplicao1Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object SairdaAplicao1: TMenuItem
      Caption = 'Tutup Aplikasi'
      OnClick = SairdaAplicao1Click
    end
  end
  object RESTServicePooler1: TRESTServicePooler
    Active = False
    CORS = False
    CORS_CustomHeaders.Strings = (
      'Access-Control-Allow-Origin=*'
      
        'Access-Control-Allow-Methods=GET, POST, PATCH, PUT, DELETE, OPTI' +
        'ONS'
      
        'Access-Control-Allow-Headers=Content-Type, Origin, Accept, Autho' +
        'rization, X-CUSTOM-HEADER')
    RequestTimeout = -1
    ServicePort = 8082
    ProxyOptions.Port = 8888
    AuthenticationOptions.AuthorizationOption = rdwAOBasic
    AuthenticationOptions.OptionParams.Username = 'Bangsat123??'
    AuthenticationOptions.OptionParams.Password = 'Master9'
    SSLMethod = sslvSSLv3
    SSLVersions = [sslvSSLv2, sslvSSLv23, sslvSSLv3]
    OnLastRequest = RESTServicePooler1LastRequest
    OnLastResponse = RESTServicePooler1LastResponse
    Encoding = esUtf8
    ServerContext = 'restdataware'
    RootPath = '/'
    SSLVerifyMode = [sslvrfPeer]
    SSLVerifyDepth = 0
    ForceWelcomeAccess = False
    RESTServiceNotification = RESTDWServiceNotification1
    CriptOptions.Use = False
    CriptOptions.Key = 'RDWBASEKEY256'
    MultiCORE = False
    Left = 316
    Top = 16
  end
  object tupdatelogs: TTimer
    Enabled = False
    OnTimer = tupdatelogsTimer
    Left = 236
    Top = 16
  end
  object RESTDWServiceNotification1: TRESTDWServiceNotification
    GarbageTime = 60000
    QueueNotifications = 50
    Left = 352
    Top = 240
  end
end

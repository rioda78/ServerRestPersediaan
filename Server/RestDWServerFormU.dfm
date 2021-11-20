object RestDWForm: TRestDWForm
  Left = 271
  Top = 114
  BorderStyle = bsSingle
  Caption = 'REST Server'
  ClientHeight = 594
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
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
    Font.Name = 'Segoe UI'
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
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 4
    Top = 4
    Width = 632
    Height = 545
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ActivePage = tsConfigs
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitHeight = 623
    object tsConfigs: TTabSheet
      Caption = 'Configuration'
      ExplicitHeight = 591
      object Panel1: TPanel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 616
        Height = 505
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        ExplicitHeight = 583
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 616
          Height = 105
          Align = alTop
          TabOrder = 0
          object labConexao: TLabel
            AlignWithMargins = True
            Left = 1
            Top = 4
            Width = 614
            Height = 23
            Margins.Left = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alTop
            AutoSize = False
            Caption = ' .: SERVER CONFIGURATION'
            Color = clGrayText
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = False
            Layout = tlCenter
            ExplicitLeft = 0
            ExplicitTop = 3
            ExplicitWidth = 615
          end
          object EdUsernameRest: TLabeledEdit
            Left = 344
            Top = 55
            Width = 121
            Height = 25
            EditLabel.Width = 88
            EditLabel.Height = 17
            EditLabel.Caption = 'Username Rest'
            TabOrder = 0
          end
          object EdPassRest: TLabeledEdit
            Left = 488
            Top = 55
            Width = 121
            Height = 25
            EditLabel.Width = 85
            EditLabel.Height = 17
            EditLabel.Caption = 'Password Rest'
            TabOrder = 1
          end
          object EdPortRest: TLabeledEdit
            Left = 12
            Top = 55
            Width = 121
            Height = 25
            EditLabel.Width = 53
            EditLabel.Height = 17
            EditLabel.Caption = 'Port Rest'
            TabOrder = 2
          end
        end
        object Panel5: TPanel
          Left = 0
          Top = 294
          Width = 616
          Height = 211
          Align = alBottom
          TabOrder = 1
          ExplicitTop = 334
          object Label6: TLabel
            AlignWithMargins = True
            Left = 4
            Top = 187
            Width = 608
            Height = 17
            Margins.Bottom = 6
            Align = alBottom
            Alignment = taCenter
            AutoSize = False
            Caption = 'Tambahkan rule dalam firewall'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitLeft = 1
            ExplicitTop = 526
            ExplicitWidth = 610
          end
          object labSSL: TLabel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 608
            Height = 23
            Margins.Bottom = 0
            Align = alTop
            AutoSize = False
            Caption = ' .: SSL CONFIGURATION'
            Color = clGrayText
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = False
            Layout = tlCenter
            ExplicitLeft = 1
            ExplicitTop = 164
            ExplicitWidth = 614
          end
          object EdPrivKeyFile: TLabeledEdit
            Left = 12
            Top = 44
            Width = 121
            Height = 25
            EditLabel.Width = 87
            EditLabel.Height = 17
            EditLabel.Caption = 'Private Key File'
            TabOrder = 0
          end
          object EdPrivKeyPass: TLabeledEdit
            Left = 474
            Top = 48
            Width = 121
            Height = 25
            EditLabel.Width = 94
            EditLabel.Height = 17
            EditLabel.Caption = 'Private Key Pass'
            TabOrder = 1
          end
          object EdCertFile: TLabeledEdit
            Left = 12
            Top = 97
            Width = 469
            Height = 25
            EditLabel.Width = 79
            EditLabel.Height = 17
            EditLabel.Caption = 'certificate File'
            TabOrder = 2
          end
          object EdHostCertFile: TLabeledEdit
            Left = 12
            Top = 145
            Width = 469
            Height = 25
            EditLabel.Width = 112
            EditLabel.Height = 17
            EditLabel.Caption = 'Host Certificate File'
            TabOrder = 3
          end
        end
        object Panel7: TPanel
          Left = 0
          Top = 105
          Width = 616
          Height = 189
          Align = alClient
          TabOrder = 2
          ExplicitTop = 103
          ExplicitHeight = 229
          object labDBConfig: TLabel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 608
            Height = 23
            Margins.Bottom = 0
            Align = alTop
            AutoSize = False
            Caption = ' .: DATABASE CONFIGURATION'
            Color = clGrayText
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = False
            Layout = tlCenter
            ExplicitTop = 6
          end
          object Label14: TLabel
            Left = 12
            Top = 30
            Width = 35
            Height = 17
            Caption = 'Driver'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object labNomeBD: TLabel
            Left = 447
            Top = 71
            Width = 56
            Height = 17
            Caption = 'Db Name'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object labPorta: TLabel
            Left = 325
            Top = 63
            Width = 24
            Height = 17
            Caption = 'Port'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object labSenha: TLabel
            Left = 447
            Top = 123
            Width = 56
            Height = 17
            Caption = 'Password'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object labUsuario: TLabel
            Left = 325
            Top = 123
            Width = 27
            Height = 17
            Caption = 'User'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object cbAdaptadores: TComboBox
            Left = 7
            Top = 94
            Width = 269
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            Text = 'cbAdapter'
            OnChange = cbAdaptadoresChange
          end
          object cbDriver: TComboBox
            Left = 7
            Top = 53
            Width = 269
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            Text = 'MySQL'
            OnCloseUp = cbDriverCloseUp
            Items.Strings = (
              'MSSQL'
              'MySQL'
              'PostgreSQL')
          end
          object cbOsAuthent: TCheckBox
            Left = 447
            Top = 48
            Width = 91
            Height = 17
            Caption = 'OsAuthent'
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            State = cbChecked
            TabOrder = 2
          end
          object ckUsaURL: TCheckBox
            Left = 9
            Top = 123
            Width = 82
            Height = 17
            Caption = 'Uses URL'
            TabOrder = 3
            OnClick = ckUsaURLClick
          end
          object edBD: TEdit
            Left = 447
            Top = 94
            Width = 148
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 4
          end
          object edPasswordBD: TEdit
            Left = 447
            Top = 146
            Width = 148
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            PasswordChar = '*'
            TabOrder = 5
            Text = 'masterkey'
          end
          object edPortaBD: TEdit
            Left = 325
            Top = 92
            Width = 40
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 6
            Text = '3050'
          end
          object edURL: TEdit
            Left = 9
            Top = 146
            Width = 269
            Height = 25
            TabOrder = 7
            Text = 'informe  a URL'
            Visible = False
          end
          object edUserNameBD: TEdit
            Left = 325
            Top = 146
            Width = 100
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 8
            Text = 'sysdba'
          end
        end
      end
    end
    object tsLogs: TTabSheet
      Caption = 'Logs'
      ImageIndex = 1
      ExplicitHeight = 591
      object Label19: TLabel
        Left = 7
        Top = 262
        Width = 57
        Height = 17
        Caption = 'Response'
        Color = clBtnFace
        ParentColor = False
      end
      object Label18: TLabel
        Left = 7
        Top = 10
        Width = 47
        Height = 17
        Caption = 'Request'
        Color = clBtnFace
        ParentColor = False
      end
      object memoReq: TMemo
        Left = 7
        Top = 30
        Width = 606
        Height = 210
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object memoResp: TMemo
        Left = 7
        Top = 282
        Width = 606
        Height = 210
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 553
    Width = 632
    Height = 37
    Margins.Left = 4
    Margins.Top = 0
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    ExplicitTop = 631
    DesignSize = (
      632
      37)
    object lSeguro: TLabel
      Left = 9
      Top = 12
      Width = 82
      Height = 17
      Anchors = []
      Caption = 'Aman : Tidak'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ButtonStart: TButton
      Left = 409
      Top = 6
      Width = 100
      Height = 25
      Cursor = crHandPoint
      Anchors = []
      Caption = 'Mulai'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = ButtonStartClick
    end
    object ButtonStop: TButton
      Left = 521
      Top = 6
      Width = 100
      Height = 25
      Cursor = crHandPoint
      Anchors = []
      Caption = 'Stop'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = ButtonStopClick
    end
    object cbPoolerState: TCheckBox
      Left = 184
      Top = 12
      Width = 115
      Height = 17
      Anchors = []
      Caption = 'Pooler Active?'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 2
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 238
    Top = 144
  end
  object ctiPrincipal: TTrayIcon
    Hint = 'REST Dataware - Service'
    PopupMenu = pmMenu
    OnDblClick = ctiPrincipalDblClick
    Left = 414
    Top = 264
  end
  object pmMenu: TPopupMenu
    Left = 482
    Top = 160
    object RestaurarAplicao1: TMenuItem
      Caption = 'Restore App'
      OnClick = RestaurarAplicao1Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object SairdaAplicao1: TMenuItem
      Caption = 'Keluar'
      OnClick = SairdaAplicao1Click
    end
  end
  object RESTServicePooler1: TRESTServicePooler
    Active = False
    CORS = False
    CORS_CustomHeaders.Strings = (
      
        'Access-Control-Allow-Methods=GET, POST, PATCH, PUT, DELETE, OPTI' +
        'ONS'
      
        'Access-Control-Allow-Headers=Content-Type, Origin, Accept, Autho' +
        'rization, X-CUSTOM-HEADER')
    PathTraversalRaiseError = True
    RequestTimeout = -1
    ServicePort = 8082
    ProxyOptions.Port = 8888
    AuthenticationOptions.AuthorizationOption = rdwAOToken
    AuthenticationOptions.OptionParams.AuthDialog = True
    AuthenticationOptions.OptionParams.CustomDialogAuthMessage = 'Protected Space...'
    AuthenticationOptions.OptionParams.Custom404TitleMessage = '(404) The address you are looking for does not exist'
    AuthenticationOptions.OptionParams.Custom404BodyMessage = '404'
    AuthenticationOptions.OptionParams.Custom404FooterMessage = 'Take me back to <a href="./">Home REST Dataware'
    AuthenticationOptions.OptionParams.TokenType = rdwJWT
    AuthenticationOptions.OptionParams.CryptType = rdwAES256
    AuthenticationOptions.OptionParams.Key = 'token'
    AuthenticationOptions.OptionParams.GetTokenEvent = 'GetToken'
    AuthenticationOptions.OptionParams.GetTokenRoutes = [crPost]
    AuthenticationOptions.OptionParams.TokenHash = 'testedehash01'
    AuthenticationOptions.OptionParams.ServerSignature = 'RESTDWServer01'
    AuthenticationOptions.OptionParams.LifeCycle = 1800
    SSLMethod = sslvTLSv1_2
    SSLVersions = [sslvTLSv1_2]
    OnLastRequest = RESTServicePooler1LastRequest
    OnLastResponse = RESTServicePooler1LastResponse
    Encoding = esUtf8
    RootPath = '/'
    SSLVerifyMode = [sslvrfPeer, sslvrfClientOnce]
    SSLVerifyDepth = 2
    ForceWelcomeAccess = False
    CriptOptions.Use = True
    CriptOptions.Key = 'RDWBASEKEY256'
    MultiCORE = True
    Left = 306
    Top = 70
  end
  object tupdatelogs: TTimer
    Enabled = False
    OnTimer = tupdatelogsTimer
    Left = 266
    Top = 152
  end
end

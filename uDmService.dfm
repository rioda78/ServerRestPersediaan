object ServerBest: TServerBest
  OldCreateOrder = False
  OnCreate = ServerMethodDataModuleCreate
  Encoding = esUtf8
  Height = 325
  Width = 553
  object frxReport1: TfrxReport
    Version = '6.7.5'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43046.012833298610000000
    ReportOptions.LastChange = 43046.012833298610000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 184
    Top = 24
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Frame.Typ = []
        Height = 26.456710000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Align = baClient
          AllowVectorExport = True
          Width = 718.110700000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Relat'#243'rio Demo')
          ParentFont = False
        end
      end
      object Shape1: TfrxShapeView
        AllowVectorExport = True
        Left = 117.610080000000000000
        Top = 105.826840000000000000
        Width = 445.984540000000000000
        Height = 170.078850000000000000
        Fill.BackColor = cl3DDkShadow
        Frame.Typ = []
      end
      object Memo2: TfrxMemoView
        AllowVectorExport = True
        Left = 185.196970000000000000
        Top = 124.724490000000000000
        Width = 306.141930000000000000
        Height = 60.472480000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = []
        HAlign = haCenter
        Memo.UTF8W = (
          'RestDataWare demo transporte Relat'#243'rio')
        ParentFont = False
      end
      object SysMemo1: TfrxSysMemoView
        AllowVectorExport = True
        Left = 285.799165000000000000
        Top = 219.212740000000000000
        Width = 147.401670000000000000
        Height = 18.897650000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = []
        HAlign = haCenter
        Memo.UTF8W = (
          '[DATE]')
        ParentFont = False
      end
    end
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    Left = 184
    Top = 88
  end
  object DWServerEvents1: TDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovBlob
            ParamName = 'Relatorio'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'DownloadFile'
      end>
    ContextName = 'SE1'
    Left = 176
    Top = 137
  end
  object RESTDWPoolerDB2: TRESTDWPoolerDB
    RESTDriver = RESTDWDriverUNIDAC1
    Compression = True
    Encoding = esUtf8
    StrsTrim = False
    StrsEmpty2Null = False
    StrsTrim2Len = True
    Active = True
    PoolerOffMessage = 'RESTPooler not active.'
    ParamCreate = True
    Left = 272
    Top = 96
  end
  object KoneksiDb: TUniConnection
    ProviderName = 'SQL Server'
    LoginPrompt = False
    BeforeConnect = KoneksiDbBeforeConnect
    Left = 400
    Top = 64
  end
  object RESTDWDriverUNIDAC1: TRESTDWDriverUNIDAC
    CommitRecords = 100
    Connection = KoneksiDb
    Left = 392
    Top = 168
  end
  object InterBaseUniProvider1: TInterBaseUniProvider
    Left = 368
    Top = 224
  end
  object PostgreSQLUniProvider1: TPostgreSQLUniProvider
    Left = 264
    Top = 232
  end
  object MySQLUniProvider1: TMySQLUniProvider
    Left = 248
    Top = 192
  end
  object UniQuery1: TUniQuery
    Connection = KoneksiDb
    Left = 456
    Top = 224
  end
  object SQLServerUniProvider1: TSQLServerUniProvider
    Left = 448
    Top = 144
  end
end

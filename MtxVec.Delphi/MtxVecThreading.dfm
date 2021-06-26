object MtxVecThreadingForm: TMtxVecThreadingForm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Kinematical X-ray Diffraction'
  ClientHeight = 379
  ClientWidth = 652
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object TPanel
    Left = 0
    Top = 145
    Width = 652
    Height = 234
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 228
    DesignSize = (
      652
      234)
    object Label5: TLabel
      Left = 13
      Top = 206
      Width = 406
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 
        'All multithreading timing tests show meaningfull results only wh' +
        'en run outside of IDE!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object Memo: TMemo
      Left = 173
      Top = 9
      Width = 443
      Height = 184
      Anchors = [akLeft, akTop, akRight, akBottom]
      ReadOnly = True
      TabOrder = 0
      ExplicitHeight = 178
    end
    object btnBenchmark: TButton
      Left = 13
      Top = 8
      Width = 150
      Height = 28
      Caption = 'Benchmark'
      TabOrder = 1
      OnClick = btnBenchmarkClick
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 652
    Height = 145
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      'RichEdit1')
    ParentFont = False
    TabOrder = 1
  end
end

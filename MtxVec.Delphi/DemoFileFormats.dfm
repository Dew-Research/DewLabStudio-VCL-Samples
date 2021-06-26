inherited frmFileFormats: TfrmFileFormats
  Caption = 'frmFileFormats'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel3: TPanel
    object ButtonExport: TButton
      Left = 16
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Export =>'
      TabOrder = 0
      OnClick = ButtonExportClick
    end
    object RichEdit2: TRichEdit
      Left = 160
      Top = 6
      Width = 401
      Height = 163
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      WordWrap = False
    end
  end
end

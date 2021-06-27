inherited InvMtx: TInvMtx
  Caption = 'InvMtx'
  ClientHeight = 502
  ClientWidth = 615
  OldCreateOrder = True
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 615
    ExplicitWidth = 615
    inherited RichEdit1: TRichEdit
      Width = 613
      ExplicitWidth = 613
    end
  end
  inherited Panel2: TPanel
    Top = 463
    Width = 615
    Height = 39
    ExplicitTop = 463
    ExplicitWidth = 615
    ExplicitHeight = 39
    object Button1: TBitBtn
      Left = 16
      Top = 10
      Width = 129
      Height = 24
      Caption = 'Generate random matrix'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TBitBtn
      Left = 160
      Top = 10
      Width = 97
      Height = 24
      Caption = 'Inverse of matrix'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 264
      Top = 10
      Width = 81
      Height = 24
      Caption = 'A*A-1 = ?'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  inherited Panel3: TPanel
    Width = 615
    Height = 333
    Constraints.MinHeight = 290
    Constraints.MinWidth = 615
    ExplicitWidth = 615
    ExplicitHeight = 333
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 139
      Height = 13
      Caption = 'Matrix dimension (Rows/Cols)'
    end
    object Label2: TLabel
      Left = 135
      Top = 56
      Width = 32
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Label2'
    end
    object Label3: TLabel
      Left = 184
      Top = 8
      Width = 16
      Height = 13
      Caption = 'A : '
    end
    object Label4: TLabel
      Left = 184
      Top = 168
      Width = 25
      Height = 13
      Caption = 'A-1 : '
    end
    object TrackBar1: TTrackBar
      Left = 16
      Top = 56
      Width = 113
      Height = 17
      Max = 100
      Min = 2
      Frequency = 4
      Position = 4
      TabOrder = 0
      TickMarks = tmTopLeft
      OnChange = TrackBar1Change
    end
    object StringGrid1: TStringGrid
      Left = 185
      Top = 20
      Width = 288
      Height = 140
      ColCount = 2
      DefaultRowHeight = 18
      FixedCols = 0
      RowCount = 2
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
      TabOrder = 1
    end
    object StringGrid2: TStringGrid
      Left = 185
      Top = 180
      Width = 288
      Height = 140
      ColCount = 2
      DefaultRowHeight = 18
      FixedCols = 0
      RowCount = 2
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goAlwaysShowEditor]
      TabOrder = 2
    end
  end
end

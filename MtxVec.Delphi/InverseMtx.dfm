inherited InvMtx: TInvMtx
  Caption = 'InvMtx'
  ClientHeight = 600
  ClientWidth = 730
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 746
  ExplicitHeight = 639
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 730
    ExplicitWidth = 615
    inherited RichEdit1: TRichEdit
      Width = 728
      Font.Color = 7105644
      ExplicitWidth = 613
    end
  end
  inherited Panel2: TPanel
    Top = 554
    Width = 730
    Height = 46
    ExplicitTop = 456
    ExplicitWidth = 615
    ExplicitHeight = 46
    object Button1: TBitBtn
      Left = 16
      Top = 10
      Width = 130
      Height = 24
      Caption = 'Generate random matrix'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TBitBtn
      Left = 160
      Top = 10
      Width = 130
      Height = 24
      Caption = 'Inverse of matrix'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 303
      Top = 10
      Width = 130
      Height = 24
      Caption = 'A*A-1 = ?'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  inherited Panel3: TPanel
    Width = 730
    Height = 424
    Constraints.MinHeight = 290
    Constraints.MinWidth = 615
    ExplicitWidth = 615
    ExplicitHeight = 333
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 216
      Height = 422
      Align = alLeft
      Color = 14869218
      TabOrder = 0
      ExplicitHeight = 331
      object Label1: TLabel
        Left = 14
        Top = 32
        Width = 183
        Height = 13
        Caption = 'Matrix dimension (Rows/Cols)'
      end
      object Label2: TLabel
        Left = 165
        Top = 56
        Width = 32
        Height = 17
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Label2'
      end
      object TrackBar1: TTrackBar
        Left = 15
        Top = 56
        Width = 138
        Height = 17
        Ctl3D = True
        Max = 100
        Min = 2
        ParentCtl3D = False
        Frequency = 4
        Position = 4
        TabOrder = 0
        TickMarks = tmTopLeft
        OnChange = TrackBar1Change
      end
    end
    object Panel5: TPanel
      Left = 217
      Top = 1
      Width = 512
      Height = 422
      Align = alClient
      Color = 14869218
      TabOrder = 1
      OnResize = Panel5Resize
      ExplicitLeft = 170
      ExplicitWidth = 444
      ExplicitHeight = 331
      object StringGrid1: TStringGrid
        Left = 12
        Top = 9
        Width = 385
        Height = 166
        ColCount = 2
        DefaultRowHeight = 18
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
        TabOrder = 0
      end
      object StringGrid2: TStringGrid
        Left = 12
        Top = 188
        Width = 385
        Height = 164
        ColCount = 2
        DefaultRowHeight = 18
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goAlwaysShowEditor]
        TabOrder = 1
      end
    end
  end
end

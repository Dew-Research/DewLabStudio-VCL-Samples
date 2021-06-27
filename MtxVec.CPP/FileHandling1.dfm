inherited FileH1: TFileH1
  Caption = 'FileH1'
  ClientHeight = 439
  ClientWidth = 615
  OldCreateOrder = True
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
    Top = 381
    Width = 615
    ExplicitTop = 381
    ExplicitWidth = 615
  end
  inherited Panel3: TPanel
    Width = 615
    Height = 251
    Constraints.MinHeight = 210
    Constraints.MinWidth = 615
    ExplicitWidth = 615
    ExplicitHeight = 251
    object Label1: TLabel
      Left = 168
      Top = 16
      Width = 60
      Height = 13
      Caption = 'Code used : '
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 16
      Width = 161
      Height = 17
      Caption = 'View loaded values'
      TabOrder = 0
    end
    object RichEdit2: TRichEdit
      Left = 168
      Top = 33
      Width = 329
      Height = 200
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 5
      Zoom = 100
    end
    object Button1: TBitBtn
      Left = 16
      Top = 48
      Width = 129
      Height = 17
      Caption = 'Streams : Read/Write'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TBitBtn
      Left = 16
      Top = 72
      Width = 129
      Height = 17
      Caption = 'Binary files : Read/Write'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TBitBtn
      Left = 16
      Top = 96
      Width = 129
      Height = 17
      Caption = 'BLOB files : Read/Write'
      TabOrder = 3
      OnClick = Button3Click
    end
    object Button4: TBitBtn
      Left = 16
      Top = 120
      Width = 129
      Height = 17
      Caption = 'Text files : Read/Write'
      TabOrder = 4
      OnClick = Button4Click
    end
  end
end

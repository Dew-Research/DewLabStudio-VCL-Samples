inherited FileH1: TFileH1
  Left = 276
  Top = 196
  Caption = 'FileH1'
  ClientHeight = 443
  ClientWidth = 607
  OldCreateOrder = True
  OnCreate = FormCreate
  ExplicitWidth = 623
  ExplicitHeight = 482
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 607
    ExplicitWidth = 607
    inherited RichEdit1: TRichEdit
      Width = 605
      Font.Color = 7105644
      ExplicitWidth = 605
    end
  end
  inherited Panel2: TPanel
    Top = 385
    Width = 607
    ExplicitTop = 385
    ExplicitWidth = 607
  end
  inherited Panel3: TPanel
    Width = 607
    Height = 255
    Constraints.MinHeight = 210
    Constraints.MinWidth = 607
    ExplicitWidth = 607
    ExplicitHeight = 255
    object Label1: TLabel
      Left = 174
      Top = 14
      Width = 61
      Height = 13
      Caption = 'Code used : '
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 13
      Width = 140
      Height = 17
      Caption = 'View loaded values'
      TabOrder = 0
    end
    object RichEdit2: TRichEdit
      Left = 174
      Top = 33
      Width = 418
      Height = 211
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 5
    end
    object Button1: TBitBtn
      Left = 16
      Top = 48
      Width = 140
      Height = 20
      Caption = 'Streams : Read/Write'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TBitBtn
      Left = 16
      Top = 72
      Width = 140
      Height = 20
      Caption = 'Binary files : Read/Write'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TBitBtn
      Left = 16
      Top = 96
      Width = 140
      Height = 20
      Caption = 'BLOB files : Read/Write'
      TabOrder = 3
      OnClick = Button3Click
    end
    object Button4: TBitBtn
      Left = 16
      Top = 120
      Width = 140
      Height = 20
      Caption = 'Text files : Read/Write'
      TabOrder = 4
      OnClick = Button4Click
    end
  end
end

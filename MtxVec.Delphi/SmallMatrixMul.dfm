inherited frmSmallMatrix: TfrmSmallMatrix
  Top = 181
  Caption = 'frmSmallMatrix'
  ClientHeight = 791
  ClientWidth = 1208
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 1224
  ExplicitHeight = 830
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 1208
    Height = 250
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 1208
    ExplicitHeight = 250
    inherited RichEdit1: TRichEdit
      Width = 1206
      Height = 248
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 1206
      ExplicitHeight = 248
    end
  end
  inherited Panel2: TPanel
    Top = 751
    Width = 1208
    Height = 40
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 751
    ExplicitWidth = 1208
    ExplicitHeight = 40
    object jitLabel: TLabel [0]
      Left = 417
      Top = 15
      Width = 51
      Height = 13
      Caption = 'Coverage:'
    end
    inherited CheckDownSample: TCheckBox
      Visible = False
    end
    object Button1: TButton
      Left = 116
      Top = 8
      Width = 110
      Height = 26
      Caption = 'Run test'
      TabOrder = 1
      OnClick = Button1Click
    end
    object ComplexBox: TCheckBox
      Left = 249
      Top = 12
      Width = 124
      Height = 17
      Hint = 'Does complex number math, if checked'
      Caption = 'Complex'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
  end
  inherited Chart1: TChart
    Top = 250
    Width = 1208
    Height = 501
    Title.Text.Strings = (
      'Small Matrix Multiply')
    BottomAxis.Axis.SmallSpace = 1
    BottomAxis.MaximumOffset = 4
    BottomAxis.MinimumOffset = 4
    BottomAxis.Title.Caption = 'Matrix size'
    DepthAxis.Maximum = 0.500000000000000000
    DepthAxis.Minimum = -0.500000000000000000
    DepthTopAxis.Maximum = 0.500000000000000000
    DepthTopAxis.Minimum = -0.500000000000000000
    LeftAxis.AxisValuesFormat = '#,##0.0##'
    LeftAxis.MaximumOffset = 4
    LeftAxis.MinimumOffset = 4
    LeftAxis.Title.Caption = 'Time [ms]'
    ExplicitTop = 250
    ExplicitWidth = 1208
    ExplicitHeight = 501
  end
end

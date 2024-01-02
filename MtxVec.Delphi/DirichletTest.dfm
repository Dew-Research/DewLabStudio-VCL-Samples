inherited frmDirichlet: TfrmDirichlet
  Left = 256
  Top = 158
  Caption = 'frmDirichlet'
  ClientHeight = 478
  OldCreateOrder = True
  OnCreate = FormCreate
  ExplicitHeight = 517
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Height = 66
    ExplicitHeight = 66
    inherited RichEdit1: TRichEdit
      Height = 64
      Font.Color = 7105644
      ExplicitHeight = 64
    end
  end
  inherited Panel2: TPanel
    Top = 420
    ExplicitTop = 420
  end
  inherited Panel3: TPanel
    Top = 66
    Height = 354
    ExplicitTop = 66
    ExplicitHeight = 354
    object Chart1: TChart
      Left = 1
      Top = 1
      Width = 403
      Height = 352
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Legend.Visible = False
      Title.Text.Strings = (
        'TChart')
      Title.Visible = False
      View3D = False
      Zoom.Pen.Mode = pmNotXor
      OnAfterDraw = Chart1AfterDraw
      Align = alClient
      BevelOuter = bvNone
      Color = 14869218
      TabOrder = 0
      ColorPaletteIndex = 0
    end
    object Panel4: TPanel
      Left = 404
      Top = 1
      Width = 169
      Height = 352
      Align = alRight
      BevelOuter = bvNone
      Color = 14869218
      TabOrder = 1
      object Label1: TLabel
        Left = 16
        Top = 205
        Width = 41
        Height = 13
        Caption = 'X range:'
      end
      object Label2: TLabel
        Left = 16
        Top = 253
        Width = 41
        Height = 13
        Caption = 'Y range:'
      end
      object RadioGroup1: TRadioGroup
        Left = 13
        Top = 7
        Width = 135
        Height = 102
        Caption = 'Function'
        ItemIndex = 0
        Items.Strings = (
          'Riemann Zeta'
          'Dirichlet Eta'
          'Dirichlet Lambda'
          'Dirichlet Beta')
        TabOrder = 0
        OnClick = RadioGroup1Click
      end
      object RadioGroup2: TRadioGroup
        Left = 13
        Top = 115
        Width = 135
        Height = 75
        Caption = 'Draw'
        ItemIndex = 0
        Items.Strings = (
          'Re'
          'Im'
          'Abs')
        TabOrder = 1
        OnClick = RadioGroup2Click
      end
      object Edit1: TEdit
        Left = 16
        Top = 221
        Width = 60
        Height = 21
        TabOrder = 2
        Text = '-5'
      end
      object Edit2: TEdit
        Left = 84
        Top = 221
        Width = 60
        Height = 21
        TabOrder = 3
        Text = '2'
      end
      object Edit3: TEdit
        Left = 16
        Top = 269
        Width = 60
        Height = 21
        TabOrder = 4
        Text = '-4'
      end
      object Edit4: TEdit
        Left = 84
        Top = 269
        Width = 60
        Height = 21
        TabOrder = 5
        Text = '2'
      end
      object Button1: TButton
        Left = 15
        Top = 307
        Width = 106
        Height = 25
        Caption = 'Recreate'
        TabOrder = 6
        OnClick = Button1Click
      end
    end
  end
end

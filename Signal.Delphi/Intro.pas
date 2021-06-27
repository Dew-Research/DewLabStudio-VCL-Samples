unit Intro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TIntroduction = class(TForm)
    RichEdit1: TRichEdit;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Introduction: TIntroduction;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TIntroduction.FormCreate(Sender: TObject);
begin
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
//    SelAttributes.Color := RGB(226,226,226); //#E00000
    
    SelAttributes.Size := 12;
    Add('Welcome to DSP Master');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Written entirely with MtxVec and taking advantage  '
      + 'of full vector/matrix design.');
    Add('Supports signal processing algorithms in streaming '
      + 'or single block mode.');
    Add('Features a large set of ready to use components '
      + 'covering digital filter design and frequency analysis.');
    Add('Visually connect signal processing components to form ' +
        'signal processing pipes capable of streaming. ' );
    Add('Supports multichannel, aribtrary sampling frequency, '+
        'complex or real, double or single precision, signal processing.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Style := [fsItalic];
    Add('"MtxVec was created to help shorten the '
      + 'development time of commercial scientific '
      + 'applications."');
    Add('');
    Add('Navigate through the demo application, to learn '
      + 'more about DSP Master.');
  end;
end;

initialization
  RegisterClass(TIntroduction);
end.

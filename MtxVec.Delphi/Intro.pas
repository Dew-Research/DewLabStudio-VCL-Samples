unit Intro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, jpeg,  ExtCtrls;

type
  TIntroduction = class(TForm)
    RichEdit1: TRichEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Introduction: TIntroduction;

implementation

uses Math387;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TIntroduction.FormCreate(Sender: TObject);
begin
  Label1.Caption := 'Welcome to MtxVec v' + FormatSample('0.00',MtxVecVersion/100);
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('Welcome to MtxVec, an object oriented threaded and vectorized numerical library '
      + 'for Delphi and .NET platform');
    Add('');
    Add('MtxVec adds the following capabilities to your development environment:');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Comprehensive set of mathematical and statistical functions');
    Add('Substantial performance improvements of floating point math by exploiting the SSE3, SSE4.x, AVX, AVX2 and AVX512 instruction sets.');
    Add('Support for 64bit applications.');
    Add('Certified support for 4GB address range on 64bit OS for 32bit applications.');
    Add('Open CL support allows high performance cross platform portable code and gives you access to the power of GPUs.');
    Add('Improved compactness and readability of code.');
    Add('Significantly shorter development times by protecting the developer from a wide range of possible errors.');
    Add('Same API interface in Delphi for W32 and in .NET');
    Add('Support for 64bit in .NET');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    Add('Typical performance improvements observed by most users are 4-6 times for ' +
        'vector functions, but speed ups up to 20 times are not rare. The matrix ' +
        'multiplication for example is faster up to 50 times.');
    Add('');
    Add('Navigate through the demo application, to learn '
      + 'more about MtxVec and experience it''s unmatched '
      + 'performance and ease of use.');
  end;
end;

initialization
  RegisterClass(TIntroduction);
end.

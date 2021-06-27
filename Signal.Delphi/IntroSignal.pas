unit IntroSignal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroSignalForm = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IntroSignalForm: TIntroSignalForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TIntroSignalForm.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    DefAttributes.Size := 10;
    DefAttributes.Style := [fsBold];
    SelAttributes.Size := 12;

    SelAttributes.Color := RGB(51,51,153);
    Add('A wide range of signal filtering routines includes:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Elliptic,Butterworth, Bessel and Chebyshev filter designers');
    Add('Parks-McClellan optimal FIR filter design routine');
    Add('Savitzky-Golay polynomial FIR filter');
    Add('Windowed FIR filter design with Kaiser window.');
    Add('Simple DC filters, Median filters, Moving average, Exponential decay and delay filters.');
    Add('Fractional delay filters.');
    Add('Signal generators.');
    Paragraph.Numbering := nsNone;    
    Paragraph.FirstIndent := 0;
  end;
end;

initialization
  RegisterClass(TIntroSignalForm);

end.

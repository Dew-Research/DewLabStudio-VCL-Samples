unit IntroPerformance;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroPerformanceForm = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IntroPerformanceForm: TIntroPerformanceForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TIntroPerformanceForm.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    DefAttributes.Size := 10;
    DefAttributes.Style := [fsBold];

    SelAttributes.Size := 12;
    SelAttributes.Color := RGB(51,51,153);
    Add('Optimal signal processing performance is ensured with:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('CPU specific support and code optimization. Exceptional performance for multi-core systems.');
    Add('Data is processed in "blocks". This allows highly efficient optimization of tight loops.');
    Add('Ultra fast decimation and interpolation algorithm with multi-rate, multi-stage, half-band filters.');
    Add('All critical routines are vectorized and can take advantage of SSE2, SSE3, SSE4 and Intel AVX instruction sets.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
  end;
end;

initialization
   RegisterClass(TIntroPerformanceForm);

end.

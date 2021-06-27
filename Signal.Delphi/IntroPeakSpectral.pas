unit IntroPeakSpectral;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroPeakSpectralForm = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IntroPeakSpectralForm: TIntroPeakSpectralForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TIntroPeakSpectralForm.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    DefAttributes.Size := 10;
    DefAttributes.Style := [fsBold];
    SelAttributes.Size := 12;

    SelAttributes.Color := RGB(51,51,153);
    Add('Frequency spectrum peak analysis:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('6 methods for frequency and amplitude interpolation: '+
        'Numeric, Quadratic, Barycentric, Quinn''s First, Quinn''s second, Jain''s');
    Add('Auto find peaks in the frequency spectrum: largest, harmonics or retrace existing');
    Add('Add and delete peak marks on the fly with a dedicated TeeTool');
    Add('Peak order tracking');
    Add('Limit search for peaks within a frequency band');
    Add('Link RMS calculation of frequency bands to peak position');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
  end;
end;

initialization
   RegisterClass(TIntroPeakSpectralForm);


end.

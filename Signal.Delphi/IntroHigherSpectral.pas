unit IntroHigherSpectral;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroHigherSpectralForm = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IntroHigherSpectralForm: TIntroHigherSpectralForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TIntroHigherSpectralForm.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    DefAttributes.Size := 10;
    DefAttributes.Style := [fsBold];
    SelAttributes.Size := 12;

    SelAttributes.Color := RGB(51,51,153);
    Add('Make use of higher order spectral analysis:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Compute bispectrum and/or bicoherence of real and complex signals');
    Add('Compute bicoherence for only preselected frequency pairs');
    Add('View bicoherence in real time with running average');
    Add('Select from 10 time window functions');
    Add('Supports spectrum sizes with more then 16384 lines for preselected '+
        'frequency pairs');
    Add('Full set of peak marking/tracking features');
    Add('Frequency band statistics');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
  end;
end;

initialization
   RegisterClass(TIntroHigherSpectralForm);


end.

unit IntroSignalGeneration;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroSignalGenerationForm = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IntroSignalGenerationForm: TIntroSignalGenerationForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TIntroSignalGenerationForm.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    DefAttributes.Size := 10;
    DefAttributes.Style := [fsBold];
    SelAttributes.Size := 12;

    SelAttributes.Color := RGB(51,51,153);
    Add('Powerful signal generation algorithms:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Generate, white, pink, brownian, blue and violate noise by filtering white noise with appropriate FIR filters.');
    Add('Generate triangular, square and multi-tone signals.');
    Add('Vary frequency and/or amplitude between specified ranges (chirp signal).');
    Add('Use HP style calculator to define equations for noise generation from multiple sources.');
    Add('TSignalGenerator component uses vectorized signal generation for lowest CPU usage.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
  end;
end;

initialization
  RegisterClass(TIntroSignalGenerationForm);

end.

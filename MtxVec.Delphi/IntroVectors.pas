unit IntroVectors;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroVec = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IntroVec: TIntroVec;

implementation

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TIntroVec.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('Vector operations:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Real and complex FFT');
    Add('Auto and cross correlations');
    Add('Convolution and filtering');
    Add('Complete vector arithmetic');
    Add('Sorting real and complex numbers');
    Add('Random generators');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
  end;
end;

initialization
  RegisterClass(TIntroVec);

end.

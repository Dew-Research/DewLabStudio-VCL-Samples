unit IntroPolynoms;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroPoly = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
                                                               
var
  IntroPoly: TIntroPoly;

implementation

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TIntroPoly.FormCreate(Sender: TObject);
begin
  inherited;
  with RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('Robust polynomials handling methods:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Polynomial evaluation, root finding');
    Add('Piece-wise polynomials');
    Add('Fast cubic spline algorithm');
    Add('Linear or cubic interpolation');
    Add('Fit high order polynomials to data');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
  end;
end;

initialization
   RegisterClass(TIntroPoly);

end.

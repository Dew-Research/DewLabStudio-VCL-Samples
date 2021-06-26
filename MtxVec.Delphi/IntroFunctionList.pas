unit IntroFunctionList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroFunList = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IntroFunList: TIntroFunList;

implementation

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TIntroFunList.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('Basic MtxVec package gives you:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Over 1200 well documented routines');
    Add('Full support (where appropriate) for complex numbers');
    Add('TMtx and TVec objects provide you with full matrix, vector and matrix-vector arithmetics');
    Add('16 different probability functions (PDF,CDF and inverse CDF)');
    Add('4 minimization algorithms (BGFS, Marquard, Simplex and Brent)');
    Add('9 special functions (Bessel functions, elliptic integrals, …)');
    Add('Math387 unit - it fully replaces and extends Delphi Math unit ');
    Add('Polynomial handling routines (splines, piece-wise polynomials, polynomial root finding,..)');
    Add('Symmetric multiprocessing support for up to 8 CPUs');
    Add('Processor specific optimization');
    Add('Multi-threading safe');
    Add('Built-in dynamic memory allocation');
    Add('Fee free tech support with 24h response');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
  end;
end;

initialization
   RegisterClass(TIntroFunList);

end.

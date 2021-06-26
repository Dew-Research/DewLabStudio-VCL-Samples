unit IntroMatrices;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroMtx = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;                                                        

var
  IntroMtx: TIntroMtx;

implementation

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TIntroMtx.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('Matrix operations:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Least squares solution to a system of linear equations');
    Add('Refining solution of linear systems and error estimate');
    Add('Singular value decomposition and solution of a system of equations');
    Add('Eigenvalues and eigenvectors');
    Add('Toeplitz systems of linear equations');
    Add('Complete support for complex numbers');
    Add('2D FFT');
    Add('Complete matrix arithmetics');
    Add('Support for sparse matrices');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
  end;
end;

initialization
   RegisterClass(TIntroMtx);
end.

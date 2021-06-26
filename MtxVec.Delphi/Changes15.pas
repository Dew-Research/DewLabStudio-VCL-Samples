unit Changes15;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Basic3, StdCtrls, ComCtrls;

type
  TfrmChanges15 = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChanges15: TfrmChanges15;

implementation

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TfrmChanges15.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('List of new features in v2.1.5:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;

    Add('Support for BDS2006 Update#2.');
    Add('Simplex  optimization algorithm features support for constrained optimization.');
    Add('TMtxGridSeries now supports three color and rainbow color palette with ' +
         'a very rich set of options including color balance and  custom  ' +
         'bitmap  resampling  methods.');
    Add('Updates for Intel MKL 8.1 and Intel IPP 5.1 and Intel Compilers v9.1.');
    Add('FFT''''s can now be multithread.');
    Add('TVec.Difference got a lag parameter.');
    Add('API improvements for the vectorized parser.');
    Add('');

    Paragraph.FirstIndent := 0;    
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('List of new features in v2.1:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;

    Add('Operator overloading for Delphi 2006 with ' +
        'support for Vectors, Matrices and complex numbers!');
    Add('Enhanced support for .NET platform.');
    Add('Uses Intel MKL 8.0');
    Add('New Vectorized expression parser gives you the ' +
        'fastest expression evaluation.');
    Add('Fixed a bug for object cache resize.');
    Add('Fixed a bug in TPiecePoly when assigning Breaks before Coefficients.');
    Add('TMtxComponent has been upgraded with VCL independent ' +
        'FreeNotification system.');
    Add('ViewValues editor now comes with MS Office style menus.');
    Add('ViewValues editor now correctly copies columns to clipboard.');
    Add('');

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('List of new features in v2.0:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;

    Add('Support for .NET platform. Single source code compiles ' +
        'on .NET and W32.');
    Add('Sparse matrices: Umfpack v4.3 and Pardiso solver.');
    Add('All C/C++ (umfpack) code compiled with Intel C/C++ compiler ' +
        'with support for SSE2/SSE3.');
    Add('All Fortran code compiled with Intel Fortran compiler ' +
        'with support for SSE2/SSE3.');
    Add('Sparse solvers for complex sparse matrices.');
    Add('New random generators via MKL 7.0');
    Add('New FFT engine with support for arbitrary length FFTs ' +
        '(including arbitrary 2D FFT sizes) and symmetric multiprocessing.');
    Add('Extensive tests written to interface DUnit test framework. '+
        'Tests execute under .NET and W32 and ensure that code gives ' +
        'the same result.');
    Add('New memory allocation bypassing Delphi memory manager and allowing '+
        'to better exploit available system memory');
    Add('Intel SPL calls replaced with Intel IPP 4.0.');
    Add('New dll interfaces allow support of C++Builder and Kylix.');
    Add('Common abstract class between for TVec, TMtx '+
        'and TSparseMtx shares common functions. '+
        'New syntax options allowing much more flexibility '+
        'when exchanging data between TVec, TMtx '+
        'and TSparseMtx. Only the "view" of memory is changed. ' +
        'It is possible to write single source code which can take vector '+
        ',matrix and sparse matrix objects as parameters.' );
    Add('Vastly improved error checking, mostly due to ' +
        'in-depth tests. ');
    Add('Prescot CPU support exploiting the features of the '+
        'new (SSE3) instruction set. ');
    Add('Extensive performance optimizations across '+
        'the entire library.');
    Add('Operator overloading under .NET for complex '+
        'numbers. ');
    Add('It should be possible to write single source code ' +
        'that would execute on W32 and .NET with the same '+
        'or very similar performance even for short vectors ' +
        'and small matrices.');

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;

  end;
end;

initialization
  RegisterClass(tfrmChanges15);

end.

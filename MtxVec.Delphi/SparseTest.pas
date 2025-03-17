unit SparseTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Basic2, StdCtrls, ComCtrls, ExtCtrls, Sparse, MtxVec, TeEngine,
  Series, TeeProcs, Chart, MtxExpr;
                                 
  {$I bdsppdefs.inc}

type
  TfrmSparseTest = class(TBasicForm2)
    Chart1: TChart;
    Series1: TBarSeries;
    Panel4: TPanel;
    Button1: TButton;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Memo1: TMemo;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    SparseA: TSparseMtx;
    A: Matrix;
    B: Vector;
    tmpTime : double;
    x1,x2,x3,x4: Vector; { compare solutions }
    DecSep,ThSep: Char;
  public
    { Public declarations }
  end;

var
  frmSparseTest: TfrmSparseTest;

implementation

Uses MtxVecEdit, lapack_umfpack, Math387, StringVar, AbstractMtxVec;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TfrmSparseTest.FormCreate(Sender: TObject);
begin
  inherited;
  DecSep := GetDecimalSeparator;
  {$IFDEF D15}
  ThSep := FormatSettings.ThousandSeparator;
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.ThousandSeparator := ',';
  {$ELSE}
  ThSep := SysUtils.ThousandSeparator{$IFDEF CLR}[1]{$ENDIF};
  SysUtils.DecimalSeparator{$IFDEF CLR}[1]{$ENDIF} := '.';
  SysUtils.ThousandSeparator{$IFDEF CLR}[1]{$ENDIF} := ',';
  {$ENDIF}

  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('The system of 256 linear equations (sparse) sytstem is solved with four methods:');
    Add('');
    Add('1) TMtx.LUSolve method is used to solve the system of equations');
    Add('2) TSparseMtx.Solve direct method (umfpack) is used to solve the system of equations');
    Add('3) TSparseMtx.Solve direct method (pardiso) is used to solve the system of equations');
    Add('4) TSparseMtx iterative method is used to solve the system of equations');
    Add('');
    Add('The test''s should be ran at least twice because the pardiso solver '+
        'has a long initialization period! Umfpack can optionally report also ' +
        'statistics about the solver!');
  end;

  A.Size(0,0);
  x1.Size(0);
  x2.Size(0);
  x3.Size(0);
  x4.Size(0);


  SparseA := TSparseMtx.Create;
  SparseA.ReportLevel := prlNone; { no report - fastest }
  SparseA.AutoClearReport := True; { force clear }
  SparseA.LoadFromMatrixMarketFile('pde225.mtx');


//  SparseA.SparseToDense(A);
//  ShowMessage(MtxTypeToString(A.DetectMtxType(true)));

//  SparseA.Pardiso.CpuCount := 4;
//  SparseA.Pardiso.OutOfCoreMode := pooAutomatic;
  { random data for Ax=b i.e. b constants }
  B.Size(SparseA.Rows, False);
  B.RandGauss;
end;

procedure TfrmSparseTest.FormDestroy(Sender: TObject);
begin
  {$IFDEF D15}
  FormatSettings.DecimalSeparator := DecSep;
  FormatSettings.ThousandSeparator := ThSep;
  {$ELSE}
  SysUtils.DecimalSeparator := DecSep;
  SysUtils.ThousandSeparator := ThSep;
  {$ENDIF}
  SparseA.Free;
  inherited;
end;

procedure TfrmSparseTest.Button1Click(Sender: TObject);
var i : Integer;
  tmpStr: String;
  StrList: StringList;
begin
  Screen.Cursor := crHourGlass;
  try
    Series1.Clear;
    { Ordinary Mtx.LuSolve }
    SparseA.SparseToDense(A);
    StartTimer;
    for i := 1 to 100 do A.LUSolve(B,x1);
    Series1.Add(StopTimer*1000,'LUSolve',clRed);

    { "UMFPack" sparse solve }
    SparseA.ReportLevel := TReportLevel(ComboBox1.ItemIndex);
    SparseA.SparseSolver := ssUmfPack;
    MtxVec.Report.Clear;
    StartTimer;
    for i := 1 to 100 do SparseA.Solve(B,x2);
    Series1.Add(StopTimer*1000,'UMFPack'+chr(13)+'Solve',clBlue);

    { load report from MtxVec.Report class }
    Memo1.Lines.Clear();
    MtxVec.Report.Position := 0;
    Memo1.Lines.LoadFromStream(MtxVec.Report);

    { "Pardiso" sparse solve }

    SparseA.SparseSolver := ssPardiso;
    StartTimer;
    for i := 1 to 100 do
    begin
        SparseA.Solve(B,x3);
    end;
    tmpTime := GetTickCount - tmpTime;
    Series1.Add(StopTimer*1000,'Pardiso'+chr(13)+'Solve',clGreen);

    if SparseA.ReportLevel <> prlNone then
    begin
         Memo1.Lines.Add('');
         Memo1.Lines.Add('Pardiso:');
         StrList.Clear;
         MtxVec.Report.Position := 0;
         StrList.LoadFromStream(MtxVec.Report);
         Memo1.Lines.AddStrings(StrList.Data);
    end;

    { Iterative sparse solve }
    x4.Size(B);
    SparseA.SparseSolver := ssIterative;
    SparseA.IterativeMethod := itmLUGMRES;
    StartTimer;
    for i := 1 to 100 do
    begin
         x4.Ramp; {Approximate solution}
         SparseA.Solve(B,x4);
    end;
    Series1.Add(StopTimer*1000,'Sparse'+chr(13)+'IterativeSolve',clYellow);

  finally
    Screen.Cursor := crDefault;
  end;
  if x1.Equal(x2,1.0e-2) then tmpStr := 'LU Solve solution equal to UMFPack solve solution'
  else tmpStr := 'LU Solve solution NOT equal to UMFPack solve solution';

  if x1.Equal(x3,1.0e-2) then tmpStr := tmpStr+chr(10)+chr(13)+'LU Solve solution equal to Pardiso solve solution'
  else tmpStr := tmpStr+chr(10)+chr(13)+'LU Solve solution NOT equal to Pardiso solve solution';

  if x1.Equal(x4,1.0e-2) then tmpStr := tmpStr+chr(10)+chr(13)+'LU Solve solution equal to iterative solve solution'
  else tmpStr := tmpStr+chr(10)+chr(13)+ 'LU Solve solution NOT equal to iterative solve solution';

  ShowMessageBox(tmpStr);
end;

initialization
  RegisterClass(TfrmSparseTest);

end.

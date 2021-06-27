unit MultiStepReg;

interface

uses
  System.Types, 
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, StdCtrls,
  MtxVec, AbstractMtxVec, Statistics, Regress,
  MtxExpr, math387, StringVar, MtxExprInt, MtxVecInt, Probabilities,
  CheckLst, Grids, MtxDialogs, ExtCtrls, StatTools;

type
  TMultiStepRegForm = class(TForm)
    VarListBox: TCheckListBox;
    Label1: TLabel;
    StepButton: TButton;
    StringGrid: TStringGrid;
    Memo: TMemo;
    MethodGroup: TRadioGroup;
    Qualitybox: TComboBox;
    Label2: TLabel;
    procedure StepButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure VarListBoxClickCheck(Sender: TObject);
    procedure MethodGroupClick(Sender: TObject);
    procedure QualityboxChange(Sender: TObject);
  private
    { Private declarations }
///    MtxStep: TMtxStepwiseReg;
  public
    { Public declarations }
    aSrc: Matrix;
    bi: VectorInt;
    reportCoeff, reportSSE: Matrix;
    stdDevA: Vector;
    aList: TVecList;
    sMethod: TStepwiseMethod;
  end;

var
  MultiStepRegForm: TMultiStepRegForm;

implementation

uses MtxVecBase;

{$R *.dfm}

procedure TMultiStepRegForm.FormCreate(Sender: TObject);
var i: integer;
begin
    Memo.Clear;
    Memo.Lines.Add('Stepwise regression is an optimization aglorithm aiming to improve the quality of the multiple linear regression ' +
                   'by excluding noisy variables. Optimal result is possible only when using the "exhaustive" search method, ' +
                   'which will check all posibilities. The results are displayed in two tables. First table shows the results of each step ' +
                   'with one line per step. Second table shows var count lines per step and detailed coefficient statistics.' +
                   'Try switching between different methods and preselected variables. Checked/unchecked variables are initial state for the forward/backward algorithms.' +
                   'Regression with the best configuration has the smallest standard error.');

    aSrc.SetIt(15, 6, false, [83, 34, 65, 63, 64, 106,
                              73, 19, 73, 48, 82, 92,
                              54, 81, 82, 65, 73, 102,
                              96, 72, 91, 88, 94, 121,
                              84, 53, 72, 68, 82, 102,
                              86, 72, 63, 79, 57, 105,
                              76, 62, 64, 69, 64, 97,
                              54, 49, 43, 52, 84, 92,
                              37, 43, 92, 39, 72, 94,
                              42, 54, 96, 48, 83, 112,
                              71, 63, 52, 69, 42, 130,
                              63, 74, 74, 71, 91, 115,
                              69, 81, 82, 75, 54, 98,
                              81, 89, 64, 85, 62, 96,
                              50, 75, 72, 64, 45, 103]);

    reportCoeff.Size(0,0);
    reportSSE.Size(0,0);

    VarListBox.Clear;
    bi.BitCount := aSrc.Cols-1;
    for i := 0 to aSrc.Cols-2 do
    begin
        VarListBox.Items.Add('x'+IntToStr(i));
        VarListBox.Checked[i] := True;
        bi.Bits[i] := true;
    end;

    aList := TVecList.Create;
    aList.DecomposeColumnMatrix(aSrc);
    stdDevA.Size(aList.Count);
    for i := 0 to aList.Count-1 do stdDevA[i] := aList[i].StdDev;

    StringGrid.RowCount := 8*32;
    QualityBox.ItemIndex := 0;
    StepButtonClick(nil);
end;

procedure TMultiStepRegForm.FormDestroy(Sender: TObject);
begin
    aList.Free;
end;

procedure TMultiStepRegForm.MethodGroupClick(Sender: TObject);
begin
    StepButtonClick(Sender);
end;

procedure TMultiStepRegForm.QualityboxChange(Sender: TObject);
begin
    StepButtonClick(Sender);
end;

function CustomQualityCriteria(const stats: TRegStats; const b,t: TVec; const ParamMask: TVecInt; const CriteriaOwner: TObject): double;
begin
    case TMultiStepRegForm(CriteriaOwner).QualityBox.ItemIndex of
    0: Result :=  Stats.StdError;
    1: Result := -Stats.FStats.F;
    else Result := 0;
    end;

    if IsInf(Result) then Result := INF; // same as "worst result"
end;

procedure TMultiStepRegForm.StepButtonClick(Sender: TObject);
var i: integer;
    j: Integer;
begin
    for i := 0 to aSrc.Cols-2 do
    begin
        bi.Bits[i] := varListbox.Checked[i];
    end;
    sMethod := TStepwiseMethod(MethodGroup.ItemIndex);

    if QualityBox.ItemIndex = 0 then
    begin
        case sMethod of
          swExhaustive: StepwiseRegression(aList, stdDevA, sMethod, bi, reportSSE, reportCoeff);
          swForward,
          swBackward,
          swStepwise: StepwiseRegression(aList, stdDevA, sMethod, bi, reportSSE, reportCoeff, 1000, false);
        end;
    end else
    begin
          case sMethod of
          swExhaustive: StepwiseRegression(aList, stdDevA, sMethod, bi, reportSSE, reportCoeff, 1000, True, CustomQualityCriteria, Self);
          swForward,
          swBackward,
          swStepwise: StepwiseRegression(aList, stdDevA, sMethod, bi, reportSSE, reportCoeff, 1000, false, CustomQualityCriteria, Self);
        end;
    end;

    for i := 1 to StringGrid.ColCount do
      for j := 1 to StringGrid.RowCount do
        StringGrid.Cells[i,j] := '';

//    When using component:
//    MtxStep := TMtxStepwiseReg.Create(Self);
//    MtxStep.Method := sMethod;
//    MtxStep.AutoInitBitMask := False;
//    MtxStep.BitMask.Assign(TVecInt(Bi));
//    MtxStep.A.Assign(aList);
//    MtxStep.Recalc;
//    MtxStep.Free;


    j := 1;
    for i := 0 to aList.Count-2 do StringGrid.Cells[i+2,j] := 'x' + IntToStr(i);
    StringGrid.Cells[1, j] := 'Step#';
    i := aList.Count+1;

    case QualityBox.ItemIndex of
    0: stringGrid.Cells[i, j] := 'Std. error';
    1: stringGrid.Cells[i, j] := '- F';
    end;

    stringGrid.Cells[i+1, j] := 'SSE'; // Residual sum of squares.
    stringGrid.Cells[i+2, j] := 'SSR'; // Regression sum of squares.
    stringGrid.Cells[i+3, j] := 'SST'; // Total sum of squares = SSE + SSR
    stringGrid.Cells[i+4, j] := 'R2'; // Coefficient of determination
    stringGrid.Cells[i+5, j] := 'Adjusted R2'; // Adjusted coefficient of determination
    stringGrid.Cells[i+6, j] := 'MSE'; //Residual variance

    ValuesToGrid(reportSSE, StringGrid, 2, 1, '0.####', false);

    j := 1 + reportSSE.Rows + 2;
    i := 1;
    stringGrid.Cells[i, j] := 'Step #';
    stringGrid.Cells[i+1, j] := 'x';  //1 if var is included
    stringGrid.Cells[i+2, j] := 'Var incl.';  //1 if var is included
    stringGrid.Cells[i+3, j] := 'Std. coeff'; // Regression sum of squares.
    stringGrid.Cells[i+4, j] := 't-Value'; // Total sum of squares = SSE + SSR
    stringGrid.Cells[i+5, j] := 'p-Value'; // Coefficient of determination

    ValuesToGrid(reportCoeff, StringGrid, j + 1, 1, '0.####', false);
end;

procedure TMultiStepRegForm.VarListBoxClickCheck(Sender: TObject);
begin
    StepButtonClick(Sender);
end;

initialization
  RegisterClass(TMultiStepRegForm);

end.

unit Optim_Bounded;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Basic2, StdCtrls, ComCtrls, ExtCtrls, Grids, MtxExpr, Optimization,
  MtxIntDiff, MtxParseClass, MtxParseExpr, Math387;

type
  TfrmOptimBounded = class(TBasicForm2)
    Label1: TLabel;
    EditFunction: TEdit;
    Label2: TLabel;
    StringGridVars: TStringGrid;
    ButtonDetect: TButton;
    Button1: TButton;
    Memo1: TMemo;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Edit2: TEdit;
    UpDown1: TUpDown;
    CheckBox1: TCheckBox;
    StringGridResults: TStringGrid;
    Label5: TLabel;
    procedure ButtonDetectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EditFunctionChange(Sender: TObject);
  private
    { Private declarations }
    iVariables: TVariableCollection;
    pars,Lb,UB: Array of double;
    procedure InitSystem;
    procedure SolveProblem;
  public
    { Public declarations }
  end;


var
  frmOptimBounded: TfrmOptimBounded;

implementation

{$IFDEF CLR}
  {$R *.NFM}
{$ELSE}
  {$R *.DFM}
{$ENDIF}

uses MtxVec;

// A bit tricky, but ObjConsts hold all necessary objects, strings, etc..
// needed for calculation of f(x)
// ObjConsts[0] = TMtxExpression
// ObjConsts[1] = iVariables
// Parameters = parameter values
function OptObjFun(const Parameters: TVec; const Constants: TVec; Const ObjConst: Array of TObject): double;
var i: Integer;
  vars: TVariableCollection;
begin
  vars := ObjConst[1] as TVariableCollection;
  with ObjConst[0] as TMtxExpression do
  begin
    for i := 0 to Parameters.Length-1 do
    begin
      VarByName[vars[i].VarName].DoubleValue := Parameters.Values[i];
    end;
    Result := EvaluateDouble;
  end;
end;

procedure TfrmOptimBounded.Button1Click(Sender: TObject);
begin
  SolveProblem;
end;

procedure TfrmOptimBounded.ButtonDetectClick(Sender: TObject);
begin
  InitSystem;
  Button1.Enabled := true;
end;

procedure TfrmOptimBounded.EditFunctionChange(Sender: TObject);
begin
  Button1.Enabled := false;
end;




procedure TfrmOptimBounded.FormCreate(Sender: TObject);
begin
  inherited;
  EditFunction.Text := '100*Sqr(b-Sqr(a)) + Sqr(1-a)';
  iVariables := TVariableCollection.Create;
  With RichEdit1.Lines do
  begin
    Clear;
    Add('Optimization now supports bounded constraints. Invididual parameter '
      + 'can have no, lower, upper or both limits. This is done by:');
    Add('1. No limit: lower bound is -INF, upper bound is INF.');
    Add('2. Lower bound: lower bound is lb, upper bound is INF.');
    Add('3. Upper bound: lower bound is -INF, upper bound is ub.');
    Add('4. Lower and upper bound: lower bound is lb, upper bound is ub.');
    Add('');
    Add('1. Enter any function in the "Functon" edit box.');
    Add('2. Click the "Detect" button to get the list of variables in function.');
    Add('3. Define bounds (if any) for individual variables.');
    Add('4. Define starting values for individual variables.');
    Add('5. Press the "Calculate" button to minimize function.');
  end;


  Edit1.Text := SampleToStr(1e-8);
  InitSystem;
  Button1.Enabled := true;     

end;

procedure TfrmOptimBounded.FormDestroy(Sender: TObject);
begin
  iVariables.Free;
  SetLength(pars,0);
  SetLength(LB,0);
  SetLength(UB,0);
  pars := nil;
  LB := nil;
  UB := nil;
  inherited;
end;

procedure TfrmOptimBounded.InitSystem;
var list: TStrings;
  i: Integer;
  v: TNamedVariable;
  expr: TMtxExpression;
begin
  iVariables.Clear;
  list := TStringList.Create;
  expr := TMtxExpression.Create;
  try
    expr.AddExpr(EditFunction.Text);
    expr.GetVarList(list);

    StringGridVars.RowCount := List.Count + 1;
    StringGridResults.RowCount := List.Count + 1;
    StringGridVars.Cells[0,0] := 'Name';
    StringGridVars.Cells[1,0] := 'Lower bound';
    StringGridVars.Cells[2,0] := 'Upper bound';
    StringGridVars.Cells[3,0] := 'Initial value';
    StringGridResults.Cells[0,0] := 'Name';
    StringGridResults.Cells[1,0] := 'Value';

    for i := 0 to List.Count - 1 do
    begin
        v := iVariables.Add(List[i]);
        v.Value.DefineDouble;
    end;

    // Populate string grid
    for i := 0 to iVariables.Count-1 do
    begin
      StringGridVars.Cells[0,i+1] := iVariables.Items[i].VarName;
      StringGridVars.Cells[1,i+1] := '-INF';
      StringGridVars.Cells[2,i+1] := 'INF';
      StringGridVars.Cells[3,i+1] := iVariables.Items[i].Value.AsString;
      StringGridResults.Cells[0,i+1] := iVariables.Items[i].VarName;
    end;

  finally
    expr.Free;
    list.Free;
  end;
end;

procedure TfrmOptimBounded.SolveProblem;
var numvars: Integer;
  i: Integer;
  fMin: double;
  StopReason: TOptStopReason;
  expr: TMtxExpression;
  tol: double;
  maxiter: Integer;
begin
  expr := TMtxExpression.Create;
  Screen.Cursor := crHourGlass;
  try
    numvars := iVariables.Count;
    SetLength(pars,numvars);
    SetLength(LB,numvars);
    SetLength(UB,numvars);

    // #1: Setup expression evaluator
    for i := 0 to numvars-1 do
      expr.DefineDouble(iVariables[i].VarName).Value := StrToSample(StringGridVars.Cells[3,i+1]);

    expr.Expressions := EditFunction.Text;

    Memo1.Lines.Clear;
    // #2: Read values for optimization
    for i := 0 to numvars-1 do
    begin
      pars[i] := StrToSample(StringGridVars.Cells[3,i+1]);
      LB[i] := StrToSample(StringGridVars.Cells[1,i+1]);
      UB[i] := StrToSample(StringGridVars.Cells[2,i+1]);
    end;

    // #3: Setup and solve with Simplex
    tol := StrToSample(Edit1.Text);
    if tol < 1E-14 then tol := 1E-14;
    
    maxiter := UpDown1.Position;
    if CheckBox1.Checked then
      Simplex(OptObjFun,pars,[],[expr,iVariables],Lb,UB,fMin,StopReason,mvDouble, maxiter,tol,Memo1.Lines)
    else
      Simplex(OptObjFun,pars,[],[expr,iVariables],Lb,UB,fMin,StopReason,mvDouble, maxiter,tol);

    // #4: Write results
    Memo1.Lines.Add('');
    Case StopReason of
      OptResNotFound : Memo1.Lines.Add('Minimum not found.');
      OptResSmallGrad: Memo1.Lines.Add('Small gradient step.');
      OptResSingular:Memo1.Lines.Add('Singularity.');
      OptResSmallStep: Memo1.Lines.Add('Small step.');
      OptResZeroStep: Memo1.Lines.Add('Zero step.');
      OptResBigLambda: Memo1.Lines.Add('Big lambda.');
      OptResMaxIter: Memo1.Lines.Add('Maximum iteration limit reached.');
    else Memo1.Lines.Add('Converged within given tolerance.');
    End;

    Memo1.Lines.Add('Function value: '+SampleToStr(fMin,3,6));

    // Write results back to StringGridResults
    for i := 0 to numvars-1 do
      StringGridResults.Cells[1,i+1] := SampleToStr(pars[i],3,6);
  finally
    expr.Free;
    Screen.Cursor := crDefault;
  end;

end;

initialization
  RegisterClass(TfrmOptimBounded);

end.

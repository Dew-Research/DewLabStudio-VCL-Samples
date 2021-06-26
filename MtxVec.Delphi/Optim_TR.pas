unit Optim_TR;

interface

{$I BdsppDefs.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Basic2, StdCtrls, ComCtrls, ExtCtrls, MtxVec, Types, MtxExpr, Optimization,
  Math387, TeEngine, Series, TeeProcs, Chart;

type
  TfrmTRDemo = class(TBasicForm2)
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    Chart1: TChart;
    Series1: TBarSeries;
    Series2: TBarSeries;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);                           
  private
    { Private declarations }
    IterArray: Array[0..6] of Integer;
    TimeArray: Array[0..6] of double;
    initpars: Array[0..1] of TSample;
    procedure TRTest;
    procedure SimplexTest;
    procedure MarquardtTest;
    procedure BFGSTest;
    procedure DFPTest;
    procedure ConjGradFletcher;
    procedure ConjGradPolack;
  public
    { Public declarations }
  end;

var
  frmTRDemo: TfrmTRDemo;

implementation

uses MtxIntDiff, AbstractMtxVec;

const NumRep = 200;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

// initial estimates: (EPS,EPS)
procedure BananaVector(const x,f: TVec; const c: Array of double; const o: Array of TObject);
begin
  f[0] := 100*Sqr(x[1]-Sqr(x[0]));
  f[1] := Sqr(1-x[0]);
end;

// initial estimates: (EPS,EPS)
function BananaScalar(const x: TVec;Const c :TVec; Const o: Array of TObject): double;
begin
  Result := 100*Sqr(x.Values[1]-Sqr(x.Values[0]))+Sqr(1-x.Values[0]);
end;

procedure TfrmTRDemo.BFGSTest;
var
  i: Integer;
  x: Array[0..1] of double;
  stopReason: TOptStopReason;
  fMin: double;
  iHess: Matrix;
begin
  Math387.StartTimer;
  IterArray[3] := 0;
  for I := 1 to NumRep do
  begin
    x[0] := initpars[0];
    x[1] := initpars[1];
    IterArray[3] := IterArray[3] + BFGS(BananaScalar,NumericGradDifference,x,[],[],fMin,iHEss,stopREason,mvDouble,false,true,1000);
  end;
  TimeArray[3] := Math387.StopTimer*1000;
  IterArray[3] := Round(IterArray[3]/NumRep);
  if (stopReason=optResConverged) then
  begin
    Series1.Add(IterArray[3],'BFGS'+#13+'converged');
    Series2.Add(TimeArray[3],'BFGS'+#13+'converged');
  end
  else
  begin
    Series1.Add(IterArray[3],'BFGS'+#13+'NOT converged');
    Series2.Add(TimeArray[3],'BFGS'+#13+'NOT converged');
  end;
end;

procedure TfrmTRDemo.Button1Click(Sender: TObject);
begin
  Series1.Clear;
  Series2.Clear;
  initpars[0] := StrToSample(Edit1.Text);
  initpars[1] := StrToSample(Edit2.Text);
  Screen.Cursor := crHourGlass;
  try
    TRTest;
    SimplexTest;
    MarquardtTest;
    BFGSTest;
    DFPTest;
    ConjGradFletcher;
    ConjGradPolack;
  finally
    Screen.Cursor := crDefault;
  end;
  RadioGroup1Click(Self);
end;

procedure TfrmTRDemo.ConjGradFletcher;
var
  i: Integer;
  x: Array[0..1] of double;
  stopReason: TOptStopReason;
  fMin: double;
begin
  Math387.StartTimer;
  IterArray[5] := 0;
  for I := 1 to NumRep do
  begin
    x[0] := initpars[0];
    x[1] := initpars[1];
    IterArray[5] := IterArray[5] + ConjGrad(BananaScalar, NumericGradDifference,x,[],[],fMin,stopREason,mvDouble,true,true,1500);
  end;
  TimeArray[5] := StopTimer*1000;
  IterArray[5] := Round(IterArray[5]/NumRep);
  if (stopReason=optResConverged) then
  begin
    Series1.Add(IterArray[5],'Fletcher'+#13+'converged');
    Series2.Add(TimeArray[5],'Fletcher'+#13+'converged');
  end
  else
  begin
    Series1.Add(IterArray[5],'Fletcher'+#13+'NOT converged');
    Series2.Add(TimeArray[5],'Fletcher'+#13+'NOT converged');
  end;
end;

procedure TfrmTRDemo.ConjGradPolack;
var
  i: Integer;
  x: Array[0..1] of double;
  stopReason: TOptStopReason;
  fMin: double;
begin
  Math387.StartTimer;
  IterArray[6] := 0;
  for I := 1 to NumRep do
  begin
    x[0] := initpars[0];
    x[1] := initpars[1];
    IterArray[6] := IterArray[6] + ConjGrad(BananaScalar,NumericGradDifference,x,[],[],fMin,stopREason,mvDouble,false,true,1500);
  end;
  TimeArray[6] := StopTimer*1000;
  IterArray[6] := Round(IterArray[6]/NumRep);
  if (stopReason=optResConverged) then
  begin
    Series1.Add(IterArray[6],'Polack'+#13+'converged');
    Series2.Add(TimeArray[6],'Polack'+#13+'converged');
  end
  else
  begin
    Series1.Add(IterArray[6],'Polack'+#13+'NOT converged');
    Series2.Add(TimeArray[6],'Polack'+#13+'NOT converged');
  end;
end;

procedure TfrmTRDemo.DFPTest;
var
  i: Integer;
  x: Array[0..1] of double;
  stopReason: TOptStopReason;
  fMin: double;
  iHess: Matrix;
begin
  Math387.StartTimer;
  IterArray[4] := 0;
  for I := 1 to NumRep do
  begin
    x[0] := initpars[0];
    x[1] := initpars[1];
    IterArray[4] := IterArray[4] + BFGS(BananaScalar,NumericGradDifference,x,[],[],fMin,iHEss,stopREason,mvDouble,true);
  end;
  TimeArray[4] := StopTimer*1000;
  IterArray[4] := Round(IterArray[4]/NumRep);
  if (stopReason=optResConverged) then
  begin
    Series1.Add(IterArray[3],'DFP'+#13+'converged');
    Series2.Add(TimeArray[3],'DFP'+#13+'converged');
  end
  else
  begin
    Series1.Add(IterArray[3],'DFP'+#13+'NOT converged');
    Series2.Add(TimeArray[3],'DFP'+#13+'NOT converged');
  end;
end;

procedure TfrmTRDemo.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines do
  begin
    Clear;
    Add('New in MtxVec 3.0 : Trust Region optimization algorithm.');
    Add('Using TR algorithm it''s now possible to minimize vector function of '
      + ' several variables with or without bounds.');
    Add('');
    Add('This example minimizes the famous "Banana" function using several different '
      + ' algorithms and compares the results. As seen from results, TR algorithm is not '
      + 'the best choice if you''re minimizing small scale problems. TR algorithm is the '
      + 'preffered choice if you''re working on large scale bounded or unbouded problems.');
    Add('');
    Add('NOTE: Check http://plato.la.asu.edu/guide.html when in doubt which algorithm to use.');
  end;

  Edit1.Text := FormatSample(0.0);
  Edit2.Text := FormatSample(0.0);
end;

procedure TfrmTRDemo.MarquardtTest;
var x: Array[0..1] of double;
  StopReason: TOptStopReason;
  fmin: double;
  iHess: TMtx;
  i: Integer;
begin
  CreateIt(iHess);
  try
    Math387.StartTimer;
    IterArray[2] := 0;
    for I := 1 to NumRep do
    begin
      x[0] := initpars[0];
      x[1] := initpars[1];
      IterArray[2] := IterArray[2] + Marquardt(BananaScalar,NumericGradHess,x,[],[],fMin,iHess,StopReason,mvDouble,1000);
    end;
    TimeArray[2] := StopTimer*1000;
    IterArray[2] := Round(IterArray[2]/NumRep);
    if (stopReason=optResConverged) then
    begin
      Series1.Add(IterArray[2],'Marquardt'+#13+'converged');
      Series2.Add(TimeArray[2],'Marquardt'+#13+'converged');
    end
    else
    begin
      Series1.Add(IterArray[2],'Marquardt'+#13+'NOT converged');
      Series2.Add(TimeArray[2],'Marquardt'+#13+'NOT converged');
    end;
  finally
    FreeIt(iHess);
  end;
end;

procedure TfrmTRDemo.RadioGroup1Click(Sender: TObject);
begin
  Series1.Active := RadioGroup1.ItemIndex = 0;
  Series2.Active := RadioGroup1.ItemIndex = 1;
  Chart1.Title.Text.Clear;
  Case RadioGroup1.ItemIndex of
    0: Chart1.Title.Text.Add('Average number of iterations needed to converge.');
    1: Chart1.Title.Text.Add('Time needed to converge ('+ IntToStr(NumRep)+' iterations).');
  End;
end;

procedure TfrmTRDemo.SimplexTest;
var x: Array[0..1] of double;
  StopReason: TOptStopReason;
  fmin: double;
  i: Integer;
begin
  Math387.StartTimer;
  IterArray[1] := 0;
  for I := 1 to NumRep do
  begin
    x[0] := initpars[0];
    x[1] := initpars[1];
    IterArray[1] := IterArray[1] + Simplex(BananaScalar,x,[],[],fMin,StopReason,mvDouble,1000);
  end;
  TimeArray[1] := StopTimer*1000;
  IterArray[1] := Round(IterArray[1]/NumRep);
  if (stopReason=optResConverged) then
  begin
    Series1.Add(IterArray[1],'Simplex'+#13+'converged');
    Series2.Add(TimeArray[1],'Simplex'+#13+'converged');
  end
  else
  begin
    Series1.Add(IterArray[1],'Simplex'+#13+'NOT converged');
    Series2.Add(TimeArray[1],'Simplex'+#13+'NOT converged');
  end;
end;

procedure TfrmTRDemo.TRTest;
var x,y: Vector;
  EPSArray: TEPSArray;
  StopReason: TOptStopReason;
  i: Integer;
begin
  x.SetIt(false,[initpars[0],initpars[1]]);
  y.Size(2);

  {$IFDEF TTDOUBLE}
  EPSArray[0] := 1.0E-10;
  EPSArray[1] := 1.0E-8;
  EPSArray[2] := 1.0E-8;
  EPSArray[3] := 1.0E-8;
  EPSArray[4] := 1.0E-8;
  EPSArray[5] := 1.0E-10;
  {$ELSE}
  EPSArray[0] := 1.0E-5;
  EPSArray[1] := 1.0E-4;
  EPSArray[2] := 1.0E-4;
  EPSArray[3] := 1.0E-4;
  EPSArray[4] := 1.0E-4;
  EPSArray[5] := 1.0E-5;
  {$ENDIF}

  Math387.StartTimer;
  IterArray[0] := 0;
  for I := 1 to NumRep do
  begin
    x.SetIt(false,[initpars[0],initpars[1]]);
    IterArray[0] := IterArray[0] + TrustRegion(BananaVector,nil,x,y,[],[],1000,100,EPSArray,0.0,stopReason);
  end;
  TimeArray[0] := StopTimer*1000;
  IterArray[0] := Round(IterArray[0]/NumRep);
  if (stopReason=optResConverged) then
  begin
    Series1.Add(IterArray[0],'TR'+#13+'converged');
    Series2.Add(TimeArray[0],'TR'+#13+'converged');
  end
  else
  begin
    Series1.Add(IterArray[0],'TR'+#13+'NOT converged: ' + StopReasonToStr(stopReason));
    Series2.Add(TimeArray[0],'TR'+#13+'NOT converged: ' + StopReasonToStr(stopReason));
  end;
end;

initialization
  RegisterClass(TfrmTRDemo);
end.

unit ParserPerformance;

interface

uses
  System.Types,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Basic2, StdCtrls, ComCtrls, ExtCtrls, MtxComCtrls, TeeProcs,
  TeEngine, Chart, MtxParseClass, MtxParseExpr,MtxVec, Series, Math387,
  MtxExpr;   

type
  TfrmParserPerformance = class(TBasicForm2)
    Chart1: TChart;
    FormulaEdit: TEdit;
    Label1: TLabel;                         
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    ComputationGroup: TRadioGroup;
    UpdateButton: TButton;
    Series1: TFastLineSeries;
    BenchmarkButtom: TButton;
    StandardLabel: TLabel;
    vectorLabel: TLabel;
    RatioLabel: TLabel;
    StartXEdit: TMtxFloatEdit;
    StopXEdit: TMtxFloatEdit;
    StepXEdit: TMtxFloatEdit;
    procedure BenchmarkButtomClick(Sender: TObject);
    procedure UpdateButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StepXEditChange(Sender: TObject);
    procedure StopXEditChange(Sender: TObject);
    procedure StartXEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure UpdateX;
    { Private declarations }
  public
    { Public declarations }
    x,y: Vector;
    yResult: TVec;
    Expr: TMtxExpression;
    x1,y1: TValueRec;
  end;

var
  frmParserPerformance: TfrmParserPerformance;

implementation

uses MtxVecTee, MtxVecEdit, AbstractMtxVec, MtxVecBase;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TfrmParserPerformance.BenchmarkButtomClick(Sender: TObject);
var i, j, Loops: integer;
    Tick, Tick1: double;
    xValues,yValues: TSampleArray;
begin
    UpdateButtonClick(Sender);
    StandardLabel.Visible := true;
    vectorlabel.Visible := true;
    ratioLabel.Visible := true;

    Loops := (1000*1000 div 2) div x.Length;

    Expr.ClearAll;
    x1 := Expr.DefineDouble('x');
    Expr.Expressions := FormulaEdit.Text;

    x.CopyToArray(xValues);
    y.SizeToArray(yValues);    

    StartTimer;
    for j := 0 to Loops - 1 do
    begin
        for i := 0 to x.Length - 1 do
        begin
            x1.DoubleValue :=  xValues[i];
            yValues[i] := Expr.EvaluateDouble;
        end;
    end;

    Tick := 1000*StopTimer;
    StandardLabel.Caption := 'Standard = ' + FormatSample('0.00ms',tick);

    Expr.ClearAll;
    Expr.DefineVector('x',x);
    Expr.Expressions := FormulaEdit.Text;

    StartTimer;
    for j := 0 to Loops - 1 do
    begin
        yResult := Expr.EvaluateVector;
    end;

    tick1 := 1000*StopTimer;
    VectorLabel.Caption := 'Vectorized = ' + FormatSample('0.00ms',tick1);

    RatioLabel.Caption := 'Ratio = ' + FormatSample('0.00x',Tick/Tick1);
end;

procedure TfrmParserPerformance.FormCreate(Sender: TObject);
begin
    inherited;
    With RichEdit1.Lines do
    begin
      Clear;
      Add('Example demonstrates performance benefits and usage differences ' +
          'when using a classical single value parser and a vectorized parser.' +
          'Try changing the math formula and measure the time needed with both ' +
          'approaches.');
    end;
    Expr := TMtxExpression.Create;
    UpdateX;
end;

procedure TfrmParserPerformance.UpdateButtonClick(Sender: TObject);
var i: integer;
begin
    StandardLabel.Visible := false;
    vectorlabel.Visible := false;
    ratiolabel.Visible := false;

    Expr.ClearAll;
    case ComputationGroup.ItemIndex of
    0: begin
          x1 := Expr.DefineDouble('x');
          Expr.Expressions := FormulaEdit.Text;

          if x.IsDouble then
          begin
              for i := 0 to x.Length - 1 do
              begin
                   x1.DoubleValue :=  X.Values[i];
                   y.Values[i] := Expr.EvaluateDouble;
              end;
          end else
          begin
              for i := 0 to x.Length - 1 do
              begin
                   x1.DoubleValue :=  X.SValues[i];
                   y.SValues[i] := Expr.EvaluateDouble;
              end;
          end;

          yResult := y;
       end;
    1: begin
          Expr.DefineVector('x',x);
          Expr.Expressions := FormulaEdit.Text;

          yResult := Expr.EvaluateVector;
       end;
    end;

    Chart1.Title.Text.Clear;
    Chart1.Title.Text.Add('y = ' + FormulaEdit.Text);
    DrawValues(x,yresult,Series1);
end;

procedure TFrmParserPerformance.UpdateX;
begin
    x.Length := Round(abs(StopXEdit.Position - StartXEdit.Position)/StepXEdit.Position);
    x.Ramp(Math387.Min(StopXEdit.Position,StartXEdit.Position),StepXEdit.Position);
    y.Size(x);
end;

procedure TfrmParserPerformance.FormDestroy(Sender: TObject);
begin
   Expr.Free;
end;

procedure TfrmParserPerformance.StartXEditChange(Sender: TObject);
begin
    UpdateX;
end;

procedure TfrmParserPerformance.StepXEditChange(Sender: TObject);
begin
    UpdateX;
end;

procedure TfrmParserPerformance.StopXEditChange(Sender: TObject);
begin
    UpdateX;
end;

initialization
  RegisterClass (TfrmParserPerformance);
end.

unit RidgeRegWizard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Basic_Wizard, ComCtrls, StdCtrls, Types, MtxVec,
  Math387, TeeProcs, TeEngine, Chart, TeeComma, MtxExpr, ExtCtrls, TeeGDIPlus;

type
  TfrmRidgeRegWizard = class(TfrmBasicWizard)
    tsInputData: TTabSheet;
    tsCoeff: TTabSheet;
    tsConfigReports: TTabSheet;
    tsTextReport: TTabSheet;
    tsChart: TTabSheet;
    RichEdit: TRichEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    ChkBoxUseWeights: TCheckBox;
    Edit4: TEdit;
    Edit3: TEdit;
    TeeCommander1: TTeeCommander;
    Chart1: TChart;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    EditkLB: TEdit;
    Label8: TLabel;
    EditkUB: TEdit;
    Label9: TLabel;
    EditkSteps: TEdit;
    UpDown1: TUpDown;
    GroupBox4: TGroupBox;
    Label10: TLabel;
    EditkFinal: TEdit;
    CheckBoxkOptimal: TCheckBox;
    GroupBox5: TGroupBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ChkBoxUseWeightsClick(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure EditkLBChange(Sender: TObject);
    procedure EditkUBChange(Sender: TObject);
    procedure EditkStepsChange(Sender: TObject);
    procedure CheckBoxkOptimalClick(Sender: TObject);
  private
    { Private declarations }
    Alpha: double;
    klb,kub: double;
    numk: Integer;
//    k_used: TSample;
    procedure TextReport;
    procedure ChartReport(AIndex: Integer);
    procedure DescStatReport;
    procedure CorrMtxReport;
    procedure LSMultiColReport;
    procedure EigenvaluesReport;
  protected
      // These three methods control wizard behavoir
    procedure RefreshWizardControls; override;
    procedure DoMoveForward; override;
    procedure DoMoveBack; override;
  public
    { Public declarations }
    A: TMtx;
    y,b,w: TVec;
  end;

var
  frmRidgeRegWizard: TfrmRidgeRegWizard;

implementation

{$R *.dfm}

Uses MtxVecEdit, Statistics, Regress, AbstractMtxVec,MtxVecBase;

{ page numbers }
const
  firstchartindex = 4;
  lastchartindex = 4;

function R2Calc(y: TVec; A: TMtx; out mse: double): double;
var b,yCalc: TVec;
begin
    CreateIt(b,yCalc);
    try
      MulLinRegress(y,A,b,true,yCalc);
      Result := R2(y,yCalc);
    finally
      FreeIt(b,YCalc);
    end;
end;

{ TfrmRidgeRegWizard }

procedure TfrmRidgeRegWizard.Button1Click(Sender: TObject);
begin
  ViewValues(A,'A in A*b=y',True,FAlse,True);
end;

procedure TfrmRidgeRegWizard.Button2Click(Sender: TObject);
begin
  ViewValues(y,'y in A*b=y',True,False,True);
end;

procedure TfrmRidgeRegWizard.Button3Click(Sender: TObject);
begin
  ViewValues(w,'Weights in A*b=y',True,False,True);
end;

procedure TfrmRidgeRegWizard.ChartReport(AIndex: Integer);
begin

end;

procedure TfrmRidgeRegWizard.CheckBoxkOptimalClick(Sender: TObject);
begin
  GroupBox5.Visible := CheckBoxkOptimal.Checked;
  EditkFinal.Enabled := Not CheckBoxkOptimal.Checked;
end;

procedure TfrmRidgeRegWizard.ChkBoxUseWeightsClick(Sender: TObject);
begin
  Button3.Enabled := ChkBoxUseWeights.Checked;
end;

procedure TfrmRidgeRegWizard.CorrMtxReport;
var AdjCorrMtx,tmpMtx: Matrix;
begin
  RichEdit.SelAttributes.Style := [fsBold,fsUnderline];
  RichEdit.Lines.Add('Correlation matrix');
  AdjCorrMtx.Size(A.Rows,A.Cols + 1);
  RichEdit.Paragraph.TabCount := AdjCorrMtx.Cols;
  SetupTabs(RichEdit.Paragraph.TabCount, RichEdit);
  AdjCorrMtx.Copy(A,0,0,0,0,A.Rows,A.Cols,false);
  AdjCorrMtx.SetCol(Y,A.Cols);
  CorrCoef(AdjCorrMtx,tmpMtx);
  tmpMtx.ValuesToStrings(RichEdit.Lines,Chr(9),ftaNone,FormatString);
  RichEdit.Lines.Add(Chr(13));
end;

procedure TfrmRidgeRegWizard.DescStatReport;
var i: Integer;
  tmpMin,tmpMean,
  tmpStdDev,tmpMax: double;
  LineText : String;
  tv: Vector;
begin
  RichEdit.Paragraph.TabCount := 5;
  SetupTabs(RichEdit.Paragraph.TabCount, RichEdit);
  RichEdit.SelAttributes.Style := [fsBold,fsUnderline];
  RichEdit.Lines.Add('Descriptive Statistics');
  RichEdit.SelAttributes.Color := clBlue;
  RichEdit.Lines.Add('Variable'+chr(9)+'Mean'+chr(9)+'Std.Dev.'
                      +chr(9)+'Min'+chr(9)+'Max');
  { basic descriptive statistics }
  for i := 0 to A.Cols-1 do
  begin
    tv.GetCol(A,0,i,A.Rows);
    tmpMean := tv.Mean;
    tmpStdDev := tv.StdDev(tmpMean);
    tmpMax := tv.Max;
    tmpMin := tv.Min;
    LineText :='A column '+IntToStr(i)+Chr(9);
    LineText := LineText + FormatFloat(FormatString,tmpMean)+Chr(9);
    LineText := LineText + FormatFloat(FormatString,tmpStdDev) + Chr(9);
    LineText := LineText + FormatFloat(FormatString,tmpMin) + Chr(9);
    LineText := LineText + FormatFloat(FormatString,tmpMax);
    RichEdit.Lines.Add(LineText);
  end;
  tmpMean := Y.Mean;
  tmpStdDev := Y.StdDev(tmpMean);
  tmpMax := Y.Max;
  tmpMin := Y.Min;
  LineText := 'Y column'+chr(9);
  LineText := LineText + FormatFloat(FormatString,tmpMean) + Chr(9);
  LineText := LineText + FormatFloat(FormatString,tmpStdDev) + Chr(9);
  LineText := LineText + FormatFloat(FormatString,tmpMin) + Chr(9);
  LineText := LineText + FormatFloat(FormatString,tmpMax);
  RichEdit.Lines.Add(LineText);
  RichEdit.Lines.Add(Chr(13));
end;


procedure TfrmRidgeRegWizard.DoMoveBack;
begin
  if (PageControl.ActivePage = tsChart) and (chartindex>firstchartindex) then
  begin
    Dec(chartindex);
    ChartReport(chartindex);
    moveback := false;
  end else moveback := true;

  inherited DoMoveBack;
end;

procedure TfrmRidgeRegWizard.DoMoveForward;
begin
  if (PageControl.ActivePage = tsChart) and (chartindex<lastchartindex) then
  begin
    Inc(chartindex);
    moveforward := false;
  end else moveforward := true;

  inherited DoMoveForward;

  if (PageControl.ActivePage = tsTextReport) then
  begin
    // Calculate everything
    TextReport;
  end
  else if (PageControl.ActivePage = tsChart) then ChartReport(chartindex);
end;

procedure TfrmRidgeRegWizard.Edit3Change(Sender: TObject);
begin
  Alpha := StrToSample(Edit3.Text);
end;

procedure TfrmRidgeRegWizard.Edit4Change(Sender: TObject);
begin
  FormatString := Edit4.Text;
end;

procedure TfrmRidgeRegWizard.EditkLBChange(Sender: TObject);
begin
  klb:= StrToSample(EditkLB.Text);
end;

procedure TfrmRidgeRegWizard.EditkStepsChange(Sender: TObject);
begin
  numk := StrToInt(EditkSteps.Text);
end;

procedure TfrmRidgeRegWizard.EditkUBChange(Sender: TObject);
begin
  kub:= StrToSample(EditkUB.Text);
end;

procedure TfrmRidgeRegWizard.EigenvaluesReport;
var i: Integer;
  LineText: String;
  PC,Z: Matrix;
  eigen,pct: Vector;
begin
  RichEdit.Paragraph.TabCount := 4;
  SetupTabs(RichEdit.Paragraph.TabCount, RichEdit);
  RichEdit.SelAttributes.Style := [fsBold,fsUnderline];
  RichEdit.Lines.Add('Eigenvalues of Correlations');
  RichEdit.SelAttributes.Color := clBlue;
  RichEdit.Lines.Add('Number'+chr(9)+'Eigenvalue'+chr(9)+'Percent'+chr(9)+'Cond. number');
  PCA(A,PC,Z,eigen,pct,PCACorrMat);
  for I := 0 to eigen.Length - 1 do
  begin
    LineText := IntToStr(i)+chr(9)+FormatSample(eigen[i],FormatString)
      + chr(9)+FormatSample(pct[i],'0.00')+chr(9)+FormatSample(eigen.Max/eigen[i],FormatString);
    RichEdit.Lines.Add(LineText);
  end;

  RichEdit.Lines.Add(Chr(13));
  RichEdit.Lines.Add('If some Condition Numbers are between 100 and 1000, Multicollinearity is a MILD problem.');
  RichEdit.Lines.Add('If some Condition Numbers are greater than 1000, Multicollinearity is a SEVERE problem.');
  RichEdit.Lines.Add(Chr(13));
end;

procedure TfrmRidgeRegWizard.FormCreate(Sender: TObject);
begin
  inherited;
  A := TMtx.Create;
  y := TVec.Create;
  b := TVec.Create;
  w := TVec.Create;
  Alpha := 0.05;
  ChartIndex := firstchartindex;
  // Setup visual controls
  Edit3.Text := SampleToStr(Alpha);
  Edit4.Text := FormatString;
  klb := 1.0e-7;
  kub := 1.0e+0;
  numk := 30;
  EditkLB.Text := SampleToStr(klb);
  EditkUB.Text := SampleToStr(kub);
  UpDown1.Position := numk;
end;

procedure TfrmRidgeRegWizard.FormDestroy(Sender: TObject);
begin
  A.Destroy;
  y.Destroy;
  b.Destroy;
  w.Destroy;
  inherited;
end;

procedure TfrmRidgeRegWizard.LSMultiColReport;
var i: Integer;
  tmpm: Matrix;
  tmpv: Vector;
  calcr2, vif, mse: double;
  LineText: String;
begin
  RichEdit.Paragraph.TabCount := 4;
  SetupTabs(RichEdit.Paragraph.TabCount, RichEdit);
  RichEdit.SelAttributes.Style := [fsBold,fsUnderline];
  RichEdit.Lines.Add('Least Squares Multicollinearity Section');
  RichEdit.SelAttributes.Color := clBlue;
  RichEdit.Lines.Add('Variable'+chr(9)+'VIF'+chr(9)+'R2 vs. other'+chr(9)+'Tolerance');

  for i := 0 to A.Cols -1 do
  begin
    RemoveColumn(A,tmpm,i);
    tmpv.GetCol(A,i);
    calcR2 := R2Calc(tmpv,tmpm,mse);
    vif := 1.0/(1.0-calcR2);
    LineText := IntToStr(i) + chr(9) + FormatSample(vif,FormatString) + chr(9)
      + FormatSample(calcR2,FormatString)+chr(9)+FormatSample(1.0-calcR2,FormatString);
    RichEdit.Lines.Add(LineText);
  end;
  RichEdit.Lines.Add(Chr(13));
  RichEdit.Lines.Add('If some VIF’s are greater than 10, multicollinearity is a problem.');
  RichEdit.Lines.Add(Chr(13));
end;

procedure TfrmRidgeRegWizard.RefreshWizardControls;
begin
  inherited;
  if PageControl.ActivePage = tsChart then btnNext.Enabled := chartindex < lastchartindex;
end;

procedure TfrmRidgeRegWizard.TextReport;
begin
  RichEdit.Lines.Clear;
  RichEdit.DefAttributes.Color := clBlack;
  RichEdit.DefAttributes.Pitch := fpFixed;
  RichEdit.DefAttributes.Style := [];
  RichEdit.SelAttributes.Style := [fsBold,fsUnderline];
  RichEdit.SelAttributes.Size := 16;
  RichEdit.Lines.Add('Ridge Regression');
  RichEdit.Lines.Add(Chr(13));
  RichEdit.Lines.Add(Chr(13));

  DescStatReport;
  CorrMtxReport;
  LSMultiColReport;
  EigenvaluesReport;

end;

end.

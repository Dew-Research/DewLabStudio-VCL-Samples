unit MLRegWizard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_Wizard, ComCtrls, StdCtrls, ExtCtrls, Buttons, StatTools,
  MtxVec, TeeProcs, TeEngine, Chart, MtxBaseComp, TeeComma, TeeGDIPlus;

type
  TfrmMulLinRegWiz = class(TfrmBasicWizard)
    tsInputData: TTabSheet;
    tsReportConfig: TTabSheet;
    tsChart: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;                              
    Label4: TLabel;
    Label5: TLabel;
    BitBtnA: TBitBtn;
    BitBtnY: TBitBtn;
    BitBtnW: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    ChkBoxUseWeights: TCheckBox;
    ChkBoxRemoveInt: TCheckBox;
    Edit4: TEdit;
    Edit3: TEdit;
    GroupBox3: TGroupBox;
    ChkBoxCorr: TCheckBox;
    ChkBoxDescStat: TCheckBox;
    ChkBoxRegCoeff: TCheckBox;
    ChkBoxRes: TCheckBox;
    ChkBoxRegStats: TCheckBox;
    ChkBoxSerCorr: TCheckBox;
    TeeCommander1: TTeeCommander;
    Chart1: TChart;
    tsTextReport: TTabSheet;
    RichEdit: TRichEdit;
    ChkBoxNormality: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure BitBtnAClick(Sender: TObject);
    procedure ChkBoxUseWeightsClick(Sender: TObject);
    procedure ChkBoxRemoveIntClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    MtxAnova: TMtxAnova;
    tmpMtx: TMtx;
    tmpVec: TVec;
    ChartIndex : Integer;
    procedure TextReport;
    procedure ChartReport(AIndex: Integer);
    procedure CorrMtxReport;
    procedure DescStatReport;
    procedure RegCoeffReport;
    procedure ResidualReport;
    procedure BasicRegStatReport;
    procedure SerCorrReport;
    procedure NormalityReport;
  protected
    // These three methods control wizard behavoir
    procedure RefreshWizardControls; override;
    procedure DoMoveForward; override;
    procedure DoMoveBack; override;
  public
    { Public declarations }
    MtxMulLinReg: TMtxMulLinReg;
  end;

var
  frmMulLinRegWiz: TfrmMulLinRegWiz;

implementation

Uses Types, MtxVecEdit, Math387, Statistics, StatChar, Series,
     MtxVecTee, StatSeries, ErrorBar, Probabilities, StatProbPlots,
     Regress, MtxExpr, AbstractMtxVec, MtxVecBase;

{ page numbers }
const
  firstchartindex = 3;
  lastchartindex = 6;

{$R *.DFM}

{ TfrmBasicWizard1 }

procedure TfrmMulLinRegWiz.BasicRegStatReport;
var Pressval,PressR2: double;
begin
  // Calc
  Pressval := PRESS(MtxMulLinReg.A,MtxMulLinReg.Y);
  PressR2 := 1.0 - (Pressval/MtxMulLinReg.RegressStatistics.TSS);
  RichEdit.Paragraph.TabCount := 1;
  RichEdit.Paragraph.Tab[0] := 100;
  RichEdit.SelAttributes.Style := [fsBold,fsUnderline];
  RichEdit.Lines.Add('Basic regression statistics');
  With RichEdit.Lines do
  begin
    Add('Residuals variance : ' + chr(9) + FormatFloat(FormatString,MtxMulLinReg.RegressStatistics.ResidualVar));
    Add('R squared : '+ chr(9) + FormatFloat(FormatString,MtxMulLinReg.RegressStatistics.R2));
    Add('Adjusted R squared :'+ chr(9) + FormatFloat(FormatString,MtxMulLinReg.RegressStatistics.AdjustedR2));
    Add('PRESS value : '+chr(9)+FormatFloat(FormatString,Pressval));
    Add('PRESS R2 : '+chr(9)+FormatFloat(FormatString,PressR2));
    Add('F value : '+ chr(9) + FormatFloat(FormatString,MtxMulLinReg.RegressStatistics.F));
    Add('Probability of F : '+ chr(9) + FormatFloat(FormatString,MtxMulLinReg.RegressStatistics.SignifProb));
    Add('Total sum of squares : '+ chr(9) + FormatFloat(FormatString,MtxMulLinReg.RegressStatistics.TSS));
    Add('Regression sum of squares : '+ chr(9) + FormatFloat(FormatString,MtxMulLinReg.RegressStatistics.RSS));
    Add('Error sum of squares : '+ chr(9) + FormatFloat(FormatString,MtxMulLinReg.RegressStatistics.SSE));
    Add(Chr(13));
  end;
end;

procedure TfrmMulLinRegWiz.CorrMtxReport;
var AdjCorrMtx: Matrix;
begin
    RichEdit.SelAttributes.Style := [fsBold,fsUnderline];
    RichEdit.Lines.Add('Correlation matrix');
    with MtxMulLinReg do
    begin
        AdjCorrMtx.Size(A.Rows,A.Cols + 1, A.FloatPrecision);
        RichEdit.Paragraph.TabCount := AdjCorrMtx.Cols;
        SetupTabs(RichEdit.Paragraph.TabCount, RichEdit);
        AdjCorrMtx.Copy(A,0,0,0,0,A.Rows,A.Cols,false);
        AdjCorrMtx.SetCol(Y,A.Cols);
        CorrCoef(AdjCorrMtx,tmpMtx);
        tmpMtx.ValuesToStrings(RichEdit.Lines,Chr(9),ftaNone,FormatString);
    end;
    RichEdit.Lines.Add(Chr(13));
end;

procedure TfrmMulLinRegWiz.DescStatReport;
var i: Integer;
  tmpMin,tmpMean,
  tmpStdDev,tmpMax: double;
  LineText : String;
begin
  RichEdit.Paragraph.TabCount := 5;
  SetupTabs(RichEdit.Paragraph.TabCount, RichEdit);
  RichEdit.SelAttributes.Style := [fsBold,fsUnderline];
  RichEdit.Lines.Add('Descriptive Statistics');
  RichEdit.SelAttributes.Color := clBlue;
  RichEdit.Lines.Add('Variable'+chr(9)+'Mean'+chr(9)+'Std.Dev.'
                      +chr(9)+'Min'+chr(9)+'Max');
  { basic descriptive statistics }
  for i := 0 to MtxMulLinReg.A.Cols-1 do
  begin
    tmpVec.GetCol(MtxMulLinReg.A,0,i,MtxMulLinReg.A.Rows);
    tmpMean := tmpVec.Mean;
    tmpStdDev := tmpVec.StdDev(tmpMean);
    tmpMax := tmpVec.Max;
    tmpMin := tmpVec.Min;
    LineText :='A column '+IntToStr(i)+Chr(9);
    LineText := LineText + FormatFloat(FormatString,tmpMean)+Chr(9);
    LineText := LineText + FormatFloat(FormatString,tmpStdDev) + Chr(9);
    LineText := LineText + FormatFloat(FormatString,tmpMin) + Chr(9);
    LineText := LineText + FormatFloat(FormatString,tmpMax);
    RichEdit.Lines.Add(LineText);
  end;
  tmpMean := MtxMulLinReg.Y.Mean;
  tmpStdDev := MtxMulLinReg.Y.StdDev(tmpMean);
  tmpMax := MtxMulLinReg.Y.Max;
  tmpMin := MtxMulLinReg.Y.Min;
  LineText := 'Y column'+chr(9);
  LineText := LineText + FormatFloat(FormatString,tmpMean) + Chr(9);
  LineText := LineText + FormatFloat(FormatString,tmpStdDev) + Chr(9);
  LineText := LineText + FormatFloat(FormatString,tmpMin) + Chr(9);
  LineText := LineText + FormatFloat(FormatString,tmpMax);
  RichEdit.Lines.Add(LineText);
  RichEdit.Lines.Add(Chr(13));
end;

procedure TfrmMulLinRegWiz.RegCoeffReport;
var i: Integer;
  LineText : String;
  CIText : String;
  var TVals, PVals: Vector;
begin
  { calculate t values }
  { This is the t-test value for testing the hypothesis that j = 0 versus
    the alternative that after removing the influence of all other X's.
    This t-value has Rows-Cols-1 degrees of freedom.
  }
  TVals.Divide(MtxMulLinReg.RegressResult.B,MtxMulLinReg.RegressResult.BStdDev);

  { calculate p values }
  { The p-value is the probability that above T-statistic will take on a value
    at least as extreme as the actually observed value, assuming that the null hypothesis
    is true (i.e., the regression estimate is equal to zero). If the p-value is less than
    alpha, say 0.05, the null hypothesis is rejected.
    This p-value is for a two-tail test.
  }
  StudentCDF(TVals,MtxMulLinReg.A.Rows - MtxMulLinReg.A.Cols -1,PVals);
  for i := 0 to PVals.Length -1 do
    PVals[i] := 2.0*Min(PVals[i],1.0 - PVals[i]);

   CIText := FormatFloat('0.00 %',100*(1-MtxMulLinReg.Alpha));
   With RichEdit do
   begin
     Paragraph.TabCount := 7;
     SetupTabs(RichEdit.Paragraph.TabCount, RichEdit);
     SelAttributes.Style := [fsBold,fsUnderline];
     Lines.Add('Regression coefficients');
     SelAttributes.Color := clBlue;
     Lines.Add('Independent'+chr(9)+'Regression'+chr(9)+'Standard'
                     +chr(9)+'T Value'+chr(9)+'P Value'+chr(9)+'Lower'+chr(9)+'Upper');
     SelAttributes.Color := clBlue;
     Lines.Add('variable'+chr(9)+'coefficient'+chr(9)+'deviation'+chr(9)+'Ho: B=0'+
                     chr(9)+chr(9)+CIText+' CI'+chr(9)+CIText+' CI');
     { regression coefficients }
     for i := 0 to MtxMulLinReg.RegressResult.B.Length -1 do
     with MtxMulLinReg.RegressResult do
     begin
       LineText := 'Variable ' + IntToStr(i)+chr(9);
       LineText := LineText + FormatFloat(FormatString,B[i])+chr(9);
       LineText := LineText + FormatFloat(FormatString,BStdDev[i])+chr(9);
       LineText := LineText + FormatFloat(FormatString,TVals[i])+chr(9);
       LineText := LineText + FormatFloat(FormatString,PVals[i])+chr(9);
       LineText := LineText + FormatFloat(FormatString,BConfInt[i,0])+chr(9);
       LineText := LineText + FormatFloat(FormatString,BConfInt[i,1]);
       Lines.Add(LineText)
     end;
     Lines.Add(Chr(13));
  end;
end;

procedure TfrmMulLinRegWiz.ResidualReport;
var LineText : String;
    i : Integer;
begin
  With RichEdit do
  begin
    Paragraph.TabCount := 3;
    SetupTabs(RichEdit.Paragraph.TabCount, RichEdit);
    SelAttributes.Style := [fsBold,fsUnderline];
    Lines.Add('Residuals');
    SelAttributes.Color := clBlue;
    Lines.Add('Actual'+chr(9)+'Predicted'+chr(9)+'Residual');
  { regression coefficients }
    for i := 0 to MtxMulLinReg.Y.Length -1 do
    with MtxMulLinReg do
    begin
      LineText := FormatFloat(FormatString,Y[i])+chr(9);
      LineText := LineText + FormatFloat(FormatString,RegressResult.YCalc[i])+chr(9);
      LineText := LineText + FormatFloat(FormatString,RegressResult.Residuals[i]);
      Lines.Add(LineText)
    end;
    Lines.Add(Chr(13));
  end;
end;

procedure TfrmMulLinRegWiz.NormalityReport;
var hres: THypothesisResult;
  signif: double;
  statval: double;

  function HypResult(hypres: THypothesisResult): String;
  begin
    if hypres = hrNotReject then result := 'Accept'
    else if hypres = hrReject then result := 'Reject'
    else result := '';
  end;

begin
  With RichEdit do
  begin
    Paragraph.TabCount := 4;
    SetupTabs(RichEdit.Paragraph.TabCount, RichEdit);
    SelAttributes.Style := [fsBold,fsUnderline];
    Lines.Add('Normality tests on residuals');
    SelAttributes.Color := clBlue;
    Lines.Add('Test'+#9+'Test'+#9+'Probability'+#9+'Reject Ho');
    SelAttributes.Color := clBlue;
    Lines.Add('name'+#9+'value'+#9+'level'+#9+'alpha='+FormatSample('0.00 %',100*(1-MtxMulLinReg.Alpha)));

    // Shapiro-Wilks
    // Input values must be ordered and unique
    Unique(MtxMulLinReg.RegressResult.Residuals,tmpvec);
    statval := ShapiroWilks(tmpvec,hres,signif,htTwoTailed,MtxMulLinReg.Alpha);
    Lines.Add('Sh.-Wilks'+#9+FormatSample(FormatString,statval)+#9+FormatSample(FormatString,signif)+#9+HypResult(hres));

    // Shapiro-Francia
    statval := ShapiroFrancia(tmpvec,hres,signif,htTwoTailed,MtxMulLinReg.Alpha);
    Lines.Add('Sh.-Francia'+#9+FormatSample(FormatString,statval)+#9+FormatSample(FormatString,signif)+#9+HypResult(hres));

    // Anderson-Darling
    tmpvec.Copy(MtxMulLinReg.RegressResult.Residuals);
    tmpVec.SortAscend;
    statval := AndersonDarling(tmpvec,distNormal,hres,signif,MtxMulLinReg.Alpha);
    Lines.Add('Anderson-D.'+#9+FormatSample(FormatString,statval)+#9+FormatSample(FormatString,signif)+#9+HypResult(hres));

        // Bera-Jarque
    statval := GOFBeraJarqueTest(MtxMulLinReg.RegressResult.Residuals,hres,signif,MtxMulLinReg.Alpha);
    Lines.Add('Bera-Jarque'+#9+FormatSample(FormatString,statval)+#9+FormatSample(FormatString,signif)+#9+HypResult(hres));

    // Kolmogorov-Smirnov
    statval := GOFKolmogorov(MtxMulLinReg.RegressResult.Residuals,hres,signif,nil,nil,htTwoTailed,MtxMulLinReg.Alpha);
    Lines.Add('K-S'+#9+FormatSample(FormatString,statval)+#9+FormatSample(FormatString,signif)+#9+HypResult(hres));

    // LillieFors
    statval := GOFLillieTest(MtxMulLinReg.RegressResult.Residuals,hres,signif,MtxMulLinReg.Alpha,1e-4);
    Lines.Add('Lillie'+#9+FormatSample(FormatString,statval)+#9+FormatSample(FormatString,signif)+#9+HypResult(hres));

    Lines.Add('');
  end;

end;

procedure TfrmMulLinRegWiz.SerCorrReport;
var SS : double;
    Lags : Integer;
    i : Integer;
    LineText : String;
begin
  RichEdit.Paragraph.TabCount := 2;
  SetupTabs(RichEdit.Paragraph.TabCount, RichEdit);
  RichEdit.SelAttributes.Style := [fsBold,fsUnderline];
  RichEdit.Lines.Add('Serial correlation (up to 10th lag)');
  RichEdit.SelAttributes.Color := clBlue;
  RichEdit.Lines.Add('Lag'+chr(9)+'Correlation');
  With MtxMulLinReg.RegressResult do
  begin
    Lags := Min(Residuals.Length,11); { max 10 lags }
    SS := Sqr(Residuals.NormL2); { sum of squares }
    tmpVec.AutoCorrNormal(Residuals,Lags);
  end;
  tmpVec.Scale(1.0/SS);
  { regression coefficients }
  for i := 1 to tmpVec.Length -1 do
  begin
    LineText := IntToStr(i)+chr(9);
    LineText := LineText + FormatFloat(FormatString, tmpVec[i]);
    RichEdit.Lines.Add(LineText)
  end;
  {RichEdit.Lines.Add('Serial correlations are significant if their '
                    +' absolute values are greater than : ' + FormatFloat(FormatString,Power(2,Sqrt(tmpVec.Length))));
  }
  if tmpVec.Length >=2 then
  begin
    RichEdit.Lines.Add(Chr(13));
    RichEdit.Lines.Add('Durbin-Watson value : ' + FormatFloat(FormatString,2.0*(1.0 - tmpVec[1])));
  end;
  RichEdit.Lines.Add(Chr(13));
end;

procedure TfrmMulLinRegWiz.TextReport;
begin
  RichEdit.Enabled := false;
  RichEdit.Lines.Clear;
  try
    RichEdit.DefAttributes.Color := clBlack;
    RichEdit.DefAttributes.Pitch := fpFixed;
    RichEdit.DefAttributes.Style := [];
    RichEdit.SelAttributes.Style := [fsBold,fsUnderline];
    RichEdit.SelAttributes.Size := 16;
    RichEdit.Lines.Add('Multiple linear regression');
    RichEdit.Lines.Add(Chr(13));
    RichEdit.Lines.Add(Chr(13));
    if ChkBoxRegCoeff.Checked then RegCoeffReport;
    if ChkBoxRes.Checked then ResidualReport;
    if ChkBoxNormality.Checked then NormalityReport;
    if ChkBoxRegStats.Checked then BasicRegStatReport;
    if ChkBoxDescStat.Checked then DescStatReport;
    if ChkBoxCorr.Checked then CorrMtxReport;
    if ChkBoxSerCorr.Checked then SerCorrReport;
  finally
    RichEdit.Enabled := true;
  end;
end;

procedure TfrmMulLinRegWiz.ChartReport(AIndex: Integer);
var tmpVec1,tmpVec2: Vector;
    minX,MaxX,minY,MaxY: double;
//    zVal: TSample;
begin
  Chart1.FreeAllSeries;
//  zval := NormalCDFInv(1.0-0.5*MtxMulLinReg.Alpha,0,1.0);
  if (AIndex = firstchartindex) then
  begin
    { setup chart title and axes }
    Chart1.Title.Text.Clear;
    Chart1.Title.Text.Add('Histogram of residuals');
    Chart1.LeftAxis.Title.Caption := 'Count';
    Chart1.BottomAxis.Title.Caption := 'Residuals';
    Chart1.LeftAxis.AutomaticMinimum := false;
    Chart1.LeftAxis.Minimum := 0.0;
    { add histogram series }
    Chart1.AddSeries(THistogramSeries.Create(Self));
    Chart1.Series[0].SeriesColor := clBlue;
    THistogramSeries(Chart1.Series[0]).LinesPen.Visible := true;
    { draw histogram }
    Histogram(MtxMulLinReg.RegressResult.Residuals,10,tmpVec1,tmpVec2,true);
    DrawValues(tmpVec2,tmpVec1,Chart1.Series[0]);
  end
  else if (AIndex = firstchartindex+1) then
  begin
    { setup chart title and axes }
    Chart1.Title.Text.Clear;
    Chart1.AddSeries(TStatProbSeries.Create(Self));
    Chart1.Series[0].SeriesColor := clBlue;
    TStatProbSeries(Chart1.Series[0]).Pointer.Style := psCircle;
    Chart1.Title.Text.Add('Residuals normal probability plot');
    Chart1.LeftAxis.Title.Caption := 'Expected normals';
    Chart1.LeftAxis.Automatic := true;
    Chart1.BottomAxis.Title.Caption := 'Residuals';
    StatNormalPlot(MtxMulLinReg.RegressResult.Residuals,tmpVec1,tmpVec2,MinX,MaxX,MinY,MaxY,nil,False);
    TStatProbSeries(Chart1.Series[0]).MinX:= MinX;
    TStatProbSeries(Chart1.Series[0]).MaxX:= MaxX;
    TStatProbSeries(Chart1.Series[0]).MinY:= MinY;
    TStatProbSeries(Chart1.Series[0]).MaxY:= MaxY;
    DrawValues(tmpVec1,tmpVec2,Chart1.Series[0]);
  end
  else if (AIndex = firstchartindex+2) then
  begin
    { setup chart title and axes }
    Chart1.Title.Text.Clear;
    Chart1.Title.Text.Add('Residuals Serial Correlation');
    Chart1.LeftAxis.Title.Caption := 'Residuals';
    Chart1.LeftAxis.Automatic := true;
    Chart1.BottomAxis.Title.Caption := 'Residuals Lagged Once';
    Chart1.AddSeries(TPointSeries.Create(Self));
    Chart1.Series[0].SeriesColor := clBlue;
    TPointSeries(Chart1.Series[0]).Pointer.Style := psCircle;
    TPointSeries(Chart1.Series[0]).Pointer.InflateMargins := true;
    With MtxMulLinReg.RegressResult do
    begin
      tmpVec1.Size(Residuals.Length -1, Residuals.FloatPrecision);
      tmpVec2.Size(Residuals.Length -1, Residuals.FloatPrecision);
      tmpVec1.Copy(Residuals,1,0,tmpVec1.Length);
      tmpVec2.Copy(Residuals,0,0,tmpVec2.Length);
      DrawValues(tmpVec2,tmpVec1,Chart1.Series[0]);
    end;
  end
  else if (AIndex = firstchartindex+3) then
  begin
    { setup chart title and axes }
    Chart1.Title.Text.Clear;
    Chart1.Title.Text.Add('Residuals versus predicted values');
    Chart1.LeftAxis.Title.Caption := 'Residuals';
    Chart1.BottomAxis.Title.Caption := 'Predicted';
    Chart1.LeftAxis.Automatic := true;
    { add point series }
    Chart1.AddSeries(TPointSeries.Create(Self));
    Chart1.Series[0].SeriesColor := clBlue;
    TPointSeries(Chart1.Series[0]).Pointer.Style := psCircle;
    TPointSeries(Chart1.Series[0]).Pointer.InflateMargins := true;
    With MtxMulLinReg.RegressResult do
      DrawValues(YCalc,Residuals,Chart1.Series[0]);
  end;
end;

procedure TfrmMulLinRegWiz.FormCreate(Sender: TObject);
begin
  inherited;
  MtxAnova := TMtxAnova.Create(Self);
  MtxMulLinReg := TMtxMulLinReg.Create(Self);
  tmpMtx := TMtx.Create;
  tmpVec := TVec.Create;
  chartindex := firstchartindex;
end;

procedure TfrmMulLinRegWiz.BitBtnAClick(Sender: TObject);
begin
  if Sender = BitBtnA then
  begin
    ViewValues(MtxMulLinReg.A,'Independent variables',true,true);
    Edit1.Text := IntToStr(MtxMulLinReg.A.Rows);
    Edit2.Text := IntToStr(MtxMulLinReg.A.Cols);
    MtxMulLinReg.Y.Length := MtxMulLinReg.A.Rows;
    MtxMulLinReg.Weights.Length := MtxMulLinReg.A.Rows;
  end
  else if Sender = BitBtnY then ViewValues(MtxMulLinReg.Y,'Dependent variable',true,true)
  else if Sender = BitBtnW then ViewValues(MtxMulLinReg.Weights,'Weights',true,true);
  RefreshWizardControls;
end;

procedure TfrmMulLinRegWiz.ChkBoxUseWeightsClick(Sender: TObject);
begin
  MtxMulLinReg.UseWeights := ChkBoxUseWeights.Checked;
  RefreshWizardControls;
end;

procedure TfrmMulLinRegWiz.ChkBoxRemoveIntClick(Sender: TObject);
begin
  MtxMulLinReg.Constant := Not (ChkBoxRemoveInt.Checked);
  RefreshWizardControls;
end;

procedure TfrmMulLinRegWiz.FormDestroy(Sender: TObject);
begin
  MtxAnova.Free;
  MtxMulLinReg.Free;
  tmpMtx.Destroy;
  tmpVec.Destroy;
  inherited;
end;

procedure TfrmMulLinRegWiz.Edit4Change(Sender: TObject);
begin
  FormatString := Edit4.Text;
  try
    FormatFloat(FormatString,1.22);  { dummy test }
  except
  end;
end;

procedure TfrmMulLinRegWiz.Edit1Change(Sender: TObject);
var i : Integer;
begin
  try
    i := StrToInt(TEdit(Sender).Text);
    if Sender = Edit1 then
    begin
      MtxMulLinReg.A.Rows := i;
      MtxMulLinReg.Y.Length := i;
      MtxMulLinReg.Weights.Length := i;
    end
    else if Sender = Edit2 then MtxMulLinReg.A.Cols := i;
  except
  end;
  RefreshWizardControls;
end;

procedure TfrmMulLinRegWiz.Edit3Change(Sender: TObject);
begin
  try
    MtxMulLinReg.Alpha := StrToFloat(Edit3.Text);
  except
  end;
end;

procedure TfrmMulLinRegWiz.FormShow(Sender: TObject);
begin
  inherited;
  { initialize page }
  PageControl.ActivePage := tsInputData;
  Edit1.Text := IntToStr(MtxMulLinReg.A.Rows);
  Edit2.Text := IntToStr(MtxMulLinReg.A.Cols);
  Edit3.Text := FormatFloat('0.00',MtxMulLinReg.Alpha);
  Edit4.Text := FormatString;
  FormatString := Edit4.Text;
end;

procedure TfrmMulLinRegWiz.DoMoveForward;
begin
  if (PageControl.ActivePage = tsChart) and (chartindex<lastchartindex) then
  begin
    Inc(chartindex);
    moveforward := false;
  end else moveforward := true;

  inherited DoMoveForward;

  if (PageControl.ActivePage = tsTextReport) then
  begin
    MtxMulLinReg.Recalc;
    TextReport;
  end
  else if (PageControl.ActivePage = tsChart) then ChartReport(chartindex);
end;

procedure TfrmMulLinRegWiz.DoMoveBack;
begin
  if (PageControl.ActivePage = tsChart) and (chartindex>firstchartindex) then
  begin
    Dec(chartindex);
    ChartReport(chartindex);
    moveback := false;
  end else moveback := true;

  inherited DoMoveBack;
end;

procedure TfrmMulLinRegWiz.RefreshWizardControls;
begin
  inherited;
  if PageControl.ActivePage = tsInputData then btnNext.Enabled := MtxMulLinReg.ValidSystem
  else if PageControl.ActivePage = tsChart then btnNext.Enabled := chartindex < lastchartindex;
end;

end.

unit QC_CP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_Form, TeEngine, TeeTools, Series, TeeProcs, Chart, StdCtrls,
  ExtCtrls, MtxVec, StatChar, Math387, Statistics;

type
  TfrmQCCP = class(TfrmBasic)
    Chart1: TChart;
    ChartTool1: TColorLineTool;
    ChartTool2: TColorLineTool;
    Series1: THistogramSeries;
    Panel2: TPanel;
    Label2: TLabel;
    Edit1: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Series2: TLineSeries;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ChartTool1EndDragLine(Sender: TColorLineTool);
    procedure ChartTool2EndDragLine(Sender: TColorLineTool);
    procedure Edit1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
    Data: TVec;
    p, CP, CPK, Alpha: double;
    CPConfInt, CPKConfInt: TTwoElmReal;
    procedure Recalculate;
  public
    { Public declarations }
  end;

var
  frmQCCP: TfrmQCCP;

implementation

Uses Probabilities, MtxVecTee, StatControlCharts;
{$R *.DFM}

procedure TfrmQCCP.FormCreate(Sender: TObject);
var tmpMtx: TMtx;
    X, XDense, Bell,Y : TVec;
    Mean, StdDev: double;
begin
  inherited;
  with Series1.GetVertAxis do
  begin
    AutomaticMinimum := false;
    Minimum := 0.0;
  end;
  Alpha := 0.05;
  Edit1.Text := FormatFloat('0.000',Alpha);
  With Memo1.Lines do
  begin
    Clear;
    Add('CP and CPK charts');
    Add('By using new TeeChart v5 TColorLineTool you can easily' +
        ' do Process Capability Charts. Try dragging upper and ' +
        ' lower control limit (red lines) - p, CP and CPK coefficients '+
        ' and their confidence intervals (CI) are recalculated automatically.');
  end;
  Data := TVec.Create;
  tmpMtx := TMtx.Create;
  X := TVec.Create;
  XDense := TVec.Create;
  Y := TVec.Create;
  Bell := TVec.Create;
  try
    { load prepared data }
    try
      tmpMtx.LoadFromFile('QC_XR.mtx');
      Data.Copy(tmpMtx);
      Histogram(Data,10,Y,X,true);
       // get values for Bell curve
      Mean := Data.Mean;
      StdDev := Data.StdDev(Mean);
      // 200 calc points
      XDense.Length := 500;
      XDense.Ramp(0.0,(X.Max-0.0)*0.005);
      NormalPDF(XDense,Mean,StdDev,Bell);
      With Series1.GetHorizAxis do
      begin
        Automatic := false;
        SetMinMax(Data.Min - 10, Data.Max + 10);
      end;
      DrawValues(X,Y,Series1,false);
      DrawValues(XDense,Bell,Series2,false);
      ChartTool1.Value := X.Min + 1;
      ChartTool2.Value := X.Max - 1;
      Recalculate;
    finally
      tmpMtx.Destroy;
      X.Destroy;
      XDense.Destroy;
      Bell.Destroy;
      Y.Destroy;
    end;
  except
  end;
end;

procedure TfrmQCCP.FormDestroy(Sender: TObject);
begin
  Data.Destroy;
  inherited;
end;

procedure TfrmQCCP.Recalculate;
var LB, UB: double;
begin
  LB := ChartTool1.Value;
  UB := ChartTool2.Value;
  QCCapIndexes(Data,LB,UB,p,CP,CPK,CPConfInt,CPKConfInt, Alpha);
  Label1.Caption := 'p = ' + FormatFloat('0.0000',p);
  Label3.Caption := 'CP = ' + FormatFloat('0.0000',CP);
  Label4.Caption := 'CP CI = [' + FormatFloat('0.0000',CPConfInt[0])+' ; '+
                    FormatFloat('0.0000',CPConfInt[1])+']';
  Label5.Caption := 'CPK = ' + FormatFloat('0.0000',CPK);
  Label6.Caption := 'CPK CI = [' + FormatFloat('0.0000',CPKConfInt[0])+' ; '+
                    FormatFloat('0.0000',CPKConfInt[1])+']';
end;

procedure TfrmQCCP.ChartTool1EndDragLine(Sender: TColorLineTool);
begin
  If ChartTool1.Value >= ChartTool2.Value then ChartTool1.Value := ChartTool2.Value - EPS;
  Recalculate;
end;

procedure TfrmQCCP.ChartTool2EndDragLine(Sender: TColorLineTool);
begin
  If ChartTool2.Value <= ChartTool1.Value then ChartTool2.Value := ChartTool1.Value + EPS;
  Recalculate;
end;

procedure TfrmQCCP.Edit1Change(Sender: TObject);
begin
  if Showing then
  begin
    Alpha := StrToFloat(Edit1.Text);
    Recalculate;
  end

end;

procedure TfrmQCCP.CheckBox1Click(Sender: TObject);
begin
  Series2.Active := CheckBox1.Checked;
end;

initialization
  RegisterClass(TfrmQCCP);

end.

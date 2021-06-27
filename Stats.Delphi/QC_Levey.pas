unit QC_Levey;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Basic_Chart, StdCtrls, TeeProcs, TeEngine, Chart, ExtCtrls,
  MtxVec, MtxVecTee, StatControlCharts, Series, Math387, TeeTools,
  VclTee.TeeGDIPlus;

type
  {$I bdsppdefs.inc}

  TfrmLevey = class(TfrmBasicChart)
    Series1: TLineSeries;
    CheckBoxMean: TCheckBox;
    CheckBoxSigma: TCheckBox;
    Button2: TButton;
    function Series1GetPointerStyle(Sender: TChartSeries;
      ValueIndex: Integer): TSeriesPointerStyle;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Series1GetMarkText(Sender: TChartSeries; ValueIndex: Integer;
      var MarkText: String);
    procedure Chart1AfterDraw(Sender: TObject);
    procedure CheckBoxMeanClick(Sender: TObject);
    procedure CheckBoxSigmaClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    data: TVec;
    outcont: TVec;
    m,s: double;
    procedure Recalc;
  public
    { Public declarations }
  end;

var
  frmLevey: TfrmLevey;

implementation

{$R *.dfm}

Uses MtxVecEdit, AbstractMtxVec
     {$IFDEF D16}
     ,UITypes
     {$ENDIF}
     ,Types
    ;

// Transform error byte value back to readable format
function EncodeRules(mask: Byte): String;
begin
  Result := '';
  if ((mask and 1) = 1) then Result := Result + '1S3'+#13;
  if ((mask and 2) = 2) then Result := Result + '1S2'+#13;
  if ((mask and 4) = 4) then Result := Result + '2S2'+#13;
  if ((mask and 8) = 8) then Result := Result + 'RS4'+#13;
  if ((mask and 16) = 16) then Result := Result + '41S'+#13;
  if ((mask and 32) = 32) then Result := Result + '10X';
end;

function TfrmLevey.Series1GetPointerStyle(Sender: TChartSeries;
  ValueIndex: Integer): TSeriesPointerStyle;
begin
  if outcont[ValueIndex]> 0 then Result := psCross else Result := psDownTriangle;
end;

procedure TfrmLevey.FormCreate(Sender: TObject);
begin
  inherited;
  With Memo1.Lines do
  begin
    Clear;
    Add('The Levey-Jennings control chart is a special case of the common X-bar (variables) chart in which '
      + 'there is only a single stream of data and sigma is estimated using the standard deviation of those data.');
    Add('Individual values are tested to determine if they are in, or out, of control using a set of five rules '
      + 'called the Westgard rules. They are specified in Westgard et al. (1981). These rules indicate which rows '
      + 'in a variable are out-of-control.');
    Add('');
    Add('Check http://www.westgard.com/mltirule.htm to learn more about Westgard rules and how to interpret them.');
  end;

  data := TVec.Create;
  outcont := TVec.Create;

  data.SetIt([248, 250, 255, 243, 254, 260, 251, 261, 253, 244,
    257 ,254, 239, 236, 250, 259, 260, 262, 263, 254, 241 ,255 ,250,
    256, 247, 242, 256, 246]);
  Recalc;
end;

procedure TfrmLevey.FormDestroy(Sender: TObject);
begin
  Data.Destroy;
  outcont.Destroy;
  inherited;
end;

procedure TfrmLevey.Series1GetMarkText(Sender: TChartSeries;
  ValueIndex: Integer; var MarkText: String);
begin
  MarkText := EncodeRules(Trunc(outcont[ValueIndex]));
end;

procedure TfrmLevey.Chart1AfterDraw(Sender: TObject);
var ypos: Integer;
begin
  inherited;
  Chart1.Canvas.ClipRectangle(Chart1.ChartRect);
  if CheckBoxMean.Checked then
  begin
    ypos := Chart1.Axes.Left.CalcPosValue(m);
    Chart1.Canvas.Pen.Width := 1;
    Chart1.Canvas.Pen.Style := psDot;
    Chart1.Canvas.Pen.Color := Series1.Color;
    Chart1.Canvas.Line(Chart1.ChartRect.Left,ypos,Chart1.ChartRect.Right,ypos);
    Chart1.Canvas.Font.Color := Series1.Color;
    Chart1.Canvas.TextOut(Chart1.ChartRect.Left+10,ypos,'mean');
  end;
  if CheckBoxSigma.Checked then
  begin
    Chart1.Canvas.Pen.Width := 1;
    Chart1.Canvas.Pen.Style := psDashDot;
    // 1 sigma lines
    Chart1.Canvas.Pen.Color := clGreen;
    ypos := Chart1.Axes.Left.CalcPosValue(m+s);
    Chart1.Canvas.Line(Chart1.ChartRect.Left,ypos,Chart1.ChartRect.Right,ypos);
    Chart1.Canvas.Font.Color := Chart1.Canvas.Pen.Color;
    Chart1.Canvas.TextOut(Chart1.ChartRect.Left+10,ypos,'1-sigma');
    ypos := Chart1.Axes.Left.CalcPosValue(m-s);
    Chart1.Canvas.Line(Chart1.ChartRect.Left,ypos,Chart1.ChartRect.Right,ypos);
    // 2 sigma lines
    Chart1.Canvas.Pen.Color := clYellow;
    ypos := Chart1.Axes.Left.CalcPosValue(m+2*s);
    Chart1.Canvas.Line(Chart1.ChartRect.Left,ypos,Chart1.ChartRect.Right,ypos);
    Chart1.Canvas.Font.Color := Chart1.Canvas.Pen.Color;
    Chart1.Canvas.TextOut(Chart1.ChartRect.Left+10,ypos,'2-sigma');
    ypos := Chart1.Axes.Left.CalcPosValue(m-2*s);
    Chart1.Canvas.Line(Chart1.ChartRect.Left,ypos,Chart1.ChartRect.Right,ypos);
    // 3 sigma lines
    Chart1.Canvas.Pen.Color := clRed;
    ypos := Chart1.Axes.Left.CalcPosValue(m+3*s);
    Chart1.Canvas.Line(Chart1.ChartRect.Left,ypos,Chart1.ChartRect.Right,ypos);
    Chart1.Canvas.Font.Color := Chart1.Canvas.Pen.Color;
    Chart1.Canvas.TextOut(Chart1.ChartRect.Left+10,ypos,'3-sigma');
    ypos := Chart1.Axes.Left.CalcPosValue(m-3*s);
    Chart1.Canvas.Line(Chart1.ChartRect.Left,ypos,Chart1.ChartRect.Right,ypos);
  end;
  Chart1.Canvas.UnClipRectangle;
end;

procedure TfrmLevey.CheckBoxMeanClick(Sender: TObject);
begin
  Chart1.Repaint;
end;

procedure TfrmLevey.CheckBoxSigmaClick(Sender: TObject);
begin
  Chart1.Repaint;
end;

procedure TfrmLevey.Button2Click(Sender: TObject);
begin
  ViewValues(data,'Process values',true,false,true);
  Recalc;
end;

procedure TfrmLevey.Recalc;
begin
  m := Data.Mean;
  s := Data.StdDev;
  QCWestgardRules(data,outcont,m,s);
  DrawValues(Data,Series1,0,1);
end;

initialization
  RegisterClass(TfrmLevey);

end.

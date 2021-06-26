unit MtxFastLineDemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Basic1, TeeProcs, TeEngine, Chart, StdCtrls, ComCtrls, ExtCtrls,
  MtxExpr, MtxVecTee, Series, MtxComCtrls;

type
  TMtxFastLineForm = class(TBasicForm1)
    Timer1: TTimer;
    MtxFloatEdit: TMtxFloatEdit;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure MtxFloatEditChange(Sender: TObject);
  private
    { Private declarations }
    normalFast: TChartSeries;
    mtxFast: TChartSeries;
    Data: Vector;
  public
    { Public declarations }
  end;

var
  MtxFastLineForm: TMtxFastLineForm;

implementation

uses MtxVec;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TMtxFastLineForm.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    Add('New TMtxFastLinesSeires draws 3x faster than TFastLineSeries.');
    Add('Allows zoom-in and zoom-out with pixeldownsamle enabled.');
    Add('TMtxFastLineSeries can be used '
      + 'with all TeeChart versions (v4 Standard, v4 Pro, 5,6,7 and 8). ');
    Add('');
    Add('Try different data sizes and zooming and panning in the chart.');        
  end;

  Chart1.FreeAllSeries(nil);
  normalfast := Chart1.AddSeries(TFastLineSeries.Create(Chart1));
  normalfast.Title := 'TFastlineSeries';

  mtxfast := Chart1.AddSeries(TMtxFastLineSeries.Create(Chart1));
  mtxfast.Title := 'TMTxFastLineSeries';

  MtxFloatEditChange(nil);
end;

procedure TMtxFastLineForm.MtxFloatEditChange(Sender: TObject);
begin
  chart1.Zoom.Allow := True;
  Data.Size(MtxFloatEdit.IntPosition);
  Data.RandGauss(4.0,1.0);

  Screen.Cursor := crHourGlass;
  TimeCheck := GetTickCount;
  try
    DrawValues(Data,mtxfast,0,1,false);
  finally
    TimeElapsed := GetTickCount - TimeCheck;
    Screen.Cursor := crDefault;
  end;

  Screen.Cursor := crHourGlass;
  TimeCheck := GetTickCount;
  try
    DrawValues(Data,normalfast,0,1,CheckDownSample.Checked);
  finally
    TimeElapsed := GetTickCount - TimeCheck;
    Screen.Cursor := crDefault;
  end;
end;

initialization
  RegisterClass(TMtxFastLineForm);

end.

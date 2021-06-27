unit MedianDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, MtxBaseComp,Series, StdCtrls, TeeTools,
  MtxDialogs, SignalUtils, MtxComCtrls, TeeGDIPlus;

type
  TMedianDemoForm = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ChartEditButton: TToolButton;
    ChartEditor: TChartEditor;
    RichEdit1: TRichEdit;
    Panel2: TPanel;
    Splitter1: TSplitter;
    SignalChart1: TSignalChart;
    Series3: TFastLineSeries;
    Series1: TFastLineSeries;
    FilterBox: TComboBox;
    Label1: TLabel;
    StepEdit: TMtxFloatEdit;
    Label2: TLabel;
    procedure ChartEditButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FilterBoxChange(Sender: TObject);
    procedure StepEditChange(Sender: TObject);
  private
    State: TMedianState;
    DelayState: TDelayFilterState;
    procedure UpdateDelay;
    procedure UpdateMedian;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MedianDemoForm: TMedianDemoForm;

implementation

uses Math387, MtxVec, MtxVecTee, MtxVecInt;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TMedianDemoForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TMedianDemoForm.FormCreate(Sender: TObject);
begin
    SignalChart1.Legend.Visible := True; 
    FilterBox.ItemIndex := 0; 
    FilterBoxChange(Sender);
    With RichEdit1.Lines, RichEdit1 do
    begin
      Clear;
      Add('The chart shows a ramp filtered through a median or an integer delay filter. ' +
          'Median and delay filter are both streaming filters. The size of the block ' +
          'is set to 10 and the mask size can be varied. Change the mask size to test both ' +
          'filters. If the filter work Ok, increasing the mask size will shift the ramp to the right.');
    end;
end;

type TFilterSpecs = packed record
      	pFilterSpec: PApointer;
      	pDelay: PDouble;
      	pBuffer: PDouble;
      	MaskSize: integer;
    end;

    PFilterSpecs = ^TFilterSpecs;

{$POINTERMATH ON}

procedure TMedianDemoForm.UpdateMedian;
var a,b: TVec;
    i,BlockLength, MaskSize: integer;
    arr: array of double;
begin
    CreateIt(a,b);
    MaskSize := StepEdit.IntPosition;

    MedianInit(MaskSize,State, a.FloatPrecision);
    try
         a.Size(1000,false);
         b.Size(a);
         a.Ramp;

         BlockLength := 10;
         SetLength(arr, MaskSize-1);
         for i := 0 to (a.Length div BlockLength) - 1 do
         begin
             a.SetSubRange(i*BlockLength,BlockLength);
             b.SetSubRange(i*BlockLength,BlockLength);
             MedianFilter(a,b,State);
         end;
         a.SetFullRange;
         b.SetFullRange;
         DrawValues(a,SignalChart1.Series[0]);
         DrawValues(b,SignalChart1.Series[1]);
    finally
         MedianFree(State);
         FreeIt(a,b);
    end;
end;

procedure TMedianDemoForm.UpdateDelay;
var a,b: TVec;
    i,BlockLength, DelayLength: integer;
begin
    CreateIt(a,b);
    DelayLength := StepEdit.IntPosition;
    DelayInit(DelayLength,DelayState, a.FloatPrecision);
    try
         a.Size(1000,false);
         b.Size(a);
         a.Ramp;
         BlockLength := 10;  //try with n >  mask size
         for i := 0 to (a.Length div BlockLength) - 1 do
         begin
             a.SetSubRange(i*BlockLength,BlockLength);
             b.SetSubRange(i*BlockLength,BlockLength);
             DelayFilter(a, b, DelayState);
         end;
         a.SetFullRange;
         b.SetFullRange;
         DrawValues(a,SignalChart1.Series[0]);
         DrawValues(b,SignalChart1.Series[1]);
    finally
         DelayFree(DelayState);
         FreeIt(a,b);
    end;
end;

procedure TMedianDemoForm.FilterBoxChange(Sender: TObject);
begin
     case FilterBox.ItemIndex of
     0: UpdateMedian;
     1: UpdateDelay;
     end;
end;

procedure TMedianDemoForm.StepEditChange(Sender: TObject);
begin
     FilterBoxChange(Sender);
end;

initialization
RegisterClass(TMedianDemoForm);

end.

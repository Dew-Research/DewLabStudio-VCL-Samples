unit PixelDownS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic2, StdCtrls, ExtCtrls, TeeProcs, TeEngine, Chart,
  MtxVec, Math387, MtxVecEdit, Series, ComCtrls, Buttons, MtxExpr;

type
  TDownS = class(TBasicForm2)
    Chart1: TChart;                           
    Chart2: TChart;
    Series1: TFastLineSeries;
    Series2: TFastLineSeries;
    Label1: TLabel;               
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    TrackBar1: TTrackBar;
    Label5: TLabel;
    Label6: TLabel;
    Button1: TBitBtn;                                                    
    DrawNormalButton: TSpeedButton;
    DrawFastButton: TSpeedButton;
    procedure DrawFastButtonClick(Sender: TObject);
    procedure DrawNormalButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    TestVec : Vector;
    NumPoints : Integer;
    procedure FillRandomPoints;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DownS: TDownS;

implementation
{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

Uses MtxVecTee;


procedure TDownS.FillRandomPoints;
begin
    if NumPoints = TestVec.Length then
    begin
         TestVec := TestVec + 10000;
    end;
    TestVec.Size(NumPoints);
    TestVec.RandUniform(-500,500);
    TestVec.CumSum;
end;

procedure TDownS.FormResize(Sender: TObject);
begin
  Chart1.Height := Panel3.Height div 2;
end;

procedure TDownS.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines do
  begin
    Add('The PixelDownSample method can be used to speed '
      + 'up the drawing of huge amounts of data (>> 1 milion points) '
      + 'samples). The routine will reduce the number of '
      + 'points in vectors Y and X in such a way that there '
      + 'will be virtualy no visual difference between the original '
      + 'and downsampled data. That however will no longer be '
      + 'true, if you will zoom-in on the data.');
    Add('The performance gain can be as big as 500x depending '
      + 'on the charting tool that you use, CPU and number '
      + 'of points that will be drawn. You can easily '
      + 'draw data series from vectors with length of over 10 milion '
      + 'points in real time taking only a percent or so of your '
      + 'CPU. Try changing the "Number of points" '
      + 'and compare the visual appearance of both charts.');
  end;

  TrackBar1Change(TrackBar1);
end;

procedure TDownS.Button1Click(Sender: TObject);
begin
  TestVec.length := 0;
  FillRandomPoints;
  { "regular" plotting }
  Screen.Cursor := crHourGlass;
  TimeCheck := GetTickCount;
  with Chart1.BottomAxis do
  begin
       Automatic := false;
       SetMinMax(0,TestVec.Length);
  end;
  Series1.Clear;
  DrawValues(TestVec,Series1,0,1.0,False);
  TimeElapsed := GetTickCount - TimeCheck;
  Label3.Caption := SampleToStr(TimeElapsed)+' ms';

  { "optimized" plotting }
  TimeCheck := GetTickCount;
  with Chart2.BottomAxis do
  begin
       Automatic := false;
       SetMinMax(0,TestVec.Length-1);
  end;
  Series2.Clear;
  DrawValues(TestVec,Series2,0,1.0,True);
  TimeElapsed := GetTickCount - TimeCheck;
  Label4.Caption := SampleToStr(TimeElapsed)+' ms';
  Screen.Cursor := crDefault;
end;

procedure TDownS.TrackBar1Change(Sender: TObject);
begin
  NumPoints := TTrackBar(Sender).Position;
  Label6.Caption := IntToStr(NumPoints);
end;

procedure TDownS.DrawNormalButtonClick(Sender: TObject);
begin
  FillRandomPoints;
  Screen.Cursor := crHourGlass;

  TimeCheck := GetTickCount;
  with Chart1.BottomAxis do
  begin
       Automatic := false;
       SetMinMax(0,TestVec.Length);
  end;
  Series1.Clear;
  DrawValues(TestVec,Series1,0,1.0,False);
  TimeElapsed := GetTickCount - TimeCheck;
  Label3.Caption := SampleToStr(TimeElapsed)+' ms';

  Screen.Cursor := crDefault;
end;

procedure TDownS.DrawFastButtonClick(Sender: TObject);
begin
  FillRandomPoints;
  Screen.Cursor := crHourGlass;

  TimeCheck := GetTickCount;
  with Chart2.BottomAxis do
  begin
       Automatic := false;
       SetMinMax(0,TestVec.Length-1);
  end;
  Series2.Clear;
  DrawValues(TestVec,Series2,0,1.0,True);
  TimeElapsed := GetTickCount - TimeCheck;
  Label4.Caption := SampleToStr(TimeElapsed)+' ms';

  Screen.Cursor := crDefault;
end;

initialization
   RegisterClass(TDownS);

end.

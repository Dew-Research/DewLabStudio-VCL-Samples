unit Interp1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Types,
  Basic1, TeeProcs, TeEngine, Chart, StdCtrls, ExtCtrls, Series, Polynoms,
  ComCtrls, MtxVec, Math387, MtxVecEdit, MtxVecTee, MtxExpr;

type
  TInterpolating1 = class(TBasicForm1)
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    TrackBar1: TTrackBar;                                               
    StaticText2: TStaticText;
    Label4: TLabel;
    TrackBar2: TTrackBar;                         
    StaticText3: TStaticText;
    Button1: TButton;
    Label5: TLabel;                                       
    Series2: TFastLineSeries;
    Series1: TPointSeries;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    intMethod : TInterpolationType;
    NumPoints, Factor : Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Interpolating1: TInterpolating1;

implementation

uses AbstractMtxVec, MtxVecBase;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TInterpolating1.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    Add('Polynoms unit introduces a very powerful method for '
      + 'interpolation. You can perform linear or cubic interpolation '
      + '(using cubic splines). Everyhting gets done by calling just '
      + 'one  procedure:');
    Add('');
    SelAttributes.Name := 'Courier New';
    Add('Interpolate(FunValues,intX,intY,interpolationMethod);');
    Add('');
    Add('Try changing the number of data points, number of '
      + 'interpolated points and interpolation method. The '
      + '"DownSample" checkbox will use the PixelDownSample '
      + 'method to reduce the number of points to be displayed '
      + '(BIG speed-up if you are charting interpolated values).');
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('Parameters in this demo :');
    Add('Interpolation:'+#9+'interpolation method used (linear, cubic)');
    Add('DataPoints:'+#9+'number of data points');
    Add('Factor:'+#9+#9+'number of interpolated points between two data points');
    Add('Time needed:'+#9+'time in miliseconds, needed to construct and evaluate (but not draw) piece-wise polynomial');
  end;
  ComboBox1.ItemIndex := 1;
  ComboBox1Change(ComboBox1);
  TrackBar1Change(TrackBar1);
  TrackBar2Change(TrackBar2);
  CheckDownSampleClick(CheckDownSample);
end;

procedure TInterpolating1.ComboBox1Change(Sender: TObject);
begin
     case TComboBox(Sender).ItemIndex of
     0: intMethod := intLinear;
     1: intMethod := intCubic;
     end;
end;

procedure TInterpolating1.TrackBar1Change(Sender: TObject);
begin
     NumPoints := TTrackBar(Sender).Position;
     StaticText2.Caption := IntToStr(NumPoints);
end;

procedure TInterpolating1.TrackBar2Change(Sender: TObject);
begin
     Factor := TTrackBar(Sender).Position;
     StaticText3.Caption := IntToStr(Factor);
end;

procedure TInterpolating1.Button1Click(Sender: TObject);
var    X,Y       : Vector;
       pX,pY     : Vector;
       i         : Integer;
begin
    Chart1.LeftAxis.Automatic := true;
    Chart1.BottomAxis.Automatic := true;
    X.Size(NumPoints);
    Y.Size(NumPoints);
    {$IFDEF CLR}
    pY := Vector.Create(false);
    {$ENDIF}
    Screen.Cursor := crHourGlass;
    Randomize;
    X.Ramp;
    y[0] := 1000;
    for i:=1 to X.Length-1 do
    begin
        Y.Values[i]:= Y.Values[i-1] + 250 - random(500);
    end;
    DrawValues(Y,Series1,0,1,DownSize);
    { calculate piecewise poly for the range of points }
    TimeCheck:=GetTickCount;
    PX.Size(NumPoints*Factor);
    PX.Ramp(0,1.0/Factor);
    Interpolate(Y,PX,PY,intMethod,true); { !! Check what happens if you have only Y }
    TimeElapsed := GetTickCount - TimeCheck;
    Label5.Caption:='Solved in '+IntToStr(TimeElapsed)+' ms';
    DrawValues(pY,Series2,0,1.0/Factor, DownSize);
    Screen.Cursor := crDefault;
end;

initialization
   RegisterClass(TInterpolating1);

end.

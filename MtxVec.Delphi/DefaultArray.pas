unit DefaultArray;

{$I BdsppDefs.inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic2, StdCtrls, ExtCtrls, MtxVec, Math387, ComCtrls, TeEngine, Series,
  TeeProcs, Chart, Buttons, MtxExpr;

type
  TDefArray = class(TBasicForm2)
    TrackBar1: TTrackBar;                                 
    Label1: TLabel;
    Label2: TLabel;
    RadioGroup1: TRadioGroup;
    Button1: TBitBtn;
    Chart1: TChart;                                              
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    procedure FormCreate(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    TestVec : Vector;
    TestMtx : Matrix;
    Len     : Integer;
    function CumulativeSum(A: TVec): TSample; overload;
    function CumulativeSum(A: TMtx): TSample; overload;
    function CumulativeSumFast1(A: TVec): TSample; overload;    
    function CumulativeSumFast(A: TVec): TSample;overload;
    procedure CumulativeSumFast(A: TMtx);overload;
    procedure CumulativeSumFast1(A: TMtx); overload;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DefArray: TDefArray;

implementation

uses AbstractMtxVec, Types, MtxVecBase;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

function TDefArray.CumulativeSumFast(A: TVec): TSample;
var i : Integer;
begin
     {$IFDEF TTDOUBLE}
     for i := 0 to A.Length - 1 do
        A.Values[i] := A.Values[i] + A.Values[i];
     {$ELSE}
     for i := 0 to A.Length - 1 do
        A.SValues[i] := A.SValues[i] + A.SValues[i];
     {$ENDIF}
     Result := A[0];
end;

function TDefArray.CumulativeSumFast1(A: TVec): TSample;
var i : Integer;
    a1 : TSampleArray;
begin
     Enlist(A,a1);
     for i := 0 to A.Length - 1  do
     begin
          a1[i] := a1[i] + a1[i];
     end;
     Result := a1[0];

     DismissIt(a,a1);
end;                             

function TDefArray.CumulativeSum(A: TVec): TSample;
var i : Integer;
begin
     for i := 0 to A.Length - 1 do
     begin
          A[i] := A[i] + A[i];
     end;
     Result := A[0];
end;

function TDefArray.CumulativeSum(A: TMtx): TSample;
var i,j : Integer;
begin
     for i := 0 to A.Rows-1 do
        for j := 0 to A.Cols-1 do
        begin
            A[i,j] := A[i,j] + A[i,j];
        end;
     Result := A[0,0];
end;

procedure TDefArray.CumulativeSumFast1(A: TMtx);
var i,j : Integer;
    a1  : T2DDoubleArray;
    sa1  : T2DSingleArray;
begin
     if a.IsDouble then
     begin
         Enlist(A,a1);

         for i := 0 to A.Rows-1 do
            for j := 0 to A.Cols-1 do
                a1[i,j] := a1[i,j] + a1[i,j];

         DismissIt(A,a1);
     end else
     begin
         Enlist(A, sa1);

         for i := 0 to A.Rows-1 do
            for j := 0 to A.Cols-1 do
                sa1[i,j] := sa1[i,j] + sa1[i,j];

         DismissIt(A, sa1);
     end;
end;

procedure TDefArray.CumulativeSumFast(A: TMtx);
var i,j  : Integer;
    k, Cols  : Integer;
begin
     Cols := A.Cols;
     {$IFDEF TTDOUBLE}
     for i := 0 to A.Rows-1 do
        for j := 0 to A.Cols-1 do
        begin
            k := i*Cols+j;
            A.Values1D[k] := A.Values1D[k] + A.Values1D[k];
        end;
     {$ELSE}
     for i := 0 to A.Rows-1 do
        for j := 0 to A.Cols-1 do
        begin
            k := i*Cols+j;
            A.SValues1D[k] := A.SValues1D[k] + A.SValues1D[k];
        end;
     {$ENDIF}
end;


procedure TDefArray.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1 do
  begin
    Lines.Clear;
    Lines.Add('There are three different ways on how to'
                      + ' access the elements of an array. '
                      + ' (vector or matrix). All access methods '+
                      '  work on the same block of memory.');

    Lines.Add('');
    Lines.Add('(*) Default arrays give you clear syntax, '
                      + 'but are not as fast:');
    SelAttributes.Name := 'Courier New';
    Lines.Add('a[i,j] := 1; {where "a" is TMtx object}');
    Lines.Add('');
    Lines.Add('(*) Dynamic array pointer is a bit faster than '
            + ' default array.');
    SelAttributes.Name := 'Courier New';
    Lines.Add('a.Values[i,j] := 3.5; {where "a" is TMtx object}');
    Lines.Add('');
    Lines.Add('(*) One dimensional array (TMtx object only) allows '
            + 'you to work with the matrix as you would with one '
            + 'dimensional array:');
    SelAttributes.Name := 'Courier New';
    Lines.Add('a.Values1D[i*Cols+j]:= 2.3; {where "a" is TMtx object}');
  end;
  RadioGroup1Click(RadioGroup1);
  TrackBar1Change(TrackBar1);
end;

procedure TDefArray.TrackBar1Change(Sender: TObject);
begin
  Len := TTrackBar(Sender).Position;
  Label1.Caption := IntToStr(Len);
end;

procedure TDefArray.Button1Click(Sender: TObject);
var i : Integer;
    j : Integer;
    MaxIter : Integer;
begin
  { setup TestVec }
  Series1.Clear;
  Series2.Clear;
  Series3.Clear;
  Screen.Cursor := crHourGlass;
  Series1.Title := 'Values property';
  Series2.Title := 'Values array field';
  Series3.Title := 'array of double';    
  if RadioGroup1.ItemIndex = 0 then { test vector }
  begin
    j := 1;
    MaxIter := 10;
    if Len < 5000 then MaxIter := 500;
    if Len < 2000 then MaxIter := 1000;
    if Len < 500 then MaxIter := 6000;
    if Len < 100 then MaxIter := 30000;
    while j < Len do
    begin
      TestVec.Size(j);

      { default arrays }
      TestVec.SetZero;
      StartTimer;
      for i := 1 to MaxIter do CumulativeSum(TestVec);
      Series1.AddXY(j,StopTimer*1000,'',clTeeColor);


      { TSampleArray }
      TestVec.SetZero;
      StartTimer;
      for i := 1 to MaxIter do CumulativeSumFast(TestVec);
      Series2.AddXY(j,StopTimer*1000,'',clTeeColor);

     { TSampleArray Enlist}
      TestVec.SetZero;
      StartTimer;
      for i := 1 to MaxIter do CumulativeSumFast1(TestVec);
      Series3.AddXY(j,StopTimer*1000,'',clTeeColor);


      if j < 10 then j := j +2
      else if J < 100 then j := j + 10
      else if j < 500 then j := j + 50
      else if j < 1000 then j := j + 100
      else if j < 3000 then j := j + 250
      else j := j + 1000;
    end
  end else
  begin
    j := 5;
    MaxIter := 1;
    if Len < 70 then MaxIter := 150;
    if Len < 30 then MaxIter := 550;

    while j < Len do
    begin
      TestMtx.Size(j,j);

      { default arrays }
      TestMtx.SetZero;
      StartTimer;
      for i := 1 to MaxIter do CumulativeSum(TestMtx);
      Series1.AddXY(j,StopTimer*1000,'',clTeeColor);

      { TSampleArray fast}
      StartTimer;
      for i := 1 to MaxIter do CumulativeSumFast(TestMtx);
      TimeElapsed := StopTimer;
      Series2.AddXY(j,StopTimer*1000,'',clTeeColor);

      { TSampleArray ultra fast}
      StartTimer;
      for i := 1 to MaxIter do CumulativeSumFast1(TestMtx);
      TimeElapsed := StopTimer;
      Series3.AddXY(j,StopTimer*1000,'',clTeeColor);

      if j < 10 then j := j +2
      else if j < 50 then j := j + 5
      else if j < 100 then j := j + 10
      else if j < 200 then j := j + 15
      else j := j + 20;
    end;
  end;
  Chart1.LeftAxis.Title.Caption := 'time [ms] ('+IntToStr(MaxIter)+' iterations)';
  Screen.Cursor := crDefault;
end;

procedure TDefArray.RadioGroup1Click(Sender: TObject);
begin
  Case TRadioGroup(Sender).ItemIndex of
  0  : begin
            Label2.Caption := 'Vector length';
            TrackBar1.Max := 10000;
            TrackBar1.Frequency := 500;
       end;
  1  : begin
            Label2.Caption := 'Sqared matrix rows';
            TrackBar1.Max := 300;
            TrackBar1.Frequency := 10;
            TrackBar1.Position := 150;
       end;
  end;
  TrackBar1Change(TrackBar1);
end;

initialization
   RegisterClass(TDefArray);

end.

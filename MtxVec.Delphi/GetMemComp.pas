unit GetMemComp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic2, StdCtrls, ComCtrls, ExtCtrls, MtxVec,Math387, TeeProcs, TeEngine,
  Chart, Series, Buttons, MtxExpr;

type
  TGetMemC = class(TBasicForm2)
    TrackBar1: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TBitBtn;
    Chart1: TChart;                                       
    Series1: TLineSeries;
    Series2: TLineSeries;                               
    Series3: TLineSeries;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    vec1: Vector;
    wm1,wm2,wm3,wm4: PPSample;
    da1,da2,da3,da4: TSampleArray;
    Len : Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GetMemC: TGetMemC;

implementation

{$R *.DFM}

procedure TGetMemC.FormCreate(Sender: TObject);
var St: String;
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    Add('This example shows you how to use TVec SliceIt method. SliceIt method allows you '
      + 'to group four calls to GetMem/FreeMem (or dynamic array SetLength/nil )in to one. '
      + 'Normaly you would be calling GetMem(Aarray,Length*SizeOf(TSample)) four times, but '
      + 'with SliceIt, you will not be calling GetMem at all, because the vector might '
      + 'already have the memory available. Here is the code, used to allocate four AArrays :');
    Add('');
    SelAttributes.Name := 'Courier New';
    St := 'var     wm1,wm2,wm3,wm4: PSArray; {pointers to array of TSample}'+#13
      + '  Len : Integer;'+#13+'  Vec: TVec;'+#13
      + 'begin'+#13 +'  CreateIt(vec);'+#13+'  Len := 100; {number of elements per array}'+#13
      + '  vec.SliceIt(Len,Len,Len,Len,wm1,wm2,wm3,wm4);'+#13
      + '  FreeIt(vec);'+#13+'end;';
    Add(st);
    Add('');
    Add('Zoom in on a chart (left-click and drag mouse over the chart) to see more details.');
    Add('Be aware that behind all memory allocations is Delphi''s memory manager that  then '
      + 'interfaces Windows memory manager. Getting reliable measurement results reflecting '
      + 'reallity can be a tricky thing. Try several different memory sizes making big jumps '
      + 'and rerun each test several times.');
  end;

  vec1 := Vector.Create(false); //not from object cache
  Controller.SetVecCacheSize(1,8000); // 1 preloaded vector with 8000 elements allocated
  TrackBar1Change(TrackBar1);
end;

procedure TGetMemC.Button1Click(Sender: TObject);
var LenD4 : Integer;
    i     : Integer;
    j     : Integer;
begin
  { GetMem / FreeMem }
  j := 4;
  Series1.Clear;
  Series2.Clear;
  Series3.Clear;
  Screen.Cursor := crHourGlass;
  while j <= Len do
  begin
       LenD4 := j div 4;
       TimeCheck := GetTickCount;
       { GetMem/FreeMem }
       for i := 0 to 100000 do
       begin
            GetMem(wm1,LenD4*SizeOf(TSample));
            GetMem(wm2,LenD4*SizeOf(TSample));
            GetMem(wm3,LenD4*SizeOf(TSample));
            GetMem(wm4,LenD4*SizeOf(TSample));

            FreeMem(wm1,LenD4*SizeOf(TSample));
            FreeMem(wm2,LenD4*SizeOf(TSample));
            FreeMem(wm3,LenD4*SizeOf(TSample));
            FreeMem(wm4,LenD4*SizeOf(TSample));
       end;
       TimeElapsed := GetTickCount - TimeCheck;
       Series1.AddXY(j,TimeElapsed,'',clTeeColor);

       TimeCheck := GetTickCount;
       { Size / SliceIt }
       for i := 0 to 100000 do
       begin
            TVec(vec1).SliceIt(LenD4,LenD4,LenD4,LenD4,
               wm1,wm2,wm3,wm4);
       end;
       TimeElapsed := GetTickCount - TimeCheck;
       Series2.AddXY(j,TimeElapsed,'',clTeeColor);

       TimeCheck := GetTickCount;
       { SetLength  }
       for i := 0 to 100000 do
       begin
            SetLength(da1,LenD4);
            SetLength(da2,LenD4);
            SetLength(da3,LenD4);
            SetLength(da4,LenD4);
            da1 := nil;
            da2 := nil;
            da3 := nil;
            da4 := nil;
       end;
       TimeElapsed := GetTickCount - TimeCheck;
       Series3.AddXY(j,TimeElapsed,'',clTeeColor);

       j := j+40;
  end;
  Screen.Cursor := crDefault;
end;

procedure TGetMemC.TrackBar1Change(Sender: TObject);
begin
  Len := TTrackBar(Sender).Position;
  Label2.Caption := IntToStr(Len);
end;

procedure TGetMemC.FormDestroy(Sender: TObject);
begin
  Controller.SetVecCacheSize(32,1024);
  inherited;
end;

initialization
   RegisterClass(TGetMemC);

end.

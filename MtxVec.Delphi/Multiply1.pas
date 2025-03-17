unit Multiply1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  MtxVec, Math387, Basic2, StdCtrls, ExtCtrls, ComCtrls, TeEngine, Series,
  TeeProcs, Chart, MtxComCtrls;
                                
{ "Regular" 2D arrays}
type TDelphi2DArray = Array of Array of double;

type
  TMult1 = class(TBasicForm2)
    TrackBar1: TTrackBar;
    Label1: TLabel;
    StaticText1: TStaticText;
    Button4: TButton;
    RadioGroup1: TRadioGroup;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    ThreadCountLabel: TLabel;
    CPUCacheSizeLabel: TLabel;
    CPUCoreCountLabel: TLabel;
    ThreadCountEdit: TMtxFloatEdit;
    procedure FormCreate(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ThreadCountEditChange(Sender: TObject);
  private
    Factor: integer;
    DA,DB,DC : TDelphi2DArray; {"regular" arrays }
    A,B,C : TMtx;             {MtxVec arrays}
    MtxDim : Integer;
    procedure MulDelphi(ADim: Integer);
    procedure GenerateData(ADim : Integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Mult1: TMult1;

implementation

uses MtxExpr, Types;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TMult1.MulDelphi(ADim: Integer);
var i,j,k : Integer;
    ac: double;
begin
   for i := 0 to ADim-1 do
      for k := 0 to ADim-1 do
      begin
         ac := DA[i,k];
         for j := 0 to ADim-1 do
              DC[i,j] := DC[i,j]+ ac*DB[k,j];
      end;
end;

procedure TMult1.GenerateData(ADim: Integer);
var i,j : Integer;
begin
     { resize matrices }
     A.Size(ADim,ADim);
     B.Size(A);
     { resize 2D arrays}
     SetLength(DA,0,0);
     SetLength(DB,0,0);
     SetLength(DC,0,0);

     SetLength(DA,ADim,ADim);
     SetLength(DB,ADim,ADim);
     SetLength(DC,ADim,ADim);
     { fill sample data }
     Randomize;
     for i := 0 to ADim-1 do
         for j := 0 to ADim-1 do
         begin
              DA[i,j] := random(10);
              DB[i,j] := random(10);
              A[i,j] := DA[i,j];
              B[i,j] := DB[i,j];
         end;
end;

procedure TMult1.FormCreate(Sender: TObject);
begin
  With RichEdit1.Lines do
  begin
    Clear;
    Add('Matrix multiplication performance gives you '
      + 'an impression of the performance of MtxVec. You '
      + 'will be able to experience these performance '
      + 'gains with all MtxVec packages, when dealing '
      + 'with vectors or matrices. If you have a multi-CPU '
      + 'machine multi-threading is automatically enabled.  ');
  end;
  A := TMtx.Create;
  B := TMtx.Create;
  C := TMtx.Create;
  Factor := 1;
  CPUCoreCountLabel.Caption := 'CPU core count = ' + IntToStr(Controller.CpuCores);
  CPUCacheSizeLabel.Caption := 'CPU cache size = ' + FormatSample('0.0 [MB]',(Controller.CpuCacheSizeInBytes/sqr(1024)));
  ThreadCountEdit.MaxValue := IntToStr(Controller.CpuCoresLogical);
  ThreadCountEdit.IntPosition := Controller.BlasThreadCount;
  TrackBar1Change(TrackBar1);
end;

procedure TMult1.ThreadCountEditChange(Sender: TObject);
begin
  Controller.BlasThreadCount := ThreadCountEdit.IntPosition;
end;

procedure TMult1.TrackBar1Change(Sender: TObject);
begin
  MtxDim := TTrackBar(Sender).Position;
  StaticText1.Caption := IntToStr(MtxDim);
end;

procedure TMult1.Button4Click(Sender: TObject);
var i,j: integer;
    Adim : Integer;
begin
  Controller.ThreadWaitBeforeSleep := 1; // Enable
  GenerateData(MtxDim);
  i := 2;
  Screen.Cursor := crHourGlass;
  Series1.Clear;
  Series2.Clear;
  repeat
        ADim := i;
        GenerateData(ADim);
        StartTimer;
        if MtxDim <= 30 then
             for j := 0 to 99*Factor*4 do MulDelphi(ADim)
        else if MtxDim <= 60 then
             for j := 0 to 9*Factor do MulDelphi(ADim)
        else MulDelphi(ADim);
        Series1.AddXY(i, StopTimer*1000,'',clTeeColor);

        StartTimer;
        if MtxDim <= 30 then
           for j := 0 to Factor*99*4 do C.Mul(A,B)
        else if MtxDim <= 60 then
           for j := 0 to Factor*9 do C.Mul(A,B)
        else C.Mul(A,B);
        Series2.AddXY(i, StopTimer*1000,'',clTeeColor);

        if i<50 then i := i+2 else i:= i+25;
  until i >= MtxDim;
  Screen.Cursor := crDefault;
  Controller.ThreadWaitBeforeSleep := 0; // Disable
end;

procedure TMult1.RadioGroup1Click(Sender: TObject);
begin
  Case TRadioGroup(Sender).ItemIndex of
     0 : TrackBar1.Position := 25;
     1 : TrackBar1.Position := 60;
     2 : TrackBar1.Position := 400;
  end;
  TrackBar1Change(TrackBar1);
end;

procedure TMult1.FormDestroy(Sender: TObject);
begin
  Controller.BlasThreadCount := 1;  //disable

  A.Free;
  B.Free;
  C.Free;
  inherited;
end;

initialization
   RegisterClass(TMult1);
end.

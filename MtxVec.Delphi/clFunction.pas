unit clFunction;

interface

{$I bdsppdefs.inc}

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math387, MtxForLoop, Types, OpenCL_Dynamic,
  clMtxVec, ComCtrls, ExtCtrls, AbstractMtxVec, MtxVecBase;

type
  TclFunctionForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;                          
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Button1: TButton;
    Memo: TMemo;
    PlatformListBox: TListBox;
    DeviceListBox: TListBox;
    FunctionBox: TListBox;
    VectorLengthBox: TComboBox;
    RichEdit1: TRichEdit;
    ComplexBox: TCheckBox;
    Label6: TLabel;
    FloatPrecisionBox: TComboBox;
    CPUFloatPrecisionLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PlatformListBoxClick(Sender: TObject);
  private
    { Private declarations }
    SelectedDevice: TOpenCLDevice;
    procedure DoCompute;
  public
    { Public declarations }
  end;

var
  clFunctionForm: TclFunctionForm;
  VectorLen :integer;

implementation

uses MtxVecEdit, MtxVec, StringVar, MtxExpr, clMtxExpr, ZLib, MtxVecInt;

{$R *.dfm}

procedure TclFunctionForm.DoCompute;
var B,C, R: Vector;
    i, k, IterCount: integer;
    aTime, bTime: double;
    ScalarB: double;
    clB, clC: clVector;
    a: double;
    ac: TCplx;
    sac: TSCplx;
    sa: single;
    floatPrecision: TMtxFloatPrecision;
begin
    Screen.Cursor := crHourGlass;
    try
    clC.FloatPrecision := TclFloatPrecision(FloatPrecisionBox.ItemIndex);
    clB.FloatPrecision := TclFloatPrecision(FloatPrecisionBox.ItemIndex);

    FloatPrecision := mvSingle;
    case clc.FloatPrecision of
    clFloat: if ComplexBox.Checked then floatPrecision := mvSingleComplex else floatPrecision := mvSingle;
    clDouble: if ComplexBox.Checked then floatPrecision := mvDoubleComplex else floatPrecision := mvDouble;
    end;

    a := 1;
    ScalarB := 1.02;
    Memo.Lines.Clear;

    Memo.Lines.Add('Vector length = ' + IntToStr(VectorLen));
    case floatPrecision of
    mvSingle, mvSingleComplex: Memo.Lines.Add('Float size = ' + IntToStr(sizeof(single)) + ' bytes');
    mvDouble, mvDoubleComplex: Memo.Lines.Add('Float size = ' + IntToStr(sizeof(double)) + ' bytes');
    end;

    IterCount := 1;
    case Functionbox.ItemIndex of
    0: IterCount := 4096;
    1: IterCount := 256;
    2: IterCount := 128;
    3: IterCount := 128;
    end;

    B.Size(VectorLen, FloatPrecision);
    B.SetVal(ScalarB);
    C.Size(VectorLen, FloatPrecision);
    C.SetVal(1);

    { warm up the cache }
    B.Copy(C);
    C.Copy(B);

    StartTimer;
    B.Copy(C);
    C.Copy(B);
    aTime := StopTimer;
    Memo.Lines.Add('Copy CPU->CPU (2x) = ' + FormatSample('0.00us',aTime*1000*1000));

    B.SetVal(ScalarB);
    C.SetVal(1);

    StartTimer;
    clC.Copy(C);
    clB.Copy(B);
    aTime := StopTimer;
    Memo.Lines.Add('Copy CPU->GPU (2x) = ' + FormatSample('0.00us',aTime*1000*1000));

    StartTimer;
    for i := 0 to IterCount-1 do
    begin
         case FunctionBox.ItemIndex of
         0: clC := clC * clB;
         1: clC := sin(clC)  + sin(clB);
         2: clC := Sqrt(4 * a /(2*PI)) * a * sqr(clB) * Exp(-0.5 * a * sqr(clB));
         3: if not clB.Complex then ScalarB := clB.Mean else ScalarB := clB.Meanc.Re;
         end;
    end;
    clC.CopyTo(R); { from GPU to CPU }
    aTime := StopTimer;
    Memo.Lines.Add('');
    Memo.Lines.Add('Open CL timings:');
    Memo.Lines.Add('');
    Memo.Lines.Add('Function kernel (1x)  = ' + FormatSample('0.00us',aTime*1000*1000/IterCount) + ', TotalTime = ' + FormatSample('0.000s', aTime));

    B.SetVal(ScalarB);
    C.SetVal(1);

    StartTimer;
    for i := 0 to IterCount-1 do
    begin
        case FunctionBox.ItemIndex of
        0: c := c * b;
        1: c := sin(c) + sin(b);
        2: c := Sqrt(4 * a /(2*PI)) * a * sqr(b) * Exp(-0.5 * a * sqr(b));
        3: if not B.Complex then a := B.Mean else a := B.Meanc.Re;
        end;
    end;
    bTime := StopTimer;

    Memo.Lines.Add('');
    Memo.Lines.Add('Intel IPP timings:');
    Memo.Lines.Add('');
    Memo.Lines.Add('IPP (1x) = ' + FormatSample('0.00us',bTime*1000*1000/IterCount) + ', TotalTime = ' + FormatSample('0.000s', bTime));
    Memo.Lines.Add('Ratio OpenCL/IPP = ' + FormatSample('0.00x',bTime/aTime));
    Memo.Lines.Add('Ratio OpenCL/(Threaded IPP) = ' + FormatSample('0.00x',bTime/(aTime*Controller.CpuCores*0.9)));
    Memo.Lines.Add('Time/element = ' + FormatSample('0.000ns',bTime*(1000000.0/IterCount)*(1000.0/VectorLen)));

    case FunctionBox.ItemIndex of
    0,1,2: if not R.IsEqual(c, 0.01, cmpRelative) then ERaise('CPU and GPU results not equal!');
    end;


    B.SetVal(ScalarB);
    C.SetVal(1);

    StartTimer;
    for i := 0 to (IterCount div 4) -1 do
    begin
         a := 0;
         sa := 0;
         ac := '0';
         sac := '0';
         case c.FloatPrecision of
         mvSingle:        case FunctionBox.ItemIndex of
                          0: for k := 0 to c.Length-1 do c.SValues[k] := c.SValues[k] * b.SValues[k];
                          1: for k := 0 to c.Length-1 do c.SValues[k] := sin(c.SValues[k]) + sin(b.SValues[k]);
                          2: for k := 0 to c.Length-1 do c.SValues[k] := Sqrt(4 * a /(2*PI)) * a * sqr(b.SValues[k]) * Exp(-0.5 * a * sqr(b.SValues[k]));
                          3: for k := 0 to c.Length-1 do sa := sa  + c.SValues[k];
                          end;
         mvDouble:        case FunctionBox.ItemIndex of
                          0: for k := 0 to c.Length-1 do c[k] := c[k] * b[k];
                          1: for k := 0 to c.Length-1 do c[k] := sin(c[k]) + sin(b[k]);
                          2: for k := 0 to c.Length-1 do c[k] := Sqrt(4 * a /(2*PI)) * a * sqr(b[k]) * Exp(-0.5 * a * sqr(b[k]));
                          3: for k := 0 to c.Length-1 do a := a  + c[k];
                          end;
         mvSingleComplex: case FunctionBox.ItemIndex of
                          0: for k := 0 to c.Length-1 do c.SCValues[k] := c.SCValues[k] * b.SCValues[k];
                          1: for k := 0 to c.Length-1 do c.SCValues[k] := sin(c.SCValues[k]) + sin(b.SCValues[k]);
                          2: for k := 0 to c.Length-1 do c.SCValues[k] := Sqrt(4 * a /(2*PI)) * a * csqr(b.SCValues[k]) * Exp(-0.5 * a * csqr(b.SCValues[k]));
                          3: for k := 0 to c.Length-1 do sac := sac  + c.SCValues[k];
                          end;
         mvDoubleComplex: case FunctionBox.ItemIndex of
                          0: for k := 0 to c.Length-1 do c.CValues[k] := c.CValues[k] * b.CValues[k];
                          1: for k := 0 to c.Length-1 do c.CValues[k] := sin(c.CValues[k]) + sin(b.CValues[k]);
                          2: for k := 0 to c.Length-1 do c.CValues[k] := Sqrt(4 * a /(2*PI)) * a * csqr(b.CValues[k]) * Exp(-0.5 * a * csqr(b.CValues[k]));
                          3: for k := 0 to c.Length-1 do ac := ac  + c.CValues[k];
                          end;
         end;
    end;
    bTime := StopTimer*4; { simulate longer running time, because IterCount is div 4 for for loop}

    Memo.Lines.Add('');
    Memo.Lines.Add('Delphi timings:');
    Memo.Lines.Add('');
    Memo.Lines.Add('Delphi (1x) = ' + FormatSample('0.00us',bTime*1000*1000/IterCount) + ', TotalTime = ' + FormatSample('0.000s', bTime));
    Memo.Lines.Add('Ratio OpenCL/Delphi = ' + FormatSample('0.00x',bTime/aTime));
    Memo.Lines.Add('Ratio OpenCL/(Threaded Delphi) = ' + FormatSample('0.00x',bTime/(aTime*Controller.CpuCores*0.9)));
    Memo.Lines.Add('Time/element = ' + FormatSample('0.000ns',bTime*(1000000.0/IterCount)*(1000.0/VectorLen)));

    finally
        Screen.Cursor := crDefault;
    end;
end;

procedure TclFunctionForm.Button1Click(Sender: TObject);
var CacheLength: integer;
begin
    VectorLen := StrToInt(VectorLengthBox.Text);
    CacheLength := VectorLen;
    if ComplexBox.Checked then CacheLength := CacheLength*2;
    if FloatPrecisionBox.ItemIndex > 0 then CacheLength := CacheLength*2;

    clPlatform.UnmarkThreads;
    selectedDevice := clPlatform[PlatformListBox.ItemIndex].Device[DeviceListBox.ItemIndex];

    if (selectedDevice.DevicePlatform.Name = INTEL_PLATFORM) and clPlatform.IgnoreIntel then
    begin
        ShowMessage('clPlatform.IgnoreIntel = True. If you want to run benchmark for Intel platform set this flag to false first!');
    end else
    begin
        SelectedDevice.Cache.SetCacheSize(12, CacheLength, 12, 12);
        SelectedDevice.CommandQueue[0].MarkThread; { UserThread := GetCurrentThreadID; }
        DoCompute;
    end;
end;

procedure TclFunctionForm.FormCreate(Sender: TObject);
var i, k, kernelSum: Integer;
begin
    With RichEdit1.Lines do
    begin
      Clear;
      Add('The platform list shows the Open CL drivers  '
        + 'available on your computer. If you dont have a AMD or Nvidia GPU '
        + 'you can still install Intel or Open CL drivers which '
        + 'run on the CPU alone.  '
        + 'Intel drivers require at least SSE4.x (Core 2) capable hardware. '
        + 'Presence of Intel drivers also slows down the start of the '
        + 'application by minutes. That is why clPlatform.IgnoreIntel is set to true by default. ');
      Add('Select various functions and see how they perform in compare to '
        + 'intel IPP (MtxVec) and native Delphi code. Dont forget however '
        + 'that data also needs to be copied to GPU and back and this is '
        + 'fairly slow.');
      Add('If the same graphics card is used also for display next to its OpenCL purpose '
        + 'the performance degradation of Open CL code can be substantial. This depends largely also '
        + 'on the amount of total memory allocated on the GPU by the Open CL library. ');
    end;

    FloatPrecisionBox.ItemIndex := 0;

    case FloatPrecisionBox.ItemIndex of
    0: CPUFloatPrecisionLabel.Caption := 'CPU (MtxVec) float precision: ' + IntToStr(sizeof(single)*8) + 'bit';
    1: CPUFloatPrecisionLabel.Caption := 'CPU (MtxVec) float precision: ' + IntToStr(sizeof(double)*8) + 'bit';
    end;

{    ReportMemoryLeaksOnShutDown := True; }

    for i := 0 to clPlatform.Count - 1 do
         PlatformListBox.Items.Add(clPlatform[i].Name);

    PlatformListBox.ItemIndex := 0;

    for i := 0 to clPlatform[0].Count - 1 do
         DeviceListBox.Items.Add(clPlatform[0].Device[i].Name);

    DeviceListBox.ItemIndex := 0;

    clPlatform.IgnoreIntel := true;
    kernelSum := 0;
    for i := 0 to clPlatform.Count-1 do
    begin
        for k := 0 to clPlatform[i].Count-1 do
        begin
            kernelSum := kernelSum + clPlatform[i].Device[k].Kernels.Count;
        end;
    end;

//    clPlatform.SaveDefaultToRC('C:\CommonObjects\Dew MtxVec.NET\');
//    clPlatform.ClearPrecompiledBinaries;
    if kernelSum = 0 then
    begin         { load default kernels }
        Screen.Cursor := crHourGlass;
        ShowMessage('When loading the first time, the Open CL drivers need to recompile the source code.'
                  + 'This may take a minute or longer. If you have Intel Open CL drivers installed they '
                  + 'add 20s delay regardless, if the program is precompiled. Similar for AMD. The NVidia '
                  + 'compiled code load times are much faster, but GPU has limits (2s) on maximum kernel '
                  + 'execution time for gaming GPUs.');
        clPlatform.LoadProgramsForDevices(true, true, true, true, false);
        Screen.Cursor := crDefault;
    end;

    FunctionBox.ItemIndex := 0;

    VectorLen := Round(Exp2(19));
    VectorLengthBox.Text := IntToStr(VectorLen);
end;

procedure TclFunctionForm.PlatformListBoxClick(Sender: TObject);
var i: integer;
    DeviceList: StringList;
begin
    for i := 0 to clPlatform[PlatformListBox.ItemIndex].Count - 1 do
         DeviceList.Add(clPlatform[PlatformListBox.ItemIndex].Device[i].Name);

    DeviceListBox.Items.Assign(TStringList(DeviceList));
    DeviceListBox.ItemIndex := 0;
end;

initialization
   RegisterClass(TclFunctionForm);

end.

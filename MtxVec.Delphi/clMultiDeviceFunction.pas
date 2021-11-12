unit clMultiDeviceFunction;

interface

{$I bdsppdefs.inc}

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math387, MtxForLoop, OpenCL_Dynamic,
  clMtxVec, ComCtrls, ExtCtrls, AbstractMtxVec;

type
  TclMultiDeviceFunctionForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Button1: TButton;
    PlatformListBox: TListBox;                                               
    DeviceListBox: TListBox;
    FunctionBox: TListBox;
    VectorLengthBox: TComboBox;
    RichEdit1: TRichEdit;
    ComplexBox: TCheckBox;
    Label6: TLabel;
    FloatPrecisionBox: TComboBox;
    CPUFloatPrecisionLabel: TLabel;
    SchedulerTimer: TTimer;
    Label7: TLabel;
    MaximumJobCountEdit: TComboBox;
    CurrentJobCountLabel: TLabel;
    TotalRunningTimeLabel: TLabel;
    ErrorsLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PlatformListBoxClick(Sender: TObject);
    procedure SchedulerTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Finished: boolean;
    StartTime: TDateTime;
    { Private declarations }
    GlobalJobIndex: integer;
    procedure DoOnExecute(const cmdQueue: TOpenCLCommandQueue; JobIndex: integer);
  public
    { Public declarations }
  end;

var
  clMultiDeviceFunctionForm: TclMultiDeviceFunctionForm;
  VectorLen :integer;

implementation

uses MtxVecEdit, MtxVec, StringVar, MtxExpr, clMtxExpr, ZLib, MtxVecInt;

{$R *.dfm}

procedure TclMultiDeviceFunctionForm.FormCreate(Sender: TObject);
var i, k, kernelSum: Integer;
begin
    With RichEdit1.Lines do
    begin
      Clear;
      Add('The platform list shows the Open CL drivers  '
        + 'available on your computer. Select the platform of your choice and press Run.'
        + 'Then you can observe how long it takes before the specified Job Count is computed '
        + 'on all devices available on the platform. This benchmarks uses both CPU and GPU.');
      Add('Select various functions and see how they perform on different '
        + 'platforms.');
    end;

    FloatPrecisionBox.ItemIndex := 0;
    CPUFloatPrecisionLabel.Caption := 'CPU (MtxVec) float precision: ' + IntToStr(sizeof(TSample)*8) + 'bit';

    for i := 0 to clPlatform.Count - 1 do
         PlatformListBox.Items.Add(clPlatform[i].Name);

    PlatformListBox.ItemIndex := 0;

    for i := 0 to clPlatform[0].Count - 1 do
         DeviceListBox.Items.Add(clPlatform[0].Device[i].Name);

    DeviceListBox.ItemIndex := 0;

    for i := 0 to DeviceListBox.Items.Count - 1 do
        DeviceListBox.Selected[i] := true;

    MaximumJobCountEdit.Text := '2';

    kernelSum := 0;
    for i := 0 to clPlatform.Count-1 do
    begin
        for k := 0 to clPlatform[i].Count-1 do
        begin
            kernelSum := kernelSum + clPlatform[i].Device[k].Kernels.Count;
        end;
    end;

    if kernelSum = 0 then
    begin         { load default kernels }
        Screen.Cursor := crHourGlass;
        ShowMessage('When loading the first time, the Open CL drivers need to recompile the source code.'
                  + 'This may take minutes.');
        clPlatform.LoadProgramsForDevices(false, false, true, false, false);
        Screen.Cursor := crDefault;
    end;

    FunctionBox.ItemIndex := 0;
    VectorLen := Round(Exp2(19));
    VectorLengthBox.Text := IntToStr(VectorLen);
    Finished := True;
end;

procedure TclMultiDeviceFunctionForm.FormShow(Sender: TObject);
var i: integer;
begin
    for i := 0 to clPlatform[PlatformListBox.ItemIndex].Count - 1 do
      DeviceListBox.Selected[i] := true;
end;

procedure TclMultiDeviceFunctionForm.PlatformListBoxClick(Sender: TObject);
var i: integer;
    DeviceList: StringList;
begin
    for i := 0 to clPlatform[PlatformListBox.ItemIndex].Count - 1 do
         DeviceList.Add(clPlatform[PlatformListBox.ItemIndex].Device[i].Name);

    DeviceListBox.Items.Assign(TStringList(DeviceList));
    DeviceListBox.ItemIndex := 0;

    for i := 0 to clPlatform[PlatformListBox.ItemIndex].Count - 1 do
      DeviceListBox.Selected[i] := true;
end;

procedure TclMultiDeviceFunctionForm.Button1Click(Sender: TObject);
var i:integer;
    aDevice: TOpenCLDevice;
    CacheLength: integer;
begin
    if not Finished then Exit; { previous run not yet finished }

    VectorLen := StrToInt(VectorLengthBox.Text);
    CacheLength := VectorLen;
    if ComplexBox.Checked then CacheLength := CacheLength*2;
    if FloatPrecisionBox.ItemIndex > 0 then CacheLength := CacheLength*2;

    for i := 0 to DeviceListBox.Count-1 do  { assign events to command queue threads }
    begin
        aDevice := clPlatform[PlatformListBox.ItemIndex].Device[i];
        aDevice.CommandQueue[0].JobThread.OnExecute := DoOnExecute;
        aDevice.Cache.SetCacheSize(12, CacheLength, 12, 12);
    end;

    Finished := false;
    GlobalJobIndex := 0;
    PlatformListBox.Enabled := False;
    DeviceListBox.Enabled := False;
    FunctionBox.Enabled := False;
    FloatPrecisionBox.Enabled := False;
    SchedulerTimer.Enabled := True;
    StartTime := Now;
end;


procedure TclMultiDeviceFunctionForm.SchedulerTimerTimer(Sender: TObject);
var i, MaxJobCount:integer;
    aCmd: TOpenCLCommandQueue;
    deltaTime: TDateTime;
    Hour, Min, Sec, MSec: Word;
begin
    MaxJobCount := StrToInt(MaximumJobCountEdit.Text);

    Finished := True;

    for i := 0 to DeviceListBox.Count-1 do  { assign events to command queue threads }
    begin
        if DeviceListBox.Selected[i] then
        begin
            aCmd := clPlatform[PlatformListBox.ItemIndex].Device[i].CommandQueue[0];
            if aCmd.JobThread.Sleeping and (GlobalJobIndex < MaxJobCount) then
            begin
                  GlobalJobIndex := GlobalJobIndex + 1;  { get next job }
                  aCmd.JobThread.JobIndex := GlobalJobIndex;
                  aCmd.JobThread.Start;
            end;

            Finished := Finished and aCmd.JobThread.Sleeping and (GlobalJobIndex >= MaxJobCount);
        end;
    end;

    if not Finished then
    begin
        CurrentJobCountLabel.Caption := 'Current job count = ' + IntToStr(GlobalJobIndex);
        deltaTime := Now - StartTime;
        DecodeTime(DeltaTime, Hour, Min, Sec, MSec);
        TotalRunningTimeLabel.Caption := 'Total running time = ' + FormatFloat('00', Hour) + ':' + FormatFloat('00', Min) + ':' + FormatFloat('00', Sec) + ':' + FormatFloat('000', MSec);
    end else
    begin
        ErrorsLabel.Caption := '';

        for i := 0 to DeviceListBox.Count-1 do  { assign events to command queue threads }
        begin
            if DeviceListBox.Selected[i] then
            begin
                aCmd := clPlatform[PlatformListBox.ItemIndex].Device[i].CommandQueue[0];
                if aCmd.JobThread.ExceptionMessage <> '' then
                    ErrorsLabel.Caption := ErrorsLabel.Caption + aCmd.JobThread.ExceptionMessage;
            end;
        end;

        if ErrorsLabel.Caption = '' then ErrorsLabel.Caption := 'Errors: None';

        PlatformListBox.Enabled := True;
        DeviceListBox.Enabled := True;
        FunctionBox.Enabled := True;
        FloatPrecisionBox.Enabled := True;
        SchedulerTimer.Enabled := false;
    end;
end;

procedure TclMultiDeviceFunctionForm.DoOnExecute(const cmdQueue: TOpenCLCommandQueue; JobIndex: integer);
var R: Vector;
    i, IterCount: integer;
    ScalarB: TSample;
    clB, clC: clVector;
    a: TSample;
begin  { Ignore job index for this test case (!!!) }
    a := 1;
    ScalarB := 1.002;

    IterCount := 1;
    case Functionbox.ItemIndex of
    0: IterCount := 8192;  { increase single shot running time to above 1s }
    1: IterCount := 8192;
    2: IterCount := 8192;
    end;

    clB.Size(VectorLen, TclFloatPrecision(FloatPrecisionBox.ItemIndex), ComplexBox.Checked);
    clB.SetVal(ScalarB);
    clC.Size(VectorLen, TclFloatPrecision(FloatPrecisionBox.ItemIndex), ComplexBox.Checked);
    clC.SetVal(1);

    for i := 0 to IterCount-1 do
    begin
         case FunctionBox.ItemIndex of
         0: clC := clC * clB;
         1: clC := sin(clC)  + sin(clB);
         2: clC := Sqrt(4 * a /(2*PI)) * a * sqr(clB) * Exp(-0.5 * a * sqr(clB));
         end;
    end;
    clC.CopyTo(R); { from GPU to CPU }
    if (R.Find(NAN) <> -1) or (R.Find(INF) <> -1) then ERaise('NAN or INF detected!');
end;

initialization
   RegisterClass(TclMultiDeviceFunctionForm);

end.

unit ProgDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic2, StdCtrls, ComCtrls, ExtCtrls, MtxBaseComp, MtxDialogs,
  Optimization, MtxComCtrls, MtxVec;

type
  TfrmProgDialog = class(TBasicForm2)
    Label1: TLabel;
    ProgressLabel: TLabel;
    Label2: TLabel;
    Label3: TLabel;                         
    IteratorGroup: TRadioGroup;
    LoopTypeGroup: TRadioGroup;
    ShowFormBox: TCheckBox;
    ThreadBox: TComboBox;
    StartButton: TButton;
    ProgressBar: TProgressBar;
    UpdateIntervalEdit: TMtxFloatEdit;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    MinEdit: TMtxFloatEdit;
    MaxEdit: TMtxFloatEdit;
    MtxThread: TMtxProgressDialog;
    procedure ShowFormBoxClick(Sender: TObject);
    procedure LoopTypeGroupClick(Sender: TObject);
    procedure MtxThreadCompute(Sender: TObject);
    procedure MtxThreadProgressUpdate(Sender: TObject;
      Event: TMtxProgressEvent);
    procedure IteratorGroupClick(Sender: TObject);
    procedure MinEditChange(Sender: TObject);
    procedure MaxEditChange(Sender: TObject);
    procedure UpdateIntervalEditChange(Sender: TObject);
    procedure ThreadBoxChange(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    A,B,C: TMtx;
    procedure WhileLoopInProcedure(var Counter: integer;
      var Cancel: boolean);

  public
    { Public declarations }
  end;

var
  frmProgDialog: TfrmProgDialog;

implementation

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TfrmProgDialog.ShowFormBoxClick(Sender: TObject);
begin
  MtxThread.ShowDialog := ShowFormBox.Checked;
end;

procedure TfrmProgDialog.LoopTypeGroupClick(Sender: TObject);
begin
  case LoopTypeGroup.ItemIndex of
    0: MtxThread.InfiniteLoop := False;
    1: MtxThread.InfiniteLoop := True;
  end;
end;
{
Procedure that has been thread:
begin
         CreateIt(A,B,C);
         A.Size(100,100);
         A.RandGauss;
         B.Copy(a);
         for i := 0 to Count-1 do C.Mul(A,B);
         FreeIt(A,B,C);
end;
}

procedure TfrmProgDialog.MtxThreadCompute(Sender: TObject);
var i: integer;
begin
  case IteratorGroup.ItemIndex of
    0: C.Mul(a,b);  //Internal loop
    1: for i := MtxThread.Min to MtxThread.Max do
       begin  //external loop,
             MtxThread.Counter := i;
             if MtxThread.Cancel then Break;
             //
             C.Mul(A,B);
       end;
    2: WhileLoopInProcedure(MtxThread.Counter,MtxThread.Cancel);
  end;
end;



procedure TfrmProgDialog.MtxThreadProgressUpdate(Sender: TObject;
  Event: TMtxProgressEvent);
begin
  case Event of
  peInit: begin
            MtxThread.DefineProgressBar(ProgressBar);
            CreateIt(A,B,C);
            A.Size(100,100);
            A.RandGauss;
            B.Copy(a);
          end;
  peCycle:begin
            ProgressBar.Position := MtxThread.Counter;
            ProgressLabel.Caption := 'Progress indicator: ' + FormatFloat('0 %',MtxThread.Counter/MtxThread.Max*100);
          end;
  peCleanUp:
          begin
            if not MtxThread.Cancel then
            begin
              ProgressBar.Position := MtxThread.Max;
              ProgressLabel.Caption := 'Progress indicator: ' + FormatFloat('0.00',100);
            end;
            FreeIt(A,B,C);
          end;
  end;
end;
procedure TfrmProgDialog.IteratorGroupClick(Sender: TObject);
begin
  case IteratorGroup.ItemIndex of
    0:  MtxThread.InternalLoop := True;
    1,2:  MtxThread.InternalLoop := False;
  end;
end;

procedure TfrmProgDialog.MinEditChange(Sender: TObject);
begin
  MtxThread.Min := StrToInt(MinEdit.Value);
end;

procedure TfrmProgDialog.MaxEditChange(Sender: TObject);
begin
  MtxThread.Max := StrToInt(MaxEdit.Value);
end;

procedure TfrmProgDialog.UpdateIntervalEditChange(Sender: TObject);
begin
  MtxThread.UpdateInterval := StrToInt(UpdateIntervalEdit.Value);
end;

procedure TfrmProgDialog.ThreadBoxChange(Sender: TObject);
begin
  MtxThread.ThreadPriority := TThreadPriority(ThreadBox.ItemIndex);
end;

procedure TfrmProgDialog.StartButtonClick(Sender: TObject);
begin
  if StartButton.Caption = 'Start' then
  begin
    StartButton.Caption := 'Stop';
    MtxThread.Start;
  end else
  begin
    MtxThread.Cancel := True;
    StartButton.Caption := 'Start';
  end;
  {Sequence of calls:}

  {
   1. Calls  MtxThread OnProgressUpdate event with peInit
   2. Calls  OnCompute once or more times depending of InternalLoop
   3. Calls  MtxThread OnProgressUpdate event with peCycle in
      regular intervals to advance progress indicators.
   4. Calls MtxThread OnProgressUpdate event with peCleanUp to
      continue with the further processing of the processed data,
      once the the thread has finished.
  }
end;

procedure TfrmProgDialog.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines do
  begin
    Clear;
    Add('MtxVec 1.5 introduces new TMtxProgressDialog control. '
      + 'The TMtxProgressDialog component greatly simplifies '
      + 'the threading of numerical algorithms and offers '
      + 'built-in support to cancel the execution of algorithms '
      + 'running in it''s thread, provide information about the '
      + 'progress of the executing numerical algorithm and even '
      + 'display progress dialog showing progress indications '
      + 'updated with user defined update frequency. Component '
      + 'design does not use the Synchronize procedure to update '
      + 'progress indicators and makes the most out of the '
      + 'available CPU power.');
  end;
  ThreadBox.ItemIndex := 3;
  MtxThread.DefineLoop(0,1500);
end;

procedure TfrmProgDialog.WhileLoopInProcedure(var Counter: integer;
  var Cancel: boolean);
begin
  while not (MtxThread.Max = Counter) do
  begin
    if Cancel then Break;
    C.Mul(A,B);
    Inc(Counter);
  end;
end;

procedure TfrmProgDialog.FormDestroy(Sender: TObject);
begin
  MtxThread.Stop;
  inherited;
end;

initialization
   RegisterClass(TfrmProgDialog);

end.
 
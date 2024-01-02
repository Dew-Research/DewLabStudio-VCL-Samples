unit BenchmarkX;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Basic2, StdCtrls, ComCtrls, ExtCtrls, Menus, CheckLst, TeEngine,
  Series, TeeProcs, Chart, BenchmarkResults, BenchmarkFramework;

type
  TBenchmarkXForm = class(TBasicForm2)                   
    PopupMenu: TPopupMenu;                                 
    miSelectAllFuncs: TMenuItem;
    miUnselectAllFuncs: TMenuItem;      
    btnRun: TButton;                                            
    btnOpen: TButton;
    Label1: TLabel;
    cbVectorLength: TComboBox;
    cbIterationCount: TComboBox;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    chartResults: TChart;
    Series4: THorizBarSeries;
    Series3: THorizBarSeries;
    Series2: THorizBarSeries;
    Series1: THorizBarSeries;
    Panel4: TPanel;
    clbFuncs: TCheckListBox;
    Label3: TLabel;
    ChartMenu: TPopupMenu;
    LoadFromFileItem: TMenuItem;
    SaveToFileItem: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure clbFuncsDblClick(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure cbIterationCountDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure miSelectAllFuncsClick(Sender: TObject);
    procedure miUnselectAllFuncsClick(Sender: TObject);
    procedure LoadFromFileItemClick(Sender: TObject);
    procedure SaveToFileItemClick(Sender: TObject);
  private
    procedure LoadFuncListbox;
    function ReadIntValue(cb: TCombobox; min, max: integer): integer;
    procedure RecalcIterationCount;
    procedure UpdateComboboxHistory(cb: TCombobox);
    procedure miLoadFromFileClick(Sender: TObject);
//    procedure miSaveToFileClick(Sender: TObject);
    procedure ShowResults(results: TBenchmarkResults);
    procedure UpdateChart;
    procedure LoadFile(const file_name: string);
    procedure SelectAllFuncs(select: boolean);
    { Private declarations }
  public
    { Public declarations }
    fBenchmarkFramework: TBenchmarkFramework;
    fBenchmarkResults: TBenchmarkResults;
    fFirstActivation: boolean;
  end;

var
  BenchmarkXForm: TBenchmarkXForm;

implementation

uses MtxVecInt, MtxVec;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TBenchmarkXForm.FormCreate(Sender: TObject);
begin
  inherited;
  fFirstActivation:= TRUE;
  fBenchmarkFramework:= TBenchmarkFramework.Create;
  fBenchmarkResults:= TBenchmarkResults.Create;
  LoadFuncListbox;

  With RichEdit1.Lines do
  begin
    Clear;
    Add('These benchmarks compare vectorized and not vectorized ' +
        'versions of real and complex versions of basic math functions. ' +
        'The vectorized versions are labeled with MtxVec and the non-vectorized '+
        'versions are labeled with Math387.');
    Add('');
    Add('The non-vectorized real and complex versions ' +
        'are written in assembler for maximum performance. '+
        'Despite this, the vectorized versions are substantially faster. '+
        'Before running the tests double click on the iterations combobox. ' +
        'That will compute the number of iterations that have to be performed ' +
        'to get sufficiently long timings. The resolution of the timings is ' +
        'about 15ms.');
  end;
end;

procedure TBenchmarkXForm.FormDestroy(Sender: TObject);
begin
  fBenchmarkFramework.Free;
  fBenchmarkResults.Free;
  inherited;
end;

procedure TBenchmarkXForm.ShowResults (results: TBenchmarkResults);
begin
//  fBenchmarkResults.Assign(results);
  UpdateChart;
//  Show;
end;

procedure TBenchmarkXForm.LoadFuncListbox;
var
  i: integer;
begin
  clbFuncs.Items.BeginUpdate;
  try
    clbFuncs.Items.Clear;
    for i:= 0 to fBenchmarkFramework.FuncCount-1 do begin
      clbFuncs.Items.Add (fBenchmarkFramework.FuncName[i]);
      clbFuncs.Checked[i]:= TRUE;
    end;
  finally
    clbFuncs.Items.EndUpdate;
  end;
end;

procedure TBenchmarkXForm.SelectAllFuncs(select: boolean);
var
  i: integer;
begin
  for i:= 0 to clbFuncs.Items.Count-1 do
    clbFuncs.Checked[i]:= select;
end;

procedure TBenchmarkXForm.clbFuncsDblClick(Sender: TObject);
var
  idx: integer;
begin
  idx:= clbFuncs.ItemIndex;
  if idx <> -1 then
    clbFuncs.Checked[idx]:= not clbFuncs.Checked[idx];
end;

procedure TBenchmarkXForm.UpdateComboboxHistory (cb: TCombobox);
var
  i : integer;
begin
  if cb.Text <> '' then begin
    i:= cb.Items.Count-1;
    while (i >= 0) do
      if (cb.Items[i] = cb.Text) then
        break
      else
        Dec(i);

    if (i < 0) then
      cb.Items.Insert (0, cb.Text)
    else
      if (i > 0) then
        cb.Items.Move (i, 0);

    cb.Text:= cb.Items[0];
  end;
end;

function TBenchmarkXForm.ReadIntValue (cb: TCombobox; min, max: integer): integer;
begin
  if TryStrToInt (cb.Text, Result) then begin
    if (Result >= min) and (Result <= max) then
      Exit;
  end else
    if cb.CanFocus then
      cb.SetFocus;

  raise Exception.CreateFmt ('Expected value in range [%d..%d]', [min, max]);
end;

procedure TBenchmarkXForm.btnRunClick(Sender: TObject);
var
  cursor: TCursor;
  i: integer;
  results: TBenchmarkResults;
begin
  UpdateComboboxHistory (cbVectorLength);
  UpdateComboboxHistory (cbIterationCount);
                   
  cursor:= Screen.Cursor;
  Screen.Cursor:= crHourGlass;  
  try
    fBenchmarkFramework.VectorLength:= ReadIntValue (cbVectorLength, 0, 1000000);
    fBenchmarkFramework.IterationCount:= ReadIntValue (cbIterationCount, 1, 1000000);

    results := fBenchmarkResults;

    results.Clear;
    for i:= 0 to clbFuncs.Count-1 do
      if clbFuncs.Checked[i] then
        fBenchmarkFramework.Run (clbFuncs.Items[i], results);

    results.Title:= Format ('D7:  Length: %d   Count: %d ',
      [fBenchmarkFramework.VectorLength, fBenchmarkFramework.IterationCount]);

    ShowResults(results);

  finally
    Screen.Cursor:= cursor;
  end;
end;

procedure TBenchmarkXForm.btnOpenClick(Sender: TObject);
begin
    LoadFile('');
end;

procedure TBenchmarkXForm.LoadFile(const file_name: string);
begin
  if FileExists (file_name) then begin
    fBenchmarkResults.LoadFromFile(file_name);
    UpdateChart;
  end else
    miLoadFromFileClick(nil);
end;

procedure TBenchmarkXForm.cbIterationCountDblClick(Sender: TObject);
begin
  fBenchmarkFramework.VectorLength := ReadIntValue (cbVectorLength, 0, 1000000);
  RecalcIterationCount;
end;

procedure  TBenchmarkXForm.RecalcIterationCount;
var
  cursor: TCursor;
begin
  cursor:= Screen.Cursor;
  Screen.Cursor:= crHourGlass;
  try
    cbIterationCount.Text:= IntToStr(fBenchmarkFramework.RecalcIterationCount);
  finally
    Screen.Cursor:= cursor;
  end;
end;

procedure TBenchmarkXForm.FormActivate(Sender: TObject);
begin
  if fFirstActivation then begin
    fFirstActivation:= FALSE;
    Application.ProcessMessages;
    RecalcIterationCount;
  end;
end;

procedure TBenchmarkXForm.miLoadFromFileClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    fBenchmarkResults.LoadFromFile(OpenDialog1.FileName);
    UpdateChart;
  end;
end;

{procedure TBenchmarkXForm.miSaveToFileClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
    fBenchmarkResults.SaveToFile(SaveDialog1.FileName);
end;}

procedure TBenchmarkXForm.miSelectAllFuncsClick(Sender: TObject);
begin
  SelectAllFuncs (TRUE);
end;

procedure TBenchmarkXForm.miUnselectAllFuncsClick(Sender: TObject);
begin
  SelectAllFuncs (false);
end;

procedure TBenchmarkXForm.LoadFromFileItemClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    fBenchmarkResults.LoadFromFile(OpenDialog1.FileName);
    UpdateChart;
  end;
end;

procedure TBenchmarkXForm.SaveToFileItemClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
    fBenchmarkResults.SaveToFile(SaveDialog1.FileName);
end;

procedure TBenchmarkXForm.UpdateChart;
var
  i: integer;
begin
  Series1.Clear;
  Series2.Clear;
  Series3.Clear;
  Series4.Clear;

  chartResults.Height:= 100 + (60 * fBenchmarkResults.Count);
  Caption:= fBenchmarkResults.Title;

  for i:= fBenchmarkResults.Count-1 downto 0 do begin
    Series1.AddBar(fBenchmarkResults[i].SmplVecTicks, fBenchmarkResults[i].FuncName, clDefault);
    Series2.AddBar(fBenchmarkResults[i].CplxVecTicks, fBenchmarkResults[i].FuncName, clDefault);
    Series3.AddBar(fBenchmarkResults[i].SmplFuncTicks, fBenchmarkResults[i].FuncName, clDefault);
    Series4.AddBar(fBenchmarkResults[i].CplxFuncTicks, fBenchmarkResults[i].FuncName, clDefault);
  end;
end;

initialization
   RegisterClass(TBenchmarkXForm);

end.

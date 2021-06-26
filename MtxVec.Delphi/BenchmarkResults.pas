unit BenchmarkResults;

interface
uses
  Classes;

type
  TBenchmarkItem = class (TCollectionItem)
  private
    fIterationCount: integer;
    fSmplVecTicks: double;
    fCplxFuncTicks: double;
    fVecLen: integer;
    fSmplFuncTicks: double;
    fCplxVecTicks: double;
    fFuncName: string;
  protected
    procedure AssignTo (dest: TPersistent); override;
  published
    property FuncName: string read fFuncName write fFuncName;
    property VecLen: integer read fVecLen write fVecLen;
    property IterationCount: integer read fIterationCount write fIterationCount;
    property SmplVecTicks: double read fSmplVecTicks write fSmplVecTicks;
    property CplxVecTicks: double read fCplxVecTicks write fCplxVecTicks;
    property SmplFuncTicks: double read fSmplFuncTicks write fSmplFuncTicks;
    property CplxFuncTicks: double read fCplxFuncTicks write fCplxFuncTicks;
  end;

  TBenchmarkResults = class (TPersistent)
  private
    fList: TCollection;
    fTitle: string;

    function GetItems(idx: integer): TBenchmarkItem;
    procedure SetItems(idx: integer; const Value: TBenchmarkItem);
    procedure SetList(const Value: TCollection);
    function GetCount: integer;
  protected
    procedure AssignTo (dest: TPersistent); override;

  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    function Add (const func_name: string; vec_len: integer; iteration_count: integer;
                  smpl_vec_ticks, cplx_vec_ticks, smpl_func_ticks, cplx_func_ticks: double): TBenchmarkItem;

    procedure SaveToFile (const file_name: string);
    procedure LoadFromFile (const file_name: string);
    property Items[idx: integer]: TBenchmarkItem read GetItems write SetItems; default;
    property Count: integer read GetCount;
    
  published
    property Title: string read fTitle write fTitle;
    property List: TCollection read fList write SetList;
  end;

implementation
uses
  PersistentStreamer;

{ TBenchmarkResults }

function TBenchmarkResults.Add(const func_name: string; vec_len,
  iteration_count: integer; smpl_vec_ticks, cplx_vec_ticks, smpl_func_ticks,
  cplx_func_ticks: double): TBenchmarkItem;
begin
  Result:= fList.Add as TBenchmarkItem;
  Result.FuncName:= func_name;
  Result.VecLen:= vec_len;
  Result.IterationCount:= iteration_count;
  Result.SmplVecTicks:= smpl_vec_ticks;
  Result.CplxVecTicks:= cplx_vec_ticks;
  Result.SmplFuncTicks:= smpl_func_ticks;
  Result.CplxFuncTicks:= cplx_func_ticks;
end;

procedure TBenchmarkResults.AssignTo(dest: TPersistent);
begin
  if dest is TBenchmarkResults then begin
    TBenchmarkResults(dest).Title:= fTitle;
    TBenchmarkResults(dest).List:= fList;
  end else
    inherited;
end;

procedure TBenchmarkResults.Clear;
begin
  fTitle:= '';
  fList.Clear;
end;

constructor TBenchmarkResults.Create;
begin
  inherited;
  fList:= TCollection.Create (TBenchmarkItem);
end;

destructor TBenchmarkResults.Destroy;
begin
  fList.Free;
  inherited;
end;

function TBenchmarkResults.GetCount: integer;
begin
  Result:= fList.Count;
end;

function TBenchmarkResults.GetItems(idx: integer): TBenchmarkItem;
begin
  Result:= fList.Items[idx] as TBenchmarkItem
end;

procedure TBenchmarkResults.LoadFromFile(const file_name: string);
begin
  Clear;
  LoadPersistentFromFile (Self, file_name);
end;

procedure TBenchmarkResults.SaveToFile(const file_name: string);
begin
  SavePersistentToFile (Self, file_name, sofText);
end;

procedure TBenchmarkResults.SetItems(idx: integer; const Value: TBenchmarkItem);
begin
  (fList.Items[idx] as TBenchmarkItem).Assign(Value);
end;

procedure TBenchmarkResults.SetList(const Value: TCollection);
begin
  fList.Assign(Value);
end;

{ TBenchmarkItem }

procedure TBenchmarkItem.AssignTo(dest: TPersistent);
begin
  if dest is TBenchmarkItem then begin
    TBenchmarkItem(dest).FuncName:= fFuncName;
    TBenchmarkItem(dest).VecLen:= fVecLen;
    TBenchmarkItem(dest).IterationCount:= fIterationCount;
    TBenchmarkItem(dest).SmplVecTicks:= fSmplVecTicks;
    TBenchmarkItem(dest).CplxVecTicks:= fCplxVecTicks;
    TBenchmarkItem(dest).SmplFuncTicks:= fSmplFuncTicks;
    TBenchmarkItem(dest).CplxFuncTicks:= fCplxFuncTicks;
  end else
    inherited;
end;

end.

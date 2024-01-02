unit ScriptingGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Math387,
  Dialogs, StdCtrls, MtxParseExpr, MtxParseClass, ComCtrls, ExtCtrls, Grids, Types,
  MtxGrid, Chart, Series, MtxParseProbabilities, TeEngine, TeeProcs, RichEdit, ExprToolTipUnit,
  Buttons, MtxVecTee;

type
  TScriptingGridForm = class(TForm)
    Panel1: TPanel;
    RichEdit: TRichEdit;
    ExprEdit: TEdit;
    Splitter1: TSplitter;
    Panel2: TPanel;
    ListBox: TListBox;
    Splitter2: TSplitter;
    Label1: TLabel;
    VarView: TListView;
    Splitter3: TSplitter;
    StatusBar: TStatusBar;
    Splitter4: TSplitter;
    ScriptEdit: TRichEdit;
    ScriptLabel: TLabel;
    ScriptBox: TComboBox;
    Panel4: TPanel;
    Panel5: TPanel;
    PageControl: TPageControl;
    Sheet1: TTabSheet;
    Sheet2: TTabSheet;
    RunButton: TButton;
    Chart: TTabSheet;
    Grid1: TStringGrid;
    Grid2: TStringGrid;
    Chart1: TChart;
    Chart2: TChart;
    Splitter5: TSplitter;
    ResetButton: TButton;
    Panel3: TPanel;
    LineLabel: TLabel;
    StepButton: TButton;
    SaveAsButton: TButton;
    DeleteScriptButton: TButton;
    GridInsertScriptButton: TButton;
    GridAssignScriptButton: TButton;
    Bevel1: TBevel;
    Panel6: TPanel;
    GridInsertEditButton: TButton;
    GridAssignEditButton: TButton;
    Panel7: TPanel;
    EditModeButton: TSpeedButton;
    Panel8: TPanel;
    Label3: TLabel;
    WorkspaceBox: TComboBox;
    SaveWorkButton: TButton;
    DeleteWorkButton: TButton;
    Splitter6: TSplitter;
    ResetWorkspaceButton: TButton;
    Bevel2: TBevel;
    Label2: TLabel;
    Series1: TFastLineSeries;
    Series2: TFastLineSeries;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListBoxDblClick(Sender: TObject);
    procedure VarViewDblClick(Sender: TObject);
    procedure VarViewMouseEnter(Sender: TObject);
    procedure ListBoxMouseEnter(Sender: TObject);
    procedure RichEditMouseEnter(Sender: TObject);
    procedure ExprEditMouseEnter(Sender: TObject);
    procedure ScriptBoxChange(Sender: TObject);
    procedure RunButtonClick(Sender: TObject);
    procedure Grid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure ScriptEditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StepButtonClick(Sender: TObject);
    procedure ResetButtonClick(Sender: TObject);
    procedure ScriptEditMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure AssignButtonClick(Sender: TObject);
    procedure EditModeButtonClick(Sender: TObject);
    procedure ExprEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Grid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SaveAsButtonClick(Sender: TObject);
    procedure DeleteScriptButtonClick(Sender: TObject);
    procedure GridInsertScriptButtonClick(Sender: TObject);
    procedure GridAssignScriptButtonClick(Sender: TObject);
    procedure GridInsertEditButtonClick(Sender: TObject);
    procedure GridAssignEditButtonClick(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
    procedure SaveWorkButtonClick(Sender: TObject);
    procedure DeleteWorkButtonClick(Sender: TObject);
    procedure WorkspaceBoxChange(Sender: TObject);
    procedure ResetWorkspaceButtonClick(Sender: TObject);
  private
    procedure EvaluateExpression;
    procedure UpdateVarView;
    procedure SetupGrids;
    procedure SetupGrid(const aGrid: TStringGrid);

    procedure DoSetGrid1(const Sender: TExprGridVariable; const Src: string; const row, col: integer);
    procedure DoSetGrid2(const Sender: TExprGridVariable; const Src: string; const row, col: integer);
    procedure DoGetGrid1(const Sender: TExprGridVariable; var Dst: string; const row, col: integer);
    procedure DoGetGrid2(const Sender: TExprGridVariable; var Dst: string; const row, col: integer);
    function WordUnderMouseInRichEdit(const pt: TPoint): string;
    procedure PopulateScriptList;
    function GridSelection: string;
    function GridSelectionValues: string;
    procedure SaveWorkspace(const dst: TExprWorkspace; const dstName: string);
    procedure DefineCustomValues;
    function ScriptEditActiveLine: integer;
    { Private declarations }
  public
    WorkspaceIndex: integer;
    Editing: boolean;
    { Public declarations }
    Expr: TMtxExpression;
    grid1var: TExprGridVariable;
    grid2var: TExprGridVariable;
    mtxToolTip: TExprToolTipForm;
  end;

  procedure _drawvalues5(const Param: TExprRec);
  procedure _drawvalues4(const Param: TExprRec);

var
  ScriptingGridForm: TScriptingGridForm;

implementation

uses MtxVec, MtxExpr, MtxVecEdit, StringVar, AbstractMtxVec;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TScriptingGridForm.UpdateVarView;
var i: Integer;
    aItem: TListItem;
    aVarList: TStringList;
    aVar: TValueRec;
begin
    aVarList:= TStringList.Create;
    Expr.GetVarList(aVarList);
    VarView.Clear;
    for i := 0 to aVarList.Count - 1 do
    begin
        aItem := VarView.Items.Add;
        aItem.Caption := aVarList[i];
        aVar := Expr.VarByName[aVarList[i]];
        aItem.SubItems.Add(ValTypeAsStr[avar.ValueType]);
        case aVar.ValueType of
        vtString:      aItem.SubItems.Add(aVar.StringValue);
        vtIntegerValue:aItem.SubItems.Add(IntToStr(aVar.IntegerValue));
        vtBoolValue:   aItem.SubItems.Add(BoolToStr(aVar.BoolValue, true));
        vtRangeValue:  begin
                          if aVar.ExtRange then
                          begin
                              case aVar.ExtRangeValue.Length of
                              2: aItem.SubItems.Add(SampleToStr(aVar.ExtRangeValue[0]) + ':' + SampleToStr(aVar.ExtRangeValue[1]));
                              3: aItem.SubItems.Add(SampleToStr(aVar.ExtRangeValue[0]) + ':' + SampleToStr(aVar.ExtRangeValue[1]) + ':' + SampleToStr(aVar.ExtRangeValue[2]));
                              end;
                          end else
                          begin
                              case Length(aVar.fRange) of
                              2: aItem.SubItems.Add(IntToStr(aVar.fRange[0]) + ':' + IntToStr(aVar.fRange[1]));
                              3: aItem.SubItems.Add(IntToStr(aVar.fRange[0]) + ':' + IntToStr(aVar.fRange[1]) + ':' + IntToStr(aVar.fRange[2]));
                              end;
                          end;
                       end;
        vtCustomValue: aItem.SubItems.Add(aVar.CustomValue.ClassName);
        vtDoubleValue: aItem.SubItems.Add(SampleToStr(aVar.DoubleValue));
        vtComplexValue:aItem.SubItems.Add(CplxToStr(aVar.ComplexValue));
        vtVectorValue: aItem.SubItems.Add('1x' + IntToStr(aVar.VectorValue.Length));
        vtMatrixValue: aItem.SubItems.Add(IntToStr(aVar.MatrixValue.Rows)+ 'x' +
                                          IntToStr(aVar.MatrixValue.Cols));
        vtIntVectorValue: aItem.SubItems.Add('1x' + IntToStr(aVar.IntVectorValue.Length));
        vtIntMatrixValue: aItem.SubItems.Add(IntToStr(aVar.IntMatrixValue.Rows)+ 'x' +
                                             IntToStr(aVar.IntMatrixValue.Cols));
        vtBoolVectorValue: aItem.SubItems.Add('1x' + IntToStr(aVar.BoolVectorValue.Length));
        vtBoolMatrixValue: aItem.SubItems.Add(IntToStr(aVar.BoolMatrixValue.Rows)+ 'x' +
                                              IntToStr(aVar.BoolMatrixValue.Cols));

        end;
    end;
end;

procedure TScriptingGridForm.VarViewDblClick(Sender: TObject);
var a: TValueRec;
    varName: string;
begin
   varName := VarView.Selected.Caption;
   a := Expr.VarByName[varName];
   case a.ValueType of
   vtBoolVectorValue: ViewValues(a.BoolVectorValue, varName);
   vtIntVectorValue: ViewValues(a.IntVectorValue, varName);
   vtVectorValue:    ViewValues(a.VectorValue, varName);
   vtBoolMatrixValue: ViewValues(a.BoolMatrixValue, varName);
   vtIntMatrixValue: ViewValues(a.IntMatrixValue, varName);
   vtMatrixValue:    ViewValues(a.MatrixValue, varName);
   end;
end;

procedure TScriptingGridForm.VarViewMouseEnter(Sender: TObject);
begin
    StatusBar.Panels[0].Text := 'Double click vector or matrix to examine the values';
end;

procedure TScriptingGridForm.RunButtonClick(Sender: TObject);
var a: TValueRec;
    i: integer;
    a2: double;
begin
    a2 := 0;
    Expr.ClearExpressions;
    for i := 0 to ScriptEdit.Lines.Count-1 do Expr.AddExpr(ScriptEdit.Lines[i]);
    try
        try
            Expr.Compile;
            StartTimer;
            a := Expr.EvaluateCompiled;
            a2 := StopTimer;
            expr.VarPrint(a, Expr.EvaluatedVarName(0), RichEdit.Lines);
        except
            on E: Exception do
            begin
                RichEdit.Lines.Add('');
                RichEdit.Lines.Add(E.Message);
                Expr.ClearExpressions;
            end;
        end;

    finally
        RichEdit.Lines.Add('');
        RichEdit.Lines.Add('Elapsed time: ' + FormatSample('0.0000s',a2) + ', sizeof(TSample) = ' + IntToStr(sizeof(TSample)));
        UpdateVarView;
    end;
end;


procedure TScriptingGridForm.EvaluateExpression;
var a: TValueRec;
  aCmd: string;
  i: Integer;
  funcList, hlpList: StringList;
begin
    richEdit.Lines.BeginUpdate;
    try
        Expr.ClearExpressions;
        aCmd := Trim(ExprEdit.Text);
        if aCmd = 'cls' then
        begin
            RichEdit.Lines.Clear;
            RichEdit.Lines.Add('');
            ExprEdit.Text := '';
            Exit;
        end else
        if aCmd = 'clear' then
        begin
            Expr.ClearAll;
            RichEdit.Lines.Clear;
            RichEdit.Lines.Add('');
            ExprEdit.Text := '';
            ListBox.Clear;
            VarView.Clear;
            Exit;
        end else
        if aCmd = 'help' then
        begin
            Expr.GetFuncList(TStringList(funcList), TStringList(hlpList), true);
            RichEdit.Lines.Add('');
            RichEdit.Lines.Add('Function listing:');
            RichEdit.Lines.Add('');
            for i := 0 to hlpList.Count - 1 do
                RichEdit.Lines.Add(hlpList[i]);

            Expr.GetOperList(TStringList(funcList), TStringList(hlpList));
            RichEdit.Lines.Add('');
            RichEdit.Lines.Add('Operator listing:');
            RichEdit.Lines.Add('');
            for i := 0 to hlpList.Count - 1 do
                RichEdit.Lines.Add(hlpList[i]);
            RichEdit.Lines.Add('');

            if ExprEdit.Text <> '' then
            begin
                 if ListBox.Items.IndexOf(ExprEdit.Text) < 0 then
                 begin
                     ListBox.Selected[ListBox.Items.Add(ExprEdit.Text)] := true;
                 end;
                 ExprEdit.Text := '';
            end;
            Exit;
        end;

        try
            Expr.AddExpr(ExprEdit.Text);
            a := Expr.Evaluate;

            RichEdit.Lines.Add('');
            RichEdit.Lines.Add('> ' + ExprEdit.Text);
            RichEdit.Lines.Add('');

            RichEdit.Lines.Add('');
            if not TerminatedWithSemicolon(ExprEdit.Text) then
                expr.VarPrint(a, Expr.EvaluatedVarName(0), RichEdit.Lines);

            UpdateVarView;

            Expr.ClearExpressions;
        except
            on E: Exception do
            begin
                RichEdit.Lines.Add(acmd + ' :');
                RichEdit.Lines.Add(E.Message);
                RichEdit.Lines.Add('');
                Expr.ClearExpressions;
                Exit;
            end;
        end;
    finally
       richEdit.Lines.EndUpdate;
    end;

    if ExprEdit.Text <> '' then
    begin
        if ListBox.Items.IndexOf(ExprEdit.Text) < 0 then
        begin
            ListBox.Selected[ListBox.Items.Add(ExprEdit.Text)] := true;
        end;
        ExprEdit.Text := '';
    end;
end;

procedure TScriptingGridForm.ExprEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var i: Integer;
begin
  case Key of
  VK_UP:  begin
          i := ListBox.ItemIndex;
          if (i > 0) and (ExprEdit.Text <> '') then Dec(i);
          ListBox.Selected[i] := true;
          ExprEdit.Text := ListBox.Items[I];
          ExprEdit.SelStart := Length(ListBox.Items[I]);
          end;
  VK_DOWN:begin
          i := ListBox.ItemIndex;
          if (i < (ListBox.Items.Count-1)) and (ExprEdit.Text <> '') then Inc(i);
          ListBox.Selected[i] := true;
          ExprEdit.Text := ListBox.Items[I];
          ExprEdit.SelStart := Length(ListBox.Items[I]);
          end;
  VK_RETURN: EvaluateExpression;
  end;
end;

procedure TScriptingGridForm.ExprEditMouseEnter(Sender: TObject);
begin
    StatusBar.Panels[0].Text := 'Type the expression';
end;

procedure TScriptingGridForm.DoSetGrid1(const Sender: TExprGridVariable; const src: string; const row, col: integer);
begin
    Grid1.Cells[col+1, row+1] := src;
end;

procedure TScriptingGridForm.DoSetGrid2(const Sender: TExprGridVariable; const Src: string; const row, col: integer);
begin
    Grid2.Cells[col+1, row+1] := src;
end;

procedure TScriptingGridForm.AssignButtonClick(Sender: TObject);
begin
    case PageControl.ActivePageIndex of
    0: ScriptEdit.SelText := Format('grid1(%d,%d) = %s', [Grid1.Row-1, Grid1.Col-1, Grid1.Cells[Grid1.Col, Grid1.Row]]);
    1: ScriptEdit.SelText := Format('grid2(%d,%d) = %s', [Grid2.Row-1, Grid2.Col-1, Grid2.Cells[Grid2.Col, Grid2.Row]]);
    end;
end;

procedure TScriptingGridForm.DoGetGrid1(const Sender: TExprGridVariable; var Dst: string; const row, col: integer);
begin
     Dst := Grid1.Cells[col+1, row+1];
end;

procedure TScriptingGridForm.DoGetGrid2(const Sender: TExprGridVariable; var dst: string; const row, col: integer);
begin
     Dst := Grid2.Cells[col+1, row+1];
end;

procedure TScriptingGridForm.SetupGrid(const aGrid: TStringGrid);
var i: integer;
begin
    aGrid.ColCount := 1000;
    aGrid.RowCount := 10000;
    for i := 0 to aGrid.ColCount-1 do aGrid.ColWidths[i] := 80;
    aGrid.Cells[0,0] := aGrid.Name;

    for i := 0 to aGrid.ColCount-1 do aGrid.Cells[i+1, 0] := IntToStr(i);
    for i := 0 to aGrid.RowCount-1 do aGrid.Cells[0, i+1] := IntToStr(i);
end;

procedure TScriptingGridForm.SetupGrids;
begin
    SetupGrid(Grid1);
    SetupGrid(Grid2);
end;

function TScriptingGridForm.ScriptEditActiveLine: integer;
begin
    {$IFDEF D16}
    Result := ScriptEdit.ActiveLineNo;
    {$ELSE}
    Result := ScriptEdit.Perform(EM_LINEFROMCHAR, ScriptEdit.SelStart, 0);
    {$ENDIF}
end;

procedure TScriptingGridForm.StepButtonClick(Sender: TObject);
var k: integer;
    scriptPresent: boolean;
begin
    //check first, if the script was already added to expression parser
    scriptPresent := True;
    if Expr.ExprCount <> ScriptEdit.Lines.Count then
    begin
        scriptPresent := False;
    end else
    for k := 0 to ScriptEdit.Lines.Count-1 do
    begin
        if Expr.Expression[k] <> ScriptEdit.Lines[k] then
        begin
            scriptPresent := false;
            Break;
        end;
    end;

    if not scriptPresent then
    begin
        Expr.ClearExpressions;
        for k := 0 to ScriptEdit.Lines.Count-1 do Expr.AddExpr(ScriptEdit.Lines[k]);
        expr.Compile;
    end;
    //then execute one line

    k := ScriptEditActiveLine;

    if k >= Expr.ExprCount then
    begin
        RichEdit.Lines.Add('The script is past the last line!');
        RichEdit.Lines.Add('');
        Exit;
    end;
    k := Expr.EvaluateStep(k);
    if k >= Expr.ExprCount then
    begin
        RichEdit.Lines.Add('The script has reached the end!');
        RichEdit.Lines.Add('');
        Exit;
    end;
    ScriptEdit.SelStart :=  ScriptEdit.Perform(EM_LINEINDEX, k, 0);
    ScriptEdit.SelLength := Length(ScriptEdit.Lines[k]);
    ScriptEditMouseMove(Sender, [],0,0); //update ActiveLineNo

    UpdateVarView;
end;

procedure TScriptingGridForm.EditModeButtonClick(Sender: TObject);
begin
    Editing := not Editing;
    EditModeButton.Down := Editing;

    if Editing then
    begin
        Grid1.Options := Grid1.Options + [goEditing];
        Grid2.Options := Grid2.Options + [goEditing];
    end else
    begin
        Grid1.Options := Grid1.Options - [goEditing];
        Grid2.Options := Grid2.Options - [goEditing];
    end;
end;

procedure TScriptingGridForm.ResetButtonClick(Sender: TObject);
var k: integer;
begin
    k := 0;
    ScriptEdit.Perform(EM_LINEINDEX, k, 0); //go to line 0
    ScriptEdit.SelStart :=  ScriptEdit.Perform(EM_LINEINDEX, k, 0);
    ScriptEdit.SelLength := Length(ScriptEdit.Lines[k]);
    ScriptEditMouseMove(Sender, [],0,0); //update ActiveLineNo
end;

procedure TScriptingGridForm.ResetWorkspaceButtonClick(Sender: TObject);
begin
    Expr.ClearAll;
    DefineCustomValues;
    UpdateVarView;
end;

procedure TScriptingGridForm.DefineCustomValues;
begin
   expr.DefineCustomValue('grid1', grid1var);
   expr.DefineCustomValue('grid2', grid2var);

   if Chart1.SeriesCount > 0 then expr.DefineCustomValue('series1', Chart1.Series[0]);
   if Chart2.SeriesCount > 0 then expr.DefineCustomValue('series2', Chart2.Series[0]);
end;

procedure TScriptingGridForm.FormCreate(Sender: TObject);
begin
   grid1var := TExprGridVariable.Create;
   grid2var := TExprGridVariable.Create;

   Expr := TMtxExpression.Create;
//   Expr.ConstantsAlwaysReal := True;
//   Expr.SelfTest;

   RichEdit.Lines[0] := '';
   ExprEdit.Text := 'clear';
   EvaluateExpression;
   ExprEdit.Text := 'help';
   EvaluateExpression;
   ExprEdit.Text := 'j = -2';
   EvaluateExpression;

   grid1var.OnSetValue := DoSetGrid1;
   grid1var.OnGetValue := DoGetGrid1;

   grid2var.OnSetValue := DoSetGrid2;
   grid2var.OnGetValue := DoGetGrid2;

   DefineCustomValues;

   //define custom functions
   expr.DefineFunction('drawvalues', _drawvalues5, 5, 0, 'drawvalues(vector Y, TChartSeries series, double xOffset, double xStep, boolean pixeldownsample Draws values from Y to second "TChartSeries" custom object.');
   expr.DefineFunction('drawvalues', _drawvalues4, 4, 0, 'drawvalues(vector X, vector Y, TChartSeries series, boolean pixeldownsample Draws values with (X,Y) coordinates to second "TChartSeries" custom object.');

   UpdateVarView;

   WorkspaceIndex := -1;

   PopulateScriptList;
   ScriptBox.ItemIndex := 0;
   Scriptbox.OnChange(Self);

   SetupGrids;

//   VarView.Column[2].Width := 200;
end;

procedure TScriptingGridForm.FormDestroy(Sender: TObject);
var i: integer;
begin
   for i := 0 to ScriptBox.Items.Count-1 do
   begin
       ScriptBox.Items.Objects[i].Free;
       ScriptBox.Items.Objects[i] := nil;
   end;


   for i := 0 to WorkSpaceBox.Items.Count-1 do
   begin
        WorkSpaceBox.Items.Objects[i].Free;
        WorkSpaceBox.Items.Objects[i] := nil; //for ARC
   end;

   Expr.Free;
   grid1var.Free;
   grid2var.Free;
end;

procedure TScriptingGridForm.Grid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
    //
end;

procedure TScriptingGridForm.Grid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var i, j: integer;
    a: TStringGrid;
begin
    a := nil;
    case PageControl.ActivePageIndex of
    0: a := grid1;
    1: a := grid2;
    end;

    if Key = VK_DELETE then
    begin
          for i := a.Selection.Top to a.Selection.Bottom do
              for j := a.Selection.Left to a.Selection.Right do a.Cells[j, i] := '';
    end;
end;

function TScriptingGridForm.GridSelection: string;
var rowr, colr: string;
begin
    case PageControl.ActivePageIndex of
    0:  begin
           if (grid1.Selection.Top <> grid1.Selection.Bottom) then //row range
           rowr := Format('%d:%d',[grid1.Selection.Top-1,grid1.Selection.Bottom-1])
           else rowr := IntToStr(grid1.Selection.Top-1);

           if (grid1.Selection.Left <> grid1.Selection.Right) then //column range
           colr := Format('%d:%d',[grid1.Selection.Left-1,grid1.Selection.Right-1])
           else colr := IntToStr(grid1.Selection.Left-1);

           Result := 'grid1(' + rowr + ',' + colr + ')';
       end;
   1:  begin
           if (grid2.Selection.Top <> grid2.Selection.Bottom) then //row range
           rowr := Format('%d:%d',[grid2.Selection.Top-1,grid2.Selection.Bottom-1])
           else rowr := IntToStr(grid2.Selection.Top-1);

           if (grid2.Selection.Left <> grid2.Selection.Right) then //column range
           colr := Format('%d:%d',[grid2.Selection.Left-1,grid2.Selection.Right-1])
           else colr := IntToStr(grid2.Selection.Left-1);

           Result := 'grid2(' + rowr + ',' + colr + ')';
       end;
   end;
end;

function TScriptingGridForm.GridSelectionValues: string;
var rowr, colr: string;
    i, j: integer;
begin
    case PageControl.ActivePageIndex of
    0:  begin
           for i := grid1.Selection.Top to grid1.Selection.Bottom do //across rows
           begin
               colr := '';
               for j := grid1.Selection.Left to grid1.Selection.Right do //across cols
               begin
                    if j < grid1.Selection.Right then colr := colr + grid1.Cells[j, i] + ','
                                                 else colr := colr + grid1.Cells[j, i];

               end;
               if i < grid1.Selection.Bottom then rowr := rowr + colr + ';'
                                             else rowr := rowr + colr;
           end;
       end;
   1:  begin
           for i := grid1.Selection.Top to grid1.Selection.Bottom do //across rows
           begin
               colr := '';
               for j := grid1.Selection.Left to grid1.Selection.Right do //across cols
               begin
                    if j < grid1.Selection.Right then colr := colr + grid1.Cells[j, i] + ','
                                                 else colr := colr + grid1.Cells[j, i];

               end;
               if i < grid1.Selection.Bottom then rowr := rowr + colr + ';'
                                             else rowr := rowr + colr;
           end;
       end;
   end;
   Result := '[' + rowr  +']';
end;

procedure TScriptingGridForm.GridInsertEditButtonClick(Sender: TObject);
begin
    ExprEdit.SelText := GridSelection;
end;

procedure TScriptingGridForm.GridInsertScriptButtonClick(Sender: TObject);
begin
    ScriptEdit.SelText := GridSelection;
end;

procedure TScriptingGridForm.GridAssignEditButtonClick(Sender: TObject);
begin
    case PageControl.ActivePageIndex of
    0: ExprEdit.SelText := Format('%s = %s', [GridSelection, GridSelectionValues]);
    1: ExprEdit.SelText := Format('%s = %s', [GridSelection, GridSelectionValues]);
    end;
end;

procedure TScriptingGridForm.GridAssignScriptButtonClick(Sender: TObject);
begin
    case PageControl.ActivePageIndex of
    0: ScriptEdit.SelText := Format('%s = %s', [GridSelection, Grid1.Cells[Grid1.Col, Grid1.Row]]);
    1: ScriptEdit.SelText := Format('%s = %s', [GridSelection, Grid2.Cells[Grid2.Col, Grid2.Row]]);
    end;
end;

procedure TScriptingGridForm.ListBoxClick(Sender: TObject);
begin
    ExprEdit.Text := ListBox.Items[ListBox.ItemIndex];
end;

procedure TScriptingGridForm.ListBoxDblClick(Sender: TObject);
begin
    ExprEdit.Text := ListBox.Items[ListBox.ItemIndex];
    EvaluateExpression;
end;

procedure TScriptingGridForm.ListBoxMouseEnter(Sender: TObject);
begin
    StatusBar.Panels[0].Text := 'Double click to execute expression';
end;

procedure TScriptingGridForm.RichEditMouseEnter(Sender: TObject);
begin
    StatusBar.Panels[0].Text := 'Select and rigth click to copy text';
end;

function TScriptingGridForm.WordUnderMouseInRichEdit(const pt: TPoint): string;
var ci, //Character Index
    li, //Line Index
    co: integer; //Character Offset
begin
    Result := '';
    ci := ScriptEdit.Perform(Messages.EM_CHARFROMPOS, 0, NativeInt(@Pt));
    if ci < 0 then Exit;
    li  := ScriptEdit.Perform(EM_EXLINEFROMCHAR, 0, ci);
    co := ci - ScriptEdit.Perform(EM_LINEINDEX, li, 0);
    if li > (ScriptEdit.Lines.Count-1) then Exit;

    Result := Expr.ExpandCharToWord(ScriptEdit.Lines[li], co);
end;

procedure TScriptingGridForm.ScriptEditMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var aName: string;
    aVar: TValueRec;
    aPoint: TPoint;
begin
    LineLabel.Caption := 'Line: ' + IntToStr(ScriptEditActiveLine);

    aName := WordUnderMouseInRichEdit(Point(X,Y));
    if Expr.IsCompiled then
    begin
        aVar := Expr.VarByName[aName];
    //    if Assigned(aVar) then
    //    begin
    //        ScriptEdit.ShowHint := True;
    //        ScriptEdit.Hint := expr.VarToolTip(aName, aVar);
    //        Application.ActivateHint(ScriptEdit.ClientToScreen(Point(X,Y)));
    //        Application.HintHidePause := 4000;
    //    end else ScriptEdit.ShowHint := False;

        if Assigned(aVar) then
        begin
            if not Assigned(mtxToolTip) then mtxToolTip := TExprToolTipForm.Create(Self);
            if not mtxToolTip.Showing then
            begin
                aPoint := ScriptEdit.ClientToScreen(Point(X,Y));
                mtxToolTip.Left := aPoint.X-4;
                mtxToolTip.Top := aPoint.Y+2;
            end;
            case aVar.ValueType of
              vtUndefined,
              vtDoubleValue,
              vtRangeValue,
              vtString,
              vtComplexValue,
              vtIntegerValue,
              vtBoolValue: begin
                           ScriptEdit.ShowHint := True;
                           ScriptEdit.Hint := expr.VarToolTip(aName, aVar);
                           Application.ActivateHint(ScriptEdit.ClientToScreen(Point(X,Y)));
                           Application.HintHidePause := 4000;
                           end;

              vtVectorValue:     mtxToolTip.UpdateGrid(aVar.VectorValue, aName);
              vtIntVectorValue:  mtxToolTip.UpdateGrid(aVar.IntVectorValue, aName);
              vtIntMatrixValue:  mtxToolTip.UpdateGrid(aVar.IntMatrixValue, aName);
              vtBoolVectorValue: mtxToolTip.UpdateGrid(aVar.BoolVectorValue, aName);
              vtBoolMatrixValue: mtxToolTip.UpdateGrid(aVar.BoolMatrixValue, aName);
              vtMatrixValue:     mtxToolTip.UpdateGrid(aVar.MatrixValue, aName);
              vtCustomValue: ;
            end;

        end else
        begin
            if Assigned(MtxToolTip) then MtxToolTip.Hide;
            ScriptEdit.ShowHint := False;
        end;
    end;
end;

procedure TScriptingGridForm.SaveAsButtonClick(Sender: TObject);
var aStr: string;
    aScript: TStringList;
begin
    astr := InputBox('Create new script','Please specify script name','aScript');

    aScript := TStringList.Create;
    aScript.Assign(ScriptEdit.Lines);
    ScriptBox.AddItem(aStr, aScript);
end;

procedure TScriptingGridForm.SaveWorkspace(const dst: TExprWorkspace; const dstName: string);
var i: integer;
begin
    dst.Name := dstName;
    dst.History.Assign(Listbox.Items);
    dst.ScriptNames.Assign(ScriptBox.Items);

    dst.Scripts.Clear;
    //traverse the ScriptBox Object contents:
    for i := 0 to ScriptBox.Items.Count-1 do
        dst.Scripts.Add(TStringList(ScriptBox.Items.Objects[i]).Text);

    Expr.SaveContext(dst.Variables);
end;

procedure TScriptingGridForm.SaveWorkButtonClick(Sender: TObject);
var aStr: string;
    aWSpace: TExprWorkspace;
begin
    aStr := 'aWorkspace';
    if InputQuery('Create new workspace','Workspace name',aStr) then
    begin
        if ScriptBox.ItemIndex >= 0 then //save changes to current script
            TStringList(ScriptBox.Items.Objects[ScriptBox.ItemIndex]).Assign(ScriptEdit.Lines);

        aWSpace := TExprWorkspace.Create;
        SaveWorkspace(aWspace, aStr);
        WorkspaceBox.AddItem(aStr, aWSpace);

        if WorkspaceBox.Items.Count = 1 then
        begin
            WorkspaceBox.ItemIndex := 0;
            WorkspaceBoxChange(nil);
        end;
    end;
end;

procedure TScriptingGridForm.DeleteWorkButtonClick(Sender: TObject);
var i: integer;
begin
    if WorkspaceBox.Items.Count > 0 then
    begin
        WorkSpaceBox.Items.Objects[WorkSpaceBox.ItemIndex].Free;
        WorkSpaceBox.Items.Objects[WorkSpaceBox.ItemIndex] := nil; //for ARC

        i := WorkSpaceBox.ItemIndex;
        WorkSpaceBox.Items.Delete(i);

        if WorkSpaceBox.Items.Count > 0 then WorkSpaceBox.ItemIndex := EnsureRange(0, i, WorkSpaceBox.Items.Count-1)
                                        else WorkSpaceBox.ItemIndex := -1;
        WorkspaceBoxChange(nil);
    end;
end;

procedure TScriptingGridForm.WorkspaceBoxChange(Sender: TObject);
var aWSpace: TExprWorkspace;
    i: integer;
begin
    if (WorkspaceIndex >= 0) and (WorkspaceIndex < WorkspaceBox.Items.Count) then //save previous state
    begin
        if ScriptBox.ItemIndex >= 0 then //save changes to current script
            TStringList(ScriptBox.Items.Objects[ScriptBox.ItemIndex]).Assign(ScriptEdit.Lines);

        aWSpace := TExprWorkspace(WorkSpaceBox.Items.Objects[WorkspaceIndex]);
        SaveWorkspace(aWspace, aWSpace.Name);
    end;

    WorkspaceIndex := WorkspaceBox.ItemIndex;

    if WorkspaceIndex >= 0 then //loda new state
    begin
        //load workspace
        aWSpace := TExprWorkspace(WorkspaceBox.Items.Objects[WorkspaceIndex]);

        ListBox.Items.Assign(aWSpace.History);

        //release ScriptBox items
        for i := 0 to ScriptBox.Items.Count-1 do
        begin
            TStringList(ScriptBox.Items.Objects[i]).Free;
            ScriptBox.Items.Objects[i] := nil;
        end;

        ScriptBox.Items.Assign(aWSpace.ScriptNames);

        //traverse the ScriptBox Object contents:
        for i := 0 to ScriptBox.Items.Count-1 do
        begin
            ScriptBox.Items.Objects[i] := TStringList.Create;
            TStringList(ScriptBox.Items.Objects[i]).Text := aWspace.Scripts[i];
        end;
        ScriptBox.ItemIndex := 0;
        ScriptBoxChange(Sender);

        Expr.LoadContext(aWSpace.Variables);
        Expr.ClearExpressions;
        DefineCustomValues;

        UpdateVarView;
    end else
    begin
        ScriptEdit.Clear;
        expr.ClearExpressions;

        //release ScriptBox items
        for i := 0 to ScriptBox.Items.Count-1 do
        begin
            TStringList(ScriptBox.Items.Objects[i]).Free;
            ScriptBox.Items.Objects[i] := nil;
        end;

        ScriptBox.Clear;
        WorkspaceBox.Clear;
    end;
end;

procedure TScriptingGridForm.DeleteScriptButtonClick(Sender: TObject);
var i: integer;
begin
    if Scriptbox.Items.Count > 0 then
    begin
        ScriptBox.Items.Objects[Scriptbox.ItemIndex].Free;
        ScriptBox.Items.Objects[Scriptbox.ItemIndex] := nil; //for ARC

        i := Scriptbox.ItemIndex;
        Scriptbox.Items.Delete(i);

        if Scriptbox.Items.Count > 0 then Scriptbox.ItemIndex := EnsureRange(0, i, Scriptbox.Items.Count-1)
                                     else Scriptbox.ItemIndex := -1;
        ScriptBoxChange(nil);
    end;
end;

procedure TScriptingGridForm.PopulateScriptList;
var aScript: TStringList;
begin
    aScript := TStringList.Create;
    aScript.Add('//initialize');
    aScript.Add('a = 0.1');
    aScript.Add('grid1(0:500,0:10) = "" //clear the grid');
    aScript.Add('grid1(1,0) = "Frequency ="');
    aScript.Add('grid1(1,1) = a');
    aScript.Add('');
    aScript.Add('//do the math');
    aScript.Add('f = grid1(1,1)  //pick up value from the grid');
    aScript.Add('b = cos([0.0:1023]*pi*f) //create time series');
    aScript.Add('(mag, phase) = carttopolar(fft(b))');
    aScript.Add('');
    aScript.Add('grid1(2,0) = "Peak value ="');
    aScript.Add('grid1(2,1) = max(mag)');
    aScript.Add('');
    aScript.Add('xOffset = 0.0;');
    aScript.Add('xStep = 2.0/length(b);');
    aScript.Add('drawvalues(mag(0:511),series1,xOffset, xStep,false);');
    aScript.Add('drawvalues(b,series2,0, 0.5/length(b),false);');
    aScript.Add('');
    aScript.Add('//display in the grid');
    aScript.Add('len = length(mag)/.2');
    aScript.Add('grid2(0,0) = "Magnitude"');
    aScript.Add('grid2(1:,0) = mag(0:(len-1))');
    aScript.Add('grid2(0,1) = "Phase"');
    aScript.Add('grid2(1:,1) = phase(0:(len-1))');
    ScriptBox.AddItem('FFT Spectrum', aScript);

    aScript := TStringList.Create;
    aScript.Add('grid1(0:500,0:10) = "" //clear the grid');
    aScript.Add('grid1(0,0) = "Student PDF"');
    aScript.Add('grid1(1,0) = "x"');
    aScript.Add('');
    aScript.Add('ax = [0:0.01:10]');
    aScript.Add('grid1(2:,0) = ax');
    aScript.Add('for i = 1:10');
    aScript.Add('    b = StudentPDF(ax, i);');
    aScript.Add('    grid1(1,i) = ["DOF ", i];');
    aScript.Add('    grid1(2:,i) = b;');
    aScript.Add('end');
    ScriptBox.AddItem('Student distribution', aScript);

    aScript := TStringList.Create;
    aScript.Add('undefine(a,k) //undefine type of a, k vars if defined');
    aScript.Add('');
    aScript.Add('// some comment');
    aScript.Add('');
    aScript.Add('a = -2.0');
    aScript.Add('i = 0');
    aScript.Add('for k = 0:6666666');
    aScript.Add('   a = a + 0.0000003');
    aScript.Add('   i = i + 1');
    aScript.Add('end');
    ScriptBox.AddItem('for-loop', aScript);
  //
end;

procedure TScriptingGridForm.ScriptBoxChange(Sender: TObject);
var aList: TStringList;
begin
    if Scriptbox.ItemIndex >= 0 then
    begin
        aList := TStringList(ScriptBox.Items.Objects[Scriptbox.ItemIndex]);

        ScriptEdit.Clear;
        ScriptEdit.Lines.Assign(aList);

        expr.ClearExpressions;
        Expr.AddExpr(aList);

        ResetButtonClick(Sender);
        ScriptEdit.SelLength := 0;
    end else
    begin
        ScriptBox.Clear;
        ScriptEdit.Clear;
        expr.ClearExpressions;
    end;
end;

procedure TScriptingGridForm.ScriptEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    LineLabel.Caption := 'Line: ' + IntToStr(ScriptEditActiveLine);
end;

procedure _drawvalues5(const Param: TExprRec);
var vt1,vt2,vt3, vt4, vt5: TValueType;
begin
    vt1 := Param.Args[0].ValueType;
    vt2 := Param.Args[1].ValueType;
    vt3 := Param.Args[2].ValueType;
    vt4 := Param.Args[3].ValueType;
    vt5 := Param.Args[4].ValueType;
    if (vt1 <> vtVectorValue) or (vt2 <> vtCustomValue) or (not Param.Args[2].IsRealValue) or (not Param.Args[3].IsRealValue) or
       (vt5 <> vtBoolValue) then UnsupportedValueTypesError(Param, vt1, vt2, vt3, vt4, vt5);

    DrawValues(Param.Args[0].VectorValue, TChartSeries(Param.Args[1].CustomValue),
               Param.Args[2].DoubleValue, Param.Args[3].DoubleValue, Param.Args[4].BoolValue);
end;

procedure _drawvalues4(const Param: TExprRec);
var vt1,vt2,vt3, vt4: TValueType;
begin
    vt1 := Param.Args[0].ValueType;
    vt2 := Param.Args[1].ValueType;
    vt3 := Param.Args[2].ValueType;
    vt4 := Param.Args[3].ValueType;
    if (vt1 <> vtVectorValue) or (vt2 <> vtVectorValue) or
       (vt3 <> vtCustomValue) or (vt4 <> vtBoolValue) then UnsupportedValueTypesError(Param, vt1, vt2, vt3, vt4);

    DrawValues(Param.Args[0].VectorValue, Param.Args[1].VectorValue, TChartSeries(Param.Args[2].CustomValue),Param.Args[3].BoolValue);
end;

initialization
  RegisterClass(TScriptingGridForm);

end.

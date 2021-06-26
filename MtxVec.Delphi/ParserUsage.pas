unit ParserUsage;

interface

{$I bdsppdefs.inc}
                 
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Basic2, StdCtrls, ComCtrls, ExtCtrls, Buttons, Contnrs,
  ValueEditorForm, MtxParseClass, MtxParseExpr, MtxBaseComp;

type
  TfrmParserUsage = class(TBasicForm2)
    Label1: TLabel;
    memoExpr: TMemo;
    Label4: TLabel;
    lbVars: TListBox;                                         
    btnAddVar: TButton;
    btnDelVar: TButton;
    btnClearVarList: TButton;
    btnSetVar: TButton;
    Label5: TLabel;
    cbExamples: TComboBox;
    Label6: TLabel;
    lbResults: TListBox;
    memoErrMsg: TMemo;
    PageControl1: TPageControl;
    tsConstants: TTabSheet;
    tsFunctions: TTabSheet;
    tsOperators: TTabSheet;
    lbConstants: TListBox;
    lbFunctions: TListBox;
    lbOperators: TListBox;
    btnDetect: TButton;
    btn0: TSpeedButton;
    btnDot: TSpeedButton;
    btn1: TSpeedButton;
    btn2: TSpeedButton;
    btn3: TSpeedButton;
    btn4: TSpeedButton;
    btn5: TSpeedButton;
    btn6: TSpeedButton;
    btn7: TSpeedButton;
    btn8: TSpeedButton;
    btn9: TSpeedButton;
    btnCloseBracket: TSpeedButton;
    btnOpenBracket: TSpeedButton;
    btnI: TSpeedButton;
    btnEvaluate: TButton;
    btnClearExpr: TButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    eval1: TMtxFunctionEvaluator;
    procedure btnDetectClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnEvaluateClick(Sender: TObject);
    procedure btnSetVarClick(Sender: TObject);
    procedure btnAddVarClick(Sender: TObject);
    procedure btnDelVarClick(Sender: TObject);
    procedure btnClearVarListClick(Sender: TObject);
    procedure lbVarsDblClick(Sender: TObject);
    procedure lbVarsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnSymClick(Sender: TObject);
    procedure lbSymbolsDblClick(Sender: TObject);
    procedure btnClearExprClick(Sender: TObject);
    procedure cbExamplesChange(Sender: TObject);
    procedure lbConstantsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbFunctionsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbOperatorsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
  private { Private declarations }
    fVars: TVariableCollection;
    fConstHelp: TStringList;
    fOperHelp: TStringList;
    fFuncHelp: TStringList;
    fValueEditor: TfmValueEditor;

    procedure InsertText(const txt: string);
    procedure EnableControls(enabled: boolean);

    procedure OnEditOk (Sender: TObject);
    procedure OnEditCancel (Sender: TObject);
    procedure cbExamplesChanged;
    procedure ShowHelp(lb: TListBox; help: TStrings; x, y: integer);
  public { Public declarations }
  end;

var
  frmParserUsage: TfrmParserUsage;

implementation
uses
  Math387, AbstractMtxVec, MtxVec
  {$IFDEF CLR}
  ,Borland.Vcl.Types
  {$ELSE}
  ,Types
  {$ENDIF}
  {$IFDEF D16}
  ,UITypes
  {$ENDIF}
  ;


{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure PleaseConfirm (const question: string);
begin
  if MessageDlg( 'Please confirm',mtConfirmation,[mbYes,mbNo],0) <> mrYes then Abort;
end;

{ TfrmParserUsage }

procedure TfrmParserUsage.FormCreate(Sender: TObject);

  procedure CreateValueEditor;
  begin
    fValueEditor:= TfmValueEditor.Create(Self);
//    fValueEditor.Parent:= Panel3;
    fValueEditor.Visible:= FALSE;
    fValueEditor.Left:= btn7.Left - 16;
    fValueEditor.Top:= btn7.Top - 16;
    fValueEditor.Width:= cbExamples.Left+ cbExamples.Width - btn7.Left + 24;
    fValueEditor.Height:= lbResults.Top + lbResults.Height - btn7.Top + 24;
    fValueEditor.frmValueEditor1.btnOk.OnClick:= OnEditOk;
    fValueEditor.frmValueEditor1.btnCancel.OnClick:= OnEditCancel;
  end;

  procedure PrepareExamples;
  var
    i: integer;
    eval: TMtxFunctionEvaluator;
    line: string;
  begin
    cbExamples.Clear;
    for i:= 0 to ComponentCount-1 do begin
      if Components[i] is TMtxFunctionEvaluator then begin
        eval:= TMtxFunctionEvaluator(Components[i]);
        if Assigned (eval) then begin
          line:= StringReplace(eval.Context.Expression, #13#10, ' ', [rfReplaceAll]);
          cbExamples.AddItem (line, eval);
        end;
      end;
    end;
    cbExamples.ItemIndex:= 0;
    cbExamplesChanged;
  end;

  procedure LoadSymbols;
  var
    i: integer;
  begin
    eval1.Expressions.GetConstList (lbConstants.Items, fConstHelp);
    eval1.Expressions.GetFuncList (lbFunctions.Items, fFuncHelp, TRUE);
    eval1.Expressions.GetOperList (lbOperators.Items, fOperHelp);

    for i:= lbOperators.Items.Count-1 downto 0 do begin
      if (Length(lbOperators.Items[i]) = 2) and (lbOperators.Items[i][2] = '@') then begin
        lbOperators.Items.Delete (i);
        fOperHelp.Delete(i);
      end;
    end;

    lbConstants.ItemIndex:= 0;
    lbFunctions.ItemIndex:= 0;
    lbOperators.ItemIndex:= 0;
  end;

begin
  inherited;
  fVars:= TVariableCollection.Create;
  fConstHelp:= TStringList.Create;
  fFuncHelp:= TStringList.Create;
  fOperHelp:= TStringList.Create;

  CreateValueEditor;
  PrepareExamples;
  LoadSymbols;

  RichEdit1.Lines.Clear;
  RichEdit1.Lines.Add ('TMtxExpression class is used for evaluating math formulas.');
  RichEdit1.Lines.Add('Real numbers, complex numbers, vectors and matrices are supported.');
  RichEdit1.Lines.Add('');
  RichEdit1.Lines.Add('1. Enter arithmetic expression (or select one of the predefined list).');
  RichEdit1.Lines.Add('2. Press [Detect] button to collect variables to the list (already done for predefined examples).');
  RichEdit1.Lines.Add('3. Define each variable with type and value (already done for predefined examples).');
  RichEdit1.Lines.Add('4. Press [Evaluate] button and look at the results.');
end;

procedure TfrmParserUsage.FormDestroy(Sender: TObject);
begin
  fOperHelp.Free;
  fFuncHelp.Free;
  fConstHelp.Free;
  fVars.Free;
  inherited;
end;

procedure TfrmParserUsage.cbExamplesChanged;
var
  eval: TMtxFunctionEvaluator;
  i, idx: integer;
begin
  memoExpr.Clear;
  lbVars.Clear;
  fVars.Clear;
  lbResults.Clear;

  idx:= cbExamples.ItemIndex;
  if idx = -1 then
    Abort;

  eval:= cbExamples.Items.Objects[idx] as TMtxFunctionEvaluator;
  memoExpr.Lines.Text:= eval.Context.Expression;
  fVars.Assign(eval.Context.Variables);
  for i:= 0 to fVars.Count-1 do
    lbVars.AddItem (fVars[i].VarName  + ': ' + fVars[i].Value.AsString, fVars[i]);
end;

procedure TfrmParserUsage.cbExamplesChange(Sender: TObject);
begin
  cbExamplesChanged;
  btnEvaluate.Click;
end;

procedure TfrmParserUsage.InsertText(const txt: string);
var p,bp: integer;
    s: string;
begin
  if txt = '' then
    Exit;
    
  p:= memoExpr.SelStart;
  s:= txt;

  if (s[1] = ' ') and ((p = 0) or
  {$IFDEF D15}
  CharInSet(memoExpr.Lines.Text[p], [' ','(']))
  {$ELSE}
  (memoExpr.Lines.Text[p] in [' ','(']))
  {$ENDIF}
  then Delete (s,1,1);

  if (s[Length(s)] = ' ') and ((p < Length(memoExpr.Lines.Text)) and
  {$IFDEF D15}
  CharInSet(memoExpr.Lines.Text[p+1],[',',')']))
  {$ELSE}
  (memoExpr.Lines.Text[p+1] in [',',')']))
  {$ENDIF}
  then Delete (s,Length(s),1);

  bp:= Pos ('(', s);
  memoExpr.SelText:= s;
  if bp > 0 then memoExpr.SelStart:= p+bp;
  if memoExpr.CanFocus then memoExpr.SetFocus;
end;

procedure TfrmParserUsage.btnDetectClick(Sender: TObject);
var
  eval: TMtxExpression;
  list: TStringList;
  i: integer;
  v: TNamedVariable;
begin
  memoErrMsg.Text:= '';
  try
    eval:= TMtxExpression.Create;
    list:= TStringList.Create;
    try
      eval.AddExpr (memoExpr.Text);
      eval.GetVarList(list);

      for i:= 0 to list.Count-1 do
      begin
        if fVars.FindByName (list[i]) = nil then begin
          v:= fVars.Add (list[i]);
          lbVars.AddItem (v.VarName + ': ' + v.Value.AsString, v);
        end;
      end;

      lbVars.ItemIndex:= 0;

    finally
      list.Free;
      eval.Free;
    end;
  except on Ex: Exception do
    memoErrMsg.Text:= Ex.Message;
  end;
end;

procedure TfrmParserUsage.btnEvaluateClick(Sender: TObject);
var
  eval: TMtxExpression;
  i: integer;
  vr: TNamedVariable;
  res: TValueRec;
  vname: string;
  list: TStringList;
begin
  memoErrMsg.Text:= '';
  try
    eval:= TMtxExpression.Create;
    try
      lbResults.Clear;

      for i:= 0 to lbVars.Count-1 do begin
        vr:= lbVars.Items.Objects[i] as TNamedVariable;
        case vr.Value.ValueType of
          vtIntegerValue:     eval.DefineInteger(vr.VarName).Value := vr.Value.IntegerValue;
          vtBoolValue:        eval.DefineBool(vr.VarName).Value := vr.Value.BoolValue;
          vtDoubleValue:      eval.DefineDouble(vr.VarName).Value := vr.Value.DoubleValue;
          vtComplexValue:     eval.DefineComplex(vr.VarName).Value := vr.Value.ComplexValue;
          vtVectorValue:      eval.DefineVector(vr.VarName).Value.Copy (vr.Value.VectorValue);
          vtMatrixValue:      eval.DefineMatrix(vr.VarName).Value.Copy (vr.Value.MatrixValue);
          vtIntVectorValue:      eval.DefineIntVector(vr.VarName).Value.Copy (vr.Value.IntVectorValue);
          vtIntMatrixValue:      eval.DefineIntMatrix(vr.VarName).Value.Copy (vr.Value.IntMatrixValue);
          vtBoolVectorValue:      eval.DefineBoolVector(vr.VarName).Value.Copy (vr.Value.BoolVectorValue);
          vtBoolMatrixValue:      eval.DefineBoolMatrix(vr.VarName).Value.Copy (vr.Value.BoolMatrixValue);
        end;
      end;

      eval.Expressions:= memoExpr.Text;
      res:= eval.Evaluate;

      lbResults.AddItem ('Result: ' + res.AsString, nil);

      list:= TStringList.Create;
      try
        eval.GetVarList(list);
        for i:= 0 to list.Count-1 do
        begin
          vname:= list[i];
          lbResults.AddItem(vname + ': ' + eval.VarByName[vname].AsString, nil);
        end;
      finally
        list.Free;
      end;

      lbResults.ItemIndex:= 0;

    finally
      eval.Free;
    end;

  except on Ex: Exception do
    memoErrMsg.Text:= Ex.Message;
  end;
end;

procedure TfrmParserUsage.EnableControls (enabled: boolean);

  procedure GroupEnable (const controls: array of TControl; enabled: boolean);
  var
    i: integer;
  begin
    for i:= Low (controls) to High (controls) do
    begin
      controls[i].Enabled:= enabled;
    end;
  end;

begin
  GroupEnable (
    [cbExamples,
    memoExpr, btnClearExpr, btnDetect,
    lbVars, btnClearVarList, btnAddVar, btnDelVar, btnSetVar, lbResults,
    btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8, btn9, btn0, btnI, btnDot,
    btnOpenBracket, btnCloseBracket,
    PageControl1,
    btnEvaluate,
    memoErrMsg],
    enabled
  );

  if not Enabled then fValueEditor.ShowModal;

//  fValueEditor.Visible:= not enabled;
end;

procedure TfrmParserUsage.OnEditOk(Sender: TObject);
var vr: TNamedVariable;
begin
  vr:= lbVars.Items.Objects[lbVars.ItemIndex] as TNamedVariable;
  lbVars.Items[lbVars.ItemIndex]:= vr.VarName + ': ' + fValueEditor.frmValueEditor1.VR.AsString;
  EnableControls(TRUE);
end;

procedure TfrmParserUsage.OnEditCancel(Sender: TObject);
begin
  EnableControls(TRUE);
end;

procedure TfrmParserUsage.btnSetVarClick(Sender: TObject);
begin
  if lbVars.ItemIndex = -1 then  Abort;
  fValueEditor.frmValueEditor1.VR:= (lbVars.Items.Objects[lbVars.ItemIndex] as TNamedVariable).Value;
  EnableControls(FALSE);
end;

procedure TfrmParserUsage.lbVarsDblClick(Sender: TObject);
begin
  if lbVars.ItemIndex >= 0 then  btnSetVar.Click;
end;

procedure TfrmParserUsage.btnAddVarClick(Sender: TObject);
var var_name: string;
    i: integer;
    v: TNamedVariable;
begin
  var_name:= '';
  if not InputQuery ('New variable', 'Enter variable name', var_name) then Abort;

  i:= 0;
  while (TRUE) do begin
    if i >= lbVars.Items.Count then begin
      v:= fVars.Add(var_name);
      i:= lbVars.Items.AddObject (v.VarName + ': ' + v.Value.AsString, v);
      break;
    end;

    if AnsiSameText ((lbVars.Items.Objects[i] as TNamedVariable).VarName, var_name) then
      break;

    Inc(i);
  end;

  lbVars.ItemIndex:= i;
  btnSetVar.Click;
end;

procedure TfrmParserUsage.btnDelVarClick(Sender: TObject);
var   idx: integer;
      v: TNamedVariable;
begin
  idx:= lbVars.ItemIndex;
  if idx = -1 then
    Abort;

  v:= lbVars.Items.Objects[idx] as TNamedVariable;
  PleaseConfirm (Format('Do you want to delete variable "%s"?', [v.VarName]));

  v.Free;
  lbVars.Items.Delete(idx);

  if idx >= lbVars.Count then Dec(idx);

  lbVars.ItemIndex:= idx;
end;

procedure TfrmParserUsage.btnClearExprClick(Sender: TObject);
begin
  PleaseConfirm ('Do you want to clear expressions?');
  memoExpr.Clear;
end;

procedure TfrmParserUsage.btnClearVarListClick(Sender: TObject);
begin
  PleaseConfirm ('Do you want to clear defined variables list?');
  lbVars.Clear;
  fVars.Clear;
  lbResults.Clear;
end;

procedure TfrmParserUsage.lbVarsMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  idx: integer;
begin
  with (Sender as TListBox) do
  begin
    idx:= ItemAtPos(Point(X,Y),TRUE);
    if idx >= 0 then  Hint:= Items[idx]
                else  Hint:= '';
    Application.ActivateHint(ClientToScreen(Point(X,Y)));
  end;
end;

procedure TfrmParserUsage.btnSymClick(Sender: TObject);
begin
  InsertText ((Sender as TSpeedButton).Caption);
end;

procedure TfrmParserUsage.lbSymbolsDblClick(Sender: TObject);
var
  lb: TListBox;
  idx: integer;
  s: string;
begin
  lb:= Sender as TListBox;
  idx:= lb.ItemIndex;
  if idx= -1 then
    Exit;

  s:= ' ' + lb.Items[idx] + ' ';
  InsertText (s);
end;

procedure TfrmParserUsage.ShowHelp (lb: TListBox; help: TStrings; x,y: integer);
var
  p: TPoint;
  idx: integer;
begin
  p:= Point(X,Y);
  idx:= lb.ItemAtPos(p, TRUE);
  if idx >= 0 then
    lb.Hint:= help[idx]
  else
    lb.Hint:= '';
  Application.ActivateHint(lb.ClientToScreen(p));
end;

procedure TfrmParserUsage.lbConstantsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ShowHelp (lbConstants, fConstHelp, X, Y);
end;

procedure TfrmParserUsage.lbFunctionsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ShowHelp (lbFunctions, fFuncHelp, X, Y);
end;

procedure TfrmParserUsage.lbOperatorsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ShowHelp (lbOperators, fOperHelp, X, Y);
end;

initialization
  RegisterClass (TfrmParserUsage);
end.

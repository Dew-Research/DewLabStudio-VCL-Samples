unit Scripting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MtxParseExpr, MtxParseClass, ComCtrls, ExtCtrls;

type
  TScriptingForm = class(TForm)
    Panel1: TPanel;
    RichEdit: TRichEdit;
    ExprEdit: TEdit;
    Splitter1: TSplitter;
    Panel2: TPanel;
    ListBox: TListBox;
    Splitter2: TSplitter;
    Label1: TLabel;
    VarView: TListView;
    Label2: TLabel;
    Splitter3: TSplitter;
    StatusBar: TStatusBar;
    Splitter4: TSplitter;
    ScriptEdit: TRichEdit;
    Panel3: TPanel;
    RunButton: TButton;
    ScriptLabel: TLabel;
    ScriptBox: TComboBox;
    Panel4: TPanel;
    procedure ExprEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RichEditMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ListBoxDblClick(Sender: TObject);
    procedure VarViewDblClick(Sender: TObject);
    procedure VarViewMouseEnter(Sender: TObject);
    procedure ListBoxMouseEnter(Sender: TObject);
    procedure RichEditMouseEnter(Sender: TObject);
    procedure ExprEditMouseEnter(Sender: TObject);
    procedure ScriptBoxChange(Sender: TObject);
    procedure RunButtonClick(Sender: TObject);
  private
    procedure EvaluateExpression;
    procedure UpdateVarView;
    { Private declarations }
  public
    { Public declarations }
    Expr: TMtxExpression;
    grid1var: TExprGridVariable;
    grid2var: TExprGridVariable;
  end;

var
  ScriptingForm: TScriptingForm;

implementation

uses Math387, MtxVec, MtxExpr, MtxVecEdit,  MtxVecTee, StringVar, AbstractMtxVec
    {$IFDEF D19} ,System.Types {$ELSE} ,Types {$ENDIF}
    ;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TScriptingForm.UpdateVarView;
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

procedure TScriptingForm.VarViewDblClick(Sender: TObject);
var a: TValueRec;
    varName: string;
begin
   varName := VarView.Selected.Caption;
   a := Expr.VarByName[varName];
   case a.ValueType of
   vtBoolVectorValue,
   vtIntVectorValue: ViewValues(a.IntVectorValue, varName);
   vtVectorValue:    ViewValues(a.VectorValue, varName);
   vtBoolMatrixValue,
   vtIntMatrixValue: ViewValues(a.IntMatrixValue, varName);
   vtMatrixValue:    ViewValues(a.MatrixValue, varName);
   end;
end;

procedure TScriptingForm.VarViewMouseEnter(Sender: TObject);
begin
    StatusBar.Panels[0].Text := 'Double click vector or matrix to examine the values';
end;

procedure TScriptingForm.RunButtonClick(Sender: TObject);
var a: TValueRec;
    i: integer;
    a2: double;
begin
    a2 := 0;
    Expr.ClearExpressions;
    for i := 0 to ScriptEdit.Lines.Count-1 do Expr.AddExpr(ScriptEdit.Lines[i]);

    Expr.Compile;
    try
        try
            StartTimer;
            a := Expr.EvaluateCompiled;
            a2 := StopTimer;
            expr.VarPrint(a, Expr.EvaluatedVarName(0), RichEdit.Lines);
        except
            on E: Exception do
            begin
                RichEdit.Lines.Add('');
                RichEdit.Lines.Add(E.Message);
            end;
        end;

    finally
        RichEdit.Lines.Add('Elapsed time: ' + FormatSample('0.0000s',a2) + ', sizeof(TSample) = ' + IntToStr(sizeof(TSample)));
        UpdateVarView;
    end;
end;

procedure TScriptingForm.EvaluateExpression;
var a: TValueRec;
  aCmd: string;
  i: Integer;
  funcList, hlpList: StringList;
begin
    Expr.ClearExpressions;
    aCmd := Trim(ExprEdit.Text);
    if aCmd = 'cls' then
    begin
        for i := 0 to RichEdit.Lines.Count - 1 do RichEdit.Lines.Delete(0);
        RichEdit.Lines[0] := '';
        Exit;
    end else
    if aCmd = 'clear' then
    begin
        Expr.ClearAll;
        for i := 0 to RichEdit.Lines.Count - 1 do RichEdit.Lines.Delete(0);
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
    except
        on E: Exception do
        begin
            RichEdit.Lines.Add(acmd + ' :');
            RichEdit.Lines.Add(E.Message);
            RichEdit.Lines.Add('');
            Exit;
        end;
    end;

    UpdateVarView;
    RichEdit.Lines.Add('');
    if not TerminatedWithSemicolon(ExprEdit.Text) then
        expr.VarPrint(a, Expr.EvaluatedVarName(0), RichEdit.Lines);

    if ExprEdit.Text <> '' then
    begin
        if ListBox.Items.IndexOf(ExprEdit.Text) < 0 then
        begin
            ListBox.Selected[ListBox.Items.Add(ExprEdit.Text)] := true;
        end;
        ExprEdit.Text := '';
    end;
end;

procedure TScriptingForm.ExprEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var i: Integer;
begin
  case Key of
  VK_UP:  begin
          i := ListBox.ItemIndex;
          if (i > 0) and (ExprEdit.Text <> '') then Dec(i);
          ListBox.Selected[i] := true;
          ExprEdit.Text := ListBox.Items[I];
          end;
  VK_DOWN:begin
          i := ListBox.ItemIndex;
          if (i < (ListBox.Items.Count-1)) and (ExprEdit.Text <> '') then Inc(i);
          ListBox.Selected[i] := true;
          ExprEdit.Text := ListBox.Items[I];
          end;
  VK_RETURN: EvaluateExpression;
  end;
end;

procedure TScriptingForm.ExprEditMouseEnter(Sender: TObject);
begin
    StatusBar.Panels[0].Text := 'Type the expression';
end;

procedure TScriptingForm.FormCreate(Sender: TObject);
begin
   grid1var := TExprGridVariable.Create;
   grid2var := TExprGridVariable.Create;

   Expr := TMtxExpression.Create;
   RichEdit.Lines[0] := '';
   ExprEdit.Text := 'clear';
   EvaluateExpression;
   ExprEdit.Text := 'help';
   EvaluateExpression;
   ExprEdit.Text := 'j = -2';
   EvaluateExpression;
   ExprEdit.Text := 'y = 10:15';
   EvaluateExpression;
   ExprEdit.Text := 'y = y(:)';
   EvaluateExpression;
   ExprEdit.Text := 'x = double(y)';
   EvaluateExpression;
   ExprEdit.Text := 'm = x(0:2)''*x(2:-1:0)';
   EvaluateExpression;
   ExprEdit.Text := 'm''';
   EvaluateExpression;
   ExprEdit.Text := 'rows(m)';
   EvaluateExpression;
   ExprEdit.Text := 'length(x)';
   EvaluateExpression;
   ExprEdit.Text := 'm(0:2) = 2:-1:0';
   EvaluateExpression;
   ExprEdit.Text := 'b = m\x(0:2)';
   EvaluateExpression;
   ExprEdit.Text := 'm*b''';
   EvaluateExpression;
   ExprEdit.Text := 'c = fft([1, b])';
   EvaluateExpression;
   ExprEdit.Text := 'c1 = [1,2,3,4,5]';
   EvaluateExpression;
   ExprEdit.Text := 'c2 = [1,2;2,3]';
   EvaluateExpression;
   ExprEdit.Text := 'c3 = [[1;2],[2;3]]';
   EvaluateExpression;
   ExprEdit.Text := 'c4 = ["Rows = ", rows(m),", Complex = ", (3+12.4i)*2i]';
   EvaluateExpression;

   expr.DefineCustomValue('grid1', grid1Var);
   expr.DefineCustomValue('grid2', grid2Var);
   UpdateVarView;



   ScriptBox.ItemIndex := 0;
   Scriptbox.OnChange(Self);

//   VarView.Column[2].Width := 200;
end;

procedure TScriptingForm.FormDestroy(Sender: TObject);
begin
   Expr.Free;
   grid1var.Free;
   grid2var.Free;
end;

procedure TScriptingForm.ListBoxDblClick(Sender: TObject);
begin
    ExprEdit.Text := ListBox.Items[ListBox.ItemIndex];
    EvaluateExpression;
end;

procedure TScriptingForm.ListBoxMouseEnter(Sender: TObject);
begin
    StatusBar.Panels[0].Text := 'Double click to execute expression';
end;

procedure TScriptingForm.RichEditMouseEnter(Sender: TObject);
begin
    StatusBar.Panels[0].Text := 'Select and rigth click to copy text';
end;

procedure TScriptingForm.RichEditMouseMove(Sender: TObject; Shift: TShiftState; X,  Y: Integer);
begin
//  ShowHint
end;

procedure TScriptingForm.ScriptBoxChange(Sender: TObject);
begin
    ScriptEdit.Clear;
    case ScriptBox.ItemIndex of
    0: begin
          ScriptEdit.Lines.Add('undefine(a,b,c) //undefine type of a,b,c vars if defined');
          ScriptEdit.Lines.Add('');
          ScriptEdit.Lines.Add('// some comment');
          ScriptEdit.Lines.Add('');
          ScriptEdit.Lines.Add('a = 2');
          ScriptEdit.Lines.Add('b = -1');
          ScriptEdit.Lines.Add('if a < 0  // more comment');
          ScriptEdit.Lines.Add('   c = 12');
          ScriptEdit.Lines.Add('   c = 2*c');
          ScriptEdit.Lines.Add('else');
          ScriptEdit.Lines.Add('   if b < 0');
          ScriptEdit.Lines.Add('      c = 1.5');
          ScriptEdit.Lines.Add('   else');
          ScriptEdit.Lines.Add('      c = 3.5 + b');
          ScriptEdit.Lines.Add('   end');
          ScriptEdit.Lines.Add('end');
       end;
    1: begin
          ScriptEdit.Lines.Add('undefine(a,i) //undefine type of a, i vars if defined');
          ScriptEdit.Lines.Add('');
          ScriptEdit.Lines.Add('// some comment');
          ScriptEdit.Lines.Add('');
          ScriptEdit.Lines.Add('a = -2.0');
          ScriptEdit.Lines.Add('i = 0');
          ScriptEdit.Lines.Add('while a < 0');
          ScriptEdit.Lines.Add('   a = a + 0.0000003');
          ScriptEdit.Lines.Add('   i = i + 1');
//          ScriptEdit.Lines.Add('   b = i:(i+3)');
          ScriptEdit.Lines.Add('end');
       end;
    2: begin
          ScriptEdit.Lines.Add('undefine(a,k) //undefine type of a, k vars if defined');
          ScriptEdit.Lines.Add('');
          ScriptEdit.Lines.Add('// some comment');
          ScriptEdit.Lines.Add('');
          ScriptEdit.Lines.Add('a = -2.0');
          ScriptEdit.Lines.Add('i = 0');
          ScriptEdit.Lines.Add('for k = 0:6666666');
          ScriptEdit.Lines.Add('   a = a + 0.0000003');
          ScriptEdit.Lines.Add('   i = i + 1');
          ScriptEdit.Lines.Add('end');
       end;
    end;
end;

initialization
  RegisterClass(TScriptingForm);

end.

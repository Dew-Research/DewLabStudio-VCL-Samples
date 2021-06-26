unit ParserDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Basic2, StdCtrls, ComCtrls, ExtCtrls, MtxParseExpr,
  Menus, Math387, MtxParseClass;

const
  Nundo = 41;

type
  TfrmParser = class(TBasicForm2)
    Label2: TLabel;                                  
    Label3: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    helplabel: TLabel;
    NEvalLabel: TLabel;
    ResultEdit: TEdit;
    Evaluate: TButton;
    XEdit: TEdit;
    GroupBox1: TGroupBox;
    PointButton: TButton;
    ExpressionEdit: TEdit;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    Button27: TButton;
    Button28: TButton;
    Button29: TButton;
    Button31: TButton;
    Button35: TButton;
    Button38: TButton;
    Button39: TButton;
    Button40: TButton;
    Button12: TButton;
    Button13: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button30: TButton;
    Button33: TButton;
    Button34: TButton;
    FunctionsCombo: TComboBox;
    Button32: TButton;
    yEdit: TEdit;
    ZEdit: TEdit;
    Button1: TButton;
    Button36: TButton;
    Button37: TButton;
    Button42: TButton;
    PopupMenu1: TPopupMenu;
    Undo1: TMenuItem;
    Redo1: TMenuItem;
    Label6: TLabel;
    ConstantsCombo: TComboBox;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure EvaluateClick(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button24KeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure FunctionsComboChange(Sender: TObject);
    procedure Button32Click(Sender: TObject);
    procedure XEditChange(Sender: TObject);
    procedure yEditChange(Sender: TObject);
    procedure ZEditChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ExpressionEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    X, Y, Z: TComplexValue;
{    PrevText: array[0..Nundo - 1] of string; }
    Iprevtext: Integer;
    istartundo: Integer;
    MyParser: TMtxExpression;
    procedure AddToEdit(S: string);
  public
    { Public declarations }
  end;

var
  frmParser: TfrmParser;

implementation

{$R *.dfm}

const
  Maxstrings = 27;
  Helpstrings: array[0..Maxstrings - 1] of string = (
    '() = brackets',
    'abs(x) = absolute value',
    'arccos(x) = inverse cosine of x in rad',
    'arccosh(x) = inverse hyperbolic cosine in rad',
    'arcsin(x) = inverse sine of x in rad',
    'arcsinh(x) = inverse hyperbolic sine in rad',
    'cos(x) = cosine of an angle in rad',
    'cosh(x) = hyperbolic cosine of an angle in rad',
    'degtorad(x) = conversion from degrees to radians',
    'exp(x) = the value of e raised to the power of x',
    'if(x1,x2,x3) = if x1=True(or 1) then x2 else x3',
    'ln(x) = natural logarithm of x',
    'log10(x) = logarithm base 10 of x',
    'logn(x1,x2) = logarithm base x1 of x2',
    'max(x1,x2) = the maximum of both arguments',
    'min(x1,x2) = the minimum of both arguments',
    'pi = 3.1415926535897932385',
    'radtodeg(x) = conversion from degrees to radians',
    'randg(x1,x2) = Draw from normal distrib. (mean=x1, sd =x2)',
    'random = random number between 0 and 1',
    'round(x) = round to the nearest integer',
    'sin(x) = sine of an angle in rad',
    'sinh(x) = hyperbolic sine of an angle in rad',
    'sqr(x) = the square of a number (x*x)',
    'sqrt(x) = the square root of a number',
    'tanh(x) = the hyperbolic tangent of an angle (rad)',
    'trunc(x) = truncates a real number to an integer');

 { TfrmParser }

procedure TfrmParser.AddToEdit(S: string);
var
  Len: Integer;
  IsFunction: Boolean;
begin
  if S = '' then S := ' ';
  with ExpressionEdit do
  begin
    IsFunction := Pos('(', S) > 0;
    Len := Sellength;
    if IsFunction and (Len > 0) then
    begin
      Sellength := 0;
      SelText := Copy(S, 1, Pos('(', S));
      SelStart := SelStart + Len;
      SelText := Copy(S, Pos('(', S) + 1, Len); ;
      SelStart := SelStart - 1;
    end
    else
    begin
      SelText := S;
      if IsFunction then SelStart := SelStart - 1;
    end;
  end;
end;

procedure TfrmParser.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines do
  begin
    Clear;
    Add('TMtxExpression and '
      + 'TMtxFunctionEvaluator componets can be used '
      + 'for parsing math formulas. Complex numbers are '
      + 'also supported.');
  end;  { assign function }
  PointButton.Caption := GetDecimalSeparator;
  MyParser := TMtxExpression.Create;

  x := MyParser.DefineComplex('x');
  y := MyParser.DefineComplex('y');
  z := MyParser.DefineComplex('z');

  X.ComplexValue := StrToCplx(XEdit.Text);
  Y.ComplexValue := StrToCplx(yEdit.Text);
  Z.ComplexValue := StrToCplx(ZEdit.Text);

  FunctionsCombo.ItemIndex := 0;
  Iprevtext := -1;
  istartundo := -1;
  FunctionsCombo.Clear;

  MyParser.GetConstList(ConstantsCombo.Items, nil);
  ConstantsCombo.ItemIndex := 0;
  MyParser.GetFuncList(FunctionsCombo.Items, nil, TRUE);
  FunctionsCombo.ItemIndex := 0;
end;


procedure TfrmParser.EvaluateClick(Sender: TObject);

  procedure SetEditText(Edit: TEdit; X: TComplexValue);
  var
    OnCh: TNotifyEvent;
  begin
    OnCh := Edit.OnChange;
    Edit.OnChange := nil;
    Edit.Text := CplxToStr(X.ComplexValue);
    Edit.OnChange := OnCh;
  end;
begin
  MyParser.AddExpr(ExpressionEdit.Text);
  ResultEdit.Text := CplxToStr(MyParser.EvaluateComplex);
  SetEditText(XEdit, X);
  SetEditText(yEdit, Y);
  SetEditText(ZEdit, Z);
end;

procedure TfrmParser.Button24Click(Sender: TObject);
begin
  AddToEdit((Sender as TButton).Caption);
end;

procedure TfrmParser.Button24KeyPress(Sender: TObject; var Key: Char);
begin
  ActiveControl := ExpressionEdit;
  with ExpressionEdit do
  begin
    SelStart := SelStart + Sellength;
    Sellength := 0;
  end;
end;

procedure TfrmParser.FormDestroy(Sender: TObject);
begin
  MyParser.Free;
  inherited;
end;

procedure TfrmParser.FunctionsComboChange(Sender: TObject);
begin
{  if (FunctionsCombo.ItemIndex >= 0) and (FunctionsCombo.ItemIndex < Maxstrings) then
    Helplabel.Caption := Helpstrings[FunctionsCombo.ItemIndex]; }
end;

procedure TfrmParser.Button32Click(Sender: TObject);
begin
  AddToEdit(FunctionsCombo.Text);
end;

procedure TfrmParser.XEditChange(Sender: TObject);
begin
  if XEdit.Text <> '' then
  begin
    X.ComplexValue := StrToCplx(XEdit.Text);
  end;
end;

procedure TfrmParser.yEditChange(Sender: TObject);
begin
  if YEdit.Text <> '' then
  begin
    Y.ComplexValue := StrToCplx(YEdit.Text);
  end;
end;

procedure TfrmParser.ZEditChange(Sender: TObject);
begin
  if ZEdit.Text <> '' then
  begin
    Z.ComplexValue := StrToCplx(ZEdit.Text);
  end;
end;

procedure TfrmParser.Button2Click(Sender: TObject);
begin
  AddToEdit(ConstantsCombo.Text)
end;

procedure TfrmParser.ExpressionEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 13 then EvaluateClick(Sender);
end;


initialization
  RegisterClass(TfrmParser);
end.

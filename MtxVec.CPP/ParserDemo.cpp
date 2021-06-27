//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "ParserDemo.h"
#include "MtxParseClass.hpp"
#pragma link "MtxParseExpr"
#include <SysUtils.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TfrmParser *frmParser;
//---------------------------------------------------------------------------
__fastcall TfrmParser::TfrmParser(TComponent* Owner)
  : TBasicForm2(Owner)
{

  AnsiString str;

  RichEdit1->Lines->Clear();
  str = "TMtxExpression and TMtxFunctionEvaluator componets can be used ";
  str+= "for parsing math formulas. Complex numbers are also supported.";
  RichEdit1->Lines->Add(str);

  #if __BORLANDC__ < 0x630
  PointButton->Caption = Sysutils::DecimalSeparator;
  #else
  PointButton->Caption = FormatSettings.DecimalSeparator;
  #endif

  MyParser = new TMtxExpression();
  X = MyParser->DefineComplex("x");
  Y = MyParser->DefineComplex("y");
  Z = MyParser->DefineComplex("z");

  X->ComplexValue = StrToCplx(XEdit->Text);
  Y->ComplexValue = StrToCplx(yEdit->Text);
  Z->ComplexValue = StrToCplx(ZEdit->Text);

  Iprevtext = -1;
  istartundo = -1;
  FunctionsCombo->Clear();

  MyParser->GetFuncList(FunctionsCombo->Items, NULL, false);
  FunctionsCombo->ItemIndex = 0;

  MyParser->GetConstList(ConstantsCombo->Items,NULL);
  ConstantsCombo->ItemIndex = 0;
}
//---------------------------------------------------------------------------
void __fastcall TfrmParser::FormDestroy(TObject *Sender)
{
  delete PrevText;
}
//---------------------------------------------------------------------------
void __fastcall TfrmParser::AddToEdit(AnsiString S)
{
  bool IsFunction;
  if (S == "") S=" ";
  IsFunction =  (S.Pos("(") > 0);
  int Len = ExpressionEdit->SelLength;
  if ((IsFunction) && (Len > 0))
  {
    ExpressionEdit->SelLength = 0;
    ExpressionEdit->SelText =  S.SubString(1,S.Pos("("));
    ExpressionEdit->SelStart += Len;
    ExpressionEdit->SelText = S.SubString(S.Pos("("),Len);
    ExpressionEdit->SelStart -= 1;
  }
  else
  {
    ExpressionEdit->SelText = S;
    if (IsFunction) ExpressionEdit->SelStart -= 1;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmParser::UpdateUndo(void)
{
  istartundo = -1;
  if ((Iprevtext <= 0) || (PrevText[Iprevtext - 1] != ExpressionEdit->Text))
  {
    Iprevtext ++;
    if (Iprevtext >= NUndo) Iprevtext = 0;
    PrevText[Iprevtext] = ExpressionEdit->Text;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmParser::SetUndoText(void)
{
  ExpressionEdit->OnChange = 0;
  ExpressionEdit->Text = PrevText[Iprevtext];
  ExpressionEdit->SelStart = ExpressionEdit->SelStart +  ExpressionEdit->Text.Length();
  ExpressionEdit->SelLength = 0;
  ExpressionEdit->OnChange = ExpressionEditChange;
}
//---------------------------------------------------------------------------
void __fastcall TfrmParser::ExpressionEditChange(TObject *Sender)
{
//  UpdateUndo();
}
//---------------------------------------------------------------------------

void __fastcall TfrmParser::ExpressionEditKeyDown(TObject *Sender,
      WORD &Key, TShiftState Shift)
{
  if (Key == 13) EvaluateClick(Sender);
}
//---------------------------------------------------------------------------
void __fastcall SetEditText(TEdit *Edit, TComplexValue *x)
{
  TNotifyEvent OnCh = Edit->OnChange;
  try
  {
    Edit->OnChange = 0;
    Edit->Text = CplxToStr(x->ComplexValue);
  }
  __finally
  {
	Edit->OnChange = OnCh;
  }
}
void __fastcall TfrmParser::EvaluateClick(TObject *Sender)
{
  X->ComplexValue = StrToCplx(XEdit->Text);
  Y->ComplexValue = StrToCplx(yEdit->Text);
  Z->ComplexValue = StrToCplx(ZEdit->Text);

  MyParser->AddExpr(ExpressionEdit->Text);

  ResultEdit->Text = CplxToStr(MyParser->EvaluateComplex(-1));

  SetEditText(XEdit, X);
  SetEditText(yEdit, Y);
  SetEditText(ZEdit, Z);
}
//---------------------------------------------------------------------------
void __fastcall TfrmParser::Button24Click(TObject *Sender)
{
  AddToEdit(dynamic_cast<TButton*>(Sender)->Caption);
}
//---------------------------------------------------------------------------

void __fastcall TfrmParser::Button24KeyPress(TObject *Sender, char &Key)
{
  ActiveControl = ExpressionEdit;
  ExpressionEdit->SelStart += ExpressionEdit->SelLength;
  ExpressionEdit->SelLength = 0;
}
//---------------------------------------------------------------------------

void __fastcall TfrmParser::Button32Click(TObject *Sender)
{
  AddToEdit(FunctionsCombo->Text);
}
//---------------------------------------------------------------------------

void __fastcall TfrmParser::Button2Click(TObject *Sender)
{
  AddToEdit(ConstantsCombo->Text);
}
//---------------------------------------------------------------------------





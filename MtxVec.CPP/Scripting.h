//---------------------------------------------------------------------------
#ifndef ScriptingH
#define ScriptingH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>

#include <MtxParseExpr.hpp>
#include <MtxParseClass.hpp>
//---------------------------------------------------------------------------
class TScriptingForm : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TRichEdit *RichEdit;
  TEdit *ExprEdit;
  TSplitter *Splitter1;
  TPanel *Panel2;
  TListBox *ListBox;
  TSplitter *Splitter2;
  TLabel *Label1;
  TListView *VarView;
  TLabel *Label2;
  TSplitter *Splitter3;
  TStatusBar *StatusBar;
  TSplitter *Splitter4;
  TRichEdit *ScriptEdit;
  TPanel *Panel3;
  TButton *RunButton;
  TLabel *ScriptLabel;
  TComboBox *ScriptBox;
  TPanel *Panel4;
  void __fastcall ExprEditKeyDown(TObject *Sender, WORD &Key, TShiftState Shift);
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall RichEditMouseMove(TObject *Sender, TShiftState Shift, int X, int Y);
  void __fastcall ListBoxDblClick(TObject *Sender);
  void __fastcall VarViewDblClick(TObject *Sender);
  void __fastcall VarViewMouseEnter(TObject *Sender);
  void __fastcall ListBoxMouseEnter(TObject *Sender);
  void __fastcall RichEditMouseEnter(TObject *Sender);
  void __fastcall ExprEditMouseEnter(TObject *Sender);
  void __fastcall ScriptBoxChange(TObject *Sender);
  void __fastcall RunButtonClick(TObject *Sender);
private:
  void __fastcall EvaluateExpression();
  void __fastcall UpdateVarView();
public:
  TMtxExpression *Expr;
  TExprGridVariable *grid1var;
  TExprGridVariable *grid2var;
  __fastcall TScriptingForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TScriptingForm *ScriptingForm;
//---------------------------------------------------------------------------
#endif

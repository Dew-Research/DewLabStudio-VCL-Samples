//---------------------------------------------------------------------------
#ifndef ParserDemoH
#define ParserDemoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include "Math387.hpp"
#include "MtxParseExpr.hpp"
#include "MtxParseClass.hpp"
#include <Menus.hpp>

//---------------------------------------------------------------------------
class TfrmParser : public TBasicForm2
{
__published:	// IDE-managed Components
    TLabel *Label2;
    TLabel *Label3;                                           
    TLabel *Label1;
    TLabel *Label4;
    TLabel *helplabel;
    TLabel *Label5;
    TLabel *NEvalLabel;
    TEdit *ResultEdit;
    TButton *Evaluate;
    TEdit *XEdit;
    TGroupBox *GroupBox1;
    TButton *PointButton;
    TEdit *ExpressionEdit;
    TButton *Button4;
    TButton *Button5;
    TButton *Button6;
    TButton *Button7;
    TButton *Button8;
    TButton *Button9;
    TButton *Button10;
    TButton *Button11;
    TButton *Button14;
    TButton *Button15;
    TButton *Button16;
    TButton *Button17;
    TButton *Button18;
    TButton *Button19;
    TButton *Button24;
    TButton *Button25;
    TButton *Button26;
    TButton *Button27;
    TButton *Button28;
    TButton *Button29;
    TButton *Button31;
    TButton *Button35;
    TButton *Button38;
    TButton *Button39;
    TButton *Button40;
    TButton *Button12;
    TButton *Button13;
    TButton *Button21;
    TButton *Button22;
    TButton *Button23;
    TButton *Button30;
    TButton *Button33;
    TButton *Button34;
    TComboBox *FunctionsCombo;
    TButton *Button32;
    TEdit *yEdit;
    TEdit *ZEdit;
    TButton *Button1;
    TButton *Button36;
    TButton *Button37;
    TButton *Button42;
    TCheckBox *HexCheck;
    TPopupMenu *PopupMenu1;
    TMenuItem *Undo1;
    TMenuItem *Redo1;
    TLabel *Label6;
    TComboBox *ConstantsCombo;
    TButton *Button2;
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall ExpressionEditChange(TObject *Sender);
  void __fastcall ExpressionEditKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
  void __fastcall EvaluateClick(TObject *Sender);
  void __fastcall Button24Click(TObject *Sender);
  void __fastcall Button24KeyPress(TObject *Sender, char &Key);
  void __fastcall Button32Click(TObject *Sender);
  void __fastcall Button2Click(TObject *Sender);
private:	// User declarations
    TComplexValue *X, *Y, *Z;
    AnsiString *PrevText;
    int Iprevtext, istartundo, NUndo;
    TMtxExpression *MyParser;
    void __fastcall AddToEdit(AnsiString S);
    void __fastcall UpdateUndo(void);
    void __fastcall SetUndoText(void);
public:		// User declarations
  __fastcall TfrmParser(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmParser *frmParser;
//---------------------------------------------------------------------------
#endif

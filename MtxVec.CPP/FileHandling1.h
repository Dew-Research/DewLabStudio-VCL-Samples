//---------------------------------------------------------------------------

#ifndef FileHandling1H
#define FileHandling1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
//---------------------------------------------------------------------------
class TFileH1 : public TBasicForm2
{
__published:	// IDE-managed Components
  TCheckBox *CheckBox1;                                
  TLabel *Label1;
  TRichEdit *RichEdit2;
  TBitBtn *Button1;
  TBitBtn *Button2;
  TBitBtn *Button3;
  TBitBtn *Button4;
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall Button2Click(TObject *Sender);
  void __fastcall Button4Click(TObject *Sender);
  void __fastcall Button3Click(TObject *Sender);
private:	// User declarations
  sMatrix AMtx;
  sVector AVec;
public:		// User declarations
  __fastcall TFileH1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFileH1 *FileH1;
//---------------------------------------------------------------------------
#endif

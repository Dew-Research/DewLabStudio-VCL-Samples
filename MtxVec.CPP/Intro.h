//---------------------------------------------------------------------------

#ifndef IntroH
#define IntroH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <jpeg.hpp>
#include <pngimage.hpp>
//---------------------------------------------------------------------------
class TIntroduction : public TForm
{
__published:	// IDE-managed Components
  TRichEdit *RichEdit1;
  TLabel *Label1;
	TPanel *Panel1;
	TImage *Image1;
	TImage *Image2;
	TImage *Image3;
  void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
public:		// User declarations                       
  __fastcall TIntroduction(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TIntroduction *Introduction;
//---------------------------------------------------------------------------
#endif

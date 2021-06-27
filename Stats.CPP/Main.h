//---------------------------------------------------------------------------

#ifndef MainH
#define MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Graphics.hpp>
#include <jpeg.hpp>
#include <Registry.hpp>
#include <FileCtrl.hpp>
#include "MtxBaseComp.hpp"
#include "MtxVecTools.hpp"
#include "StatTools.hpp"
#include "MtxParseExpr.hpp"

//---------------------------------------------------------------------------
class TfrmMain : public TForm
{
__published:	// IDE-managed Components
	TPageControl *PageControl1;
	TTabSheet *TabForm;
	TTabSheet *TabSource;
	TButton *btnConfig;
	TPanel *Panel1;
	TImage *Image3;
	TSpeedButton *btnClose;
	TSpeedButton *btnNext;
	TSpeedButton *btnPrevious;
	TPanel *Panel2;
	TImage *Image1;
	TImage *Image2;
	TLabel *Label1;
	TSplitter *Splitter1;
	TStatusBar *StatusBar1;
	TTreeView *TreeView1;
	TMemo *Memo1;
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall TreeView1Change(TObject *Sender, TTreeNode *Node);
	void __fastcall PageControl1Change(TObject *Sender);
	void __fastcall btnConfigClick(TObject *Sender);
	void __fastcall btnPreviousClick(TObject *Sender);
	void __fastcall btnNextClick(TObject *Sender);
	void __fastcall btnCloseClick(TObject *Sender);
	void __fastcall FormShow(TObject *Sender);
	void __fastcall FormDestroy(TObject *Sender);
private:	// User declarations
	TForm *tmpForm;
	AnsiString OldCodeFile;
	TRichEdit *RichEditCode;
	void __fastcall ShowForm(void);
	void __fastcall ShowFormClass(TFormClass AClass);
	AnsiString __fastcall CodeFile(void);
  void __fastcall LoadTree(TStringStream* list);
public:		// User declarations
	__fastcall TfrmMain(TComponent* Owner);
};

struct TExampleInfo
{
	TFormClass FormClass;
	AnsiString UnitName;
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmMain *frmMain;
//---------------------------------------------------------------------------
#endif

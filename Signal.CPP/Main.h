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
#include <Vcl.XPMan.hpp>
#include <Vcl.ActnColorMaps.hpp>
#include <Vcl.ActnMan.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeEdit.hpp>
#include "FileSignal.hpp"
#include "MtxBaseComp.hpp"
#include "SignalTools.hpp"
#include "SignalToolsTee.hpp"
#include "MtxParseExpr.hpp"
#include "MtxComCtrls.hpp"
#include "SignalProcessing.hpp"
#include <VclTee.TeeGDIPlus.hpp>
//---------------------------------------------------------------------------
class TfrmMain : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel1;
	TImage *Image1;
	TSpeedButton *btnPrevious;
	TSpeedButton *btnNext;
	TSpeedButton *btnClose;
	TSpeedButton *btnHelp;
	TPanel *Panel2;
	TImage *Image2;
	TLabel *Label1;
	TImage *Image3;
	TTreeView *TreeView1;
	TSplitter *Splitter1;
	TStatusBar *StatusBar1;
	TPageControl *PageControl1;
	TTabSheet *TabForm;
	TTabSheet *TabSource;
	TButton *btnConfig;
	TMemo *Memo1;
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall TreeView1Change(TObject *Sender, TTreeNode *Node);
	void __fastcall PageControl1Change(TObject *Sender);
	void __fastcall btnConfigClick(TObject *Sender);
	void __fastcall btnPreviousClick(TObject *Sender);
	void __fastcall btnNextClick(TObject *Sender);
	void __fastcall btnCloseClick(TObject *Sender);
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

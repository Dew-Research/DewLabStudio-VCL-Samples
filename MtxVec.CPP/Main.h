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
#include "MtxVecDBTools.hpp"
#include "MtxBaseComp.hpp"
#include "MtxComCtrls.hpp"
#include "MtxParseExpr.hpp"
#include "MtxVecTools.hpp"
#include "MtxVecTee.hpp"
//---------------------------------------------------------------------------
class TfrmMain : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel2;
  TPanel *Panel1;
  TStatusBar *StatusBar1;                                   
  TSplitter *Splitter1;
  TLabel *Label1;
  TImage *Image1;
  TPageControl *PageControl1;
  TTabSheet *TabForm;
  TTabSheet *TabSource;
  TButton *btnConfig;
  TSpeedButton *btnClose;
  TSpeedButton *btnPrevious;
  TSpeedButton *btnNext;
        TTreeView *TreeView1;
        TMemo *Memo1;
	TMtxFloatEdit *MtxFloatEdit1;
	TMtxOptimization *MtxOptimization1;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall btnPreviousClick(TObject *Sender);
  void __fastcall btnNextClick(TObject *Sender);
  void __fastcall btnCloseClick(TObject *Sender);
  void __fastcall TreeView1Change(TObject *Sender, TTreeNode *Node);
  void __fastcall btnConfigClick(TObject *Sender);
  void __fastcall PageControl1Change(TObject *Sender);
        void __fastcall Memo1MouseMove(TObject *Sender, TShiftState Shift,
          int X, int Y);
        void __fastcall FormShow(TObject *Sender);
	void __fastcall FormDestroy(TObject *Sender);
private:	// User declarations
  TForm *tmpForm;
  AnsiString OldCodeFile;
  TRichEdit *RichEditCode;
  void __fastcall ShowForm(void);
  void __fastcall ShowFormClass(TFormClass AClass);
  AnsiString __fastcall CodeFile(void);
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

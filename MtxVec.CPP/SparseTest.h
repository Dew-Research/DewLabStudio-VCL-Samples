//---------------------------------------------------------------------------
#ifndef SparseTestH
#define SparseTestH
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include "Basic2.h"
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VclTee.TeeGDIPlus.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include "Basic2.h"
#include <Sparse.hpp>
//---------------------------------------------------------------------------
class TfrmSparseTest : public TBasicForm2
{
	__published:	// IDE-managed Components
	  TChart *Chart1;
	  TBarSeries *Series1;
	  TPanel *Panel4;
	  TButton *Button1;
	  TLabel *Label1;
	  TComboBox *ComboBox1;
	  TMemo *Memo1;
	TSplitter *Splitter1;
	  void __fastcall FormDestroy(TObject *Sender);
	  void __fastcall Button1Click(TObject *Sender);
	  void __fastcall ComboBox1Change(TObject *Sender);
	private:	// User declarations
      TSparseMtx *SparseA;
	public:		// User declarations
	  __fastcall TfrmSparseTest(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmSparseTest *frmSparseTest;
//---------------------------------------------------------------------------
#endif
 
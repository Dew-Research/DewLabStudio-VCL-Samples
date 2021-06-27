//---------------------------------------------------------------------------

#ifndef Fit_ModelH
#define Fit_ModelH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Chart.h"
#include <VCLTee.Chart.hpp>
#include <ExtCtrls.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>
#include <MtxVecEdit.hpp>
#include <MtxVecTee.hpp>
#include <RegModels.hpp>
#include <Polynoms.hpp>
//---------------------------------------------------------------------------
class TfrmModels : public TfrmBasicChart
{
__published:	// IDE-managed Components
	TButton *Button2;
	TButton *Button3;
	TComboBox *ComboBox1;
	TLabel *Label1;
	TLabel *Label2;
	TPointSeries *Series1;
	TLineSeries *Series2;
	void __fastcall FormShow(TObject *Sender);
	void __fastcall Button2Click(TObject *Sender);
	void __fastcall Button3Click(TObject *Sender);
	void __fastcall ComboBox1Change(TObject *Sender);
private:	// User declarations
		sVector X,Y; // X,Y values ...
		sVector B; // Parameters
		sVector YCalc;
		sVector Residuals;
		AnsiString MsgText;
public:		// User declarations
	__fastcall TfrmModels(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmModels *frmModels;
//---------------------------------------------------------------------------
#endif

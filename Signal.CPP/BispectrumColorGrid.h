//---------------------------------------------------------------------------

#ifndef BispectrumColorGridH
#define BispectrumColorGridH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "FileSignal.hpp"
#include "MtxBaseComp.hpp"
#include "MtxVecTee.hpp"
#include "SignalAnalysis.hpp"
#include "SignalTools.hpp"
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
//---------------------------------------------------------------------------
class TBiSpectrumGridForm : public TForm
{
__published:	// IDE-managed Components
	TBiSpectrumAnalyzer *BiSpectrumAnalyzer;
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TLabel *ProgressLabel;
	TToolBar *ToolBar1;
	TToolButton *ChartEditButton;
	TToolButton *Button1;
	TCheckBox *SingleLinesOnlyBox;
	TPanel *Panel2;
	TChart *Chart1;
	TMtxGridSeries *Series1;
	TRichEdit *RichEdit1;
	TSignalRead *SignalRead1;
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall Button1Click(TObject *Sender);
	void __fastcall SingleLinesOnlyBoxClick(TObject *Sender);
private:	// User declarations
	sMatrix BMtx;
public:		// User declarations
	__fastcall TBiSpectrumGridForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TBiSpectrumGridForm *BiSpectrumGridForm;
//---------------------------------------------------------------------------
#endif

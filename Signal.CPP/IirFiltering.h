//---------------------------------------------------------------------------

#ifndef IirFilteringH
#define IirFilteringH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
#include "MtxBaseComp.hpp"
#include "MtxComCtrls.hpp"
#include "MtxDialogs.hpp"
#include "SignalAnalysis.hpp"
#include "SignalTools.hpp"
#include "SignalToolsDialogs.hpp"
#include "SignalToolsTee.hpp"
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VclTee.TeeGDIPlus.hpp>
//---------------------------------------------------------------------------
class TIirFilteringForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label3;
	TToolBar *ToolBar1;
	TToolButton *SpectrumEditButton;
	TToolButton *ChartEditButton;
	TMtxFloatEdit *OrderEdit;
	TMtxFloatEdit *AttEdit;
	TMtxFloatEdit *FreqEdit;
	TRichEdit *RichEdit1;
	TSpectrumAnalyzer *SpectrumAnalyzer;
	TSpectrumAnalyzerDialog *SpectrumAnalyzerDialog;
	TSpectrumChart *SpectrumChart;
	TAxisScaleTool *ChartTool1;
	TSpectrumMarkTool *ChartTool2;
	void __fastcall SpectrumEditButtonClick(TObject *Sender);
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall SpectrumAnalyzerParameterUpdate(TObject *Sender);
	void __fastcall OrderEditChange(TObject *Sender);
private:	// User declarations
	void __fastcall FillSeries(int Order, int Att, TSample Freq);
public:		// User declarations
	__fastcall TIirFilteringForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TIirFilteringForm *IirFilteringForm;
//---------------------------------------------------------------------------
#endif

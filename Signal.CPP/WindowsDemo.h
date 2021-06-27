//---------------------------------------------------------------------------

#ifndef WindowsDemoH
#define WindowsDemoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
#include "MtxBaseComp.hpp"
#include "MtxDialogs.hpp"
#include "SignalAnalysis.hpp"
#include "SignalTools.hpp"
#include "SignalToolsDialogs.hpp"
#include "SignalToolsTee.hpp"
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
//---------------------------------------------------------------------------
class TWindowsDemoForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TToolBar *ToolBar1;
	TToolButton *SpectrumEditButton;
	TToolButton *ChartEditButton;
	TRichEdit *RichEdit1;
	TSignal *Signal1;
	TSpectrumAnalyzer *SpectrumAnalyzer;
	TSpectrumAnalyzerDialog *SpectrumAnalyzerDialog;
	TSpectrumChart *SpectrumChart;
	TAxisScaleTool *ChartTool1;
	TSpectrumMarkTool *ChartTool2;
	void __fastcall SpectrumEditButtonClick(TObject *Sender);
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall Signal1AfterUpdate(TObject *Sender);
	void __fastcall SpectrumAnalyzerParameterUpdate(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
	void __fastcall TWindowsDemoForm::FillSeries();
public:		// User declarations
	__fastcall TWindowsDemoForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TWindowsDemoForm *WindowsDemoForm;
//---------------------------------------------------------------------------
#endif

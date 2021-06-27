//---------------------------------------------------------------------------

#ifndef PeakMarkingFormatingH
#define PeakMarkingFormatingH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
#include "FileSignal.hpp"
#include "MtxBaseComp.hpp"
#include "MtxDialogs.hpp"
#include "SignalAnalysis.hpp"
#include "SignalTools.hpp"
#include "SignalToolsDialogs.hpp"
#include "SignalToolsTee.hpp"

#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
//---------------------------------------------------------------------------
class TPeakMarkingFormatingForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TToolBar *ToolBar1;
	TToolButton *SpectrumEditButton;
	TToolButton *ChartEditButton;
	TToolButton *ToolButton1;
	TRichEdit *RichEdit1;
	TSignalRead *SignalRead1;
	TSpectrumAnalyzer *SpectrumAnalyzer;
	TSpectrumAnalyzerDialog *SpectrumAnalyzerDialog;
	TSpectrumChart *SpectrumChart;
	TFastLineSeries *Series1;
	TPointSeries *Series2;
	TSpectrumMarkTool *ChartTool2;
	TAxisScaleTool *ChartTool1;
	void __fastcall SpectrumEditButtonClick(TObject *Sender);
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall ToolButton1Click(TObject *Sender);
	void __fastcall SpectrumAnalyzerParameterUpdate(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TPeakMarkingFormatingForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TPeakMarkingFormatingForm *PeakMarkingFormatingForm;
//---------------------------------------------------------------------------
#endif

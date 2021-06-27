//---------------------------------------------------------------------------

#ifndef EnvelopeDemoH
#define EnvelopeDemoH
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
#include "SignalProcessing.hpp"
#include "SignalTools.hpp"
#include "SignalToolsDialogs.hpp"
#include "SignalToolsTee.hpp"
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
//---------------------------------------------------------------------------
class TEnvelopeDemoForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TToolBar *ToolBar1;
	TToolButton *SpectrumEditButton;
	TToolButton *ChartEditButton;
	TPanel *Panel2;
	TSplitter *Splitter1;
	TSpectrumChart *SpectrumChart;
	TFastLineSeries *Series1;
	TPointSeries *Series2;
	TAxisScaleTool *ChartTool1;
	TSpectrumMarkTool *ChartTool2;
	TSignalChart *SignalChart1;
	TFastLineSeries *Series3;
	TRichEdit *RichEdit1;
	TSignalDecimator *SignalDecimator1;
	TSignalIncBuffer *SignalIncBuffer1;
	TSignalIncBuffer *SignalIncBuffer2;
	TSignalRead *SignalRead1;
	TSpectrumAnalyzer *SpectrumAnalyzer;
	TSpectrumAnalyzerDialog *SpectrumAnalyzerDialog;
	void __fastcall SpectrumEditButtonClick(TObject *Sender);
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall SpectrumAnalyzerParameterUpdate(TObject *Sender);
	void __fastcall FormResize(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TEnvelopeDemoForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TEnvelopeDemoForm *EnvelopeDemoForm;
//---------------------------------------------------------------------------
#endif

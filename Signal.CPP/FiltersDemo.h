//---------------------------------------------------------------------------

#ifndef FiltersDemoH
#define FiltersDemoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include "MtxBaseComp.hpp"
#include "MtxDialogs.hpp"
#include "SignalAnalysis.hpp"
#include "SignalProcessing.hpp"
#include "SignalSeriesTee.hpp"
#include "SignalTools.hpp"
#include "SignalToolsDialogs.hpp"
#include "SignalToolsTee.hpp"
#include <VCLTee.TeeEdit.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <ToolWin.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VclTee.TeeGDIPlus.hpp>
//---------------------------------------------------------------------------
class TFiltersDemoForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TChartEditor *ChartEditor1;
	TPanel *Panel1;
	TToolBar *ToolBar1;
	TToolButton *SpectrumEditButton;
	TToolButton *ChartEditButton;
	TToolButton *ToolButton1;
	TToolButton *FilterButton;
	TPanel *Panel2;
	TSplitter *Splitter1;
	TSpectrumChart *SpectrumChart;
	TFastLineSeries *Series1;
	TPointSeries *Series2;
	TAxisScaleTool *ChartTool1;
	TSpectrumMarkTool *ChartTool2;
	TSignalChart *SignalChart;
	TSignalDiscreteSeries *Series3;
	TSignalChart *SignalChart1;
	TRichEdit *RichEdit1;
	TSignal *Signal1;
	TSignal *Signal2;
	TSignalFilter *SignalFilter1;
	TSignalFilterDialog *SignalFilterDialog1;
	TSpectrumAnalyzer *SpectrumAnalyzer;
	TSpectrumAnalyzerDialog *SpectrumAnalyzerDialog;
	void __fastcall SpectrumEditButtonClick(TObject *Sender);
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall ToolButton1Click(TObject *Sender);
	void __fastcall FilterButtonClick(TObject *Sender);
	void __fastcall SignalFilter1ParameterUpdate(TObject *Sender);
	void __fastcall SignalFilter1AfterUpdate(TObject *Sender);
	void __fastcall Panel2Resize(TObject *Sender);
	void __fastcall SpectrumAnalyzerParameterUpdate(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TFiltersDemoForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFiltersDemoForm *FiltersDemoForm;
//---------------------------------------------------------------------------
#endif

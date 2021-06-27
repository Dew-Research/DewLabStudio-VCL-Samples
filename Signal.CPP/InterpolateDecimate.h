//---------------------------------------------------------------------------

#ifndef InterpolateDecimateH
#define InterpolateDecimateH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "FileSignal.hpp"
#include "MtxBaseComp.hpp"
#include "MtxComCtrls.hpp"
#include "MtxDialogs.hpp"
#include "SignalAnalysis.hpp"
#include "SignalProcessing.hpp"
#include "SignalTools.hpp"
#include "SignalToolsDialogs.hpp"
#include "SignalToolsTee.hpp"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
//---------------------------------------------------------------------------
class TInterpolateDecimateForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TLabel *Label1;
	TLabel *Label2;
	TToolBar *ToolBar1;
	TToolButton *SpectrumEditButton;
	TToolButton *ChartEditButton;
	TMtxFloatEdit *FilePositionEdit1;
	TMtxFloatEdit *FilePositionEdit2;
	TRichEdit *RichEdit1;
	TSignalDecimator *SignalDecimator1;
	TSignalInterpolator *SignalInterpolator1;
	TSignalRead *SignalRead1;
	TSignalRead *SignalRead2;
	TSignalRead *SignalRead3;
	TSignalWrite *SignalWrite1;
	TSpectrumAnalyzer *SpectrumAnalyzer;
	TSpectrumAnalyzer *SpectrumAnalyzer1;
	TSpectrumAnalyzerDialog *SpectrumAnalyzerDialog;
	TSpectrumChart *SpectrumChart;
	TFastLineSeries *Series1;
	TFastLineSeries *Series3;
	TPointSeries *Series2;
	TAxisScaleTool *ChartTool1;
	TSpectrumMarkTool *ChartTool2;
	void __fastcall SpectrumEditButtonClick(TObject *Sender);
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall SpectrumAnalyzerParameterUpdate(TObject *Sender);
	void __fastcall FilePositionEdit1Change(TObject *Sender);
	void __fastcall FilePositionEdit2Change(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TInterpolateDecimateForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TInterpolateDecimateForm *InterpolateDecimateForm;
//---------------------------------------------------------------------------
#endif

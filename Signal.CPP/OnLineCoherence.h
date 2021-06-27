//---------------------------------------------------------------------------

#ifndef OnLineCoherenceH
#define OnLineCoherenceH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
#include "AudioSignal.hpp"
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
class TOnLineCoherenceForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TCrossSpectrumAnalyzer *CrossAnalyzer;
	TCrossSpectrumAnalyzerDialog *CrossSpectrumAnalyzerDialog;
	TPanel *Panel1;
	TLabel *Label1;
	TToolBar *ToolBar1;
	TToolButton *ChartEditButton;
	TToolButton *ToolButton1;
	TComboBox *SpectrumBox;
	TRichEdit *RichEdit1;
	TSignal *Signal1;
	TSignal *Signal2;
	TSignalIn *SignalIn1;
	TSignalTimer *SignalTimer1;
	TSpectrumChart *SpectrumChart;
	TFastLineSeries *Series1;
	TPointSeries *Series2;
	TAxisScaleTool *ChartTool1;
	TSpectrumMarkTool *ChartTool2;
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall CrossAnalyzerParameterUpdate(TObject *Sender);
	void __fastcall SpectrumBoxChange(TObject *Sender);
	void __fastcall SignalTimer1Timer(TObject *Sender);
	void __fastcall ToolButton1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TOnLineCoherenceForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TOnLineCoherenceForm *OnLineCoherenceForm;
//---------------------------------------------------------------------------
#endif

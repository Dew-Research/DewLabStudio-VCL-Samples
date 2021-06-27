//---------------------------------------------------------------------------

#ifndef BicoherenceTestH
#define BicoherenceTestH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "MtxBaseComp.hpp"
#include "MtxComCtrls.hpp"
#include "MtxDialogs.hpp"
#include "MtxVecTee.hpp"
#include "SignalAnalysis.hpp"
#include "SignalTools.hpp"
#include "SignalToolsDialogs.hpp"
#include "SignalToolsTee.hpp"
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.Chart.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <ToolWin.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.ActnMan.hpp>
#include <Vcl.PlatformDefaultStyleActnCtrls.hpp>
#include "MtxParseExpr.hpp"
//---------------------------------------------------------------------------
class TBicoherenceTestForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TLabel *Label1;
	TLabel *Label2;
	TToolBar *ToolBar1;
	TToolButton *SpectrumEditButton;
	TToolButton *ChartEditButton;
	TToolButton *Button1;
	TMtxFloatEdit *Freq1Edit;
	TMtxFloatEdit *Freq2Edit;
	TPanel *Panel2;
	TSplitter *Splitter1;
	TChart *Chart1;
	TMtxGridSeries *Series1;
	TSpectrumChart *SpectrumChart;
	TFastLineSeries *FastLineSeries1;
	TPointSeries *Series2;
	TAxisScaleTool *ChartTool2;
	TSpectrumMarkTool *ChartTool1;
	TRichEdit *RichEdit1;
	TSignal *Signal1;
	TSpectrumAnalyzerDialog *SpectrumAnalyzerDialog;
	TBiSpectrumAnalyzer *BiSpectrumAnalyzer;
	TSpectrumAnalyzer *SpectrumAnalyzer;
	void __fastcall SpectrumEditButtonClick(TObject *Sender);
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall Freq1EditChange(TObject *Sender);
	void __fastcall Button1Click(TObject *Sender);
	void __fastcall Signal1AfterUpdate(TObject *Sender);
	void __fastcall Panel2Resize(TObject *Sender);
private:	// User declarations
	sMatrix BMtx;
	TToneState ToneState1,ToneState2;
public:		// User declarations
	__fastcall TBicoherenceTestForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TBicoherenceTestForm *BicoherenceTestForm;
//---------------------------------------------------------------------------
#endif

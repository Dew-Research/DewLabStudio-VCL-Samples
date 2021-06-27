//---------------------------------------------------------------------------

#ifndef SavGolayDemoH
#define SavGolayDemoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ToolWin.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include "FileSignal.hpp"
#include "MtxBaseComp.hpp"
#include "MtxComCtrls.hpp"
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
class TSavGolayDemoForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TLabel *Label1;
	TLabel *Label2;
	TToolBar *ToolBar1;
	TToolButton *SpectrumEditButton;
	TToolButton *ChartEditButton;
	TMtxFloatEdit *FrameSizeEdit;
	TMtxFloatEdit *OrderEdit;
	TRichEdit *RichEdit1;
	TSignalRead *SignalRead1;
	TSpectrumAnalyzer *SpectrumAnalyzer;
	TSpectrumAnalyzerDialog *SpectrumAnalyzerDialog;
	TSpectrumChart *SpectrumChart;
	TFastLineSeries *Series1;
	TPointSeries *Series2;
	TAxisScaleTool *ChartTool1;
	TSpectrumMarkTool *ChartTool2;
	void __fastcall SpectrumEditButtonClick(TObject *Sender);
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall SpectrumAnalyzerParameterUpdate(TObject *Sender);
	void __fastcall FrameSizeEditChange(TObject *Sender);
	void __fastcall SpectrumAnalyzerAfterUpdate(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TSavGolayDemoForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TSavGolayDemoForm *SavGolayDemoForm;
//---------------------------------------------------------------------------
#endif

//---------------------------------------------------------------------------

#ifndef PeakFilteringH
#define PeakFilteringH
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
#include <VclTee.TeeGDIPlus.hpp>
//---------------------------------------------------------------------------
class TPeakFilteringForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TLabel *Label1;
	TToolBar *ToolBar1;
	TToolButton *SpectrumEditButton;
	TToolButton *ChartEditButton;
	TCheckBox *CheckBox1;
	TComboBox *ComboBox1;
	TRichEdit *RichEdit1;
	TSignal *Signal1;
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
	void __fastcall CheckBox1Click(TObject *Sender);
	void __fastcall ComboBox1Change(TObject *Sender);
	void __fastcall Signal1AfterUpdate(TObject *Sender);
private:	// User declarations
	TSpectrumMarkTool* __fastcall GetMarkTool();
	TAxisScaleTool* __fastcall GetAxisScaleTool();
public:		// User declarations
	__fastcall TPeakFilteringForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TPeakFilteringForm *PeakFilteringForm;
//---------------------------------------------------------------------------
#endif

//---------------------------------------------------------------------------

#ifndef CoherenceTestH
#define CoherenceTestH
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
class TCoherenceTestForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TCrossSpectrumAnalyzerDialog *CrossSpectrumAnalyzerDialog;
	TSignal *FilteredSignal;
	TPanel *Panel1;
	TLabel *Label1;
	TToolBar *ToolBar1;
	TToolButton *ChartEditButton;
	TToolButton *EditSpectrumButton;
	TToolButton *UpdateButton;
	TComboBox *SpectrumBox;
	TCheckBox *PhaseBox;
	TRichEdit *RichEdit1;
	TSignalRead *SignalRead1;
	TSpectrumChart *SpectrumChart;
	TFastLineSeries *Series1;
	TPointSeries *Series2;
	TAxisScaleTool *ChartTool1;
	TSpectrumMarkTool *ChartTool2;
	TCrossSpectrumAnalyzer *CrossAnalyzer;
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall EditSpectrumButtonClick(TObject *Sender);
	void __fastcall SignalRead1AfterUpdate(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall FormDestroy(TObject *Sender);
	void __fastcall SpectrumBoxChange(TObject *Sender);
	void __fastcall PhaseBoxClick(TObject *Sender);
	void __fastcall CrossAnalyzerParameterUpdate(TObject *Sender);
	void __fastcall UpdateButtonClick(TObject *Sender);
private:	// User declarations
	void __fastcall ToolButton1Click();
public:		// User declarations
	__fastcall TCoherenceTestForm(TComponent* Owner);
	TFirState FirState;
};
//---------------------------------------------------------------------------
extern PACKAGE TCoherenceTestForm *CoherenceTestForm;
//---------------------------------------------------------------------------
#endif

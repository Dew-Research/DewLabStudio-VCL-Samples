//---------------------------------------------------------------------------

#ifndef LissajousScopeH
#define LissajousScopeH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "AudioSignal.hpp"
#include "MtxBaseComp.hpp"
#include "SignalTools.hpp"
#include "SignalToolsTee.hpp"
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.TeePolar.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
//---------------------------------------------------------------------------
class TLissajousScopeForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TLabel *Label1;
	TToolBar *ToolBar1;
	TToolButton *ChartButton;
	TComboBox *SamplesBox;
	TPanel *Panel2;
	TChart *PhaseChart;
	TPolarSeries *Series1;
	TAxisScaleTool *ChartTool1;
	TAxisScaleTool *ChartTool2;
	TAxisScaleTool *ChartTool3;
	TAxisScaleTool *ChartTool4;
	TRichEdit *RichEdit1;
	TSignal *Signal1;
	TSignal *Signal2;
	TSignalIn *SignalIn1;
	TSignalTimer *SignalTimer1;
	void __fastcall SignalTimer1Timer(TObject *Sender);
	void __fastcall ChartButtonClick(TObject *Sender);
	void __fastcall FormDestroy(TObject *Sender);
	void __fastcall SamplesBoxChange(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TLissajousScopeForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TLissajousScopeForm *LissajousScopeForm;
//---------------------------------------------------------------------------
#endif

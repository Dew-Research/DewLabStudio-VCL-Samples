//---------------------------------------------------------------------------

#ifndef PhaseScopeH
#define PhaseScopeH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ToolWin.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
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
#include "SignalSeriesTee.hpp"
//---------------------------------------------------------------------------
class TPhaseScopeForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TLabel *Label1;
	TToolBar *ToolBar1;
	TToolButton *ChartButton;
	TComboBox *ChannelBox;
	TPanel *Panel2;
	TSplitter *Splitter1;
	TSignalChart *SignalChart1;
	TFastLineSeries *Series3;
	TPanel *Panel3;
	TSplitter *Splitter2;
	TChart *RightPhaseChart;
	TAxisScaleTool *ChartTool5;
	TChart *LeftPhaseChart;
	TAxisScaleTool *ChartTool1;
	TAxisScaleTool *ChartTool2;
	TAxisScaleTool *ChartTool3;
	TAxisScaleTool *ChartTool4;
	TRichEdit *RichEdit1;
	TSignal *Signal1;
	TSignal *Signal2;
	TSignalIn *SignalIn1;
	TSignalTimer *SignalTimer1;
	TSignalPolarSeries *Series4;
	TSignalPolarSeries *Series1;
	void __fastcall ChartButtonClick(TObject *Sender);
	void __fastcall Panel2Resize(TObject *Sender);
	void __fastcall SignalTimer1Timer(TObject *Sender);
	void __fastcall FormDestroy(TObject *Sender);
private:	// User declarations
	TDelayFilterState DelayState; // for delay filter
	TFirState HilbertState;
public:		// User declarations
	__fastcall TPhaseScopeForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TPhaseScopeForm *PhaseScopeForm;
//---------------------------------------------------------------------------
#endif

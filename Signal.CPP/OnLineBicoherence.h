//---------------------------------------------------------------------------

#ifndef OnLineBicoherenceH
#define OnLineBicoherenceH
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
#include "MtxComCtrls.hpp"
#include "MtxDialogs.hpp"
#include "SignalAnalysis.hpp"
#include "SignalTools.hpp"
#include "SignalToolsDialogs.hpp"
#include "SignalToolsTee.hpp"
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VclTee.TeeGDIPlus.hpp>
//---------------------------------------------------------------------------
class TOnLineBicoherenceForm : public TForm
{
__published:	// IDE-managed Components
	TBiSpectrumAnalyzer *BiSpectrumAnalyzer;
	TBiSpectrumAnalyzerDialog *BiSpectrumAnalyzerDialog1;
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TLabel *Label1;
	TLabel *Label2;
	TToolBar *ToolBar1;
	TToolButton *SpectrumEditButton;
	TToolButton *ToolButton1;
	TToolButton *ChartEditButton;
	TMtxFloatEdit *FreqEdit;
	TComboBox *ChannelBox;
	TPanel *Panel2;
	TSplitter *Splitter1;
	TSpectrumChart *SpectrumChart;
	TFastLineSeries *Series1;
	TPointSeries *Series2;
	TAxisScaleTool *ChartTool1;
	TSpectrumMarkTool *ChartTool2;
	TColorLineTool *ChartTool4;
	TSpectrumChart *SpectrumChart1;
	TFastLineSeries *FastLineSeries1;
	TPointSeries *PointSeries1;
	TAxisScaleTool *AxisScaleTool1;
	TSpectrumMarkTool *ChartTool3;
	TRichEdit *RichEdit1;
	TSignal *Signal1;
	TSignalIn *SignalIn1;
	TSignalTimer *SignalTimer1;
	TSpectrumAnalyzer *SpectrumAnalyzer;
	TSpectrumAnalyzerDialog *SpectrumAnalyzerDialog;
	void __fastcall SpectrumEditButtonClick(TObject *Sender);
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall SpectrumAnalyzerParameterUpdate(TObject *Sender);
	void __fastcall FreqEditChange(TObject *Sender);
	void __fastcall Panel2Resize(TObject *Sender);
	void __fastcall SignalTimer1Timer(TObject *Sender);
	void __fastcall ToolButton1Click(TObject *Sender);
	void __fastcall ChannelBoxChange(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TOnLineBicoherenceForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TOnLineBicoherenceForm *OnLineBicoherenceForm;
//---------------------------------------------------------------------------
#endif

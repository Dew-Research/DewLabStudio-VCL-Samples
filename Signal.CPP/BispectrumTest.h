//---------------------------------------------------------------------------

#ifndef BispectrumTestH
#define BispectrumTestH
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
#include "SignalTools.hpp"
#include "SignalToolsDialogs.hpp"
#include "SignalToolsTee.hpp"
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
#include <VclTee.TeeGDIPlus.hpp>
//---------------------------------------------------------------------------
class TBiSpectrumTestForm : public TForm
{
__published:	// IDE-managed Components
	TBiSpectrumAnalyzer *BiSpectrumAnalyzer;
	TBiSpectrumAnalyzerDialog *BiSpectrumAnalyzerDialog;
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TLabel *Label1;
	TLabel *ProgressLabel;
	TToolBar *ToolBar1;
	TToolButton *SpectrumEditButton;
	TToolButton *ChartEditButton;
	TToolButton *Button1;
	TMtxFloatEdit *FreqEdit;
	TCheckBox *SingleLinesOnlyBox;
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
	TSignalRead *SignalRead1;
	TSpectrumAnalyzer *SpectrumAnalyzer;
	TSpectrumAnalyzerDialog *SpectrumAnalyzerDialog;
	void __fastcall SpectrumEditButtonClick(TObject *Sender);
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall Button1Click(TObject *Sender);
	void __fastcall SpectrumAnalyzerParameterUpdate(TObject *Sender);
	void __fastcall FreqEditChange(TObject *Sender);
	void __fastcall Panel2Resize(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TBiSpectrumTestForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TBiSpectrumTestForm *BiSpectrumTestForm;
//---------------------------------------------------------------------------
#endif

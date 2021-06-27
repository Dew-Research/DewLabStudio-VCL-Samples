//---------------------------------------------------------------------------

#ifndef GeneratorDemoH
#define GeneratorDemoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
#include "FileSignal.hpp"
#include "MtxBaseComp.hpp"
#include "MtxDialogs.hpp"
#include "SignalAnalysis.hpp"
#include "SignalProcessing.hpp"
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
class TGeneratorDemoForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TChartEditor *ChartEditor1;
	TPanel *Panel1;
	TToolBar *ToolBar1;
	TToolButton *SpectrumEditButton;
	TToolButton *ChartEditButton;
	TToolButton *ToolButton1;
	TToolButton *GeneratorButton;
	TToolButton *ToolButton2;
	TPanel *Panel2;
	TSplitter *Splitter1;
	TSpectrumChart *SpectrumChart;
	TFastLineSeries *Series1;
	TPointSeries *Series2;
	TAxisScaleTool *ChartTool1;
	TSpectrumMarkTool *ChartTool2;
	TSignalChart *SignalChart;
	TFastLineSeries *Series3;
	TSignalChart *SignalChart1;
	TRichEdit *RichEdit1;
	TSaveDialog *SaveDialog;
	TSignalGenerator *SignalGenerator1;
	TSignalGeneratorDialog *SignalGeneratorDialog1;
	TSignalWrite *SignalWrite;
	TSpectrumAnalyzer *SpectrumAnalyzer;
	TSpectrumAnalyzerDialog *SpectrumAnalyzerDialog;
	void __fastcall SpectrumEditButtonClick(TObject *Sender);
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall SpectrumAnalyzerParameterUpdate(TObject *Sender);
	void __fastcall Panel2Resize(TObject *Sender);
	void __fastcall ToolButton1Click(TObject *Sender);
	void __fastcall GeneratorButtonClick(TObject *Sender);
	void __fastcall SignalGenerator1ParameterUpdate(TObject *Sender);
	void __fastcall ToolButton2Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TGeneratorDemoForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TGeneratorDemoForm *GeneratorDemoForm;
//---------------------------------------------------------------------------
#endif

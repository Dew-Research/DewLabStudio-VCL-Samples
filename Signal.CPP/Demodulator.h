//---------------------------------------------------------------------------

#ifndef DemodulatorH
#define DemodulatorH
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
#include "MtxComCtrls.hpp"
#include "MtxDialogs.hpp"
#include "SignalAnalysis.hpp"
#include "SignalProcessing.hpp"
#include "SignalSeriesTee.hpp"
#include "SignalTools.hpp"
#include "SignalToolsDialogs.hpp"
#include "SignalToolsTee.hpp"
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
//---------------------------------------------------------------------------
class TDemodulatorForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor1;
	TPanel *Panel1;
	TSplitter *Splitter2;
	TSpectrumChart *SpectrumChart2;
	TFastLineSeries *FastLineSeries1;
	TSignalDiscreteSeries *SignalDiscreteSeries1;
	TAxisScaleTool *AxisScaleTool1;
	TSpectrumMarkTool *ChartTool2;
	TSpectrumChart *SpectrumChart3;
	TFastLineSeries *FastLineSeries2;
	TSignalDiscreteSeries *SignalDiscreteSeries2;
	TAxisScaleTool *AxisScaleTool2;
	TSpectrumMarkTool *ChartTool1;
	TPanel *Panel2;
	TLabel *Label1;
	TLabel *Label2;
	TToolBar *ToolBar1;
	TToolButton *SpectrumEditButton;
	TToolButton *ChartEditButton;
	TMtxFloatEdit *MtxFloatEdit1;
	TMtxFloatEdit *MtxFloatEdit2;
	TRichEdit *RichEdit1;
	TSignalDemodulator *SG1;
	TSignalRead *SignalRead1;
	TSpectrumAnalyzer *SpectrumAnalyzer1;
	TSpectrumAnalyzer *SpectrumAnalyzer3;
	TSpectrumAnalyzerDialog *SpectrumAnalyzerDialog1;
	void __fastcall SpectrumEditButtonClick(TObject *Sender);
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall FormResize(TObject *Sender);
	void __fastcall MtxFloatEdit1Change(TObject *Sender);
	void __fastcall SpectrumAnalyzer1ParameterUpdate(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TDemodulatorForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TDemodulatorForm *DemodulatorForm;
//---------------------------------------------------------------------------
#endif

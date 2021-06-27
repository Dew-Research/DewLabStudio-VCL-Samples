//---------------------------------------------------------------------------

#ifndef SignalAnalysisDemoH
#define SignalAnalysisDemoH
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
//---------------------------------------------------------------------------
class TSignalAnalysisDemoForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TLabel *Label1;
	TToolBar *ToolBar1;
	TToolButton *ChartEditButton;
	TToolButton *AnalysisButton;
	TComboBox *FilterBox;
	TPanel *Panel2;
	TSplitter *Splitter1;
	TSignalChart *SignalChart1;
	TFastLineSeries *Series3;
	TPointSeries *Series1;
	TSignalMarkTool *ChartTool1;
	TRichEdit *RichEdit1;
	TSignalAnalyzer *SignalAnalyzer1;
	TSignalAnalyzerDialog *SignalAnalyzerDialog1;
	TSignalRead *SignalRead1;
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall AnalysisButtonClick(TObject *Sender);
	void __fastcall FilterBoxChange(TObject *Sender);
	void __fastcall SignalAnalyzer1ParameterUpdate(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TSignalAnalysisDemoForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TSignalAnalysisDemoForm *SignalAnalysisDemoForm;
//---------------------------------------------------------------------------
#endif

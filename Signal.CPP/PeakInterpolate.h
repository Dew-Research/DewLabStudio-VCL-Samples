//---------------------------------------------------------------------------

#ifndef PeakInterpolateH
#define PeakInterpolateH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
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
#include <VclTee.TeeGDIPlus.hpp>
//---------------------------------------------------------------------------
class TPeakInterpolateForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TChartEditor *ChartEditor1;
	TPanel *Panel1;
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label3;
	TToolBar *ToolBar1;
	TToolButton *SpectrumEditButton;
	TToolButton *ChartEditButton;
	TToolButton *ToolButton1;
	TMtxFloatEdit *FreqEdit;
	TMtxFloatEdit *PhaseEdit;
	TMtxFloatEdit *AmpltEdit;
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
	TSignal *Signal1;
	TSpectrumAnalyzer *SpectrumAnalyzer;
	TSpectrumAnalyzerDialog *SpectrumAnalyzerDialog;
	void __fastcall SpectrumEditButtonClick(TObject *Sender);
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall ToolButton1Click(TObject *Sender);
	void __fastcall Signal1AfterUpdate(TObject *Sender);
	void __fastcall FreqEditChange(TObject *Sender);
	void __fastcall Panel2Resize(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TPeakInterpolateForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TPeakInterpolateForm *PeakInterpolateForm;
//---------------------------------------------------------------------------
#endif

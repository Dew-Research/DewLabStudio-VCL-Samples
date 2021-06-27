//---------------------------------------------------------------------------

#ifndef DifferentiatorH
#define DifferentiatorH
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
//---------------------------------------------------------------------------
class TDifferentiatorForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TLabel *FirLengthLabel;
	TLabel *Label1;
	TLabel *Label2;
	TToolBar *ToolBar1;
	TToolButton *SpectrumEditButton;
	TToolButton *ChartEditButton;
	TMtxFloatEdit *TransBWEdit;
	TComboBox *DiffBox;
	TCheckBox *PhaseBox;
	TRichEdit *RichEdit1;
	TSpectrumAnalyzer *SpectrumAnalyzer;
	TSpectrumAnalyzerDialog *SpectrumAnalyzerDialog;
	TSpectrumChart *SpectrumChart;
	TFastLineSeries *Series1;
	TFastLineSeries *Series2;
	TAxisScaleTool *ChartTool1;
	TSpectrumMarkTool *ChartTool2;
	void __fastcall SpectrumEditButtonClick(TObject *Sender);
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall SpectrumAnalyzerParameterUpdate(TObject *Sender);
	void __fastcall TransBWEditChange(TObject *Sender);
	void __fastcall PhaseBoxClick(TObject *Sender);
private:	// User declarations
	void __fastcall ComputeError(TVec* h, TIntegration Integration, TVec* Err, TSample FS);
	void __fastcall FillSeries(TSample TransBW, TSample Ripple, int Pindex);
public:		// User declarations
	__fastcall TDifferentiatorForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TDifferentiatorForm *DifferentiatorForm;
//---------------------------------------------------------------------------
#endif

//---------------------------------------------------------------------------

#ifndef BispectrumSurfaceH
#define BispectrumSurfaceH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "FileSignal.hpp"
#include "MtxBaseComp.hpp"
#include "SignalAnalysis.hpp"
#include "SignalTools.hpp"
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.TeeSurfa.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Chart.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
//---------------------------------------------------------------------------
class TBiSpectrumSurfaceForm : public TForm
{
__published:	// IDE-managed Components
	TBiSpectrumAnalyzer *BiSpectrumAnalyzer;
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TLabel *ProgressLabel;
	TToolBar *ToolBar1;
	TToolButton *ChartEditButton;
	TToolButton *Button1;
	TCheckBox *SingleLinesOnlyBox;
	TPanel *Panel2;
	TChart *Chart1;
	TSurfaceSeries *Series1;
	TRichEdit *RichEdit1;
	TSignalRead *SignalRead1;
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall Button1Click(TObject *Sender);
	void __fastcall SingleLinesOnlyBoxClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TBiSpectrumSurfaceForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TBiSpectrumSurfaceForm *BiSpectrumSurfaceForm;
//---------------------------------------------------------------------------
#endif

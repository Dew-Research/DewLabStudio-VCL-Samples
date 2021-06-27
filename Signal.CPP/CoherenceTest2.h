//---------------------------------------------------------------------------

#ifndef CoherenceTest2H
#define CoherenceTest2H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ToolWin.hpp>
#include "FileSignal.hpp"
#include "MtxBaseComp.hpp"
#include "MtxDialogs.hpp"
#include "SignalAnalysis.hpp"
#include "SignalTools.hpp"
#include "SignalToolsDialogs.hpp"
#include "SignalToolsTee.hpp"
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
#include <Menus.hpp>
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VclTee.TeeGDIPlus.hpp>
//---------------------------------------------------------------------------
class TCoherenceTest2Form : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TCrossSpectrumAnalyzer *CrossAnalyzer;
	TCrossSpectrumAnalyzerDialog *CrossSpectrumAnalyzerDialog;
	TOpenDialog *OpenDialog;
	TPanel *Panel1;
	TLabel *Label2;
	TLabel *ProgressLabel;
	TToolBar *ToolBar1;
	TToolButton *ChartEditButton;
	TToolButton *EditSpectrumButton;
	TToolButton *UpdateButton;
	TToolButton *FirstFileButton;
	TCheckBox *PhaseBox;
	TComboBox *SamplesBox;
	TPopupMenu *PopupMenu1;
	TMenuItem *Openfile1;
	TMenuItem *OpenFile2;
	TMenuItem *N1;
	TMenuItem *Copychart;
	TMenuItem *N2;
	TMenuItem *Saveconfiguration;
	TMenuItem *Loadconfiguration;
	TSaveDialog *SaveDialog;
	TSignalRead *SignalRead1;
	TSignalRead *SignalRead2;
	TSpectrumChart *SpectrumChart;
	TFastLineSeries *Series1;
	TPointSeries *Series2;
	TAxisScaleTool *ChartTool1;
	TSpectrumMarkTool *ChartTool2;
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall PhaseBoxClick(TObject *Sender);
	void __fastcall EditSpectrumButtonClick(TObject *Sender);
	void __fastcall CrossAnalyzerParameterUpdate(TObject *Sender);
	void __fastcall UpdateButtonClick(TObject *Sender);
	void __fastcall SamplesBoxChange(TObject *Sender);
	void __fastcall CopychartClick(TObject *Sender);
	void __fastcall SaveconfigurationClick(TObject *Sender);
	void __fastcall OpenFile2Click(TObject *Sender);
	void __fastcall Openfile1Click(TObject *Sender);
	void __fastcall LoadconfigurationClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TCoherenceTest2Form(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TCoherenceTest2Form *CoherenceTest2Form;
//---------------------------------------------------------------------------
#endif

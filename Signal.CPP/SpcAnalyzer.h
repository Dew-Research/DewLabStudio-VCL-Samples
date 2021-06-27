//---------------------------------------------------------------------------

#ifndef SpcAnalyzerH
#define SpcAnalyzerH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
#include <Menus.hpp>
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
class TSpcAnalyzerForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TOpenDialog *OpenDialog;
	TPanel *Panel1;
	TToolBar *ToolBar1;
	TToolButton *SpectrumEditButton;
	TToolButton *ToolButton1;
	TCheckBox *PhaseBox;
	TPopupMenu *PopupMenu1;
	TMenuItem *Openfile1;
	TMenuItem *N2;
	TMenuItem *Copychart1;
	TMenuItem *N1;
	TMenuItem *Saveconfiguration1;
	TMenuItem *Loadconfiguration1;
	TPopupMenu *PopupMenu2;
	TMenuItem *Spectrum1;
	TMenuItem *Chart1;
	TMenuItem *File1;
	TSaveDialog *SaveDialog;
	TSignalDemux *SignalDemux1;
	TSignalRead *SignalRead1;
	TSignalReadDialog *SignalReadDialog1;
	TSpectrumAnalyzer *SpectrumAnalyzer;
	TSpectrumAnalyzerDialog *SpectrumAnalyzerDialog;
	TSpectrumChart *SpectrumChart;
	TFastLineSeries *Series1;
	TPointSeries *Series2;
	TAxisScaleTool *ChartTool1;
	TSpectrumMarkTool *ChartTool2;
	void __fastcall SpectrumAnalyzerParameterUpdate(TObject *Sender);
	void __fastcall PhaseBoxClick(TObject *Sender);
	void __fastcall Copychart1Click(TObject *Sender);
	void __fastcall Saveconfiguration1Click(TObject *Sender);
	void __fastcall Openfile1Click(TObject *Sender);
	void __fastcall Loadconfiguration1Click(TObject *Sender);
	void __fastcall SignalRead1ParameterUpdate(TObject *Sender);
	void __fastcall SignalRead1ProcessAll(TObject *Sender);
	void __fastcall Spectrum1Click(TObject *Sender);
	void __fastcall Chart1Click(TObject *Sender);
	void __fastcall File1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TSpcAnalyzerForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TSpcAnalyzerForm *SpcAnalyzerForm;
//---------------------------------------------------------------------------
#endif

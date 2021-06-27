//---------------------------------------------------------------------------

#ifndef BiSpcAnalyzerH
#define BiSpcAnalyzerH
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
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
#include <Menus.hpp>
#include <ToolWin.hpp>
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VclTee.TeeGDIPlus.hpp>
//---------------------------------------------------------------------------
class TBiSpcAnalyzerForm : public TForm
{
__published:	// IDE-managed Components
	TBiSpectrumAnalyzer *BiSpectrumAnalyzer;
	TBiSpectrumAnalyzerDialog *BiSpectrumAnalyzerDialog;
	TChartEditor *ChartEditor;
	TOpenDialog *OpenDialog;
	TPanel *Panel1;
	TLabel *FrequencyLabel;
	TLabel *ProgressLabel;
	TToolBar *ToolBar1;
	TToolButton *SpectrumEditButton;
	TToolButton *ToolButton1;
	TToolButton *ChartEditButton;
	TToolButton *Button1;
	TMtxFloatEdit *FrequencyEdit;
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
	TPopupMenu *PopupMenu;
	TMenuItem *Openfile1;
	TMenuItem *N2;
	TMenuItem *Copy1;
	TMenuItem *Recalculate1;
	TMenuItem *N1;
	TMenuItem *SaveConfig;
	TMenuItem *LoadConfig;
	TSaveDialog *SaveDialog;
	TSignalRead *SignalRead1;
	TSpectrumAnalyzer *SpectrumAnalyzer;
	TSpectrumAnalyzerDialog *SpectrumAnalyzerDialog;
	void __fastcall SpectrumEditButtonClick(TObject *Sender);
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall SpectrumAnalyzerParameterUpdate(TObject *Sender);
	void __fastcall Panel2Resize(TObject *Sender);
	void __fastcall Openfile1Click(TObject *Sender);
	void __fastcall ToolButton1Click(TObject *Sender);
	void __fastcall SaveConfigClick(TObject *Sender);
	void __fastcall LoadConfigClick(TObject *Sender);
	void __fastcall BiSpectrumAnalyzerParameterUpdate(TObject *Sender);
	void __fastcall Recalculate1Click(TObject *Sender);
	void __fastcall FrequencyEditChange(TObject *Sender);
	void __fastcall Copy1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TBiSpcAnalyzerForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TBiSpcAnalyzerForm *BiSpcAnalyzerForm;
//---------------------------------------------------------------------------
#endif

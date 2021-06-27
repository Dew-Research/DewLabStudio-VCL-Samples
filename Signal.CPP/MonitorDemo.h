//---------------------------------------------------------------------------

#ifndef MonitorDemoH
#define MonitorDemoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Menus.hpp>
#include <ToolWin.hpp>
#include "AudioSignal.hpp"
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
class TMonitorDemoForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TChartEditor *ChartEditor1;
	TPanel *Panel1;
	TLabel *Label1;
	TToolBar *ToolBar1;
	TToolButton *SpectrumEditButton;
	TToolButton *StartButton;
	TComboBox *ChannelBox;
	TCheckBox *RecordToFileBox;
	TPanel *Panel2;
	TSplitter *Splitter1;
	TSpectrumChart *SpectrumChart;
	TFastLineSeries *Series1;
	TPointSeries *Series2;
	TAxisScaleTool *ChartTool1;
	TSpectrumMarkTool *ChartTool2;
	TSignalChart *SignalChart;
	TFastLineSeries *Series3;
	TPopupMenu *PopupMenu1;
	TMenuItem *Spectrum1;
	TMenuItem *Recording1;
	TMenuItem *N1;
	TMenuItem *Spectrumchart1;
	TMenuItem *imechart1;
	TRichEdit *RichEdit1;
	TSignal *Signal1;
	TSignalIn *SignalIn1;
	TSignalInDialog *SignalInDialog;
	TSignalTimer *SignalTimer1;
	TSignalWrite *SignalWrite1;
	TSpectrumAnalyzer *SpectrumAnalyzer;
	TSpectrumAnalyzerDialog *SpectrumAnalyzerDialog;
	void __fastcall SpectrumAnalyzerParameterUpdate(TObject *Sender);
	void __fastcall Panel2Resize(TObject *Sender);
	void __fastcall RecordToFileBoxClick(TObject *Sender);
	void __fastcall Spectrum1Click(TObject *Sender);
	void __fastcall imechart1Click(TObject *Sender);
	void __fastcall Recording1Click(TObject *Sender);
	void __fastcall Spectrumchart1Click(TObject *Sender);
	void __fastcall StartButtonClick(TObject *Sender);
	void __fastcall SignalTimer1Timer(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TMonitorDemoForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TMonitorDemoForm *MonitorDemoForm;
//---------------------------------------------------------------------------
#endif

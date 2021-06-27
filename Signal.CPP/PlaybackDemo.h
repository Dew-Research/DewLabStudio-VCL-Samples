//---------------------------------------------------------------------------

#ifndef PlaybackDemoH
#define PlaybackDemoH
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
class TPlaybackDemoForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TChartEditor *ChartEditor2;
	TOpenDialog *OpenDialog1;
	TPanel *Panel1;
	TLabel *Label1;
	TToolBar *ToolBar1;
	TToolButton *SpectrumEditButton;
	TToolButton *ToolButton1;
	TComboBox *ChannelBox;
	TPanel *Panel2;
	TSplitter *Splitter1;
	TSpectrumChart *SpectrumChart;
	TFastLineSeries *Series1;
	TPointSeries *Series2;
	TAxisScaleTool *ChartTool1;
	TSpectrumMarkTool *ChartTool2;
	TSignalChart *SignalChart1;
	TFastLineSeries *Series3;
	TPopupMenu *PopupMenu1;
	TMenuItem *Spectrum1;
	TMenuItem *Playback1;
	TMenuItem *N1;
	TMenuItem *Chart1;
	TMenuItem *imechart1;
	TRichEdit *RichEdit1;
	TSignal *Signal1;
	TSignalOut *SignalOut1;
	TSignalOutDialog *SignalOutDialog;
	TSignalRead *SignalRead1;
	TSignalTimer *SignalTimer1;
	TSpectrumAnalyzer *SpectrumAnalyzer;
	TSpectrumAnalyzerDialog *SpectrumAnalyzerDialog;
	void __fastcall Spectrum1Click(TObject *Sender);
	void __fastcall Chart1Click(TObject *Sender);
	void __fastcall Playback1Click(TObject *Sender);
	void __fastcall imechart1Click(TObject *Sender);
	void __fastcall SpectrumAnalyzerParameterUpdate(TObject *Sender);
	void __fastcall Panel2Resize(TObject *Sender);
	void __fastcall SignalTimer1Timer(TObject *Sender);
	void __fastcall ToolButton1Click(TObject *Sender);
private:	// User declarations
	void __fastcall WaitForPlayback();
public:		// User declarations
	__fastcall TPlaybackDemoForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TPlaybackDemoForm *PlaybackDemoForm;
//---------------------------------------------------------------------------
#endif

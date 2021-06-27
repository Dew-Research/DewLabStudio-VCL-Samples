//---------------------------------------------------------------------------

#ifndef BrowseDemoH
#define BrowseDemoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <VCLTee.ErrorBar.hpp>
#include "FileSignal.hpp"
#include "MtxBaseComp.hpp"
#include "MtxComCtrls.hpp"
#include "SignalSeriesTee.hpp"
#include "SignalTools.hpp"
#include "SignalToolsTee.hpp"
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.Chart.hpp>
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <ToolWin.hpp>
#include <TypeInfo>
#include "FileSignal.hpp"
#include "MtxBaseComp.hpp"
#include "MtxComCtrls.hpp"
#include "SignalSeriesTee.hpp"
#include "SignalTools.hpp"
#include "SignalToolsTee.hpp"
#include <VCLTee.TeeEdit.hpp>
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
//---------------------------------------------------------------------------
class TBrowseDemoForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TOpenDialog *OpenDialog1;
	TPanel *Panel1;
	TLabel *Label1;
	TToolBar *ToolBar1;
	TToolButton *ChartButton;
	TToolButton *OpenFileButton;
	TComboBox *ChannelBox;
	TMtxPositionPanel *PositionPanel;
	TCheckBox *ThreadedBox;
	TPanel *Panel2;
	TSignalChart *SignalChart1;
	TSignalHighLowSeries *Series1;
	TRichEdit *RichEdit1;
	TSignal *Signal1;
	TSignalBrowse *SignalBrowse1;
	void __fastcall ChartButtonClick(TObject *Sender);
	void __fastcall OpenFileButtonClick(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall ChannelBoxChange(TObject *Sender);
	void __fastcall SignalBrowse1ProgressUpdate(TObject *Sender,
          TMtxProgressEvent Event);
private:	// User declarations
	void __fastcall BrowseChartUpdate(TSample DtOffset);
	void __fastcall DrawOverviewSeries(TVec *Src, TChartSeries *Series,
		TSample DtOffset,	TSample Dt);
	void __fastcall DrawHighLowValues(TVec *Src, TChartSeries *Series,
			TSample DtOffset,	TSample Dt, bool DownSample);
public:		// User declarations
	__fastcall TBrowseDemoForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TBrowseDemoForm *BrowseDemoForm;
//---------------------------------------------------------------------------
#endif

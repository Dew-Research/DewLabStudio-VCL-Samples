//---------------------------------------------------------------------------

#ifndef DiscreteSeriesDemoH
#define DiscreteSeriesDemoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "MtxComCtrls.hpp"
#include "SignalSeriesTee.hpp"
#include "SignalToolsTee.hpp"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
//---------------------------------------------------------------------------
class TDiscreteSeriesDemoForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TLabel *Label1;
	TToolBar *ToolBar1;
	TToolButton *ChartEditButton;
	TMtxFloatEdit *StepEdit;
	TPanel *Panel2;
	TSplitter *Splitter1;
	TSignalChart *SignalChart1;
	TSignalDiscreteSeries *Series1;
	TRichEdit *RichEdit1;
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall StepEditChange(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TDiscreteSeriesDemoForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TDiscreteSeriesDemoForm *DiscreteSeriesDemoForm;
//---------------------------------------------------------------------------
#endif

//---------------------------------------------------------------------------

#ifndef PhaseDemoH
#define PhaseDemoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ToolWin.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include "MtxComCtrls.hpp"
#include "SignalSeriesTee.hpp"
#include "SignalToolsTee.hpp"
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.Chart.hpp>
//---------------------------------------------------------------------------
class TPhaseDemoForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TLabel *Label1;
	TLabel *Label2;
	TToolBar *ToolBar1;
	TToolButton *ChartEditButton;
	TMtxFloatEdit *StepEdit;
	TMtxFloatEdit *ZeroPaddEdit;
	TPanel *Panel2;
	TSplitter *Splitter1;
	TSignalChart *SignalChart1;
	TSignalDiscreteSeries *Series1;
	TRichEdit *RichEdit1;
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall StepEditChange(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TPhaseDemoForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TPhaseDemoForm *PhaseDemoForm;
//---------------------------------------------------------------------------
#endif

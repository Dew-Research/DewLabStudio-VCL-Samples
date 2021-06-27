//---------------------------------------------------------------------------

#ifndef MedianDemoH
#define MedianDemoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
#include "MtxComCtrls.hpp"
#include "SignalToolsTee.hpp"
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
//---------------------------------------------------------------------------
class TMedianDemoForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TLabel *Label1;
	TLabel *Label2;
	TToolBar *ToolBar1;
	TToolButton *ChartEditButton;
	TComboBox *FilterBox;
	TMtxFloatEdit *StepEdit;
	TPanel *Panel2;
	TSplitter *Splitter1;
	TSignalChart *SignalChart1;
	TFastLineSeries *Series3;
	TFastLineSeries *Series1;
	TRichEdit *RichEdit1;
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall FilterBoxChange(TObject *Sender);
private:	// User declarations
	TMedianState MedianState;
	TDelayFilterState DelayState;
	void __fastcall UpdateMedian();
	void __fastcall UpdateDelay();
public:		// User declarations
	__fastcall TMedianDemoForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TMedianDemoForm *MedianDemoForm;
//---------------------------------------------------------------------------
#endif

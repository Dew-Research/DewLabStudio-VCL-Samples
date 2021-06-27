//---------------------------------------------------------------------------

#ifndef IirGroupDelayH
#define IirGroupDelayH
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
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
//---------------------------------------------------------------------------
class TIirGroupDelayForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TLabel *Label1;
	TLabel *Label2;
	TToolBar *ToolBar1;
	TToolButton *ChartEditButton;
	TMtxFloatEdit *OrderEdit;
	TMtxFloatEdit *AttEdit;
	TRichEdit *RichEdit1;
	TSpectrumChart *SpectrumChart;
	TAxisScaleTool *ChartTool1;
	TSpectrumMarkTool *ChartTool2;
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall OrderEditChange(TObject *Sender);
private:	// User declarations
	void __fastcall FillSeries(int Order, int Att);
public:		// User declarations
	__fastcall TIirGroupDelayForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TIirGroupDelayForm *IirGroupDelayForm;
//---------------------------------------------------------------------------
#endif

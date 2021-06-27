//---------------------------------------------------------------------------

#ifndef IirZerosH
#define IirZerosH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "MtxComCtrls.hpp"
#include "SignalToolsTee.hpp"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.TeePolar.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
//---------------------------------------------------------------------------
class TIirZerosForm : public TForm
{
__published:	// IDE-managed Components
	TChartEditor *ChartEditor;
	TPanel *Panel1;
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label3;
	TToolBar *ToolBar1;
	TToolButton *ChartEditButton;
	TMtxFloatEdit *OrderEdit;
	TMtxFloatEdit *AttEdit;
	TComboBox *FilterBox;
	TRichEdit *RichEdit1;
	TSpectrumChart *ZeroPoleChart;
	TPolarSeries *Series1;
	TPolarSeries *Series2;
	TAxisScaleTool *ChartTool1;
	TSpectrumMarkTool *ChartTool2;
	void __fastcall ChartEditButtonClick(TObject *Sender);
	void __fastcall FilterBoxChange(TObject *Sender);
private:	// User declarations
	void __fastcall FillSeries(int Order, int Att);
public:		// User declarations
	Mtxexpr::sVector r,phi;
	__fastcall TIirZerosForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TIirZerosForm *IirZerosForm;
//---------------------------------------------------------------------------
#endif

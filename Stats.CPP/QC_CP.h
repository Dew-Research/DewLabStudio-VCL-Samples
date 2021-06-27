//---------------------------------------------------------------------------

#ifndef QC_CPH
#define QC_CPH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Form.h"
#include <ExtCtrls.hpp>
#include <VCLTee.StatChar.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeTools.hpp>
#include <Mtxexpr.hpp>
#include <Statistics.hpp>
#include <MtxVecTee.hpp>
#include <StatControlCharts.hpp>
//---------------------------------------------------------------------------
class TfrmQCCP : public TfrmBasic
{
__published:	// IDE-managed Components
	TChart *Chart1;
	THistogramSeries *Series1;
	TLineSeries *Series2;
	TColorLineTool *ChartTool1;
	TColorLineTool *ChartTool2;
	TPanel *Panel2;
	TLabel *Label2;
	TLabel *Label1;
	TLabel *Label3;
	TLabel *Label4;
	TLabel *Label5;
	TLabel *Label6;
	TEdit *Edit1;
	TCheckBox *CheckBox1;
	void __fastcall ChartTool1EndDragLine(TColorLineTool *Sender);
	void __fastcall ChartTool2EndDragLine(TColorLineTool *Sender);
	void __fastcall Edit1Change(TObject *Sender);
	void __fastcall CheckBox1Click(TObject *Sender);
private:	// User declarations
	sVector Data;
	TSample p, CP, CPK, Alpha;
	TTwoElmReal CPConfInt, CPKConfInt;
	void __fastcall Recalculate();
public:		// User declarations
	__fastcall TfrmQCCP(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmQCCP *frmQCCP;
//---------------------------------------------------------------------------
#endif


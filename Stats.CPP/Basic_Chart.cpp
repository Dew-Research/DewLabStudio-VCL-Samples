//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Basic_Chart.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Form"
#pragma resource "*.dfm"
TfrmBasicChart *frmBasicChart;
//---------------------------------------------------------------------------
__fastcall TfrmBasicChart::TfrmBasicChart(TComponent* Owner)
	: TfrmBasic(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmBasicChart::Button1Click(TObject *Sender)
{
	EditChart(this,Chart1);
}
//---------------------------------------------------------------------------

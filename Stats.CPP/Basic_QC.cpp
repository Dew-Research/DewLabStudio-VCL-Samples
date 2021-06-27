//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Basic_QC.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Form"
#pragma resource "*.dfm"
TfrmBasicQC *frmBasicQC;
//---------------------------------------------------------------------------
__fastcall TfrmBasicQC::TfrmBasicQC(TComponent* Owner)
	: TfrmBasic(Owner)
{
	Edit1->Text = FormatFloat("0.00",99.8);
	Confidence = 99.8;
	// Setup QC series and it's properties
	Series1 = new TQCSeries(Chart1);
	Series1->SeriesColor = clBlue;
	Series1->ColorEachLine = False;
	Series1->ColorEachPoint = True;
	Series1->LinePen->Width = 2;
	Series1->Pointer->Style = psTriangle;
	Series1->Pointer->VertSize = 3;
	Series1->Pointer->HorizSize = 3;
	Series1->ControlLimitPen->Style = psDash;
	Series1->ControlLimitPen->Color = clRed;
	Series1->CLPen->Color = clBlue;
	Series1->CLPen->Style = psDash;
	Series1->ParentChart = Chart1;
}
//---------------------------------------------------------------------------
void __fastcall TfrmBasicQC::Recalculate()
{
	BeforeRecalculate();
	Chart1->AutoRepaint = false;
	for (int i = 0;i<Chart1->SeriesCount();i++)
		if (dynamic_cast<TQCSeries*>(Chart1->Series[i]) != NULL)
		{
			TQCSeries* ser = dynamic_cast<TQCSeries*>(Chart1->Series[i]);
			for (int j = 0 ;j<Chart1->Series[i]->Count();j++)
					if ((*Chart1->Series[i]->YValues)[j]<ser->UCL && (*Chart1->Series[i]->YValues)[j]>ser->LCL)
						ser->ValueColor[j] = ser->SeriesColor;
					else Chart1->Series[i]->ValueColor[j] = clRed;
		}
	Chart1->AutoRepaint = true;
	Chart1->Repaint();
}

void __fastcall TfrmBasicQC::Button1Click(TObject *Sender)
{
	EditSeries(this,Series1);	
}
//---------------------------------------------------------------------------

void __fastcall TfrmBasicQC::Button2Click(TObject *Sender)
{
	ViewValues(Data,Data->Caption,true,false);
	Recalculate();
}
//---------------------------------------------------------------------------

void __fastcall TfrmBasicQC::FormDestroy(TObject *Sender)
{
  Series1->ParentChart = NULL;
	delete Series1;
}
//---------------------------------------------------------------------------

void __fastcall TfrmBasicQC::Edit1Change(TObject *Sender)
{
	if (Showing && Edit1->Text != "")
	{
		try
		{
			Confidence = StrToFloat(Edit1->Text);
		} catch (...) {
			Confidence = 99.8;
		}
		Recalculate();
	}
}
//---------------------------------------------------------------------------


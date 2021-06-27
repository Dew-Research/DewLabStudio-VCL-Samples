//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "DirichletTest.h"
#include "Probabilities.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TfrmDirichlet *frmDirichlet;
//---------------------------------------------------------------------------
__fastcall TfrmDirichlet::TfrmDirichlet(TComponent* Owner)
  : TBasicForm2(Owner)
{
    AnsiString str;

    RichEdit1->Lines->Clear();
    str = "Several new special functions have been added to MtxVec ";
    str+= "Probabilities unit. MtxVec now supports Riemann Zeta, Dirichlet Eta ";
    str+= "and Dirichlet Lambda functions in complex plane.";
    RichEdit1->Lines->Add(str);
    RichEdit1->Lines->Add("");

    GridSer = new TMtxGridSeries(Chart1);
	GridSer->ColorPalette->BottomColor = clYellow;
	GridSer->ColorPalette->TopColor = clRed;
    GridSer->ColorPalette->PaletteSteps = 16;
    GridSer->ParentChart = Chart1;
    Generate();
}

//---------------------------------------------------------------------------

//---------------------------------------------------------------------------

void __fastcall TfrmDirichlet::Button1Click(TObject *Sender)
{
    Generate();
}
//---------------------------------------------------------------------------

void __fastcall TfrmDirichlet::RadioGroup1Click(TObject *Sender)
{
  Generate();
}
//---------------------------------------------------------------------------

void __fastcall TfrmDirichlet::RadioGroup2Click(TObject *Sender)
{
  Generate();
}
//---------------------------------------------------------------------------
void __fastcall TfrmDirichlet::Generate()
{
  int i,j;

  Screen->Cursor = crHourGlass;

  xmin = StrToFloat(Edit1->Text);
  xmax = StrToFloat(Edit2->Text);
  ymin = StrToFloat(Edit3->Text);
  ymax = StrToFloat(Edit4->Text);
  xstep = (xmax-xmin)*0.02;
  ystep = (ymax-ymin)*0.02;

  Data.Size(50,50,false);

  for (i = 0; i < 50; i++) {
    for (j = 0; j < 50; j++) {

      switch (RadioGroup1->ItemIndex) {
        case 0: CVal = RiemannZeta(Cplx(xmin+i*xstep,ymin+j*ystep));
                break;
        case 1: CVal = DirichletEta(Cplx(xmin+i*xstep,ymin+j*ystep));
                break;
        case 2: CVal = DirichletLambda(Cplx(xmin+i*xstep,ymin+j*ystep));
                break;
        case 3: CVal = DirichletBeta(Cplx(xmin+i*xstep,ymin+j*ystep));
                break;
      }

	  if (Data.IsDouble) {

		  switch (RadioGroup2->ItemIndex) {
			case 0: Data.Values(i,j) = CVal.Re;
					break;
			case 1: Data.Values(i,j) = CVal.Im;
					break;
			case 2: Data.Values(i,j) = CAbs(CVal);
					break;
		  }
	  }
	  else
	  {
		  switch (RadioGroup2->ItemIndex) {
			case 0: Data.SValues(i,j) = CVal.Re;
					break;
			case 1: Data.SValues(i,j) = CVal.Im;
					break;
			case 2: Data.SValues(i,j) = CAbs(CVal);
					break;
		  }
      }
	}
  }
  GridSer->Matrix = Data;
  GridSer->XOffset = xmin;
  GridSer->XStep = xstep;
  GridSer->YOffset = ymin;
  GridSer->YStep = ystep;
//  GridSer->CreateDefaultPalette();
  GridSer->GetVertAxis->Increment = (ymax-ymin)*0.01;
  GridSer->GetHorizAxis->Increment = (xmax-xmin)*0.01;

  Screen->Cursor = crDefault;
}
//---------------------------------------------------------------------------

void __fastcall TfrmDirichlet::Chart1AfterDraw(TObject *Sender)
{
    int pos;

//  inherited;

    pos = Chart1->BottomAxis->CalcPosValue(0.0);
    if ((pos > Chart1->ChartRect.Left) && (pos < Chart1->ChartRect.Right)) {

      Chart1->Canvas->Pen->Color = clBlack;
      Chart1->Canvas->Pen->Style = psDot;
      Chart1->Canvas->Line(pos,Chart1->ChartRect.Bottom,pos,Chart1->ChartRect.Top);
    }
    pos = Chart1->LeftAxis->CalcPosValue(0.0);
    if ((pos>Chart1->ChartRect.Top) && (pos<Chart1->ChartRect.Bottom)) {

      Chart1->Canvas->Pen->Color = clBlack;
      Chart1->Canvas->Pen->Style = psDot;
      Chart1->Canvas->Line(Chart1->ChartRect.Left,pos,Chart1->ChartRect.Right,pos);
     }

}
//---------------------------------------------------------------------------



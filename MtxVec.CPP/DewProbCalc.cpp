//---------------------------------------------------------------------------
#include <vcl.h>
#include <math.h>
#pragma hdrstop

#include "DewProbCalc.h"
#include <Vcl.Clipbrd.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "ProbEditor"
#pragma resource "*.dfm"
TfrmProbCalc *frmProbCalc;
//---------------------------------------------------------------------------
__fastcall TfrmProbCalc::TfrmProbCalc(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmProbCalc::FormCreate(TObject *Sender)
{
  Dist = new TProbDistribution();
  Dist->LB = 0;
  Dist->UB = 1;
  Dist->NumPoints = 50;
  FrameDist1->Distribution = Dist;
  FrameDist1->ListBoxDist->ItemIndex = (int)Dist->DistType;
}
//---------------------------------------------------------------------------
void __fastcall TfrmProbCalc::FormDestroy(TObject *Sender)
{
  delete Dist;
}
//---------------------------------------------------------------------------
void __fastcall TfrmProbCalc::aAdditionalInfoExecute(TObject *Sender)
{
  Chart1->Repaint();
}
//---------------------------------------------------------------------------
void __fastcall TfrmProbCalc::Chart1AfterDraw(TObject *Sender)
{
  if (CheckBox3->Checked)
  {
    Chart1->Canvas->Font->Size = Chart1->Title->Font->Size;
    int linc = Math387::RoundToInt(Chart1->Canvas->Font->Size * 1.3);
    int xstart = Chart1->ChartRect.Left + 30;
    int ystart = Chart1->ChartRect.Top + 30;
    AnsiString tstr = Dist->Caption + " distribution";
    Chart1->Canvas->TextOut(xstart, ystart, tstr);
    ystart += linc * 2;
    Chart1->Canvas->TextOut(xstart, ystart, "parameters:");
    ystart += linc;
    for (int i = 0; i < Dist->DistParams->Count; i++)
    {
      tstr = Dist->DistParams->Items[i]->Name + ":" +
             FloatToStrF(Dist->DistParams->Items[i]->Value, ffFixed, 6, 6);
      Chart1->Canvas->TextOut(xstart, ystart, tstr);
      ystart += linc;
    }
    ystart += linc;
    Chart1->Canvas->TextOut(xstart, ystart,
        "Plot range:" + FloatToStrF(Dist->LB, ffFixed, 6, 6) +
        " to " + FloatToStrF(Dist->UB, ffFixed, 6, 6));
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmProbCalc::CheckBox4Click(TObject *Sender)
{
  Chart1->Repaint();
}
//---------------------------------------------------------------------------
void __fastcall TfrmProbCalc::FrameDist1RadioGroupOutClick(TObject *Sender)
{
  FrameDist1->RadioGroupOutClick(Sender);
  TabSheetChart->TabVisible = (aPDF->Checked) && (FrameDist1->RadioGroupOut->ItemIndex == 0);
}
//---------------------------------------------------------------------------
static AnsiString ResToStr(double res) { return SampleToStr(res, 6, 6); }
static AnsiString Val2Str(double x, double val) { return ResToStr(x) + "\t\t" + ResToStr(val); }
static void AddPointToSeries(TChartSeries *aSeries, double x, double y)
{
  if (!(IsNan(x) || IsNan(y) || IsInf(x) || IsInf(y)))
    aSeries->AddXY(x, y);
}
//---------------------------------------------------------------------------
void __fastcall TfrmProbCalc::aCalcExecute(TObject *Sender)
{
  if (CheckBox4->Checked) aClearAllExecute(this);
  Chart1->Title->Text->Clear();

  MemoResults->Lines->Add(Dist->Caption + " distribution");
  for (int i = 0; i < Dist->DistParams->Count; i++)
    MemoResults->Lines->Add(Dist->DistParams->Items[i]->Name + "= " +
                            SampleToStr(Dist->DistParams->Items[i]->Value, 6, 6));

  if (aPDF->Checked)
  {
    Chart1->Title->Text->Add("Probability density function");
    Chart1->Axes->Left->Title->Caption = "PDF";
    Chart1->Axes->Bottom->Title->Caption = "x";
    MemoResults->Lines->Add("Calculating probability density function (PDF)");
    MemoResults->Lines->Add("x\t\tPDF(x)");
  }
  else if (aCDF->Checked)
  {
    Chart1->Title->Text->Add("Cumulative distribution function");
    Chart1->Axes->Left->Title->Caption = "CDF";
    Chart1->Axes->Bottom->Title->Caption = "x";
    MemoResults->Lines->Add("Calculating cumulative distribution function (CDF)");
    MemoResults->Lines->Add("x\t\tCDF(x)");
  }
  else
  {
    Chart1->Axes->Left->Title->Caption = "PPF";
    Chart1->Axes->Bottom->Title->Caption = "p";
    MemoResults->Lines->Add("Calculating point percent function (PPF)");
    MemoResults->Lines->Add("p\t\tx(p)");
  }
  MemoResults->Lines->Add("---------------------------------------------");

  if (FrameDist1->RadioGroupOut->ItemIndex == 0)
  {
    // single point
    if (aICDF->Checked) MemoResults->Lines->Add(Val2Str(Dist->p->Value, Dist->PPF));
    else if (aPDF->Checked) MemoResults->Lines->Add(Val2Str(Dist->X->Value, Dist->PDF));
    else if (aCDF->Checked) MemoResults->Lines->Add(Val2Str(Dist->X->Value, Dist->CDF));
  }
  else
  {
    // range
    double clb = Dist->LB;
    double cub = Dist->UB;
    double calcstep = (cub - clb) / Dist->NumPoints;
    for (int i = 0; i < Dist->NumPoints; i++)
    {
      double parvalue;
      if (aICDF->Checked) parvalue = 0 + (double)i / Dist->NumPoints;
      else parvalue = clb + i * calcstep;
      double yval = 0.0;
      if (aPDF->Checked) yval = Dist->CalculatePDF(parvalue);
      else if (aCDF->Checked) yval = Dist->CalculateCDF(parvalue);
      else if (aICDF->Checked) yval = Dist->CalculatePPF(parvalue);

      MemoResults->Lines->Add(Val2Str(parvalue, yval));
      AddPointToSeries(Chart1->Series[0], parvalue, yval);
    }
  }
  MemoResults->Lines->Add("---------------------------------------------");
}
//---------------------------------------------------------------------------
void __fastcall TfrmProbCalc::aCDFExecute(TObject *Sender)
{
  TabSheetChart->TabVisible = (FrameDist1->RadioGroupOut->ItemIndex != 0);
  aCalcExecute(this);
}
//---------------------------------------------------------------------------
void __fastcall TfrmProbCalc::aPDFExecute(TObject *Sender)
{
  TabSheetChart->TabVisible = (FrameDist1->RadioGroupOut->ItemIndex != 0);
  aCalcExecute(this);
}
//---------------------------------------------------------------------------
void __fastcall TfrmProbCalc::aICDFExecute(TObject *Sender)
{
  TabSheetChart->TabVisible = (FrameDist1->RadioGroupOut->ItemIndex != 0);
  if (FrameDist1->RadioGroupOut->ItemIndex == 0)
  {
    AnsiString tStr = InputBox("Set p", "Valid range: 0<=p<=1",
                               FloatToStrF(Dist->p->Value, ffFixed, 6, 6));
    Dist->p->Value = StrToFloat(tStr);
  }
  aCalcExecute(this);
}
//---------------------------------------------------------------------------
void __fastcall TfrmProbCalc::aClearAllExecute(TObject *Sender)
{
  MemoResults->Lines->Clear();
  for (int i = 0; i < Chart1->SeriesCount(); i++)
    Chart1->Series[i]->Clear();
}
//---------------------------------------------------------------------------
void __fastcall TfrmProbCalc::aClearAllUpdate(TObject *Sender)
{
  aClearAll->Enabled = MemoResults->Lines->Count > 0;
}
//---------------------------------------------------------------------------

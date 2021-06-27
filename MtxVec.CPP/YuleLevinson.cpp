//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "YuleLevinson.h"
#include "MtxVecTee.hpp"
#include "Toeplitz.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic1"
#pragma resource "*.dfm"
TYuleLev *YuleLev;
//---------------------------------------------------------------------------
__fastcall TYuleLev::TYuleLev(TComponent* Owner)
  : TBasicForm1(Owner)
{
  RadioGroup1Click(RadioGroup1);
  TrackBar1Change(TrackBar1);
  TrackBar2Change(TrackBar2);

  AnsiString str;

  RichEdit1->Lines->Clear();
  str =   "YuleWalker autoregressive spectra uses Levinson ";
  str +=  "Durbin recursion to solve a toeplitz systems of ";
  str +=  "linear equations taking only O(n2) operations ";
  str +=  "instead of O(n3) as required by LUSolve. The chart ";
  str +=  "compares FFT and YuleWalker AR. The corrLen defines ";
  str +=  "the number of samples on which the Autocorrelation ";
  str +=  "is performed and LPCCoef defines the number of ";
  str +=  "computed autocorrelation coefficients. The method ";
  str +=  "uses biased autocorrelation. FFT uses only LPCoef ";
  str +=  "parameter to determine the number of sample to ";
  str +=  "include. It then rounds LPCCoef to the nearest ";
  str +=  "power of two. FFT uses no windowing.";

  RichEdit1->Lines->Add(str);
  str =   "Zoom in on a chart (left-click and drag mouse ";
  str +=  "over the chart) to see differences. Please note ";
  str +=  "that it takes less then 10ms to compute a 32000 ";
  str +=  "point FFT on P366.";
  RichEdit1->Lines->Add(str);
}
//---------------------------------------------------------------------------


void __fastcall TYuleLev::Button1Click(TObject *Sender)
{
        sVector DownY;

        double Step;
		Series1->Clear();
        Series2->Clear();
        Screen->Cursor = crHourGlass;
        StartTimer();
        // Levinson Yule Walker
		y.LoadFromFile("FFTData.vec"); // Load signal
		y.Resize(CorrLen,false);
        corr.AutoCorrBiased(y,LPCCoef);  // auto correlation
        Levinson(corr, y); // Levinson recursion
		y.Resize(LargestExp2(y.Length*ZeroPadding),true); // zero padder
		x.FFT(y,false);
		spec.Mag(x);
		spec.Inv();
        spec.Log10();
        TimeElapsed = StopTimer()*1000.0;
        Label5->Caption = "Time needed for Levinson YW : "+ IntToStr((int) TimeElapsed)+" ms";
        if (DownSize)
		{
			DownY.PixelDownSample(Chart1->ChartWidth,spec,NULL,NULL);
			Step = 0.5*(spec.Length/double(Chart1->ChartWidth));
            DrawValues(DownY,Series1,0.0,Step,false);
        }
        else DrawValues(spec,Series1,0.0,1,false);

		StartTimer();
        // "Regular" FFT
		y.LoadFromFile("FFTData.vec"); // Load signal
		y.Resize(LPCCoef);
		y.Resize(LargestExp2(LPCCoef)*ZeroPadding,true);
		x.FFT(y,false);
		spec.Mag(x);
		spec.ThreshBottom(0.00001); //-100 dB
        spec.Log10();
        TimeElapsed = StopTimer()*1000;
        Label6->Caption = "Time needed for FFT : "+ IntToStr((int) TimeElapsed)+" ms";
        if (DownSize)
        {
			DownY.PixelDownSample(Chart1->ChartWidth,spec,NULL,NULL);
            Step = 0.5*(spec.Length/double(Chart1->ChartWidth));
            DrawValues(DownY,Series2,0.0,Step,false);
        }
        else DrawValues(spec,Series2,0.0,1,false);

        Chart1->Repaint();
        Screen->Cursor = crDefault;

}
//---------------------------------------------------------------------------

void __fastcall TYuleLev::TrackBar1Change(TObject *Sender)
{
  CorrLen = TrackBar1->Position;
  Label2->Caption = IntToStr(CorrLen);
  TrackBar2->Max = CorrLen;
  TrackBar2->Frequency = CorrLen*0.05;
  TrackBar2->Position = CorrLen*0.5;
  TrackBar2Change(TrackBar2);
}
//---------------------------------------------------------------------------

void __fastcall TYuleLev::TrackBar2Change(TObject *Sender)
{
  LPCCoef = TrackBar2->Position;
  Label4->Caption = IntToStr(LPCCoef);
}
//---------------------------------------------------------------------------

void __fastcall TYuleLev::RadioGroup1Click(TObject *Sender)
{
  switch (RadioGroup1->ItemIndex)
  {
    case 0 : ZeroPadding = 1; break;
    case 1 : ZeroPadding = 2; break;
    case 2 : ZeroPadding = 4; break;
    case 3 : ZeroPadding = 8; break;
    case 4 : ZeroPadding = 16; break;
  }
}
//---------------------------------------------------------------------------


 
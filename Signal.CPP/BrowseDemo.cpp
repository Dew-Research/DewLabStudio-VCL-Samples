//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MtxExpr.hpp"
#include "BrowseDemo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TBrowseDemoForm *BrowseDemoForm;
//---------------------------------------------------------------------------
__fastcall TBrowseDemoForm::TBrowseDemoForm(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TBrowseDemoForm::ChartButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TBrowseDemoForm::OpenFileButtonClick(TObject *Sender)
{
	if (OpenDialog1->Execute())
	{
		SignalBrowse1->Threaded = ThreadedBox->Checked;
		Screen->Cursor = crHourGlass;
		SignalBrowse1->OpenBrowseFile(OpenDialog1->FileName);
		if (!SignalBrowse1->Threaded)
		{
			SignalBrowse1->LoadFullRecord();
			BrowseChartUpdate(0);
		}
		Screen->Cursor = crDefault;
	}
}
//---------------------------------------------------------------------------
void __fastcall TBrowseDemoForm::BrowseChartUpdate(TSample DtOffset)
{
	Mtxexpr::sVector a1;
	SignalChart1->Series[0]->Clear();
	switch (SignalBrowse1->ChannelCount)
	{
		case 1:
		{
			Demultiplex(SignalBrowse1->Data,a1,SignalBrowse1->ChannelCount, 0);
			DrawOverviewSeries(a1,SignalChart1->Series[0], DtOffset, SignalBrowse1->Dt);
			break;
		};
		case 2:
		{
			switch (ChannelBox->ItemIndex)
			{
				case 0:
				{
					Demultiplex(SignalBrowse1->Data,a1,SignalBrowse1->ChannelCount, 0);
					DrawOverviewSeries(a1,SignalChart1->Series[0], DtOffset, SignalBrowse1->Dt);
					break;
				}
				case 1:
				{
					Demultiplex(SignalBrowse1->Data,a1,SignalBrowse1->ChannelCount, 1);
					DrawOverviewSeries(a1,SignalChart1->Series[0], DtOffset, SignalBrowse1->Dt);
					break;
				}
			}
			break;
		}
	}
}

void __fastcall TBrowseDemoForm::DrawOverviewSeries(TVec *Src, TChartSeries *Series,
		TSample DtOffset,	TSample Dt)
{
	 ((TSignalHighLowSeries*)Series)->SeriesMode = ssmAuto;
	 if (SignalBrowse1->IsOverview())
	 {
		 ((TSignalHighLowSeries*)Series)->SeriesDataType = ssdHighLow;
		 DrawHighLowValues(Src, Series, DtOffset, Dt,True);
	 } else {
		 ((TSignalHighLowSeries*)Series)->SeriesDataType = ssdLine;
	 	 DrawValues(Src,Series,DtOffset, Dt,True);
	}
}

void __fastcall TBrowseDemoForm::DrawHighLowValues(TVec *Src, TChartSeries *Series,
			TSample DtOffset,	TSample Dt, bool DownSample)
{
	Mtxexpr::sVector a, b, c;

	int k = 1;
	if (dynamic_cast<THighLowSeries*>(Series) == NULL)
		ERaise("Series is not THighLowSeries");
	if (DownSample)
		a.PixelDownSample(Series->ParentChart->Width*k,Src);
	else
		a.Copy(Src);
	TSample adt = Dt*Src->Length / (a.Length / 2);
	b.DownSample(a,2,0);
	c.DownSample(a,2,1);
	DrawValues(OPENARRAY(TVec*,(b,c)),Series,DtOffset,adt);
}

void __fastcall TBrowseDemoForm::FormCreate(TObject *Sender)
{
	ChannelBox->ItemIndex = 0;
	SignalBrowse1->ProgressThread->UpdateInterval = 50; //20x times per second updates progress bar
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Open a few 10MB long uncompressed wav file. The chart will display signal overview." 
		"For 200 MB long wav file, it takes a little less then 6 seconds to create the overview. "
		"(.pk file). This demo will place a .pk file with same name as the opened wav file in the "
		"same directory where the opened .wav file resides. If the wav file date/time stamp "
		"has changed, since the time when the .pk file was first created, "
		"the old .pk file will be deleted and new one created.");
}
//---------------------------------------------------------------------------

void __fastcall TBrowseDemoForm::ChannelBoxChange(TObject *Sender)
{
	BrowseChartUpdate(0);	
}
//---------------------------------------------------------------------------

void __fastcall TBrowseDemoForm::SignalBrowse1ProgressUpdate(TObject *Sender,
      TMtxProgressEvent Event)
{
	switch (Event)
	{
		case peCycle:
		{
			PositionPanel->SliderSpan = SignalBrowse1->SignalFile->RecordPosition*100/SignalBrowse1->SignalFile->RecordLength;
			PositionPanel->Caption = FormatFloat("0",PositionPanel->SliderSpan) + "[%]";
			PositionPanel->Update();
			break;
		}
		case peCleanUp:
		{
			PositionPanel->SliderSpan = 100;
			PositionPanel->Caption = FormatFloat("0",PositionPanel->SliderSpan) + "[%]";
			SignalBrowse1->LoadFullRecord();
			BrowseChartUpdate(0);
			break;
		 }
		}
}
//---------------------------------------------------------------------------


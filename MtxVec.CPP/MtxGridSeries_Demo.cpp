//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "MtxGridSeries_Demo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TfrmMtxGridSeries *frmMtxGridSeries;
//---------------------------------------------------------------------------
__fastcall TfrmMtxGridSeries::TfrmMtxGridSeries(TComponent* Owner)
  : TBasicForm2(Owner)
{
	AnsiString str;

	RichEdit1->Lines->Clear();
    str = "TMtxGridSeries which can be used ";
    str+= "with all TeeChart versions (v4 Standard, v4 Pro, 5,6 and 7). ";
    str+= "Using TMtxGridSeries you can visualize matrix values. ";
    str+= "Key properties/methods are:";
    RichEdit1->Lines->Add(str);
    RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->FirstIndent = 10;
    RichEdit1->Paragraph->Numbering = nsBullet;
    RichEdit1->Lines->Add("property PaletteSteps : Defines the number of palette steps for legend");
    RichEdit1->Lines->Add("property BottomColor, TopColor : Defines color for lowest and highest value.");
    str = "property PaletteStyle : Default value is palRange meaning palette ";
    str+= "colors will be calculated from BottomColor, TopColor and PaletteSteps ";
    str+= "properties.  If you want to define custom palette levels, set ";
    str+= "PaletteStyle to palCustom and then define level and it""s color by using ";
    str+= "AddPalette method.";
    RichEdit1->Lines->Add(str);
    RichEdit1->Lines->Add("method AddPalette : adds new palette level (works only if PaletteStyle is palCustom).");
	str = "method CreateRangePalette : Recreates range palette values. Call this method if matrix ";
    str+= "maximum/minimum value changes.";
    RichEdit1->Lines->Add(str);
    RichEdit1->Lines->Add("method ClearPalette : clears palette.");
    RichEdit1->Paragraph->FirstIndent = 0;
    RichEdit1->Paragraph->Numbering = nsNone;
    RichEdit1->Lines->Add("");
    RichEdit1->Lines->Add("Some properties are accessible via the MtxGridSeries editor (click on ""Edit Grid Series"" button).");

  #ifdef TEESTD
  Button1->Visible = false;
  Chart1.Legend.Visible = false;
  #else
  Chart1->Legend->Visible = true;
  Button1->Visible = true;
  #endif

  // setup grid series
  Chart1->LeftAxis->Title->Caption = "Index";
  Chart1->LeftAxis->Increment = 1.0;
  Chart1->LeftAxis->RoundFirstLabel = false;
  Chart1->LeftAxis->LabelsOnAxis = true;
  Chart1->BottomAxis->Title->Caption = "Index";
  Chart1->BottomAxis->Increment = 1.0;
  Chart1->BottomAxis->RoundFirstLabel = false;
  Chart1->BottomAxis->LabelsOnAxis = true;

  GridSeries = new TMtxGridSeries(Chart1);

  GridSeries->ValueFormat = "0.00";
  GridSeries->ColorPalette->BottomColor = clWhite;
  GridSeries->ColorPalette->TopColor = clBlack;// RGB(74,127,186);//clBlack;
  GridSeries->ColorPalette->PaletteSteps = 10;
  GridSeries->HorizAxis = aTopAxis;
  GridSeries->ParentChart = Chart1;

  // now setup sparse matrix
  SparseA = new TSparseMtx();
  A = new Mtxvec::TMatrix();
  v1 = new Mtxvec::TVector();
  v2 = new Mtxvec::TVector();
  /* zero count is only estimated zero count if the value is to small.
	This will result in many memory reallocations by RandomSparse. */
  SparseA->Size(2000,2000,100000,false);
  SparseA->RandomSparse(v1,v2,false,1,100000);
  SparseA->PixelDownSample(A,500,TPixelDownSample(RadioGroup1->ItemIndex));
  DrawValues(A,GridSeries); // showing A
}
//---------------------------------------------------------------------------

void __fastcall TfrmMtxGridSeries::FormDestroy(TObject *Sender)
{
  delete A;
  delete v1;
  delete v2;
  delete SparseA;
}
//---------------------------------------------------------------------------
void __fastcall TfrmMtxGridSeries::Timer1Timer(TObject *Sender)
{
  SparseA->RandomSparse(v1,v2,false,1,100000);
  SparseA->PixelDownSample(A,500,TPixelDownSample(RadioGroup1->ItemIndex));
  DrawValues(A,GridSeries); //   GridSeries->Repaint();
}
//---------------------------------------------------------------------------
void __fastcall TfrmMtxGridSeries::RadioGroup1Click(TObject *Sender)
{
  SparseA->PixelDownSample(A,500,TPixelDownSample(RadioGroup1->ItemIndex));
  DrawValues(A,GridSeries); // showing A  GridSeries->Repaint();
}
//---------------------------------------------------------------------------
void __fastcall TfrmMtxGridSeries::CheckBox2Click(TObject *Sender)
{
  Timer1->Enabled = CheckBox2->Checked;
  RadioGroup1->Enabled = !Timer1->Enabled;
  CheckBox1->Checked = !CheckBox2->Checked;
}
//---------------------------------------------------------------------------
void __fastcall TfrmMtxGridSeries::Chart1GetAxisLabel(TChartAxis *Sender,  TChartSeries *Series, int ValueIndex, String &LabelText)
{     //   invert axis labels
  if ((Sender == Chart1->LeftAxis) && (GridSeries->Matrix != 0))
  {
	  double a = StrToFloat(LabelText);
	  int tmp = int(a);
	  tmp = GridSeries->Matrix->Rows - 1 - tmp;
	  LabelText = IntToStr(tmp);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmMtxGridSeries::Chart1MouseMove(TObject *Sender,  TShiftState Shift, int X, int Y)
{
  if (CheckBox1->Checked)
  {
	int index = GridSeries->Clicked(X,Y);
	if (index != -1)
	{
	  if (CheckRange(0, index, GridSeries->Matrix->Length-1)) {
		  Label1->Caption = FormatFloat("0.00",GridSeries->Matrix->Values1D[index]);
	  }
	} else Label1->Caption = "";
  }
}
//---------------------------------------------------------------------------

void __fastcall TfrmMtxGridSeries::Button1Click(TObject *Sender)
{
  #ifdef TEESTD
  EditSeries(Self,GridSeries);
  #endif
}
//---------------------------------------------------------------------------


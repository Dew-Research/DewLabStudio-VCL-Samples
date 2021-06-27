//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "QuickS.h"
#include "MtxExpr.hpp"
#include "clMtxExpr.hpp"
#include "MtxExprInt.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic3"
#pragma resource "*.dfm"
TQStart *QStart;

//---------------------------------------------------------------------------
__fastcall TQStart::TQStart(TComponent* Owner)
  : TBasicForm3(Owner)
{
	//Tests for Debugger Visualizers. All types need to show tooltip with values
	// and react on CTRL+F6
/*
	clPlatform()->LoadProgramsForDevices(true, true, true, true, false);
	clPlatform()->Platforms[1]->Device[0]->CommandQueue->Item[0]->MarkThread();
	clPlatform()->Platforms[1]->Device[0]->Cache->SetCacheSize(10,100,5,5);

//  14: TypeName := 'Mtxvec::TVec *';
//   15: TypeName := 'Mtxvec::TMtx *';

	TVec *tvec = new TVec();
	TVec *bvec = new TVec();

	tvec->Size(10);
	tvec->SetVal(1);
	bvec->Sin(tvec);

	delete tvec;
	delete bvec;

	TMtx *tmtx = new TMtx();
	TMtx *bmtx = new TMtx();

	tmtx->Size(10,10);
	tmtx->SetVal(1);
	bmtx->Sin(tmtx);

	delete tmtx;
	delete bmtx;

//   16: TypeName := 'Mtxvec::TVector *';  //MtxVecCPP
//   17: TypeName := 'Mtxvec::TMatrix *';  //MtxVecCPP


	Mtxvec::TVector *tvec1 = new Mtxvec::TVector();
	Mtxvec::TVector *bvec1 = new Mtxvec::TVector();

	tvec1->Size(10);
	tvec1->SetVal(1);
	bvec1->Sin(tvec1);

	delete tvec1;
	delete bvec1;

	Mtxvec::TMatrix *tmtx1 = new Mtxvec::TMatrix();
	Mtxvec::TMatrix *bmtx1 = new Mtxvec::TMatrix();

	tmtx1->Size(10,10);
	tmtx1->SetVal(1);
	bmtx1->Sin(tmtx1);

	delete tmtx1;
	delete bmtx1;

//   21: TypeName := 'Mtxexpr::Vector';
//   22: TypeName := 'Mtxexpr::Matrix';

	sVector tvec3, bvec3;

	tvec3.Size(10);
	tvec3.SetVal(1);
	bvec3.Sin(tvec3);

	sMatrix tmtx3;
	sMatrix bmtx3;

	tmtx3.Size(10,10);
	tmtx3.SetVal(1);
	bmtx3.Sin(tmtx3);


//   20: TypeName := 'Signaltools::TSignal';
//   23: TypeName := 'Mtxvecint::TVecInt *';
//   24: TypeName := 'Mtxexprint::VectorInt';

	VectorInt tvec4;
	TVecInt *bvec4 = new TVecInt();

	tvec4.Size(10);
	tvec4.SetVal(1);
	tvec4 = 2*tvec4 + 3;

	bvec4->Abs(tvec4);

//   27: TypeName := 'Clmtxvec::TOpenCLVector *';
//   28: TypeName := 'Clmtxvec::TOpenCLMatrix *';


	TOpenCLVector *tvec5;
	TOpenCLVector *bvec5;

	CreateIt(tvec5);
	CreateIt(bvec5);

	tvec5->Size(10, TclFloatPrecision::clFloat, false);
	tvec5->SetVal(1);
	bvec5->Sin(tvec5);

	FreeIt(tvec5);
	FreeIt(bvec5);

	TOpenCLMatrix *tmtx5;
	TOpenCLMatrix *bmtx5;

	CreateIt(tmtx5);
	CreateIt(bmtx5);

	tmtx5->Size(10,10, TclFloatPrecision::clFloat, false);
	tmtx5->SetVal(1);
	bmtx5->Sin(tmtx5);

	FreeIt(tmtx5);
	FreeIt(bmtx5);

//   25: TypeName := 'Clmtxexpr::clVector';
//   26: TypeName := 'Clmtxexpr::clMatrix';

//	clVector tvec6;
//	clVector bvec6;
//
//	tvec6.Size(10, TclFloatPrecision::clFloat, false);
//	tvec6.SetVal(1);
//	bvec6.Sin(tvec6);
//
//	clMatrix tmtx6;
//	clMatrix bmtx6;
//
//	tmtx6.Size(10,10, TclFloatPrecision::clFloat, false);
//	tmtx6.SetVal(1);
//	bmtx6.Sin(tmtx6);


//   25: TypeName := 'Clmtxexpr::oclVector';
//   26: TypeName := 'Clmtxexpr::oclMatrix';

	oclVector tvec7;
	oclVector bvec7;

	tvec7.Size(10, TclFloatPrecision::clFloat, false);
	tvec7.SetVal(1);
	bvec7.Sin(tvec7);

	oclMatrix tmtx7;
	oclMatrix bmtx7;

	tmtx7.Size(10,10, TclFloatPrecision::clFloat, false);
	tmtx7.SetVal(1);
	bmtx7.Sin(tmtx7);

//   29: TypeName := 'Math387::TCplx';
//   30: TypeName := 'Mtxexpr::sVector';
//   31: TypeName := 'Mtxexpr::cVector';
//   32: TypeName := 'Mtxexpr::sMatrix';
//   33: TypeName := 'Mtxexpr::cMatrix';

	TCplx ac, bc;
	sVector av,bv;
	sMatrix am,bm;
	cVector avc, bvc;
	cMatrix cam, cbm;

	avc.Size(10);
	avc.SetVal(2);
	bvc.Cos(avc);

	cam.Size(10, 10, true);
	cam.SetVal(2);
	cbm.Cos(cam);

	Math387::TDoubleArray arr;
	int i;
	//
	ac = StrToCplx("1+2i");  //Convert from string to complex number
	bc = 2*bc + ac;

	am = RandGauss(5,5,true); //5x5 complex matrix with Gaussian noise
	av = Mtxexpr::Ramp(25);    //real vector = [0, 1, 2,...., 23, 24]

	bv = av();

	bm = am*av;
	bv = Mtxexpr::Exp(bv)*av + Cos(ac) + 2.0;  // (*,/) treat Matrices as vectors
	bm = Mtxexpr::Exp(am)*av + Cos(ac) + 2.0;  // (*,/) treat Matrices as vectors
			   // Same as: ./  and .* operators (not linear algebra)

	//To make linear algebra multiplication and division use functions

	bm = Divide(am,bm) + 2.0;  //matrix division
	bm = Mul(am,bm) + 2.0;  //matrix multiply

	//of course you can mix matrices and vectors

	av.Resize(5);
	av = Mul(av,bm) + 2.0;  //vector from left and matrix multiply
	av.CopyToArray(arr);  //copy data to array of double
	av.CopyFromArray(arr);  //copy data from array to vector

	am.Complex = false;
	for (i = 0; i < am.Rows; i++)  //standard loop example
	{
	  //in case of complex values
  //	  av.CValues(i) = am.CValues(i,0)*av.CValues(i); //same as previous line

  //in case of real values
	  av[i] = am[i,0]*av[i];
	  av.Values(i) = am.Values(i,0)*av.Values(i); //same as previous lines
	}
*/
  AnsiString str;

  RichEdit1->Lines->Clear();
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Quick start: Computing a frequency spectrum.");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Start a new project.");
  RichEdit1->Lines->Add("Make sure MtxVec TeeChart package was compiled and installed (see TeeChart support document to learn more about this).");
  RichEdit1->Lines->Add("Place one TChart component ('Additional' panel) on the panel and one Button ('Standard' panel)");
  RichEdit1->Lines->Add("Double click on the TChart component and click the Add button and the select the Fast Line seires. Press Close;");
  RichEdit1->Lines->Add("Move cursor to the top of the unit and add the following.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->SelAttributes->Name = "Courier New";
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("  #include <MtxExpr.hpp>");
  RichEdit1->Lines->Add("  #include <MtxVecTee.hpp>");
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Name = "Arial";
  RichEdit1->Lines->Add("Double click the Button.");
  RichEdit1->Lines->Add("Insert the following code:");
  RichEdit1->SelAttributes->Name = "Courier New";
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("void __fastcall TForm1::Button1Click(TObject *Sender)");
  RichEdit1->Lines->Add("{");
  RichEdit1->Lines->Add("sVector x, y, spec;");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("   /*Please include the full path of the file.");
  RichEdit1->Lines->Add("   The file is included with the MtxVec BasicDemo");
  RichEdit1->Lines->Add("   distribution and has 8000 values only. */");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("   y.LoadFromFile('C:\\MtxVecDemo\\FFTData.vec');");
  RichEdit1->Lines->Add("   y.Resize(1024);");
  RichEdit1->Lines->Add("   x.FFT(y);");
  RichEdit1->Lines->Add("   spec.Mag(x);");
  RichEdit1->Lines->Add("   DrawValues(spec,Series1);");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("}");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("F9 to compile and press Button1.");
  RichEdit1->Lines->Add("should be looking at the frequency spectra displaying one series of harmonics.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Things to try:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Change the 1024 value to some other values that are power of two. (512 or 2048).");
  RichEdit1->Lines->Add("Use TAreaSeries chart series.");
  RichEdit1->Lines->Add("Make the spectra logarithmic in the amplitude (use the Log10 method).");
  RichEdit1->Lines->Add("Save spectra to a file, then load it and draw to the chart with DrawValues.");
  RichEdit1->Lines->Add("Replace DrawValues(spec,Series1) with ViewValues(spec) - in this case add #include ""MtxVecEdit.hpp"" -  and then try ViewValues(x). Play with the menu options in the displayed form.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

}
//---------------------------------------------------------------------------

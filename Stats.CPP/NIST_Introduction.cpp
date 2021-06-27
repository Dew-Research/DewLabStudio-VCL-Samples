//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "NIST_Introduction.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmNISTIntro *frmNISTIntro;
//---------------------------------------------------------------------------
__fastcall TfrmNISTIntro::TfrmNISTIntro(TComponent* Owner)
	: TForm(Owner)
{
	Memo1->Lines->Clear();
	Memo1->Lines->Add("Taken from NIST introduction (http://www.itl.nist.gov/div898/strd/index.html)");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("\"In response to industrial concerns about the numerical accuracy" 
			" of computations from statistical software, the Statistical Engineering"
			" and Mathematical and Computational Sciences Divisions of NISTs Information"
			" Technology Laboratory are providing datasets with certified values for a"
			" variety of statistical methods.");
	Memo1->Lines->Add("Currently datasets and certified values are provided for assessing the accuracy" 
			" of software for univariate statistics, linear regression, nonlinear regression," 
			" and analysis of variance. The collection includes both generated and \"real-world\"" 
			" data of varying levels of difficulty. Generated datasets are designed to challenge "
			" specific computations. Certified values are \"best-available\" solutions.");
	Memo1->Lines->Add("Datasets are ordered by level of difficulty (lower, average, and higher)."
			" Strictly speaking the level of difficulty of a dataset depends on the algorithm. These" 
			" levels are merely provided as rough guidance for the user. Producing correct results on"
			" all datasets of higher difficulty does not imply that your software will pass all datasets"
			" of average or even lower difficulty. Similarly, producing correct results for all datasets"
			" in this collection does not imply that your software will do the same for your particular"
			" dataset. It will, however, provide some degree of assurance, in the sense that your package"
			" provides correct results for datasets known to yield incorrect results for some software.\"");


}
//---------------------------------------------------------------------------

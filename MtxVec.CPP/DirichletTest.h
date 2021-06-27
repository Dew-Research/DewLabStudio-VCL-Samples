//---------------------------------------------------------------------------

#ifndef DirichletTestH
#define DirichletTestH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VclTee.TeeGDIPlus.hpp>
#include "MtxExpr.hpp"
#include "MtxVecTee.hpp"
#include "Math387.hpp"
//---------------------------------------------------------------------------
class TfrmDirichlet : public TBasicForm2
{
  __published:	// IDE-managed Components
	TChart *Chart1;
	TLabel *Label1;
	TLabel *Label2;
	TRadioGroup *RadioGroup1;
	TRadioGroup *RadioGroup2;
	TEdit *Edit1;
	TEdit *Edit2;
	TEdit *Edit3;
	TEdit *Edit4;
	TButton *Button2;
	void __fastcall Button1Click(TObject *Sender);
	void __fastcall RadioGroup1Click(TObject *Sender);
	void __fastcall RadioGroup2Click(TObject *Sender);
	void __fastcall Chart1AfterDraw(TObject *Sender);
 private:	// User declarations
	int Dim;
	sMatrix Data;
	TMtxGridSeries *GridSer;
	TCplx CVal;
	double xmin,xmax,ymin,ymax,xstep,ystep;
	void __fastcall Generate();
public:		// User declarations
  __fastcall TfrmDirichlet(TComponent* Owner);

};
//---------------------------------------------------------------------------
extern PACKAGE TfrmDirichlet *frmDirichlet;
//---------------------------------------------------------------------------
#endif

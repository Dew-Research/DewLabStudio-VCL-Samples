//---------------------------------------------------------------------------
#ifndef ProbEditorH
#define ProbEditorH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include <ActnList.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>

#include "DewProbWrapper.h"
#include <Math387.hpp>
#include <Probabilities.hpp>
//---------------------------------------------------------------------------
class TFrameDist : public TFrame
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TListView *ListViewParams;
  TLabel *LabelDec;
  TRadioGroup *RadioGroupOut;
  TGroupBox *GroupBoxRange;
  TLabel *Label1;
  TLabel *Label2;
  TLabel *Label3;
  TEdit *EditNumPoints;
  TEdit *EditLB;
  TEdit *EditUB;
  TUpDown *UpDown1;
  TPanel *Panel2;
  TListBox *ListBoxDist;
  TPanel *Panel3;
  TButton *Button1;
  TButton *Button2;
  TEdit *Edit1;
  void __fastcall ListViewParamsDblClick(TObject *Sender);
  void __fastcall ListBoxDistClick(TObject *Sender);
  void __fastcall RadioGroupOutClick(TObject *Sender);
  void __fastcall EditNumPointsChange(TObject *Sender);
  void __fastcall EditLBChange(TObject *Sender);
  void __fastcall EditUBChange(TObject *Sender);
  void __fastcall Button2Click(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall Edit1Change(TObject *Sender);
private:
  TProbDistribution *FDistribution;
  AnsiString FFormatString;
  void __fastcall SetDistType(TDistribution DistType, const AnsiString &Caption);
  void __fastcall RefreshParListView();
  void __fastcall SetDistribution(TProbDistribution *Value);
  void __fastcall SetFormatString(const AnsiString &Value);
public:
  __fastcall TFrameDist(TComponent* Owner);
  __property TProbDistribution* Distribution = { read = FDistribution, write = SetDistribution };
  __property AnsiString FormatString = { read = FFormatString, write = SetFormatString };
};
//---------------------------------------------------------------------------
#endif

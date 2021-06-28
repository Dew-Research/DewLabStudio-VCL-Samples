//---------------------------------------------------------------------------

#ifndef clFunctionH
#define clFunctionH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <MtxVec.hpp>
#include <Math387.hpp>
#include <MtxExpr.hpp>
#include <clMtxVec.hpp>
//---------------------------------------------------------------------------
class TclFunctionForm : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TPanel *Panel2;
  TPanel *Panel3;
  TRichEdit *RichEdit1;
	TMemo *Memo;
	TComboBox *FloatPrecisionBox;
	TCheckBox *ComplexBox;
	TComboBox *VectorLengthBox;
	TListBox *FunctionBox;
	TListBox *DeviceListBox;
	TListBox *PlatformListBox;
	TButton *Button1;
	TLabel *Label5;
	TLabel *Label6;
	TLabel *CPUFloatPrecisionLabel;
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label4;
	TLabel *Label3;
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall Button1Click(TObject *Sender);
	void __fastcall PlatformListBoxClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
  int TimeCheck, TimeElapsed;
  int VectorLen;
  TOpenCLDevice* selectedDevice;
  void __fastcall DoCompute();
  __fastcall TclFunctionForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TclFunctionForm *clFunctionForm;
//---------------------------------------------------------------------------
#endif

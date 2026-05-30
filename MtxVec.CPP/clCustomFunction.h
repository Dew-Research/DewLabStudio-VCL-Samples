//---------------------------------------------------------------------------
#ifndef clCustomFunctionH
#define clCustomFunctionH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>

#include <Math387.hpp>
#include <MtxForLoop.hpp>
#include <OpenCL_Dynamic.hpp>
#include <clMtxVec.hpp>
#include <AbstractMtxVec.hpp>
//---------------------------------------------------------------------------
class TclCustomFunctionForm : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TLabel *Label1;
  TLabel *Label2;
  TLabel *Label5;
  TButton *Button1;
  TListBox *PlatformListBox;
  TListBox *DeviceListBox;
  TComboBox *VectorLengthBox;
  TRichEdit *RichEdit1;
  TButton *AutoDeviceButton;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall PlatformListBoxClick(TObject *Sender);
  void __fastcall AutoDeviceButtonClick(TObject *Sender);
private:
  TOpenCLDevice *SelectedDevice;
  void __fastcall DoCompute();
  void __fastcall CreateCustom();
public:
  void __fastcall LoadTest(TObject *Sender);
  __fastcall TclCustomFunctionForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TclCustomFunctionForm *clCustomFunctionForm;
extern PACKAGE int VectorLen;
//---------------------------------------------------------------------------
#endif

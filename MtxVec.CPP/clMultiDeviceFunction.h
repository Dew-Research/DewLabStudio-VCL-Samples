//---------------------------------------------------------------------------
#ifndef clMultiDeviceFunctionH
#define clMultiDeviceFunctionH
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
class TclMultiDeviceFunctionForm : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TLabel *Label1;
  TLabel *Label2;
  TLabel *Label4;
  TLabel *Label5;
  TButton *Button1;
  TListBox *PlatformListBox;
  TListBox *DeviceListBox;
  TListBox *FunctionBox;
  TComboBox *VectorLengthBox;
  TRichEdit *RichEdit1;
  TCheckBox *ComplexBox;
  TLabel *Label6;
  TComboBox *FloatPrecisionBox;
  TLabel *CPUFloatPrecisionLabel;
  TTimer *SchedulerTimer;
  TLabel *Label7;
  TComboBox *MaximumJobCountEdit;
  TLabel *CurrentJobCountLabel;
  TLabel *TotalRunningTimeLabel;
  TLabel *ErrorsLabel;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall PlatformListBoxClick(TObject *Sender);
  void __fastcall SchedulerTimerTimer(TObject *Sender);
  void __fastcall FormShow(TObject *Sender);
private:
  bool Finished;
  TDateTime StartTime;
  int GlobalJobIndex;
  void __fastcall DoOnExecute(TOpenCLCommandQueue * const cmdQueue, int JobIndex);
public:
  __fastcall TclMultiDeviceFunctionForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TclMultiDeviceFunctionForm *clMultiDeviceFunctionForm;
//---------------------------------------------------------------------------
#endif

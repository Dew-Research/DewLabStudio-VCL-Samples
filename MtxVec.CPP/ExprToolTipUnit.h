//---------------------------------------------------------------------------
#ifndef ExprToolTipUnitH
#define ExprToolTipUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include <Grids.hpp>
#include <Messages.hpp>

#include <MtxVec.hpp>
#include <MtxVecInt.hpp>
#include <MtxGrid.hpp>
#include <MtxVecBase.hpp>
//---------------------------------------------------------------------------
class TExprToolTipForm : public TForm
{
__published:	// IDE-managed Components
  TMtxVecGrid *MtxVecGrid;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
private:
  AnsiString bName;
  TDateTime mark;
  TMtx *FData;
  void __fastcall SetData(TMtx * const Value);
protected:
  void __fastcall WMNCHitTest(TWMNCHitTest &Message);

  BEGIN_MESSAGE_MAP
    VCL_MESSAGE_HANDLER(WM_NCHITTEST, TWMNCHitTest, WMNCHitTest)
  END_MESSAGE_MAP(TForm)
public:
  __property TMtx *Data = {read=FData, write=SetData};
  void __fastcall UpdateGrid(TMtxVecBase * const Src, const AnsiString &aName);
  __fastcall TExprToolTipForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TExprToolTipForm *ExprToolTipForm;
//---------------------------------------------------------------------------
#endif

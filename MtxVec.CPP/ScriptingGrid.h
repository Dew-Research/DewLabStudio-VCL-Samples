//---------------------------------------------------------------------------
#ifndef ScriptingGridH
#define ScriptingGridH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include <Grids.hpp>
#include <Buttons.hpp>
#include <Types.hpp>

#include <Math387.hpp>
#include <MtxParseExpr.hpp>
#include <MtxParseClass.hpp>
#include <MtxParseProbabilities.hpp>
#include <MtxGrid.hpp>
#include <MtxVecTee.hpp>

#include <VclTee.TeeGDIPlus.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>

#include "ExprToolTipUnit.h"
//---------------------------------------------------------------------------
class TScriptingGridForm : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TRichEdit *RichEdit;
  TEdit *ExprEdit;
  TSplitter *Splitter1;
  TPanel *Panel2;
  TListBox *ListBox;
  TSplitter *Splitter2;
  TLabel *Label1;
  TListView *VarView;
  TSplitter *Splitter3;
  TStatusBar *StatusBar;
  TSplitter *Splitter4;
  TRichEdit *ScriptEdit;
  TLabel *ScriptLabel;
  TComboBox *ScriptBox;
  TPanel *Panel4;
  TPanel *Panel5;
  TPageControl *PageControl;
  TTabSheet *Sheet1;
  TTabSheet *Sheet2;
  TButton *RunButton;
  TTabSheet *Chart;
  TStringGrid *Grid1;
  TStringGrid *Grid2;
  TChart *Chart1;
  TChart *Chart2;
  TSplitter *Splitter5;
  TButton *ResetButton;
  TPanel *Panel3;
  TLabel *LineLabel;
  TButton *StepButton;
  TButton *SaveAsButton;
  TButton *DeleteScriptButton;
  TButton *GridInsertScriptButton;
  TButton *GridAssignScriptButton;
  TBevel *Bevel1;
  TPanel *Panel6;
  TButton *GridInsertEditButton;
  TButton *GridAssignEditButton;
  TPanel *Panel7;
  TSpeedButton *EditModeButton;
  TPanel *Panel8;
  TLabel *Label3;
  TComboBox *WorkspaceBox;
  TButton *SaveWorkButton;
  TButton *DeleteWorkButton;
  TSplitter *Splitter6;
  TButton *ResetWorkspaceButton;
  TBevel *Bevel2;
  TLabel *Label2;
  TFastLineSeries *Series1;
  TFastLineSeries *Series2;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall ListBoxDblClick(TObject *Sender);
  void __fastcall VarViewDblClick(TObject *Sender);
  void __fastcall VarViewMouseEnter(TObject *Sender);
  void __fastcall ListBoxMouseEnter(TObject *Sender);
  void __fastcall RichEditMouseEnter(TObject *Sender);
  void __fastcall ExprEditMouseEnter(TObject *Sender);
  void __fastcall ScriptBoxChange(TObject *Sender);
  void __fastcall RunButtonClick(TObject *Sender);
  void __fastcall Grid1DrawCell(TObject *Sender, int ACol, int ARow, TRect &Rect, TGridDrawState State);
  void __fastcall ScriptEditKeyUp(TObject *Sender, WORD &Key, TShiftState Shift);
  void __fastcall StepButtonClick(TObject *Sender);
  void __fastcall ResetButtonClick(TObject *Sender);
  void __fastcall ScriptEditMouseMove(TObject *Sender, TShiftState Shift, int X, int Y);
  void __fastcall AssignButtonClick(TObject *Sender);
  void __fastcall EditModeButtonClick(TObject *Sender);
  void __fastcall ExprEditKeyUp(TObject *Sender, WORD &Key, TShiftState Shift);
  void __fastcall Grid1KeyUp(TObject *Sender, WORD &Key, TShiftState Shift);
  void __fastcall SaveAsButtonClick(TObject *Sender);
  void __fastcall DeleteScriptButtonClick(TObject *Sender);
  void __fastcall GridInsertScriptButtonClick(TObject *Sender);
  void __fastcall GridAssignScriptButtonClick(TObject *Sender);
  void __fastcall GridInsertEditButtonClick(TObject *Sender);
  void __fastcall GridAssignEditButtonClick(TObject *Sender);
  void __fastcall ListBoxClick(TObject *Sender);
  void __fastcall SaveWorkButtonClick(TObject *Sender);
  void __fastcall DeleteWorkButtonClick(TObject *Sender);
  void __fastcall WorkspaceBoxChange(TObject *Sender);
  void __fastcall ResetWorkspaceButtonClick(TObject *Sender);
private:
  void __fastcall EvaluateExpression();
  void __fastcall UpdateVarView();
  void __fastcall SetupGrids();
  void __fastcall SetupGrid(TStringGrid * const aGrid);

  void __fastcall DoSetGrid1(TExprGridVariable * const Sender, const UnicodeString Src, const int row, const int col);
  void __fastcall DoSetGrid2(TExprGridVariable * const Sender, const UnicodeString Src, const int row, const int col);
  void __fastcall DoGetGrid1(TExprGridVariable * const Sender, UnicodeString &Dst, const int row, const int col);
  void __fastcall DoGetGrid2(TExprGridVariable * const Sender, UnicodeString &Dst, const int row, const int col);
  AnsiString __fastcall WordUnderMouseInRichEdit(const TPoint &pt);
  void __fastcall PopulateScriptList();
  AnsiString __fastcall GridSelection();
  AnsiString __fastcall GridSelectionValues();
  void __fastcall SaveWorkspace(TExprWorkspace * const dst, const AnsiString &dstName);
  void __fastcall DefineCustomValues();
  int __fastcall ScriptEditActiveLine();
public:
  int WorkspaceIndex;
  bool Editing;
  TMtxExpression *Expr;
  TExprGridVariable *grid1var;
  TExprGridVariable *grid2var;
  TExprToolTipForm *mtxToolTip;
  __fastcall TScriptingGridForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
void __fastcall _drawvalues5(TExprRec * const Param);
void __fastcall _drawvalues4(TExprRec * const Param);
//---------------------------------------------------------------------------
extern PACKAGE TScriptingGridForm *ScriptingGridForm;
//---------------------------------------------------------------------------
#endif

//---------------------------------------------------------------------------

#ifndef BenchmarkXH
#define BenchmarkXH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include <CheckLst.hpp>
#include <Dialogs.hpp>
#include <Menus.hpp>

#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>

#include "PersistentStreamer.h"
#include "BenchmarkFramework.h"
#include "BenchmarkResults.h"
#include <VclTee.TeeGDIPlus.hpp>
//---------------------------------------------------------------------------
class TBenchmarkXForm : public TBasicForm2
{
__published:	// IDE-managed Components
        TLabel *Label3;
        TLabel *Label4;
        TButton *btnRun;
        TButton *btnOpen;
        TComboBox *cbVectorLength;
        TComboBox *cbIterationCount;
        TCheckListBox *clbFuncs;
        TLabel *Label1;
        TChart *chartResults;
        THorizBarSeries *Series4;
        THorizBarSeries *Series3;
        THorizBarSeries *Series2;
        THorizBarSeries *Series1;
        TPopupMenu *PopupMenu;
        TMenuItem *miSelectAllFuncs;
        TMenuItem *miUnselectAllFuncs;
        TOpenDialog *OpenDialog1;
        TSaveDialog *SaveDialog1;
        TPopupMenu *ChartMenu;
        TMenuItem *LoadFromFileItem;
        TMenuItem *SaveToFileItem;
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall clbFuncsClick(TObject *Sender);
        void __fastcall btnRunClick(TObject *Sender);
        void __fastcall btnOpenClick(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall LoadFromFileItemClick(TObject *Sender);
        void __fastcall SaveToFileItemClick(TObject *Sender);
        void __fastcall miSelectAllFuncsClick(TObject *Sender);
        void __fastcall miUnselectAllFuncsClick(TObject *Sender);
        void __fastcall cbIterationCountDblClick(TObject *Sender);
    private:	// User declarations
        BenchmarkFramework *fBenchmarkFramework;
        TBenchmarkResults *fBenchmarkResults;
        bool fFirstActivation;
        void __fastcall UpdateChart();
        void __fastcall RecalcIterationCount();
        void __fastcall LoadFile(const AnsiString file_name);
        int __fastcall  ReadIntValue(TComboBox *cb, int min,int max);
        void __fastcall UpdateComboBoxHistory (TComboBox *cb);
        void __fastcall SelectAllFuncs(bool select);
        void __fastcall LoadFuncListBox();
        void __fastcall ShowResults(TBenchmarkResults *results);    
    public:		// User declarations
      __fastcall TBenchmarkXForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TBenchmarkXForm *BenchmarkXForm;
//---------------------------------------------------------------------------
#endif

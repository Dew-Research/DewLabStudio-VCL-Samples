// Coded by Marjan Slatinek (marjan@dewresearch.com)
// adapted code from Teechart v5 demo, by David Berneda

//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Main.h"
#include <Registry.hpp>
#include <FileCtrl.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "MtxVecDBTools"
#pragma link "MtxBaseComp"
#pragma link "MtxComCtrls"
#pragma link "MtxParseExpr"
#pragma link "MtxVecTools"
#pragma link "MtxVecTee"
#pragma resource "*.dfm"
TfrmMain *frmMain;
//---------------------------------------------------------------------------
__fastcall TfrmMain::TfrmMain(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
AnsiString __fastcall TfrmMain::CodeFile()
{
  if (TreeView1->Selected != NULL && TreeView1->Selected->Data != NULL)
    return static_cast<TExampleInfo*>(TreeView1->Selected->Data)->UnitName;
  else
    return "";
}

int ImageIndex(TTreeNode *Node)
{
  if (Node->HasChildren) {
     if (Node->Expanded) return 2; else return 0;
  } else {
     return 1;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::ShowFormClass(TFormClass AClass)
{
  Application->CreateForm( (TComponentClass) AClass,&tmpForm);

  tmpForm->BorderStyle=bsNone;
  tmpForm->Parent=TabForm;
  tmpForm->Align=alClient;
  tmpForm->Show();
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::ShowForm(void)
{
  if (TreeView1->Selected != NULL)
  {
    if (TreeView1->Selected->Data != NULL)
    {
      delete tmpForm;
      tmpForm = NULL;
      ShowFormClass(static_cast<TExampleInfo*>(TreeView1->Selected->Data)->FormClass);
    }
    StatusBar1->SimpleText = TreeView1->Selected->Text;
    Label1->Caption = TreeView1->Selected->Text;
  }
}
//---------------------------------------------------------------------------


  void LoadTree(TTreeView *ATree, TMemo *AMemo)
  {
  int i;
  AnsiString tmpClass;
  AnsiString tmpUnit;
  TExampleInfo *FormInfo;

    TStringStream *tmp=new TStringStream(AMemo->Lines->Text);
    ATree->LoadFromStream(tmp);
    delete tmp;

      for (int t=0;t<ATree->Items->Count;t++)
      {
        AnsiString tmp = ATree->Items->Item[t]->Text;
        i=tmp.Pos(";");
        if (i>0)
        {
          ATree->Items->Item[t]->Text = tmp.SubString(1,i-1);
          tmpClass=tmp.SubString(i+1, tmp.Length());
          tmpUnit = "";
          i = tmpClass.Pos(";");
          if (i>0)
          {
            tmpUnit = tmpClass.SubString(i+1,tmp.Length());
            tmpClass = tmpClass.SubString(1,i-1);
          }


          FormInfo = new TExampleInfo;
          FormInfo->FormClass = (TFormClass) FindClass(tmpClass);
          FormInfo->UnitName = tmpUnit;
          ATree->Items->Item[t]->Data= FormInfo;
        }
      }
      ATree->Items->Item[0]->Expand(false);
   }

void __fastcall TfrmMain::InitTreeItems()
{
  // 1:1 mirror of TfrmMain.InitTreeItems in Examples\Main.pas (D37 demo).
  // TreeView is populated at runtime: Memo1 lines built here, then parsed
  // by LoadTree into hierarchical TreeView1 items with TExampleInfo data.
  Memo1->Lines->Clear();
  Memo1->Lines->Add("Introduction;TIntroduction");
  Memo1->Lines->Add(" Why MtxVec;TIntroWhyMtxVecForm");
  Memo1->Lines->Add("What is new;TfrmChanges30");
  Memo1->Lines->Add("How to use the demo;TfrmDemoHowTo");
  Memo1->Lines->Add("Matrix operations;TIntroMtx");
  Memo1->Lines->Add(" Multiplying large matrices;TMult1;Multiply1");
  Memo1->Lines->Add(" Multiplying small matrices;TfrmSmallMatrix;SmallMatrixMul");
  Memo1->Lines->Add(" Copy and  transpose operation;TCopyComp;CopyCompare");
  Memo1->Lines->Add(" Calculating the inverse of squared matrix;TInvMtx;InverseMtx");
  Memo1->Lines->Add(" Calculating squared root of matrix;TfrmSqrtMtx;CalcSqrtMtx");
  Memo1->Lines->Add(" Eigenvalues and eigenvectors;TEigVec1;EigenVectors1");
  Memo1->Lines->Add(" LQ and QR decomposition;TLQRDemo;LQR1");
  Memo1->Lines->Add(" Solving system of equations;TLinearSystem1;SysLinear1");
  Memo1->Lines->Add(" Viewing matrix values;TfrmMtxGridSeries;MtxGridSeries_Demo");
  Memo1->Lines->Add("Vector operations;TIntroVec");
  Memo1->Lines->Add(" Levinson Yule Walker;TYuleLev;YuleLevinson");
  Memo1->Lines->Add(" Displaying large amounts of data;TDownS;PixelDownS");
  Memo1->Lines->Add(" Block Processing;TfrmBlockProc;BlockProcessing");
  Memo1->Lines->Add(" Dirichlet and Riemann functions;TfrmDirichlet;DirichletTest");
  Memo1->Lines->Add(" Benchmarks;TBenchmarkXForm;BenchmarkX");
  Memo1->Lines->Add(" New fastline series;TMtxFastLineForm;MtxFastLineDemo");
  Memo1->Lines->Add(" Threaded for-loop;TForLoopForm;ForLoopUnit");
  Memo1->Lines->Add(" Efficient multithreading;TMtxVecThreadingForm;MtxVecThreading");
  Memo1->Lines->Add(" Vectorizing if-then;TIfThenForm;IfThenUnit");
  Memo1->Lines->Add(" Compound expressions;TCompoundExpressionsForm;CompoundExpressions");
  Memo1->Lines->Add("Exporting/Importing;TIntroExpImp");
  Memo1->Lines->Add(" Saving/Loading;TFileH1;FileHandling1");
  Memo1->Lines->Add(" MSOffice;TMSOffice;ClipboardMSOffice");
  Memo1->Lines->Add(" Editing matrix or vector values;TfrmGridDemo;MtxVecGridDemo");
  Memo1->Lines->Add("Memory management;TIntroMemMan");
  Memo1->Lines->Add(" Comparing CreateIt/FreeIt with Create/Destroy;TMemComp1;MemoryCompare1");
  Memo1->Lines->Add(" Super conductive multi-threaded memory alloc;TSuperConductiveForm;SuperConductive");
  Memo1->Lines->Add(" Threading concurrency;TForLoopExampleForm;ForLoopExample");
  Memo1->Lines->Add(" Using default arrays;TDefArray;DefaultArray");
  Memo1->Lines->Add(" Memory channels;TNumaForm;NumaUnit");
  Memo1->Lines->Add("Open CL support;TIntroOpenCLForm");
  Memo1->Lines->Add(" Benchmarks;TclFunctionForm;clFunction");
  Memo1->Lines->Add(" Custom function;TclCustomFunctionForm;clCustomFunction");
  Memo1->Lines->Add(" Multi device benchmark;TclMultiDeviceFunctionForm;clMultiDeviceFunction");
  Memo1->Lines->Add("Numerical integration");
  Memo1->Lines->Add(" Numerical integration: f(x);TfrmInt1D;NumInt1D");
  Memo1->Lines->Add("Polynomial routines;TIntroPoly");
  Memo1->Lines->Add(" Linear and cubic interpolation;TInterpolating1;Interp1");
  Memo1->Lines->Add(" Least-square fitting;TLQRPoly;QRPoly1");
  Memo1->Lines->Add("Optimization problems");
  Memo1->Lines->Add(" Bounded optimization (Simplex);TfrmOptimBounded;Optim_Bounded");
  Memo1->Lines->Add(" Trust Region algorithm;TfrmTRDemo;Optim_TR");
  Memo1->Lines->Add(" Linear Programming;TfrmLP;Optim_LP");
  Memo1->Lines->Add(" Unconstrained global minimization;TfrmMtxOptim;MtxOptim");
  Memo1->Lines->Add("Probabilities unit;TfrmProbCalc;DewProbCalc");
  Memo1->Lines->Add("Sparse matrices;TIntroSparseForm");
  Memo1->Lines->Add(" Sparse solvers;TfrmSparseTest;SparseTest");
  Memo1->Lines->Add("MtxVec Components");
  Memo1->Lines->Add(" Unconstrained global minimization;TfrmMtxOptim;MtxOptim");
  Memo1->Lines->Add(" TMtxFloatEdit control;TfrmFloatEdit1;FloatEdit1");
  Memo1->Lines->Add(" Progress Dialog;TfrmProgDialog;ProgDialog");
  Memo1->Lines->Add(" TMtxVecGrid control;TfrmGridDemo;MtxVecGridDemo");
  Memo1->Lines->Add(" Math Parser;TfrmParser;ParserDemo");
  Memo1->Lines->Add("MtxVec Parser;TIntroParserForm");
  Memo1->Lines->Add(" Scripting;TScriptingForm;Scripting");
  Memo1->Lines->Add(" Scripting with grid;TScriptingGridForm;ScriptingGrid");
  Memo1->Lines->Add(" Parser usage;TfrmParserUsage;ParserUsage");
  Memo1->Lines->Add(" Vectorized performance;TfrmParserPerformance;ParserPerformance");
  Memo1->Lines->Add("MtxVec package function list;TfrmListFunc");
  Memo1->Lines->Add("List of changes");
  Memo1->Lines->Add(" Version 3.x;TfrmChanges30");
  Memo1->Lines->Add(" Older versions");
  Memo1->Lines->Add("  Version 2.1.5;TfrmChanges15");
  Memo1->Lines->Add("  Version 1.02;TfrmChanges102");
  Memo1->Lines->Add("  Version 1.01;TfrmChanges101");
  Memo1->Lines->Add("Registering MtxVec;TRegisterM");
  Memo1->Lines->Add("Quick Start;TQStart");
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::FormCreate(TObject *Sender)
{
  PageControl1->ActivePage=TabForm;
  InitTreeItems();
  LoadTree(TreeView1,Memo1);
  TreeView1->Items->Item[0]->Expand(false);
  TreeView1->HotTrack=true;
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::btnPreviousClick(TObject *Sender)
{
  TreeView1->Items->Item[TreeView1->Selected->AbsoluteIndex-1]->Selected = true;
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::btnNextClick(TObject *Sender)
{
  TreeView1->Items->Item[TreeView1->Selected->AbsoluteIndex+1]->Selected = true;
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::btnCloseClick(TObject *Sender)
{
  Close();
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::TreeView1Change(TObject *Sender, TTreeNode *Node)
{
  PageControl1->ActivePage = TabForm;
  ShowForm();

  btnPrevious->Enabled = (TreeView1->Selected != NULL) && (TreeView1->Selected->AbsoluteIndex > 0);
  btnNext->Enabled = (TreeView1->Selected!=NULL) && (TreeView1->Selected->AbsoluteIndex < TreeView1->Items->Count-1);
  TabSource->TabVisible = CodeFile() != "";
}
//---------------------------------------------------------------------------
const AnsiString MtxVecRegKey = "\\Software\\Dew Research";
//---------------------------------------------------------------------------
AnsiString CodePath()
{
  AnsiString Res = "";
  TRegistry *reg = new TRegistry();
  try
  {
    if (reg->OpenKeyReadOnly(MtxVecRegKey))
      Res = reg->ReadString("MtxVecBCBDemoPath");
  }
  __finally
  {
    delete reg;
  }
  if (Res =="")
     if (FileExists("MtxVecBCBDemo.bpr")) Res = GetCurrentDir();

  return Res;
}
//---------------------------------------------------------------------------
void __fastcall AppendStrings(TStrings *Dest, AnsiString AFileName)
{
        TStringList *strl = new TStringList();
        try
        {
          strl->LoadFromFile(AFileName);
          Dest->AddStrings(strl);
        }
        __finally
        {
          delete strl;
        }
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::btnConfigClick(TObject *Sender)
{
//  #pragma message __BORLANDC__
  #if (__BORLANDC__ >= 0x0610)
  UnicodeString tmpDir;
  #else
  AnsiString tmpDir;
  #endif

  if (SelectDirectory("Folder with MtxVec demo source","",tmpDir))
  {
    TRegistry *reg = new TRegistry();
    try
    {
      if (reg->OpenKey(MtxVecRegKey,true)) reg->WriteString("MtxVecBCBDemoPath",tmpDir);
    }
    __finally
    {
      delete reg;
    }
    PageControl1Change(this);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::PageControl1Change(TObject *Sender)
{
//
  if (PageControl1->ActivePage == TabSource)
  {
    if (! FileExists(CodePath()+AnsiString("\\BenchmarkFramework.cpp")))
    {
      TRegistry *reg = new TRegistry();
      try {  reg->DeleteKey(MtxVecRegKey); }
      __finally { delete reg; }
    }

    btnConfig->Visible = (CodePath() =="");
    if (CodePath() != "" && CodeFile() != "")
    {
      if (OldCodeFile != CodeFile())
      {
        delete RichEditCode;
        TRichEdit *RichEditCode = new TRichEdit(this);
        RichEditCode->Align = alClient;
        RichEditCode->ReadOnly = true;
        RichEditCode->WordWrap = false;
        RichEditCode->ScrollBars = ssBoth;
        RichEditCode->Font->Name = "Courier New";
        RichEditCode->Font->Size = 9;
        RichEditCode->Parent = TabSource;
        AnsiString FN = CodePath()+"\\"+CodeFile();
        RichEditCode->Lines->Add(CodeFile()+".h");
        AppendStrings(RichEditCode->Lines,FN+AnsiString(".h"));
        RichEditCode->Lines->Add("\n \n");
        RichEditCode->Lines->Add(CodeFile()+".cpp");
        AppendStrings(RichEditCode->Lines,FN+AnsiString(".cpp"));
        OldCodeFile = CodeFile();
      }
    }
    else { delete RichEditCode; }
  }
}
//---------------------------------------------------------------------------



void __fastcall TfrmMain::Memo1MouseMove(TObject *Sender,
      TShiftState Shift, int X, int Y)
{
//
}
//---------------------------------------------------------------------------


void __fastcall TfrmMain::FormShow(TObject *Sender)
{
  TreeView1->Select(TreeView1->Items->Item[0]);
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::FormDestroy(TObject *Sender)
{
	for (int t = 0; t < TreeView1->Items->Count; t++)
	{
	   delete (TExampleInfo*) (TreeView1->Items->Item[t]->Data);
	}
}
//---------------------------------------------------------------------------


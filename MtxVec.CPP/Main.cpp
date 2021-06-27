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

void __fastcall TfrmMain::FormCreate(TObject *Sender)
{
  PageControl1->ActivePage=TabForm;
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


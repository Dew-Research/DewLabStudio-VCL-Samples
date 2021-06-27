//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

// uncomment if BDE is used
// #define BDE

#ifdef BDE
  #include <Db.hpp>
  #include <DBTables.hpp>
#endif


#include "FileHandling1.h"
#include "MtxVecEdit.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TFileH1 *FileH1;
//---------------------------------------------------------------------------
__fastcall TFileH1::TFileH1(TComponent* Owner)
  : TBasicForm2(Owner)
{
  AnsiString str;

  RichEdit1->Lines->Clear();
  str = "Importing and exporting values is an important feature ";
  str+= "of MtxVec. MtxVec offers you the ability to save vector/";
  str+= "matrix to memory stream, binary files, text files, BLOBs, Clipboard ...";
  RichEdit1->Lines->Add(str);
  str = "Click on buttons bellow to introduce yourself with various ";
  str+= "methods available. If ""View loaded values"" option is ";
  str+= "checked, you'll get a visual representation of loaded matrix/vector.";
  RichEdit1->Lines->Add(str);
}
//---------------------------------------------------------------------------


void __fastcall TFileH1::Button1Click(TObject *Sender)
{
  sMatrix tmpMtx;
  RichEdit2->Lines->Clear();

  RichEdit2->Lines->Add("AMtx->Size(10,10);");
  RichEdit2->Lines->Add("AMtx->RandGauss(); //add random data }");
  RichEdit2->SelAttributes->Style = RichEdit2->SelAttributes->Style << TFontStyle::fsItalic;
  RichEdit2->Lines->Add("// save header & values to stream}");
  RichEdit2->Lines->Add("TMemoryStream AStream = TMemoryStream();");
  RichEdit2->Lines->Add("try {");
  RichEdit2->Lines->Add(" AMtx->SaveToStream(AStream);");
  RichEdit2->SelAttributes->Style = RichEdit2->SelAttributes->Style << TFontStyle::fsItalic;
  RichEdit2->Lines->Add(" // now load header & values from stream }");
  RichEdit2->Lines->Add("   AStream->Seek(0,0);");
  RichEdit2->Lines->Add("   tmpMtx->LoadFromStream(AStream);");
  RichEdit2->Lines->Add("   If (CheckBox1->Checked) ViewValues(AMtx);");
  RichEdit2->Lines->Add("} __finally {");
  RichEdit2->Lines->Add("");
  RichEdit2->Lines->Add("  delete AStream");
  RichEdit2->Lines->Add("");
  RichEdit2->Lines->Add("}");


  AMtx.Size(10,10,false);
  AMtx.RandGauss(); // add random data

  // save header & values to stream}
  TMemoryStream *AStream = new TMemoryStream;
  try
  {
	AMtx.SaveToStream(AStream);
	// now load header & values from stream
	AStream->Seek(0,0);
	tmpMtx.LoadFromStream(AStream);
	if (CheckBox1->Checked) ViewValues(AMtx,"Memory stream",true,false,true);
  }
  __finally
  {
    delete AStream;
  }
}
//---------------------------------------------------------------------------

void __fastcall TFileH1::Button2Click(TObject *Sender)
{
  sVector tmpVec;
  RichEdit2->Lines->Clear();

  RichEdit2->Lines->Add("AVec->Size(100);");
  RichEdit2->Lines->Add("AVec.RandUniform(-2,2);");
  RichEdit2->SelAttributes->Style = RichEdit2->SelAttributes->Style << TFontStyle::fsItalic;
  RichEdit2->Lines->Add(" //save header & values to file}");
  RichEdit2->Lines->Add("AVec->SaveToFile(""TestVec1.vec"");");
  RichEdit2->SelAttributes->Style = RichEdit2->SelAttributes->Style << TFontStyle::fsItalic;
  RichEdit2->Lines->Add(" // load header & values into tmpVec}");
  RichEdit2->Lines->Add("tmpVec->LoadFromFile(""TestVec1.vec"");");
  RichEdit2->Lines->Add("if (CheckBox1->Checked) ViewValues(tmpVec);");

  AVec.Size(100);
  AVec.RandUniform(-2,2);
  AVec.SaveToFile("TestVec1.vec");   // save header & values to file

  tmpVec.LoadFromFile("TestVec1.vec");     // load header & values into tmpVec
  if (CheckBox1->Checked) ViewValues(tmpVec,"File Stream",true);
}
//---------------------------------------------------------------------------

void __fastcall TFileH1::Button4Click(TObject *Sender)
{
  sMatrix tmpMtx;
  RichEdit2->Lines->Clear();

  RichEdit2->Lines->Add("AMtx->Size(20,20,true);");
  RichEdit2->Lines->Add("AMtx->RandUniform(-1,2);");
  RichEdit2->Lines->Add("TStringList StringList = new TStringList();");
  RichEdit2->Lines->Add("try {");
  RichEdit2->SelAttributes->Style = RichEdit2->SelAttributes->Style << TFontStyle::fsItalic;
  RichEdit2->Lines->Add(" // use tab = chr(9) as delimiter ");
  RichEdit2->Lines->Add(" AMtx->ValuesToStrings(StringList,#9);");
  RichEdit2->SelAttributes->Style = RichEdit2->SelAttributes->Style << TFontStyle::fsItalic;
  RichEdit2->Lines->Add(" // Save matrix values to txt file }");
  RichEdit2->Lines->Add(" StringList->SaveToFile(""ASCIIMtx.txt"");");
  RichEdit2->Lines->Add("} __finally {");
  RichEdit2->Lines->Add(" delete StringList;");
  RichEdit2->Lines->Add("}");
  RichEdit2->Lines->Add("");
  RichEdit2->Lines->Add("TStringList StringList = new TStringList();");
  RichEdit2->Lines->Add("Matrix tmpMtx;");
  RichEdit2->Lines->Add("try {");
  RichEdit2->SelAttributes->Style = RichEdit2->SelAttributes->Style << TFontStyle::fsItalic;
  RichEdit2->Lines->Add(" // get matrix values from text file }");
  RichEdit2->Lines->Add(" StringList->LoadFromFile(""ASCIIMtx.txt"");");
  RichEdit2->SelAttributes->Style = RichEdit2->SelAttributes->Style << TFontStyle::fsItalic;
  RichEdit2->Lines->Add(" // use tab = chr(9) as delimiter }");
  RichEdit2->Lines->Add(" tmpMtx->StringsToValues(StringList,#9);");
  RichEdit2->Lines->Add(" if (CheckBox1->Checked) ViewValues(tmpMtx);");
  RichEdit2->Lines->Add("} __finally {");
  RichEdit2->Lines->Add(" delete StringList;");
  RichEdit2->Lines->Add("}");

  AMtx.Size(20,20,true);
  AMtx.RandUniform(-1,2);
  TStringList *StringList = new TStringList();
  try
  {
	  AMtx.ValuesToStrings(StringList,kTab, ftaNone, "0.###;-0.###", "+0.###i;-0.###i");     // use tab = chr(9) as delimiter
	  StringList->SaveToFile("ASCIIMtx.txt");     // Save matrix values to txt file
  }
  __finally
  {
	  delete StringList;
  }

  StringList = new TStringList;
  try
  {
    // get matrix values from text file
    StringList->LoadFromFile("ASCIIMtx.txt");
	// use tab = chr(9) as delimiter
	tmpMtx.StringsToValues(StringList,kTab);
	if (CheckBox1->Checked) ViewValues(tmpMtx,"TEXT file",true,false,false);
  }
  __finally
  {
    delete StringList;
  }
}
//---------------------------------------------------------------------------

void __fastcall TFileH1::Button3Click(TObject *Sender)
{
    RichEdit2->Lines->Clear();

    RichEdit2->Lines->Add("Vector tmpVec;");
    RichEdit2->Lines->Add("AVec->Size(100,false);");
    RichEdit2->Lines->Add("AVec->RandGauss(0,1);");
    RichEdit2->Lines->Add("AVec->SortAscend();");
    RichEdit2->Lines->Add("TTable *Table1 = new TTable(this);");
    RichEdit2->Lines->Add("try");
    RichEdit2->Lines->Add("{");
    RichEdit2->Lines->Add("     Table1->DatabaseName = ""DBDemos"";");
    RichEdit2->Lines->Add("     Table1->TableType = ttDefault;");
    RichEdit2->Lines->Add("     Table1->TableName =""TableVec"";");
    RichEdit2->Lines->Add("     Table1->FieldDefs->Clear();");
    RichEdit2->Lines->Add("     TFieldDef *pNewFDef = Table1->FieldDefs->AddFieldDef();");
    RichEdit2->Lines->Add("     pNewFDef->Name = ""Field1"";");
    RichEdit2->Lines->Add("     pNewFDef->DataType = ftBlob;");
    RichEdit2->Lines->Add("     pNewFDef->Required = false;");
    RichEdit2->Lines->Add("     Table1->CreateTable();");
    RichEdit2->Lines->Add("     // save to table1");
    RichEdit2->Lines->Add("     Table1->Active = true;");
    RichEdit2->Lines->Add("     Table1->Insert();");
    RichEdit2->Lines->Add("     TStream *tmpBLOB = Table1->CreateBlobStream(Table1->FieldByName(""Field1""),bmReadWrite);");
    RichEdit2->Lines->Add("     try");
    RichEdit2->Lines->Add("     {");
    RichEdit2->Lines->Add("          AVec->SaveToStream(tmpBLOB, prDouble, rnTrunc);");
    RichEdit2->Lines->Add("          Table1->Post();");
    RichEdit2->Lines->Add("          tmpBLOB->Seek(0,0); // ""reset"" BLOB stream");
    RichEdit2->Lines->Add("          tmpVec->LoadFromStream(tmpBLOB);");
    RichEdit2->Lines->Add("          if (CheckBox1->Checked) ViewValues(tmpVec,""BLOB Stream"",true); ");
    RichEdit2->Lines->Add("     } ");
    RichEdit2->Lines->Add("     __finally ");
    RichEdit2->Lines->Add("     { ");
    RichEdit2->Lines->Add("          delete tmpBLOB;");
    RichEdit2->Lines->Add("     }");
    RichEdit2->Lines->Add("     }");
    RichEdit2->Lines->Add("__finally");
    RichEdit2->Lines->Add("{");
    RichEdit2->Lines->Add("     Table1->Active = false;");
    RichEdit2->Lines->Add("     Table1->DeleteTable();");
    RichEdit2->Lines->Add("     delete Table1;");
    RichEdit2->Lines->Add("}");

  #ifdef BDE

      Vector tmpVec;
      AVec->Size(100,false);
      AVec->RandGauss(0,1);
      AVec->SortAscend();
      TTable *Table1 = new TTable(this);
      try
      {
          Table1->DatabaseName = "DBDemos";
          Table1->TableType = ttDefault;
          Table1->TableName ="TableVec";
          Table1->FieldDefs->Clear();
          TFieldDef *pNewFDef = Table1->FieldDefs->AddFieldDef();
          pNewFDef->Name = "Field1";
          pNewFDef->DataType = ftBlob;
          pNewFDef->Required = false;
          Table1->CreateTable();
          // save to table1
          Table1->Active = true;
          Table1->Insert();
          TStream *tmpBLOB = Table1->CreateBlobStream(Table1->FieldByName("Field1"),bmReadWrite);
          try
          {
              AVec->SaveToStream(tmpBLOB, prDouble, rnTrunc);
              Table1->Post();
              tmpBLOB->Seek(0,0); // "reset" BLOB stream
              tmpVec->LoadFromStream(tmpBLOB);
              if (CheckBox1->Checked) ViewValues(tmpVec,"BLOB Stream",true); 
              }
          __finally
          {
              delete tmpBLOB;
          }
      }
      __finally");
      {");
      Table1->Active = false;");
      Table1->DeleteTable();");
      delete Table1;");
      }");

    #endif

}
//---------------------------------------------------------------------------


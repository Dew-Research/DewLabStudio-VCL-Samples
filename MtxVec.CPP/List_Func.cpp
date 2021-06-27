//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "List_Func.h"
#include "Find_Form.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmListFunc *frmListFunc;
//---------------------------------------------------------------------------
__fastcall TfrmListFunc::TfrmListFunc(TComponent* Owner)
        : TForm(Owner)
{
  int Total;
  AnsiString FilePath;
  FilePath = ExtractFilePath(Application->ExeName);

  Total = ListToStringGrid(FilePath + "List_Functions.txt");
  Label1->Caption = "Function list: Count = " +IntToStr(Total) + "  (not counting overloaded functions)";
  LastIndex = -1;
  LastSearchText = "";
  LastFindAll = false;
}
//---------------------------------------------------------------------------
  bool FoundTextIn(TStrings *SearchText, AnsiString S, bool FindAllWords)
  {
    int i;
    bool Result = false;
    S = S.UpperCase();

    if (FindAllWords)  {

      for (i = 0; i < SearchText->Count;i ++)  {
         if (S.AnsiPos(SearchText->Strings[i]) == 0) return Result;
      }
      Result = true;

    } else {

      for (i = 0; i < SearchText->Count; i++) {

        if (S.AnsiPos(SearchText->Strings[i]) > 0)  {

           Result = true;
           return Result;
        }
      }
   }

   return Result;
  }

  bool SearchInLines(TStrings* SearchText, TStrings *Lines, bool FindAllWords) {

    bool result = false;
    int i;

    for (i = 0; i < Lines->Count; i++) {

      if (FoundTextIn(SearchText, Lines->Strings[i], FindAllWords)) {

        result = true;
        return result;
      }
    }
    return result;
  }

  void  SplitWords(TStringList *SearchText, AnsiString S)
  {
    int i;
    while ((i != 0) && (S != ""))  {

      i = S.AnsiPos(" ");
      if (i > 0) {

        SearchText->Add( (S.SubString(1,i-1)).UpperCase());
        S = S.Delete(1,i);
      }
    }
    if (S != "") {

      SearchText->Add(S.UpperCase());
    }
  }

//---------------------------------------------------------------------------
int __fastcall TfrmListFunc::DoSearch(AnsiString FindText, bool FindAllWords)
{
  TStringList *SearchText;
  int Result = -1;
  int  i, FirstIndex;

  SearchText = new TStringList();
  try
     {
        SplitWords(SearchText, FindText);
        FirstIndex = LastIndex+1;
        for (i = FirstIndex; i < StringGrid1->RowCount; i++) {
          if (SearchInLines(SearchText, StringGrid1->Rows[i], FindAllWords)) {

            Result = i;
            StringGrid1->Row = i;
            break;
          }
        }
     }
  __finally
  {
       delete SearchText;
  }

  return Result;
}

//---------------------------------------------------------------------------
int __fastcall TfrmListFunc::ListToStringGrid(AnsiString AFileName)
{
  int i,j, Len;
  TStringList *StrList;
  int Result = 0;

  StringGrid1->RowCount = 1;
  StringGrid1->Cells[0][0] = "(Unit) Name";
  StringGrid1->Cells[1][0] = "Description";

  if (FileExists(AFileName)) {

    StrList = new TStringList();
    try
      {
      StrList->LoadFromFile(AFileName);
      for (i = 0; i< StrList->Count; i++) {

          StringGrid1->RowCount = i+1;
          Len = StrList->Strings[i].Length();
          j = StrList->Strings[i].Pos("\t");
          StringGrid1->Cells[0][i] = StrList->Strings[i].SubString(0,j-1);
          StringGrid1->Cells[1][i] = StrList->Strings[i].SubString(j+1,Len-j);
          if (StringGrid1->Cells[1][i] != "") Result++;
      }
      StringGrid1->FixedRows = 1;
      }
    __finally {

        delete StrList;
    }
  }

  return Result;
}
//---------------------------------------------------------------------------
void __fastcall TfrmListFunc::Button1Click(TObject *Sender)
{
  TfrmFind *FindForm;

  if (LastIndex != -1) { LastIndex = DoSearch(LastSearchText,LastFindAll); }  else
  {
     FindForm = new TfrmFind(this);
     try       {

        FindForm->ShowModal();
        
        }
     __finally {

          if (FindForm->ModalResult == mrOk) {

              LastIndex = DoSearch(FindForm->FindText,FindForm->FindAll);
              LastSearchText = FindForm->FindText;
              LastFindAll = FindForm->FindAll;
          }
          delete FindForm;
     }
  }
  if (LastIndex != -1) {Button1->Caption = "Next";}
  else Button1->Caption = "Find";
}
//---------------------------------------------------------------------------
void __fastcall TfrmListFunc::Button2Click(TObject *Sender)
{
  LastIndex = -1;
  LastSearchText = "";
  LastFindAll = false;
  Button1->Caption = "Find";
}
//---------------------------------------------------------------------------
void __fastcall TfrmListFunc::FormResize(TObject *Sender)
{
  StringGrid1->ColWidths[1] = StringGrid1->Width - StringGrid1->ColWidths[0];
}
//---------------------------------------------------------------------------


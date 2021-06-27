//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "List_Func.h"
#include "FileCtrl.hpp"
#include "Basic_Form.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmListFunc *frmListFunc;
//---------------------------------------------------------------------------
__fastcall TfrmListFunc::TfrmListFunc(TComponent* Owner)
	: TForm(Owner)
{
	int Total = ListToStringGrid("List_Functions.txt");
	Label1->Caption = "Function list: Count = "+IntToStr(Total) + "  (not counting overloaded functions)";
}
//---------------------------------------------------------------------------
int __fastcall TfrmListFunc::ListToStringGrid(UnicodeString filename)
{
	int i;
	int res = 0;

	String dir = CodePath();
	if (!FileExists(dir + filename))
	{
		if (CodePathSelect())
		{
			dir = CodePath();
		}
	}
	if (!FileExists(dir + filename)) return 0;
	TStrings *s = new TStringList();
	try {
		s->LoadFromFile(dir + filename);
		StringGrid1->RowCount =1;
		StringGrid1->Cells[0][0] = "(Unit) Name";
		StringGrid1->Cells[1][0] = "Description";
		for (i = 0; i<s->Count; i++) {
			StringGrid1->RowCount = i+1;
			int j = Pos((char)9,(*s)[i]);
			StringGrid1->Cells[0][i+1] = (*s)[i].SubString(0,j-1);
			StringGrid1->Cells[1][i+1] = (*s)[i].SubString(j+1,(*s)[i].Length() - j);
			if (StringGrid1->Cells[1][i+1]!="") res++;
		}
	}
	__finally
	{
		delete s;
	}
	StringGrid1->FixedRows = 1;
	return res;
}
void __fastcall TfrmListFunc::FormResize(TObject *Sender)
{
	StringGrid1->ColWidths[1] = StringGrid1->Width - StringGrid1->ColWidths[0];
}
//---------------------------------------------------------------------------


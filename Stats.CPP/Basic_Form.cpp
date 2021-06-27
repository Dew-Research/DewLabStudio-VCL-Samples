//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Basic_Form.h"
#include "StrUtils.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmBasic *frmBasic;
//---------------------------------------------------------------------------
__fastcall TfrmBasic::TfrmBasic(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
AnsiString __fastcall CodePath()
{
	AnsiString Res = "";
	TRegistry *reg = new TRegistry();
	try
	{
		if (reg->OpenKey(DSPRegKey, true))
			Res = reg->ReadString("StatsMasterBCBDemoPath");

		if (Res =="")
		{
			Res = ExtractFilePath(ParamStr(0));
			Res = IncludeTrailingPathDelimiter(Res);
	    	Res = ReplaceStr(Res, "\\.\\", "\\");
			if (FileExists(Res + "StatDemoW32_BC27.cbproj") )
			{
				reg->WriteString("StatsMasterBCBDemoPath", Res);
			}
		}
	}
	__finally
	{
		delete reg;
	}

	return Res;
}

bool __fastcall CodePathSelect()
{
	bool res = false;

	#if (__BORLANDC__ >= 0x0610)
	UnicodeString tmpDir = ExtractFilePath(ParamStr(0));
	if (SelectDirectory("Folder with Stats Master demo source", "",tmpDir))
	#else
	AnsiString tmpDir = ExtractFilePath(ParamStr(0));
	if (SelectDirectory("Folder with Stats Master demo source", "",tmpDir))
	#endif
	{
		tmpDir = IncludeTrailingPathDelimiter(tmpDir);
		tmpDir = ReplaceStr(tmpDir, "\\.\\", "\\");
		if (FileExists(tmpDir + "StatDemoW32_BC27.cbproj") )
		{
			TRegistry *reg = new TRegistry();
			try
			{
				if (reg->OpenKey(DSPRegKey,true)) reg->WriteString("StatsMasterBCBDemoPath",tmpDir);
			}
			__finally
			{
				delete reg;
			}
			res = true;
		}
	}

    return res;
}

// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'PersistentStreamer.pas' rev: 6.00

#ifndef PersistentStreamerHPP
#define PersistentStreamerHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Persistentstreamer
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPersistentReader;
class PASCALIMPLEMENTATION TPersistentReader : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Classes::TStream* FStream;
	Classes::TStreamOriginalFormat FMode;
	
public:
	__fastcall TPersistentReader(Classes::TStream* aStream, Classes::TStreamOriginalFormat aMode);
	void __fastcall ReadPersistent(Classes::TPersistent* instance);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TPersistentReader(void) { }
	#pragma option pop
	
};


class DELPHICLASS TPersistentWriter;
class PASCALIMPLEMENTATION TPersistentWriter : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Classes::TStream* FStream;
	Classes::TStreamOriginalFormat FMode;
	
public:
	__fastcall TPersistentWriter(Classes::TStream* aStream, Classes::TStreamOriginalFormat aMode);
	void __fastcall WritePersistent(Classes::TPersistent* instance);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TPersistentWriter(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall SavePersistentToStream(Classes::TPersistent* anInstance, Classes::TStream* aStream, Classes::TStreamOriginalFormat aMode);
extern PACKAGE void __fastcall LoadPersistentFromStream(Classes::TPersistent* anInstance, Classes::TStream* aStream, Classes::TStreamOriginalFormat aMode = (Classes::TStreamOriginalFormat)(0x0));
extern PACKAGE void __fastcall SavePersistentToFile(Classes::TPersistent* anInstance, const AnsiString fileName, Classes::TStreamOriginalFormat aMode);
extern PACKAGE void __fastcall LoadPersistentFromFile(Classes::TPersistent* anInstance, const AnsiString fileName, Classes::TStreamOriginalFormat aMode = (Classes::TStreamOriginalFormat)(0x0));
extern PACKAGE void __fastcall SavePersistentToString(Classes::TPersistent* anInstance, /* out */ AnsiString &aStr, Classes::TStreamOriginalFormat aMode);
extern PACKAGE void __fastcall LoadPersistentFromString(Classes::TPersistent* anInstance, const AnsiString aStr, Classes::TStreamOriginalFormat aMode = (Classes::TStreamOriginalFormat)(0x0));

}	/* namespace Persistentstreamer */
using namespace Persistentstreamer;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PersistentStreamer

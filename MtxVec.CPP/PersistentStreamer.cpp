//---------------------------------------------------------------------------
#pragma hdrstop

#include "PersistentStreamer.h"

//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

class PersistentHolder: public TComponent {
private:
  TPersistent* instance_;
public:
  __fastcall virtual PersistentHolder(TComponent* aOwner);
__published:
  __property TPersistent* Instance = {read = instance_, write = instance_};
};
//---------------------------------------------------------------------------

__fastcall PersistentHolder::PersistentHolder (TComponent* aOwner)
  : TComponent(aOwner)
{
}
//---------------------------------------------------------------------------

PersistentReader::PersistentReader (TStream& stream, TStreamOriginalFormat mode)
  : fSteram(&stream), fMode(mode)
{
}
//---------------------------------------------------------------------------

void PersistentReader::ReadPersistent(TPersistent& instance)
{
  PersistentHolder* holder = new PersistentHolder (NULL);
  try {
    holder->Instance = &instance;

    if (fMode == sofUnknown)
      fMode = TestStreamFormat (fSteram);

    switch (fMode) {
      case sofBinary:
        fSteram->ReadComponent (holder);
        break;

      case sofText:
        TMemoryStream* stream = new TMemoryStream;
        try {
          ObjectTextToBinary (fSteram, stream);
          stream->Seek(0, soFromBeginning);
          stream->ReadComponent (holder);
        } __finally {
          delete stream;
        }
        break;

    } // switch
  } __finally {
    delete holder;
  }
}
//---------------------------------------------------------------------------

PersistentWriter::PersistentWriter (TStream& stream, TStreamOriginalFormat mode)
  : fSteram(&stream),  fMode(mode)
{
}
//---------------------------------------------------------------------------

void PersistentWriter::WritePersistent (TPersistent& instance)
{
  PersistentHolder* holder = new PersistentHolder (NULL);
  try {
    holder->Instance = &instance;
    switch (fMode) {
      case sofBinary:
        fSteram->WriteComponent (holder);
        break;

      case sofText:
        TMemoryStream* stream = new TMemoryStream();
        try {
          stream->WriteComponent (holder);
          stream->Seek(0, soFromBeginning);
          ObjectBinaryToText (stream, fSteram);
        } __finally {
          delete stream;
        }
        break;

    } // switch

  } __finally {
    delete holder;
  }
}
//---------------------------------------------------------------------------
void SavePersistentToStream (TPersistent& anInstance, TStream& stream, TStreamOriginalFormat mode)
{
  PersistentWriter wr (stream, mode);
  wr.WritePersistent (anInstance);
}
//---------------------------------------------------------------------------

void LoadPersistentFromStream (TPersistent& anInstance, TStream& stream, TStreamOriginalFormat mode)
{
  PersistentReader rd (stream, mode);
  rd.ReadPersistent (anInstance);
}
//---------------------------------------------------------------------------

void SavePersistentToFile (TPersistent& anInstance, const AnsiString& fileName, TStreamOriginalFormat mode)
{
  TFileStream* stream = new TFileStream (fileName, fmCreate);
  try {
    SavePersistentToStream (anInstance, *stream, mode);
  } __finally {
    delete stream;
  }
}
//---------------------------------------------------------------------------

void LoadPersistentFromFile (TPersistent& anInstance, const AnsiString& fileName, TStreamOriginalFormat mode)
{
  TFileStream* stream = new TFileStream (fileName, fmOpenRead);
  try {
    LoadPersistentFromStream (anInstance, *stream, mode);
  } __finally {
    delete stream;
  }
}
//---------------------------------------------------------------------------

void SavePersistentToString (TPersistent& anInstance, AnsiString& aStr, TStreamOriginalFormat mode)
{
  TStringStream* stream = new TStringStream((RawByteString) "");
  try {
    SavePersistentToStream (anInstance, *stream, mode);
    aStr = stream->DataString;
  } __finally {
    delete stream;
  }
}
//---------------------------------------------------------------------------

void LoadPersistentFromString (TPersistent& anInstance, const AnsiString& aStr, TStreamOriginalFormat mode)
{
  TStringStream* stream = new TStringStream ((RawByteString) aStr);
  try {
	LoadPersistentFromStream (anInstance, *stream, mode);
  } __finally {
	delete stream;
  }
}
//---------------------------------------------------------------------------

static void Init()
{
  RegisterClass (__classid(PersistentHolder));
}

#pragma startup Init 64
//---------------------------------------------------------------------------

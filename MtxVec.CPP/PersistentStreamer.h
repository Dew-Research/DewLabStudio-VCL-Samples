//---------------------------------------------------------------------------
#ifndef PersistentStreamerH
#define PersistentStreamerH
//---------------------------------------------------------------------------

#include <Classes.hpp>

//---------------------------------------------------------------------------

class PersistentReader {
private:
  TStream* fSteram;
  TStreamOriginalFormat fMode;
public:
  PersistentReader (TStream& stream, TStreamOriginalFormat mode = sofUnknown);
  void ReadPersistent(TPersistent& instance);
  //
  // We have to know a type of object which is read from a stream
  // and put address of created instance,
  // otherwise we have to use TComponent or
  // create own streaming mechanism
};

class PersistentWriter {
private:
  TStream* fSteram;
  TStreamOriginalFormat fMode;
public:
  PersistentWriter (TStream& stream, TStreamOriginalFormat mode);
  void WritePersistent (TPersistent& instance);
};

// stream
void SavePersistentToStream (TPersistent& anInstance, TStream& stream, TStreamOriginalFormat mode);
void LoadPersistentFromStream (TPersistent& anInstance, TStream& stream, TStreamOriginalFormat mode = sofUnknown);

// file
void SavePersistentToFile (TPersistent& anInstance, const AnsiString& fileName, TStreamOriginalFormat mode);
void LoadPersistentFromFile (TPersistent& anInstance, const AnsiString& fileName, TStreamOriginalFormat mode = sofUnknown);

// string
void SavePersistentToString (TPersistent& anInstance, AnsiString& aStr, TStreamOriginalFormat mode);
void LoadPersistentFromString (TPersistent& anInstance, const AnsiString& aStr, TStreamOriginalFormat mode = sofUnknown);

//---------------------------------------------------------------------------
#endif

unit PersistentStreamer;

interface
uses
  Classes;

type
  TPersistentReader = class
  private
    FStream: TStream;
    FMode: TStreamOriginalFormat;
  public
    constructor Create (aStream: TStream; aMode: TStreamOriginalFormat = sofUnknown);
    procedure ReadPersistent(instance: TPersistent);
  end;

  TPersistentWriter = class
  private
    FStream: TStream;
    FMode: TStreamOriginalFormat;
  public
    constructor Create (aStream: TStream; aMode: TStreamOriginalFormat);

    procedure WritePersistent (instance: TPersistent);
  end;

// stream
procedure SavePersistentToStream (anInstance: TPersistent; aStream: TStream; aMode: TStreamOriginalFormat);
procedure LoadPersistentFromStream (anInstance: TPersistent; aStream: TStream; aMode: TStreamOriginalFormat = sofUnknown);

// file
procedure SavePersistentToFile (anInstance: TPersistent; const fileName: string; aMode: TStreamOriginalFormat);
procedure LoadPersistentFromFile (anInstance: TPersistent; const fileName: string; aMode: TStreamOriginalFormat = sofUnknown);

// string
procedure SavePersistentToString (anInstance: TPersistent; out aStr: string; aMode: TStreamOriginalFormat);
procedure LoadPersistentFromString (anInstance: TPersistent; const aStr: string; aMode: TStreamOriginalFormat = sofUnknown);

implementation
uses
  SysUtils;

type
  TPersistentHolder = class (TComponent)
  private
    FInstance: TPersistent;
  published
    property Instance: TPersistent read FInstance write FInstance;
  end;

{ TPersistentReader }

constructor TPersistentReader.Create(aStream: TStream;
  aMode: TStreamOriginalFormat);
begin
  inherited Create;
  FStream:= aStream;
  FMode:= aMode;
end;


procedure TPersistentReader.ReadPersistent(instance: TPersistent);
var
  holder: TPersistentHolder;
  stream: TMemoryStream;
begin
  holder:= TPersistentHolder.Create (nil);
  try
    holder.Instance:= instance;

    if FMode = sofUnknown then
      FMode:= TestStreamFormat (FStream);

    case FMode of
      sofBinary:
        begin
          FStream.ReadComponent (holder);
        end;

      sofText:
        begin
          stream:= TMemoryStream.Create();
          try
            ObjectTextToBinary (FStream, stream);
            stream.Seek(0, soFromBeginning);
            stream.ReadComponent (holder);
          finally
            stream.Free;
          end;
        end;
    end;
  finally
    holder.Free;
  end;
end;

{ TPersistentWriter }

constructor TPersistentWriter.Create(aStream: TStream;
  aMode: TStreamOriginalFormat);
begin
  inherited Create;
  FStream:= aStream;
  FMode:= aMode;
end;


procedure TPersistentWriter.WritePersistent(instance: TPersistent);
var
  holder: TPersistentHolder;
  stream: TMemoryStream;
begin
  holder:= TPersistentHolder.Create (nil);
  try
    holder.Instance:= instance;
    case FMode of
      sofBinary:
        begin
          FStream.WriteComponent (holder);
        end;

      sofText:
        begin
          stream:= TMemoryStream.Create();
          try
            stream.WriteComponent (holder);
            stream.Seek(0, soFromBeginning);
            ObjectBinaryToText (stream, FStream);
          finally
            stream.Free;
          end;
        end;
    end;
  finally
    holder.Free;
  end;
end;

procedure SavePersistentToStream (anInstance: TPersistent; aStream: TStream; aMode: TStreamOriginalFormat);
var
  wr: TPersistentWriter;
begin
  wr:= TPersistentWriter.Create (aStream, aMode);
  try
    wr.WritePersistent (anInstance);
  finally
    wr.Free;
  end;
end;

procedure LoadPersistentFromStream (anInstance: TPersistent; aStream: TStream; aMode: TStreamOriginalFormat);
var
  rd: TPersistentReader;
begin
  rd:= TPersistentReader.Create (aStream, aMode);
  try
    rd.ReadPersistent (anInstance);
  finally
    rd.Free;
  end;
end;

procedure SavePersistentToFile (anInstance: TPersistent; const fileName: string; aMode: TStreamOriginalFormat);
var
  stream: TFileStream;
begin
  stream:= TFileStream.Create (fileName, fmCreate);
  try
    SavePersistentToStream (anInstance, stream, aMode);
  finally
    stream.Free;
  end;
end;

procedure LoadPersistentFromFile (anInstance: TPersistent; const fileName: string; aMode: TStreamOriginalFormat);
var
  stream: TFileStream;
begin
  stream:= TFileStream.Create (fileName, fmOpenRead);
  try
    LoadPersistentFromStream (anInstance, stream, aMode);
  finally
    stream.Free;
  end;
end;

procedure SavePersistentToString (anInstance: TPersistent; out aStr: string; aMode: TStreamOriginalFormat);
var
  stream: TStringStream;
begin
  stream:= TStringStream.Create ('');
  try
    SavePersistentToStream (anInstance, stream, aMode);
    aStr:= stream.DataString;
  finally
    stream.Free;
  end;
end;

procedure LoadPersistentFromString (anInstance: TPersistent; const aStr: string; aMode: TStreamOriginalFormat = sofUnknown);
var
  stream: TStringStream;
begin
  stream:= TStringStream.Create (aStr);
  try
    LoadPersistentFromStream (anInstance, stream, aMode);
  finally
    stream.Free;
  end;
end;

initialization
  RegisterClass (TPersistentHolder);
end.



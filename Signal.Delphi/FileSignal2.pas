{*******************************************}
{   BDSPP 2.5	File handling component       }
{   	   		                                }
{   Components: TSignalRead	                }
{               TSignalWrite                }
{               TSignalBrowse               }
{               TSignalReadList	            }
{               TSignalWriteList            }
{					                                  }
{   Copyright (c) 1997-2005 DewResearch     }
{   All Rights Reserved                     }
{*******************************************}

{$I BdsppDefs.inc}
{:Read or write files.}
unit FileSignal2;

interface

uses MtxVec, Classes, Math387,  MMSystem, NdspL, SysUtils,
     SignalTools, MtxDialogs, MtxBaseComp;

type

//    TACMConverter = class;

{TChannels = (chMono, chStereo);
TSamplesPerSec = (sp11025, sp22050, sp44100, sp48000, sp88200, sp96000);
TBits = (bt8, bt16, bt24, bt32);}

{:Defines how to browse a multi-record file
  Defines how the TSignalRead component should browse a multi-record file. 
  @enum: frSingleRecord NextFrame method will return
  the next frame from the current record.
  @enum frAcrossAllRecord NextFrame routine
  will return the frame from the next record
  and at the same record position.}

   TFraming = (frSingleRecord, frAcrossAllRecords);


   {:Type used by audio compression manager.
     Type used by audio compression manager.}

   TACMWaveFormat = packed record
   case integer of
      0 : (Format : TWaveFormatExtensible);
      1 : (RawData : Array[0..128] of byte);
   end;

   {:Specifies file formats supported.
     File formats supported by TSignalWrite and TSignalWrite components.
      @enum ffDat The most versatile is the ffDat file format. It can store
         many records of different length, real or complex, arbitrary sampling frequency and
         precision and with any number of multiplexed channels within each record.
         The data can be streamed when saving and when loading the ffDat file.
      @enum ffAsc A two column text file, first column is the time axis
         and the second column is the amplitude. The second column can be complex.
      @enum ffSfs Single record text file. First line denotes number of entries.
        Second line is the the total time of sampling and the third line is empty.
        All the samples follow, each in its own line. Samples can be complex.
      @enum ffSgl Multi record text file. First line denotes number of entries.
        Second line is the total time of sampling and the third line
        containes the samples separated with ";". The samples can be complex.
        The fourth line is empty. This four lines can repeate any number of times
        within the file.
      @enum ffBin,ffDbn Backward compatibility. They were replaced
        by the ffDat format.
      }
     TFileFormat = (ffDat, ffSgl, ffBin, ffWav, ffSfs, ffAsc, ffDbn);

     {:Abstract class for read and writing signals.
       Abstract class for signal reading and writing.
        The class should never be created. }

     TFileStorage = class(TSignal)
         private
            FFileName: TFileName;
            FileStream: TFileStream;
            fIOHandle: HMMIO;
            DataCK: TMMCKINFO;   {Reading}
            ck_info: TMMCKINFO;
            data_info: TMMCKINFO; {Saving}
            WaveFormat: TACMWAVEFORMAT;
            FFileFormat: TFileFormat;
            FAutoFileFormat: boolean;
            procedure SetFileName(const Value: TFileName);
            procedure SetFileFormat(const Value: TFileFormat);
            procedure SetAutoFileFormat(const Value: boolean);
         protected
            FileReady: boolean;
            Strings: TStringList;
            procedure FindChunk(Ck, ParentCk: PMMCKINFO; Flags: Integer);
            function  GetRiffChunk(CkType: FOURCC): TMMCKINFO;
            procedure SeekSource(P: Integer);
            function  GetChunks(ChunkName: FOURCC; ParentChunk: TMMCKINFO): TMMCKINFO;
            function  GetData(Ck: TMMCKINFO; var Format: TACMWaveFormat): Integer;
            procedure CloseFile; virtual; abstract;
         published
            {::If True, the file format will be automatically determined from the
               file name extension. File name is stored in the FileName property.
               Recognized file extensions are: dat, asc, sfs, sgl, bin, dbn, wav.}
            property AutoFileFormat: boolean read FAutoFileFormat write SetAutoFileFormat default True;
            {::Defines the format of the file, if AutoFileFormat property is False.}
            property FileFormat: TFileFormat read FFileFormat write SetFileFormat default ffDat;
            {::Defines the file name to be read from or written to.}
            property FileName: TFileName read FFileName write SetFileName;
            constructor Create(AOwner: TComponent); override;
            destructor Destroy; override;
         end;

         {:@Defines how to handle data at the end of file.
            Defines how to handle data at the end of the file, when
            the data is being read with the Update method, which
            advances the read cursor automatically.
         @enum lfcZeroPadded The last block of data will be zero padded.
                             The length property will not be changed.
         @enum lfcLastFullBlock The reading of the file will stop when
                                the last full block of data has been read from the file.
                                The length property will not be changed.
                                With lfcZeroPadded the very last block read from the file
                                will contain zeros padded after the position exceeding
                                the size of the file. This padded zeros can affect any
                                averaging process working on the data blocks. By selecting
                                lfcLastFullBlock the IsEndOfFile will return true for the last
                               completely full data block. The Pull method calls IsEndOfFile.
         @enum lfcAdjustLength The Length property and the size of the data block to be
                               read will be adjusted to allow reading less
                               than initial Length samples. The user must
                               reset the Length property back to its orignal
                               size on its own if the file is to be processed again.}

       TLastFrameCheck = (lfcZeroPadded,lfcLastFullBlock,lfcAdjustLength);

     {:Reads a signal from a file.
        Use TSignalRead to read wav, binary and text files
        and provide streaming capabilities with frame navigation
        and overlapp support. The read data is placed Data property
        and its sample count is determined with the Length property.
        Once a file is opened, the key properties immediatelly
        contain all the necessary information about the file
        size, number of records, data type etc...}
       TSignalRead = class(TFileStorage)
         private
         {When loading, load in itself}
            WavStreaming: boolean;
            acm: TACMConverter;   
            fFileSize: Int64;
            DataSize: integer;
            PrevRecordNumber: integer;
            FNumberOfRecords: integer;
            FRecordLength: integer;
            fRecordTimePosition: TSample;
            FRecordNumber: integer;
            fRecordTime: TSample;
            FScaleFactor: TSample;
            FFraming: TFraming;
            FOverlappingPercent: TSample;
            FMaxFrames: integer;
            FOverlappingSamples: integer;
            FRecordPosition: integer;
            FFrameNumber: integer;
            FFramesPerSecond: TSample;
            FLoop: boolean;
            FFilePosition: integer;  //Stores the recordPosition after the data has been read (<> RecordPosition)}
            FPrecision: TPrecision;
            LoadedData: TVec;
            FOnRecordPositionChange: TNotifyEvent;
            FLastFrameCheck: TLastFrameCheck;
            FSelectionStop: integer;
            FOnProcessAll: TNotifyEvent;
            FForceLength: boolean;
            FSelectionStart: integer;
            procedure ImportFile1(FileName: string);
            procedure ImportFile2(FileName: string);
            procedure ImportFile3(FileName: string);
            procedure ImportFile4(FileName: string);
            procedure ImportFile5(FileName: string);
            procedure ImportFile6(FileName: string);
            procedure ImportFile7(FileName: string);
            procedure ProcessRecord1(NewRecordPosition: integer);
            procedure ProcessRecord2(NewRecordPosition: integer);
            procedure ProcessRecord3(NewRecordPosition: integer);
            procedure ProcessRecord4(NewRecordPosition: integer);
            procedure ProcessRecord5(NewRecordPosition: integer);
            procedure ProcessRecord6(NewRecordPosition: integer);
            procedure ProcessRecord7(NewRecordPosition: integer);
            procedure SetRecordNumber(const Value: integer);
            {Wav file operations}
            {Other operations}
            procedure SetScaleFactor(const Value: TSample);
            procedure SetFraming(const Value: TFraming);
            procedure SetOverlappingPercent(const Value: TSample);
            procedure SetOverlappingSamples(const Value: integer);
            procedure SetRecordPosition(const Value: integer);
            procedure SetFrameNumber(const Value: integer);
            procedure SetFramesPerSecond(const Value: TSample);
            procedure SetLoop(const Value: boolean);
            function  SeekRecordNumber: boolean;
            function  SeekRecordPosition(NewRecordPosition: integer): boolean;
            function  SeekDatRecordNumber: boolean;
            function  SeekDatRecordPosition(NewRecordPosition: integer): boolean;
            procedure SetPrecision(const Value: TPrecision);
            procedure SetMaxFrames(const Value: integer);
            procedure SetNumberOfRecords(const Value: integer);
            procedure SetRecordLength(const Value: integer);
            procedure SetRecordTime(const Value: TSample);
            procedure SetRecordTimePosition(const Value: TSample);
            procedure ReadDatHeader;
            function  SeekRecordNumber2: boolean;
            procedure SetOnRecordPositionChange(const Value: TNotifyEvent);
            procedure SetSelectionStop(const Value: integer);
            procedure SetLastFrameCheck(const Value: TLastFrameCheck);
            procedure SetOnProcessAll(const Value: TNotifyEvent);
            function GetFileSize: Int64;
            procedure SetForceLength(const Value: boolean);
            procedure SetSelectionStart(const Value: integer);
         protected
            procedure UpdateSetLength(Sender: TObject); override;
            function InternalUpdate: TPipeState; override;
            procedure ProcessRecord(NewRecordPosition: integer);
            class function EditorClass: string; override;
         public
            {::Returnes the number of samples left to the end of the file
               per channel. It takes in to accout the SelectionStop property.}
            function SamplesLeft: integer;
            {::Returns the size of the file in bytes.}   
            function FileSize: Int64;
            {::Returns true, if the file is open.}
            function FileIsOpen: boolean;
            {::Advances the record position forward in the current record
               and reads the data. The sample count skiped is determined
               with the Length property and OverlappingSamples property.}
            procedure NextFrame;
            {::Moves the record position backward in the current record
               and reads the data. The sample count skiped is determined
               with the Length property and OverlappingSamples property.}
            procedure PrevFrame;
            {::Sets the record position to the start of the current record
               and reads the data. The sample count is determined
               with the Length property and OverlappingSamples property.}
            procedure FirstFrame;
            {::Sets the record position to the start of the last frame of the current record
               and reads the data. The sample count is determined
               with the Length property and OverlappingSamples property.}
            procedure LastFrame;
            {::Open file.}
            procedure OpenFile; virtual;
            {::Close file.}
            procedure CloseFile; override;
            {::Returns true, if the current frame is the last frame.}
            function IsEndOfFile: boolean;
            {::Create the component.}
            constructor Create(AOwner: TComponent); override;
            {::Destroy the component.}
            destructor Destroy; override;
            {::Returns the name of the file format.}
            function FormatTagDescription: string;
            {::Returns the description of the file format.}
            function FormatDescription: string;
         published
            {::The file being read by the component can be of any size,
               but data is being read in blocks of Length samples.
               This property determines how will the last data block
               be handled.}
            property LastFrameCheck: TLastFrameCheck read FLastFrameCheck write SetLastFrameCheck default lfcZeroPadded;

            {::To limit the range of samples in the file being processed
               the SelectionStop can be set to something different then -1.
               If the file ends before the specified SelectionStop
               the processing will not be affected by the value of this property.
               The value of this property affects only the IsEndOfFile method.
               SelectionStop is defined in number of samples. }
            property SelectionStop: integer read FSelectionStop write SetSelectionStop default -1;
            {::To limited the range of samples being processed the SelectionStart can
               be set to something different then 0. SelectionStart is defined in
               number of samples.}
            property SelectionStart: integer read FSelectionStart write SetSelectionStart;
            {::If True, consecutive calls to NextFrame will reset to
               the record position to the first frame, once
               the end of the current record is reached.}
            property Loop: boolean read FLoop write SetLoop default False;
            {::Defines a scale factor to be applied to just read data.}
            property ScaleFactor: TSample read FScaleFactor write SetScaleFactor;
            {::Read only. Returns the number of records contained in the current file.}
            property NumberOfRecords: integer read FNumberOfRecords write SetNumberOfRecords stored False;
            {::Read only. Returns the length of the current record in samples for one channel.}
            property RecordLength: integer read FRecordLength write SetRecordLength stored False;
            {::Read only. Returns the length the current record in seconds for one channel.}
            property RecordTime: TSample read FRecordTime write SetRecordTime stored False;
            {::Set RecordTimePosition in seconds to position the read cursor within the current record.
               Read RecordTimePosition to determine the current position of the read cursor within the current record.
               If the record is multiplexed, the position is defined for one channel.}
            property RecordTimePosition: TSample read FRecordTimePosition write SetRecordTimePosition stored False;
            {::Set RecordPosition in samples to position the read cursor within the current record
               and load Length samples from the Channel.
               Read Recordosition to determine the current position of the read cursor within the current record.
               If the record is multiplexed, the position is defined for sample count per single channel.
               Setting RecordPosition will also open file, if not already open.}
            property RecordPosition: integer read FRecordPosition write SetRecordPosition default 0;
            {::Set RecordNumber to move the read cursor within the file to the record with RecordNumber number.
               Read RecordNumber property to determine the current record number.
               RecordPosition will not change. First record has a number 0.            }
            property RecordNumber: integer read FRecordNumber write SetRecordNumber default 0;
            {::Define the overlapping in percent of consequtive frames when reading the file.}
            property OverlappingPercent: TSample read FOverlappingPercent write SetOverlappingPercent;
            {::Define the overlapping in sampels of consequtive frames when reading the file.}
            property OverlappingSamples: integer read FOverlappingSamples write SetOverlappingSamples default 0;
            {::Read ony. Read the property to determine the maximum number of frames
               within the current record with the current setting of OverlappingSamples property.}
            property MaxFrames: integer read FMaxFrames write SetMaxFrames stored False;
            {::Defines the framing with TFraming type. With each consecutive call to NextFrame,
              you can either move along the same record (increasing RecordPosition) or across all the records
              (increasing RecordNumber).}
            property Framing: TFraming read FFraming write SetFraming default frSingleRecord;
            {::Read only. Returns the number of frames per second when Framing
               property is frSingleRecord. Frames per second depend on the Length
               and overlapp property}
            property FramesPerSecond: TSample read FFramesPerSecond write SetFramesPerSecond stored False;
            {::Set FrameNumber to position the read cursor within the current record.
               Read the property to determine the current frame number (position) within the current record.}
            property FrameNumber: integer read FFrameNumber write SetFrameNumber default 0;
            {::Read the precision of the data being read from the file.}
            property Precision: TPrecision read FPrecision write SetPrecision stored False;
            {::Triggered after RecordPosition changes.}
            property OnRecordPositionChange: TNotifyEvent read FOnRecordPositionChange write SetOnRecordPositionChange;
            {::Event triggered when Process command is selected from
               the drop-down menu in the component editor.}
            property OnProcessAll: TNotifyEvent read FOnProcessAll write SetOnProcessAll;
            {::In case of variable bit rate codecs or codecs whose bit rate is not
               a multiple of 8 bits, the number of samples being read from the file
               can not be always matched with the specified TSignalRead.Length property.
               If ForceLength is True and the value of the Length property can not be
               matched an exception will be raised. The position within the file with
               variable bit rate can be defined only approximately (in steps of 0.1 second
               for example.) When the data blocks are read without explicit changes to the
               RecordPosition, all data blocks are read consequtively without overlapping
               or loosing any samples. (But the Length property will vary between
               consecutive calls.)
               }
            property ForceLength: boolean read FForceLength write SetForceLength default True;
         end;


     {:Writes a signal to a file.
       Use TSignalWrite to write wav, binary and text files
        and provide streaming capabilities.
        The data to be written is connected to the Input property.
        If you would like to save data in the Data property,
        connect the component to itself.}

       TSignalWrite = class(TFileStorage)
         {When saving, save from object connected with input property}
         private
            RecordInitialized: boolean;
            DoInitRecord: boolean;
            DataSize: integer;
            RecordStartOffset: Int64;
            FTotalRecordLength: integer;
            FAppendFile: boolean;
            FRounding: TRounding;
            FRecordNumber: integer;
            FPrecision: TPrecision;
            FAuthorInfo: string;
            procedure SetAppendFile(const Value: boolean);
            procedure SetRounding(const Value: TRounding);
            procedure SetRecordNumber(const Value: integer);
            function  SeekRecordNumber: boolean;
            procedure SetPrecision(const Value: TPrecision);
            procedure SetRecordLength(const Value: integer);
            procedure SetRecordTime(const Value: TSample);
            function GetRecordLength: integer;
            function GetRecordTime: TSample;
            procedure SetTotalRecordLength(const Value: integer);
            procedure SetAuthorInfo(const Value: string);
        protected
            function InternalUpdate: TPipeState; override;
            procedure SaveAscBlock;
        public
            {::Returns true, if the file is open.}
            function FileIsOpen: boolean;
            {::Appends a new record to the file with Filename.
               The file is opened, the Data is appended
               as a single record and the file is closed.}
            procedure AppendRecord;
            {::Initialize a new record. When writing multi-record
               files, call InitRecord each time you want to start
               a new a record. For each InitRecord a call to CloseRecord
               is made first. InitRecord and CloseFile will also call CloseRecord.
               InitRecord does not write data to the file. Instead
               it allocates space for the record header.
               When a call to SaveBlock is made, InitRecord will be called
               automatically, if the record has not yet been initialized.}
            procedure InitRecord;
            {::Call the CloseRecord once the record has been written.
               Usually this method is used in the sequence:
               InitRecord, SaveBlock,..., SaveBlock, CloseRecord.
               InitRecord, SaveBlock,...., SaveBlock,....
               You do not have to call it after a call to InitRecord:
               InitRecord, SaveBlock,..., SaveBlock, InitRecord, SaveBlock,....
               If InitRecord is called and the record is open, CloseRecord
               is called automatically.}
            procedure CloseRecord;
            {::Save Data as a single record to the file.
              Close record does not write any data to the file.}
            procedure SaveRecord;
            {::Save Data to the current record and advance the file
               position. Call CloseRecord at the end of calls
               to update the total length of the record.}
            procedure SaveBlock;
            {::Prepare the file with FileName for writing.}
            procedure SaveFile;
           {::Close the file with FileName. Usually
            the method is used in the call sequence:
            SaveFile, InitRecord,SaveBlock,..., SaveBlock, CloseRecord,
            IniRecord,.....  ,CloseRecord, CloseFile.
            }
            procedure CloseFile; override;
            {::Saves the data connected to the input property
               to the file with FileName. This method cals: SaveFile,
               InitRecord, SaveBlock, CloseRecord, CloseFile.
               Use this method when the data is not streamed.}
            procedure SaveDataToFile(const aFileName: string);
            {::Create the component.}
            constructor Create(AOwner: TComponent); override;
        published
            {::Holds the string added to the header of the saved wav file.}
            property AuthorInfo: string read FAuthorInfo write SetAuthorInfo;
            property Input;
            {::If True, the SaveFile method will set the file cursor
               at the end of the file. Any records written to the file
               will be appended to the existing ones. If the value of the property
               is false, the existing file will be overwritten.}
            property AppendFile: boolean read FAppendFile write SetAppendFile default False;
            {::Define the rounding mode when saving to integer types.}
            property Rounding: TRounding read FRounding write SetRounding default rnTrunc;
            {::Move the position cursor to the beginging of the record number RecordNumber.}
            property RecordNumber: integer read FRecordNumber write SetRecordNumber default 0;
            {::Defines the precision with which the Data will be saved.}
            property Precision: TPrecision read FPrecision write SetPrecision default  {$IFDEF TTDOUBLE} prDouble; {$ELSE} prSingle; {$ENDIF}
            {::Read only. Returns the length in samples of the Data
               written so far in the current record per channel.}
            property RecordLength: integer read GetRecordLength write SetRecordLength stored False;
            {::Read only. Returns the length in seconds of the Data
               written so far in the current record per channel.}
            property RecordTime: TSample read GetRecordTime write SetRecordTime stored False;
            {Read only. Returns the length in seconds of the Data
               written so far in the current record of all channels.
               The value of this property is the same as RecordLength,
               if ChannelCount is 1.}
            property TotalRecordLength: integer read FTotalRecordLength write SetTotalRecordLength stored False;
         end;

      {:Manage a list of TSignalRead components.
        Manage a list of TSignalRead components.}
      TSignalReadList = class(TSignalList)
      private
          function GetItems(index: integer): TSignalRead;
          procedure SetItems(index: integer; const Value: TSignalRead);
      protected
          function  AddItem: TMtxComponent; override;
      public
          {::Add another TSignalRead item to the List.}
          procedure Add; reintroduce;
          {::Close all files specified in Items[i].FileName.}          
          procedure CloseFiles;
          {:@exclude}
          property Items[index: integer]: TSignalRead read GetItems write SetItems;  default;
      end;

     {:Manage a list of TSignalWrite components.
       Manage a list of TSignalWrite components.}
      TSignalWriteList = class(TSignalList)
      private
          function GetItems(index: integer): TSignalWrite;
          procedure SetItems(index: integer; const Value: TSignalWrite);
      protected
          function  AddItem: TMtxComponent; override;
      public
          {::Add another TSignalWrite item to the List.}
          procedure Add; reintroduce;
          {::Close the files with Items[i].FileName.}          
          procedure CloseFiles;
          {::Prepare the files with Items[i].FileName for writing.}
          procedure SaveFiles;
          {:@exclude}
          property Items[index: integer]: TSignalWrite read GetItems write SetItems; default;
      published
          property Inputs;          
      end;

      {:Creates and navigates file overview files.
         Use the component to create peak overview files of much bigger
         signal files. This peak files can be used for quick navigation
         (browsing) through a few hundred MB long files.
         With a smart charting tool, a peak file allows you to
         zoom in on one sample and also zoom out to view
         the entire file without noticing any delays when drawing.
         A typical overview file of a 200 MB long wav file
         is 4 MB long and is created within 5 seconds.
         The component supports threading, so that you can
         interrupt the process running in the background.
         The component also automatically switches between
         the peak and signal file, depending on the amount
         of data that you want to read (presumably for screen display).}

      TSignalBrowse = class(TAnalysis)
      private
          FIncrement: integer;
          FSignalFile: TSignalRead;
          FSpanTime: TSample;
          FPeakFile: TSignalRead;
          FSpanLimit: integer;
          FSpanLength: integer;
          FProgressThread: TMtxProgressDialog;
          SW: TSignalWrite;
          SR: TSignalRead;
          W1, W2: TVec;
          FOnProgressUpdate: TProgressUpdateEvent;
          FThreaded: boolean;
          FData: TVec;
          procedure SetIncrement(const Value: integer);
          procedure SetSpanTime(const Value: TSample);
          procedure DownSampleMultiChannel(Src, Dest: TSignal; W1,W2: TVec);
          procedure SetSpanLimit(const Value: integer);
          procedure SetRecordPosition(const Value: integer);
          function  GetRecordPosition: integer;
          function  GetRecordTimePosition: TSample;
          procedure SetSpanLength(const Value: integer);
          procedure SetRecordTimePosition(const Value: TSample);
          function GetRecordNumber: integer;
          function GetRecordTime: TSample;
          procedure SetRecordNumber(const Value: integer);
          procedure SetRecordTime(const Value: TSample);
          procedure SetOnProgressUpdate(const Value: TProgressUpdateEvent);
          procedure OpenBrowseFiles;
          procedure SetThreaded(const Value: boolean);
          procedure SetData(const Value: TVec);
          function GetChannelCount: integer;
          function GetDt: TSample;
          function GetSamplingFrequency: TSample;
          function GetSamplingTime: TSample;
      protected
          function InternalUpdate: TPipeState; override;
          procedure Notification(AComponent: TComponent; Operation: TOperation); override;
          procedure CreateFileOnCompute(Sender: TObject);
          procedure CreateFileProgressUpdate(Sender: TObject; Event: TMtxProgressEvent);
          procedure DoProgressUpdate(Event: TMtxProgressEvent);
      public
          {::Holds the result of the overview request triggered by setting the RecordPosition.}
          property Data: TVec read FData write SetData;
          {::Get the sample time.}
          property Dt: TSample read GetDt;
          {::Get the sampling time.}
          property SamplingTime: TSample read GetSamplingTime;
          {::Get the number of channels.}
          property ChannelCount: integer read GetChannelCount;
          {::Get the sampling frequency.}
          property SamplingFrequency: TSample read GetSamplingFrequency;
          {::Create browse file from file named AFileAname.
             The extension of the browse file will always be .dat.
             The method will execute in a background thread,
             if threaded parameter is true.}
          procedure CreateBrowseFile(AFileName: string);
          {::Open browse file for the file named AFilename.
             If the browse file does not exist, it will be created.}
          procedure OpenBrowseFile(AFileName: string);
          {::Load the entire file to the Data property.
             If the file length in number of samples per channel
             is bigger then SpanLimit, then load the Peak file,
             otherwise load the original signal file.}
          procedure LoadFullRecord;
          {::Returns True, if the data read by the component comes
             from the overview file.}
           function IsOverview: boolean;
          {::Create component.}
          constructor Create(AOwner: TComponent); override;
          {::Destroy component.}
          destructor Destroy; override;
      published
          {::Set the property to specify position in seconds of the read cursor within the current record.
             Read this property to get the position in seconds of the read cursor within the current record.
             SpanLength samples will be loaded in the Data property. If SpanLength
             is bigger then SpanLimit, the data will be read from the peak file. Otherwise
             it will be read from the signal file. If data will be read from the peak file,
             the amount of samples loaded will cover
             the same time span as SpanLength samples cover in the signal file.}
          property RecordTimePosition: TSample read GetRecordTimePosition write SetRecordTimePosition;
          {::Set the property to specify position in samples of the read cursor within the current record.
             Read this property to get the position in samples of the read cursor within the current record.
             SpanLength samples will be loaded in the Data property. If SpanLength
             is bigger then SpanLimit, the data will be read from the peak file. Otherwise
             it will be read from the signal file. The record sample position always refers to the signal file.
             If data will be read from the peak file, the amount of samples loaded will cover
             the same time span as SpanLength samples cover in the signal file.}
          property RecordPosition: integer read GetRecordPosition write SetRecordPosition;
          {::Defines the pixel downsampling factor for the peak file.
             This parameter is passed to the TVec.PixelDownSample routine.}
          property Increment: integer read FIncrement write SetIncrement;
          {::Defines the maximum number of samples to be streamed from the signal file
             before, the component switches to the peak file. A good default
             value for this property can be calculated as: Increment*Chart.Width*2}
          property SpanLimit: integer read FSpanLimit write SetSpanLimit;
          {::Defines the maximum time in seconds to be streamed from the signal file
             before, the component switches to the peak file.}
          property SpanTime: TSample read FSpanTime write SetSpanTime;
          {::Defines the count of samples to be streamed from the signal file.
             If the data is streamed from the signal file, the value of this
             property is equal to the Length property.}
          property SpanLength: integer read FSpanLength write SetSpanLength;
          {::A pointer to the peak file handling component. The object is owned by Self.}
          property PeakFile: TSignalRead read FPeakFile;
          {::A pointer to the signal file handling component. The object is owned by Self.}
          property SignalFile: TSignalRead read FSignalFile;
          {::A pointer to the thread object. The object is owned by Self.}
          property ProgressThread: TMtxProgressDialog read FProgressThread;
          {::Length of the current record in seconds.}
          property RecordTime: TSample read GetRecordTime write SetRecordTime;
          {::Number of the current record within the signal file in seconds.}
          property RecordNumber: integer read GetRecordNumber write SetRecordNumber;
          {::Thread event triggered when starting, running and stopping the thread.
             The type of the event is passed as a parameter.}
          property OnProgressUpdate: TProgressUpdateEvent read FOnProgressUpdate write SetOnProgressUpdate;
          {::Set it to True, if you want the processing to run within a separate thread.}
          property Threaded: boolean read FThreaded write SetThreaded;
      end;


 {:Manage a list of TSignalBrowse components.
       Manage a list of TSignalBrowse components.}
      TSignalBrowseList = class(TSignalList)
      private
          function GetItems(index: integer): TSignalBrowse;
          procedure SetItems(index: integer; const Value: TSignalBrowse);
      protected
          function  AddItem: TMtxComponent; override;
      public
          {::Add another TSignalBrowse item to the List.}
          procedure Add; reintroduce;
          property Items[index: integer]: TSignalBrowse read GetItems write SetItems; default;
      published
          property Inputs;
      end;

      {:Interface the audio compression manager.
        Audio compression manager is a Windows service for compressing
        and decompressing audio data. }
      TACMConverter = class(TPersistent)
      private
          fSrcLengthBackup: integer;
          StreamHandle: hAcmStream;
          StreamHeader: TAcmStreamHeader;
          SrcData: TVec;
          DstData: TVec;
          FErrorStr: string;
          FSrcByteCount: integer;
          FDstByteCount: integer;
          FInitialByteCount: integer;
          StreamInitialized: boolean;
          HeaderInitialized: boolean;
          procedure SetErrorStr(const Value: string);
          procedure SetDstByteCount(const Value: integer);
          procedure SetSrcByteCount(const Value: integer);
          procedure SetBlockSize(const Value: integer);
          function GetBlockSize: integer;
          procedure SetFinalByteCount(const Value: integer);
          function GetFinalByteCount: integer;
          procedure SetInitialByteCount(const Value: integer);
      public
          SrcFormat: TACMWaveFormat;
          DstFormat: TACMWaveFormat;
          {::Returns the description of the format tag. This is the name
             of the format.}
          function FormatTagDescription(Format: TAcmWaveFormat): string;
          {::Returns the description of the specified Format.}
          function FormatDescription(Format: TACMWaveFormat): string;
          {::Initializes Stream and Header if not already initialized.}
          procedure Initialize;
          {::Initialize stream header.}
          procedure InitializeHeader;
          {::Unprepare stream header.}                  
          procedure HeaderClose;
          {::Open stream.}          
          procedure InitializeStream;
          {::Close stream.}
          procedure StreamClose;
          {::Convert data in SrcFormat stored in SrcData place the result
             in DstFormat in DstData.}
          procedure Convert;
          {::Unprepare stream header and close the stream.}
          procedure Close;
          {::The source format (srcFormat) will be used to determine the uncompressed
             PCM version of the target format (dstFormat), while
             retaining the sampling frequency and number of channels.}
          procedure SuggestPCMFormat;
          {::The routine will test, if it is possible to
             to use a prespecified number of output samples.
             It will return the number of bytes of the output
             buffer.}
          function SuggestSampleCount(Count: integer): boolean;
          {::Suggest the destination format based on the source format. The ChannelCount, SamplingFrequency
             BitCount and FormatTag are flags that have to be set to True to be preserved.
             The function returns True if a suitable format has been found. The resulting
             format is placed in DstFormat.}
          function SuggestFormat(ChannelCount, SamplingFrequency, BitCount, FormatTag: boolean): boolean;          
          {::Create the object}
          constructor Create; virtual;
          {:@exclude}
          destructor Destroy; override;
          {::The size of the source buffer in bytes.}
          property SrcByteCount: integer read FSrcByteCount write SetSrcByteCount;
          {::The size of the destination buffer in bytes.}
          property DstByteCount: integer read FDstByteCount write SetDstByteCount;
          {::Description of any error that migth have happend.}
          property ErrorStr: string read FErrorStr write SetErrorStr;
          {::The size of of smallest data block of the source buffer in bytes.
          This block size determines the minimum step by which the cursor can
          move within the file and only integer multiples of the BlockSize can be
          read from the file. This is because only integer multiples of BlockSize
          can be processed by the codec. The source buffer will always be
          an integer multiple of BlockSize in size. The property is read-only.}
          property BlockSize: integer read GetBlockSize write SetBlockSize;
          {::The number of processed bytes can be different from the
             DstByteCount (the size of the destination buffer.}
          property FinalByteCount: integer read GetFinalByteCount write SetFinalByteCount;
          {::The number of bytes to be processed can be different from the
             DstByteCount (the size of the destination buffer.
             It can also happen, that not all bytes placed in the source buffer
             are processed.}
          property InitialByteCount: integer read FInitialByteCount write SetInitialByteCount;
      end;

{:Drop down file types string.
  A string to be assigned to the Filter property
  of the TFileOpen or TFileSave dialog.}
var  SignalDialogFilter: string =
             'Binary multi precision records (*.dat)|*.dat|' +
             'Multi record ASCII (*.sgl)|*.sgl|' +
             'Binary single precision records (*.bin)|*.bin|' +
             'Binary double precision records (*.dbn)|*.dbn|' +
             'Single column ASCII (*.sfs)|*.sfs|'+
             'Two column ASCII (*.asc)|*.asc|'+
             'Windows PCM (*.wav)|*.wav|'+
             'All files (*.*)|*.*';

{TReadSignal:

 - Specify Length property.

 ImportFile:

  - Open file
  - set NumberOfRecords
  - set RecordNumber to 0 (first)

  SetRecordNumber

  - set ChannelCount
  - set Complex
  - set Precision
  - set SamplingTime
  - set RecordPosition to 0
  - set RecordTime
  - set RecordLength

 ProcessRecord:

  - move in the current record to RecordPosition
  - load data in amount of Self.Length }

implementation

uses SignalUtils, AbstractMtxVec;

const

    FOURCC_WAVE = $45564157;
    FOURCC_FMT_ = $20746D66;
    FOURCC_DATA = $61746164;

{ TSignalRead }

function TSignalRead.GetFileSize: Int64;
var af: TFileStream;
begin
     af := TFileStream.Create(FileName, fmOpenRead OR fmShareDenyWrite);
     try
         Result := af.Size;
     finally
         af.Destroy;
     end;
end;

procedure TSignalRead.ImportFile2(FileName: string);
begin    {text file, double precision, multi record, single channel, no block mode}
    Strings.Clear;
    Strings.LoadFromFile(FileName);
    fNumberOfRecords := Strings.Count div 3;
    fFileSize := GetFileSize;
    Framing := fFraming;    
end;

function TSignalRead.SeekRecordNumber2: boolean;
var a: TMtx;  {'.sgl'}
    StringRow: integer;
begin  {RecordNumber is considered zero based}
    if Strings.Count = 0 then Eraise(FileName + ': Strings.Count = 0!');
    MtxVec.CreateIt(a);
    try
        StringRow := RecordNumber*3+2;
        a.Size(1,StrToInt(Strings[RecordNumber*3]),False);
        a.StringsToValues(Strings, StringRow, 1, 0,0, ';');
        LoadedData.Copy(a);
        Complex := LoadedData.Complex;
        fRecordTime := StrToFloat(Strings[RecordNumber*3+1]);
        fRecordLength := LoadedData.Length;
        fRecordPosition := 0;
        fFilePosition := 0;
        fRecordTimePosition := 0;
        ChannelCount := 1;
        fPrecision := prDouble;
        SamplingFrequency := RecordLength/RecordTime;
        Result := True;
    finally
        MtxVec.FreeIt(a);
    end;
end;

procedure TSignalRead.ProcessRecord2(NewRecordPosition: integer);
var Len:integer;
begin                  {RecordNumber is considered zero based}
     if Length = 0 then Exit;
     Len := RecordLength-NewRecordPosition;
     Len := EnsureRange(0,Len,Data.Length);
     Data.Copy(LoadedData,NewRecordPosition,0,Min(Data.Length,Len));
     Data.SetZero(Len, Data.Length - Len);
     SamplingFrequency := fRecordLength/fRecordTime;
     fRecordPosition := NewRecordPosition;
     fRecordTimePosition := fRecordPosition/fRecordLength*fRecordTime;
end;

function TSignalRead.SeekRecordNumber: boolean;
var i,j: integer;
    a1: single;
begin
     If PrevRecordNumber = RecordNumber then
     begin
          Result := True;
          Exit;
     end;
     fFilePosition := 0;
     fRecordPosition := 0;
     fRecordTimePosition := 0;

     FileStream.Position := 0;
     FileStream.Read(j,4);
     i := 0;
     while (j > 0) and (i <> RecordNumber) do
     begin
          Inc(i);
          FileStream.Seek((j+1)*DataSize,soFromCurrent);
          FileStream.Read(j,4);
     end;
     Result := (i = (RecordNumber));
     If Result then
     begin
           {Already set by ImportFile: Complex, ChannelCount, Precision}
          case DataSize of
          4: begin
             FileStream.Read(a1, DataSize);
             fRecordTime := a1;
             end;
          8: FileStream.Read(fRecordTime, DataSize);
          end;
          fRecordLength := j;
     end else
     begin
          fRecordTime := 0;
          fRecordLength := 0;
     end;
     SamplingTime := Length/RecordLength*RecordTime;
     fFilePosition := 0;
     fRecordPosition := 0;
     fRecordTimePosition := 0;
     PrevRecordNumber := RecordNumber;

{ (Set in SeekRecord)

  - set SamplingTime Ok
  - set RecordPosition to 0 Ok
  - set RecordTime            Ok  //has only one channel
  - set RecordLength          Ok  }
end;

function TSignalRead.SeekDatRecordNumber: boolean;
var i,j: integer;
begin
     If PrevRecordNumber = RecordNumber then
     begin
          Result := True;
          Exit;
     end;
     FileStream.Position := 0;
     FileStream.Read(j,4);
     i := 0;
     while (j > 0) and (i <> RecordNumber) do
     begin
          Inc(i);
          ReadDatHeader;
          FileStream.Seek(j*SizeOfPrecision(Precision,Complex),soFromCurrent);
          FileStream.Read(j,4);
     end;
     Result := (i = (RecordNumber));
     If Result then
     begin
          ReadDatHeader;   {Sets: Precision, ChannelCount, Complex,  SamplingFrequency}
          fRecordLength := j div ChannelCount;
          fRecordTime := FRecordLength/SamplingFrequency;
     end else
     begin
          fRecordTime := 0;
          fRecordLength :=0;
     end;
     fFilePosition := 0;
     fRecordPosition := 0;
     fRecordTimePosition := 0;
     PrevRecordNumber := RecordNumber;
end;

function TSignalRead.SeekRecordPosition(NewRecordPosition: integer): boolean;
begin
     NewRecordPosition := EnsureRange(0,NewRecordPosition,RecordLength-1);
     FileStream.Seek((NewRecordPosition - FFilePosition)*DataSize,soFromCurrent);
     fRecordPosition := NewRecordPosition;
     fRecordTimePosition := RecordPosition/fRecordLength*fRecordTime;
     Result := True;
end;

function TSignalRead.SeekDatRecordPosition(NewRecordPosition: integer): boolean;
begin
     NewRecordPosition := EnsureRange(0,NewRecordPosition,RecordLength-1);
     FileStream.Seek((NewRecordPosition - FFilePosition)*SizeOfPrecision(Precision,Complex)*ChannelCount,soFromCurrent);
     fRecordPosition := NewRecordPosition;
     fRecordTimePosition := RecordPosition/fRecordLength*fRecordTime;
     Result := True;
end;

procedure TSignalRead.ProcessRecord1(NewRecordPosition: integer);
var i: integer;  {'.dat'}
begin        {RecordNumber is considered zero based}
       if Length = 0 then Exit;      
       SeekDatRecordPosition(NewRecordPosition);
       if Length > ((RecordLength - RecordPosition)*ChannelCount) then
       begin
           i := Length;
           Length := (RecordLength - RecordPosition)*ChannelCount;
           Data.ReadValues(FileStream, Precision);
           FFilePosition := FRecordPosition + (Length div ChannelCount);
           Data.Resize(i,True);
       end else
       begin
           Data.ReadValues(FileStream, Precision);
           FFilePosition := FRecordPosition + (Length div ChannelCount);
       end;
       SamplingFrequency := RecordLength/RecordTime;
end;

procedure TSignalRead.ProcessRecord3(NewRecordPosition: integer);
var i: integer;  {'.bin'}
begin        {RecordNumber is considered zero based}
       if Length = 0 then Exit;
       SeekRecordPosition(NewRecordPosition);
       if Length > (RecordLength - RecordPosition) then
       begin
           i := Length;
           Length := RecordLength - RecordPosition;
           Data.ReadValues(FileStream, prSingle);
           Data.Resize(i,True);
       end else Data.ReadValues(FileStream, prSingle);
       FFilePosition := FRecordPosition + Length;
       SamplingFrequency := RecordLength/RecordTime;
end;

procedure TSignalRead.ProcessRecord7(NewRecordPosition: integer);
var i: integer;  {'.dbn'}
begin        {RecordNumber is considered zero based}
       if Length = 0 then Exit;
       SeekRecordNumber;
       SeekRecordPosition(NewRecordPosition);
       if Length > (RecordLength - RecordPosition) then
       begin
           i := Length;
           Length := RecordLength - RecordPosition;
           Data.ReadValues(FileStream, prDouble);
           Data.Resize(i,True);
       end else Data.ReadValues(FileStream, prDouble);
       FFilePosition := FRecordPosition + Length;
       SamplingFrequency := RecordLength/RecordTime;
end;

procedure TSignalRead.ProcessRecord5(NewRecordPosition: integer);
var Len:integer;       {Same as processrecord6}
begin                  {RecordNumber is considered zero based}
     if Length = 0 then Exit;
     if NewRecordPosition >= RecordLength then Data.SetZero else
     begin
         Len := RecordLength - NewRecordPosition;
         Len := EnsureRange(0,Len,Data.Length);
         Data.Copy(LoadedData,NewRecordPosition,0,Min(Data.Length,Len));
         Data.SetZero(Len, Data.Length - Len);
     end;
     SamplingFrequency := fRecordLength/fRecordTime;
     fRecordPosition := NewRecordPosition;
     fRecordTimePosition := fRecordPosition/fRecordLength*fRecordTime;
     fRecordNumber := 0;
end;

procedure TSignalRead.ProcessRecord6(NewRecordPosition: integer);
var Len:integer;        {Same as processrecord5}
begin                  {RecordNumber is considered zero based}
     if Length = 0 then Exit;
     Len := RecordLength-NewRecordPosition;
     Len := EnsureRange(0,Len,Data.Length);
     Data.Copy(LoadedData,NewRecordPosition,0,Min(Data.Length,Len));
     Data.SetZero(Len, Data.Length - Len);
     SamplingFrequency := fRecordLength/fRecordTime;
     fRecordPosition := NewRecordPosition;
     fRecordTimePosition := fRecordPosition/fRecordLength*fRecordTime;
     fRecordNumber := 0;
end;

procedure TSignalRead.ProcessRecord(NewRecordPosition: integer);
begin
       if not Active then Exit;
//       if Length = 0 then Exit;
       if not FileReady then
       begin
           if FileExists(FileName) then OpenFile else Exit;
       end;
       case FileFormat of
       ffdat: ProcessRecord1(NewRecordPosition);
       ffsgl: ProcessRecord2(NewRecordPosition);
       ffbin: ProcessRecord3(NewRecordPosition);
       ffwav: ProcessRecord4(NewRecordPosition);
       ffsfs: ProcessRecord5(NewRecordPosition);
       ffasc: ProcessRecord6(NewRecordPosition);
       ffdbn: ProcessRecord7(NewRecordPosition);
       end;
       Data.Scale(ScaleFactor);
       if Assigned(FOnRecordPositionChange) then OnRecordPositionChange(Self);
end;

constructor TFileStorage.Create(AOwner: TComponent);
begin
     inherited Create(AOwner);
     FFileName := '';
     FileStream := nil;
     FileReady := False;
     FFileFormat := ffDat;
     FAutoFileFormat := True;
     Strings := TStringList.Create;
end;

constructor TSignalRead.Create(AOwner: TComponent);
begin
     inherited Create(AOwner);
     acm := TACMConverter.Create;
     fRecordTime := 0;
     fRecordLength := 0;
     fRecordNumber := 0;
     fScaleFactor := 1;
     PrevRecordNumber := 0;
     fLoop := False;
     UsesInputs := False;
     LoadedData := TVec.Create;
     fLastFrameCheck := lfcZeroPadded;
     fSelectionStop  := -1;
     fForceLength := True;
end;

procedure TSignalRead.OpenFile;
begin
     CloseFile;
     ChannelCount := 1;
     If not FileExists(FileName) then Eraise('File not found: ' + FileName);
     try
         case FileFormat of
         ffdat: ImportFile1(FileName);
         ffsgl: ImportFile2(FileName);
         ffbin: ImportFile3(FileName);
         ffwav: ImportFile4(FileName);
         ffsfs: ImportFile5(FileName);
         ffasc: ImportFile6(FileName);
         ffdbn: ImportFile7(FileName);
         end;
         FileReady := True;
         RecordNumber := 0;
     except
         CloseFile;
     end;
end;

procedure TSignalRead.ReadDatHeader;
var i: integer;
    ST: double;
begin
      if Assigned(FileStream) then
      begin
          FileStream.Read(ST, SizeOf(Double));
          FileStream.Read(i, SizeOf(Integer));
          FPrecision := TPrecision(i);
          FileStream.Read(i, SizeOf(Integer));
          Complex := Boolean(i);
          FileStream.Read(i, SizeOf(Integer));
          ChannelCount := i;
      end;
      SamplingFrequency := ST;
end;

procedure TSignalRead.ImportFile1(FileName: string);
var j,i: integer;
begin    {.dat}    {multi-precision, multi-record, multi-channel}
     FileStream.Free;
     Filestream := TFileStream.Create(FileName, fmOpenRead OR fmShareDenyWrite);
     FFileSize := FileStream.Size;
     fNumberOfRecords := 0;
     j := FileStream.Read(i,4);
     while  j > 0 do  {The loop needed for record counting}
     begin
           Inc(fNumberOfRecords);
           ReadDatHeader;
           FileStream.Seek(i*SizeOfPrecision(Precision,Complex),soFromCurrent);
           j := FileStream.Read(i,4);
     end;
     PrevRecordNumber := -1;
     fRecordNumber := -1;
     Framing := fFraming;
     Strings.Clear;
end;

procedure TSignalRead.ImportFile3(FileName: string);
var j,i : integer;
begin    {.bin}    {single precision, multi record, single channel, block mode support}
     FileStream.Free;
     Filestream := TFileStream.Create(FileName, fmOpenRead OR fmShareDenyWrite);
     fFileSize := FileStream.Size;
     fNumberOfRecords := 0;
     j := FileStream.Read(i,4);
     while  j > 0 do
     begin
           Inc(fNumberOfRecords);
           FileStream.Seek(i*SizeOf(single)+ SizeOf(single),soFromCurrent);
           j := FileStream.Read(i,4);
     end;
     DataSize := SizeOf(Single);
     fPrecision := prSingle;
     ChannelCount := 1;
     Complex := False;
     fRecordNumber := -1;
     PrevRecordNumber := -1;
     Framing := fFraming;
     Strings.Clear;

{  - set ChannelCount Ok
  - set Complex  Ok
  - set Precision Ok
  - set NumberOfRecords Ok}

end;


procedure TSignalRead.ImportFile7(FileName: string);
var j,i: integer;
begin     {.dbn}  {double precision, multi record, single channel, block mode support}
     FileStream.Free;
     FileStream := TFileStream.Create(FileName, fmOpenRead OR fmShareDenyWrite);
     fFileSize := FileStream.Size;
     fNumberOfRecords := 0;
     j := FileStream.Read(i,4);
     while  j > 0 do
     begin
           Inc(fNumberOfRecords);
           FileStream.Seek((j+1)*SizeOf(Double),soFromCurrent);
           j := FileStream.Read(i,4);
     end;
     ChannelCount := 1;
     DataSize := SizeOf(Double);
     fPrecision := prDouble;
     Complex := False;
     fRecordNumber := -1;
     PrevRecordNumber := -1;
     Framing := fFraming;     
     Strings.Clear;

{  - set ChannelCount Ok
  - set Complex  Ok
  - set Precision Ok
  - set NumberOfRecods Ok}
end;


procedure TSignalRead.SetScaleFactor(const Value: TSample);
begin
 if Value = 0 then FScaleFactor := 1 else fScaleFactor := Value;
end;

procedure TSignalRead.SetFraming(const Value: TFraming);
var Len: integer;
    ATime: TSample;
begin
  FFraming := Value;
  Len := Length div ChannelCount;
  if Length = 0 then Exit;
  case fFraming of
  frSingleRecord:      if SelectionStop <= 0 then
                       begin
                           fMaxFrames := Trunc((fRecordLength-Len)/(Len*(1-FOverlappingPercent*0.01)));
                           if RecordTime > 0 then fFramesPerSecond := fMaxFrames/fRecordTime;
                           fFrameNumber := Trunc(fRecordPosition/((1-FOverlappingPercent*0.01)*Len));
                       end else
                       begin
                           fMaxFrames := Trunc((fSelectionStop-Len)/(Len*(1-FOverlappingPercent*0.01)));
                           ATime := fSelectionStop/SamplingFrequency;
                           if RecordTime > 0 then fFramesPerSecond := fMaxFrames/ATime;
                           fFrameNumber := Trunc(fRecordPosition/((1-FOverlappingPercent*0.01)*Len));
                       end;
  frAcrossAllRecords:  begin
                           fMaxFrames := fNumberOfRecords;
                           fFramesPerSecond := 1;
                           fFrameNumber := fRecordNumber;
                       end;
  end;
end;

procedure TSignalRead.SetOverlappingPercent(const Value: TSample);
begin
  FOverlappingPercent := Min(Value,100);
  FOverlappingSamples := Round((Length div ChannelCount)*FOverlappingPercent*0.01);
  Framing := fFraming;
end;

procedure TSignalRead.SetOverlappingSamples(const Value: integer);
begin
  FOverlappingSamples := Value;
  if Length > 0 then FOverlappingPercent := Min(FOverlappingSamples/(Length div ChannelCount),1)*100;
  Framing := fFraming;
end;

procedure TSignalRead.SetFrameNumber(const Value: integer);
begin
  FFrameNumber := Value;
  RecordPosition := Trunc(Value*(1-FOverlappingPercent*0.01)*(Length div ChannelCount));
end;

procedure TSignalRead.SetFramesPerSecond(const Value: TSample);
begin
  {   FFramesPerSecond := Value;
     if (Value > 0) and (SamplingTime > 0) then OverlappingPercent := (1-1/(Value*SamplingTime))*100;}
end;


procedure TSignalRead.SetRecordPosition(const Value: integer);
begin
   if not (csLoading in ComponentState) then ProcessRecord(Max(Value,0));
   Framing := fFraming;
end;

procedure TSignalRead.ImportFile4(FileName: string);
var  RiffCK :TMMCKINFO;
     Ck :TMMCKINFO;
begin                                      {.wav}
      if FIOHandle <> 0 then
      begin
          acm.Close;      
          mmioClose( FIOHandle, 0 );
          FIOHandle := 0;
      end;

      FIOHandle := mmioOpen(PChar(FileName), nil, MMIO_READ OR MMIO_COMPAT OR MMIO_ALLOCBUF);
      if FIOHandle = 0 then ERaise('Error opening audio file!');
      RiffCk := GetRiffChunk(FOURCC_WAVE);
      Ck := GetChunks(FOURCC_FMT_, RiffCK);     {Set extract format}
      GetData(Ck, acm.SrcFormat);                  {Get format}
      DataCk := GetChunks(FOURCC_DATA, RiffCk); {Set Extract data}

      acm.SuggestPcmFormat;  //get from SrcFormat to DstFormat


      WaveFormat := acm.DstFormat;  //copy DstFormat
      ChannelCount := WaveFormat.Format.Format.nChannels;
      //this can be an approximate value:
      fRecordTime := Integer(DataCk.CkSize)/acm.SrcFormat.Format.Format.nAvgBytesPerSec;
      fRecordLength :=  Round(fRecordTime*acm.SrcFormat.Format.Format.nSamplesPerSec);
      //but in case of fixed bitrate, it will be accurate

      case WaveFormat.Format.Format.wBitsPerSample of
      8:   fPrecision := prByte;
      16:  fPrecision := prSmallInt;
      24:  fPrecision := prInt24;
      32:  begin
           fPrecision := prInteger;  //for Wave_Format_Pcm
           if WaveFormat.Format.Format.wFormatTag = WAVE_FORMAT_EXTENSIBLE then
           begin
               if CompareMem(@WaveFormat.Format.SubFormat, @KSDATAFORMAT_SUBTYPE_IEEE_FLOAT,SizeOf(TGUID)) then
                  fPrecision := prSingle;
               if CompareMem(@WaveFormat.Format.SubFormat, @KSDATAFORMAT_SUBTYPE_PCM,SizeOf(TGUID)) then
                  fPrecision := prInteger;
           end;
           if WaveFormat.Format.Format.wFormatTag = WAVE_FORMAT_IEEE_FLOAT then
              fPrecision := prSingle;
           end;
      end;

      Complex := False;
      SamplingFrequency := WaveFormat.Format.Format.nSamplesPerSec;
      FFilePosition := 0;
      fRecordPosition := 0;
      fRecordNumber := 0;
      PrevRecordNumber := 0;
      fNumberOfRecords := 1;
      Framing := fFraming;
      fFileSize := RiffCk.Cksize + 8; //+8 is a guess
end;

procedure TSignalRead.ImportFile5(FileName: string);
begin
     Strings.Clear;     {Set all parameters here already, because there is only record}
     Strings.LoadFromFile(FileName);   {.sfs}
     LoadedData.Length := StrToInt(Strings[0]);
     LoadedData.StringsToValues(Strings,3,0,LoadedData.Length);
     fNumberOfRecords := 1;
     fRecordTime := StrToVal(Strings[1]);
     fRecordLength := LoadedData.Length;
     FFilePosition := 0;
     fRecordPosition := 0;
     fRecordTimePosition := 0;
     ChannelCount := 1;
     fPrecision := prDouble;
     Complex := LoadedData.Complex;
     SamplingFrequency := fRecordLength/fRecordTime;
     Framing := fFraming;
     Strings.Clear;
     fFileSize := GetFileSize;
end;

procedure TSignalRead.ImportFile6(FileName: string);
var i,j: integer;
    CurrentDelimiter: string;
begin
     Strings.Clear;     {Set all parameters here already, because there is only one record}
     Strings.LoadFromFile(FileName);   {.asc}
     if Pos(Chr(9),Strings[0]) > 0 then CurrentDelimiter := Chr(9) else
     if Pos(' ', Strings[0]) > 0 then CurrentDelimiter := ' ' else
     ERaise('Delimiter for .asc must be tab or space!');
     i := 1;
     j := 1;
     SamplingFrequency := 1/(ExtractSample(Strings[1],i,CurrentDelimiter)
                           - ExtractSample(Strings[0],j,CurrentDelimiter));
     for i := 0 to Strings.Count-1 do
     begin {Loose the first column and the first delimiter}
          j := Pos(CurrentDelimiter,Strings[i]);
          Strings[i] := system.Copy(Strings[i],j+1,System.Length(Strings[i])-j);
     end;
     LoadedData.Length := Strings.Count;
     LoadedData.StringsToValues(Strings);
     fNumberOfRecords := 1;
     fRecordLength := LoadedData.Length;
     fRecordTime := RecordLength/SamplingFrequency;
     FFilePosition := 0;
     fRecordPosition := 0;
     fRecordTimePosition := 0;
     ChannelCount := 1;
     fPrecision := prDouble;
     Complex := LoadedData.Complex;
     Framing := fFraming;     
     Strings.Clear;
     fFileSize := GetFileSize;
end;

procedure TSignalRead.SetRecordNumber(const Value: integer);
var Located: boolean;
begin
    if not FileReady then Exit;
    if RecordNumber = Value then Exit;
    FRecordNumber := EnsureRange(0,Value,FNumberOfRecords-1);
    Located := False;
    case FileFormat of
    ffdat: Located := SeekDatRecordNumber; //
    ffsgl: Located := SeekRecordNumber2;     //
    ffbin: Located := SeekRecordNumber;        //
    ffwav: Located := (FRecordNumber = 0);  {has only one record}
    ffsfs: Located := (FRecordNumber = 0);  {has only one record}
    ffasc: Located := (FRecordNumber = 0);     {has only one record}
    ffdbn: Located := SeekRecordNumber;          //
    end;
    if not Located then ERaise('Record number: ' + IntToStr(RecordNumber) + ' not found!');
end;

procedure TSignalRead.ProcessRecord4(NewRecordPosition: integer);
var SamplesRead, i,Bits,Position, BlockCount: integer; {*.wav}
begin {Load stereo signals as if it would be mono}
    try
        fRecordPosition := NewRecordPosition;
        fRecordTimePosition := RecordPosition/fRecordLength*fRecordTime;

        if ForceLength then
        begin
             if not acm.SuggestSampleCount(Length)then ERaise('The suggested Length of the data block can not be used '+
                               'with the current audio format!');
        end else
        begin
             acm.SuggestSampleCount(-1);
        end;

        BlockCount := Round(fRecordPosition/FRecordLength*DataCk.ckSize    /acm.BlockSize);
        Position := BlockCount*acm.BlockSize;
        SeekSource(EnsureRange(0,Position,Integer(DataCk.CkSize)) + Integer(DataCK.dwDataOffset));
        if acm.SrcByteCount > 0 then
        begin
             Bits := acm.DstFormat.Format.Format.wBitsPerSample;
             i := mmioRead(FIOHandle, PAPointer(acm.SrcData.PValues1D(0)), acm.SrcByteCount);
             if i < 0 then ERaise('Unable to read the file: mmioRead error!');
             acm.InitialByteCount := (i div acm.BlockSize)*acm.BlockSize;  //define number of read samples and make sure they are block aligned.
             acm.Convert;
             SamplesRead := acm.FinalByteCount div (Bits div 8);
             //if not end of file, try to keep Length fixed
             if i < acm.SrcByteCount then
             begin  //found end of file.
                    if ForceLength then Length := Max(Length,SamplesRead)
                                   else Length := SamplesRead;
             end else Length := SamplesRead;

             ReadBinaryValues(acm.DstData.PValues1D(0),Data.PValues1D(0),fPrecision, SamplesRead,false);
             if fPrecision = prByte then Data.Offset(-128);
             //if it was end of file:
             if SamplesRead < Length then Data.SetZero(SamplesRead,Length-SamplesRead);
        end;
        //There is a small chance that new FRecordPosition will not
        //advance the RecordPosition enough to ensure new block.

        if WavStreaming then
        begin //if BlockSize is not to small, this wlll work.
            Position := Position + acm.SrcByteCount;
            FRecordPosition := Round(Position/DataCk.CkSize*fRecordLength);
        end;

    except
        on E: Exception do
        begin
            CloseFile;
            ERaise('Error reading audio file: ' + E.Message);
        end;
    end;
end;

function TSignalRead.FileIsOpen: boolean;
begin
     Result := FileReady;
end;

procedure TSignalRead.CloseFile;
begin
     if FIOHandle <> 0 then
     begin
          mmioClose(FIOHandle, 0);
          FIOHandle := 0;
     end;
     if Assigned(acm) then acm.Close;
     if Assigned(FileStream) then FreeAndNil(FileStream);
     FFileSize := 0;
     FRecordPosition := 0;
     FFilePosition := 0;
     FileReady := False;
end;

procedure TSignalRead.LastFrame;
begin
     if not FileReady then OpenFile;
     RecordPosition := fRecordLength - (Length div ChannelCount);
     fRecordPosition := fRecordLength;
end;

procedure TSignalRead.NextFrame;
begin
     if not FileReady then OpenFile;
     if (FileFormat = ffWav) and (fOverlappingSamples = 0) then 
     begin
         WavStreaming := True;
         RecordPosition := fRecordPosition;
         WavStreaming := False;
     end else
     begin
         RecordPosition := fRecordPosition;
         fRecordPosition := fRecordPosition + ((Length div ChannelCount) - fOverlappingSamples);
     end;
end;

procedure TSignalRead.PrevFrame;
begin
     if not FileReady then OpenFile;
     RecordPosition := fRecordPosition;
     fRecordPosition := Max(0,fRecordPosition - ((Length div ChannelCount) - fOverlappingSamples));
end;

procedure TSignalRead.FirstFrame;
begin
     if not FileReady then OpenFile;
     RecordPosition := FSelectionStart;
     fRecordPosition := (Length div ChannelCount) - fOverlappingSamples;
end;

function TSignalRead.SamplesLeft: integer;
var FinalCount: integer;
begin
     if SelectionStop >= 0 then FinalCount := Min(fSelectionStop,fRecordLength)
                          else FinalCount := fRecordLength;
     SamplesLeft := FinalCount-FRecordPosition; //number of samples to be read
end;

function TSignalRead.IsEndOfFile: boolean;
var SamplesCount: integer;
begin
     Result := False;
     SamplesCount := Length div ChannelCount;
     case LastFrameCheck of
     lfcZeroPadded:     Result := (SamplesLeft <= 0);
     lfcLastFullBlock:  Result := (SamplesLeft < SamplesCount);
     lfcAdjustLength:   Result := (SamplesLeft <= 0);
     end;
end;

function TSignalRead.InternalUpdate: TPipeState;
var Len: integer;
begin
   Result := pipeOK;
   if Continuous then
   begin
       if Loop then
       begin
            if IsEndOfFile then FirstFrame else NextFrame;
       end else
       begin
            if not IsEndOfFile then
            begin
                  if (LastFrameCheck = lfcAdjustLength) then
                  begin
                       Len := SamplesLeft;
                       if CheckRange(1,Len, (Length div ChannelCount)-1) then Length := Len;
                  end;
                  NextFrame;
             end else
             begin
                 // CloseFile;       {Dont close the file because of SelectionStop}
                  Result := pipeEnd;
             end;
       end;
   end else
   begin
       RecordPosition := fRecordPosition;
   end;
end;

procedure TSignalRead.SetLoop(const Value: boolean);
begin
  FLoop := Value;
end;

procedure TSignalRead.SetPrecision(const Value: TPrecision);
begin
// read only
end;

procedure TSignalRead.SetMaxFrames(const Value: integer);
begin
//  FMaxFrames := Value;
end;

procedure TSignalRead.SetNumberOfRecords(const Value: integer);
begin
//  FNumberOfRecords := Value;
end;

procedure TSignalRead.SetRecordLength(const Value: integer);
begin
//  FRecordLength := Value;
end;

procedure TSignalRead.SetRecordTime(const Value: TSample);
begin
//  FRecordTime := Value;
end;

procedure TSignalRead.SetRecordTimePosition(const Value: TSample);
begin
    if FRecordTime > 0 then
    RecordPosition := Round(FRecordLength/FRecordTime*Value)
    else RecordPosition := 0;
end;

destructor TSignalRead.Destroy;
begin
  FreeAndNil(acm);
  FreeAndNil(LoadedData);
  inherited;
end;

procedure TSignalRead.SetOnRecordPositionChange(const Value: TNotifyEvent);
begin
  FOnRecordPositionChange := Value;
end;

procedure TSignalRead.UpdateSetLength(Sender: TObject);
begin
  inherited;
  OverlappingPercent := FOverlappingPercent;
//  Framing := FFraming;
 // RecordPosition := FRecordPosition; //Reloading should not be done, because we might end in a dead lock.
end;

procedure TSignalRead.SetSelectionStop(const Value: integer);
begin
  if Value <> FSelectionStop then
  begin
       FSelectionStop := Value;
       Framing := FFraming;
  end;
end;

procedure TSignalRead.SetLastFrameCheck(const Value: TLastFrameCheck);
begin
  FLastFrameCheck := Value;
end;

procedure TSignalRead.SetOnProcessAll(const Value: TNotifyEvent);
begin
  FOnProcessAll := Value;
end;

class function TSignalRead.EditorClass: string;
begin
     Result := 'TFileReadDialogForm';
end;

function TSignalRead.FileSize: Int64;
begin
     Result := FFileSize;
end;

procedure TSignalRead.SetForceLength(const Value: boolean);
begin
  FForceLength := Value;
end;

procedure TSignalRead.SetSelectionStart(const Value: integer);
begin
  FSelectionStart := Value;
end;

{ TFileStorage }

procedure TFileStorage.SeekSource( P :Integer );
begin
  if mmioSeek(FIOHandle, P, SEEK_SET) = -1
    then ERaise('Seek Error');
end;

procedure TFileStorage.SetFileName(const Value: TFileName);
var Extension: string;
begin
  if (Value <> FFileName) then
  begin
      if FileReady then CloseFile;
      if FAutoFileFormat and (Value <> '') then
      begin
          Extension := ExtractFileExt(LowerCase(Value));
          if Extension = '.dat' then FFileFormat := ffDat else
          if Extension = '.sgl' then FFileFormat := ffSgl else
          if Extension = '.bin' then FFileFormat := ffBin else
          if Extension = '.wav' then FFileFormat := ffWav else
          if Extension = '.sfs' then FFileFormat := ffSfs else
          if Extension = '.asc' then FFileFormat := ffAsc else
          if Extension = '.dbn' then FFileFormat := ffDbn else
             ERaise('Unknown file file format extension: ' + Extension);
      end;
      FileReady := False;
      FFileName := Value;
  end;
end;

procedure TFileStorage.FindChunk(Ck, ParentCk :PMMCKINFO; Flags :Integer );
var i: integer;
begin
  i := mmioDescend( FIOHandle, Ck, ParentCk, Flags );
  if i <> MMSYSERR_NOERROR  then Eraise('Error in mmIoDescend!');
end;

function TFileStorage.GetRiffChunk(CkType :FOURCC ) :TMMCKINFO;
begin
  SeekSource( 0 );
  FillChar(Result, Sizeof(Result ), 0);
  With Result do begin
       ckID := FOURCC_RIFF;
       fccType := CkType;
  end;
  FindChunk(@result, nil, MMIO_FINDRIFF);
end;

function TFileStorage.GetChunks(ChunkName :FOURCC; ParentChunk :TMMCKINFO ):TMMCKINFO;
begin
     SeekSource(ParentChunk.dwDataOffset + 4 );
     Fillchar(Result, SizeOf( result ), 0);
     Result.ckID := ChunkName;
     FindChunk(@Result, @ParentChunk, MMIO_FINDCHUNK );
end;

function TFileStorage.GetData(Ck :TMMCKINFO; var Format: TACMWaveFormat) :Integer;
var i: integer;
begin
    SeekSource(Ck.dwDataOffset);
    if ck.cksize > SizeOf(TACMWaveFormat) then
    begin
         i := ck.ckSize;
         ck.cksize := SizeOf(TACMWaveFormat);
         result := mmIoRead( FIOHandle, @Char( Data ), Ck.ckSize );
         ck.ckSize := i;
    end else
         result := mmIoRead(FIOHandle, @Format, Ck.ckSize);
end;

destructor TFileStorage.Destroy;
begin
  CloseFile;
  Strings.Destroy;
  inherited;
end;

procedure TFileStorage.SetFileFormat(const Value: TFileFormat);
begin
  if FAutoFileFormat then Exit;
  FFileFormat := Value;
end;

procedure TFileStorage.SetAutoFileFormat(const Value: boolean);
begin
  FAutoFileFormat := Value;
  if Value then FileName := FFileName;
end;

{ TSignalWrite }

constructor TSignalWrite.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
    fAppendFile := False;
    FTotalRecordLength := 0;
    DoInitRecord := false;
    Precision := {$IFDEF TTDOUBLE} prDouble; {$ELSE} prSingle; {$ENDIF}
    FRecordNumber := 0;
    RecordInitialized := false;
end;

procedure TSignalWrite.CloseFile;
var list_info: TMMCKINFO;
    date_info: TMMCKINFO;
    soft_info: TMMCKINFO;
    DateStr: string;
begin
     case FFileFormat of
     ffWav:
     if FIOHandle <> 0 then {If saving wav file}
     begin
          try
          DateStr := DateToStr(Date);
          mmioAscend (FIOHandle, @data_info, 0);          // finished the 'data' chunk
          list_info.fccType := mmioStringToFOURCC ('INFO', 0);
          mmioCreateChunk (FIOHandle, @list_info, MMIO_CREATELIST);  // create the list chunk
               // the 'Creation date' chunk
               date_info.ckid := mmioStringToFourCC ('ICRD', 0);
               mmioCreateChunk (FIOHandle, @date_info, 0);     // create the 'creation date' chunk
                    mmioWrite (FIOHandle, PChar(DateStr), System.Length(DateStr));
               mmioAscend (FIOHandle, @date_info, 0);          // finished the 'creation date' chunk
               // finally, the 'Creator software' chunk
               soft_info.ckid := mmioStringToFourCC('ISFT', 0);
               mmioCreateChunk(FIOHandle, @soft_info, 0);     // create the 'software' chunk
                    mmioWrite(FIOHandle, PChar (fAuthorInfo), System.Length(FAuthorInfo));
               mmioAscend(FIOHandle, @soft_info, 0);          // finished the 'software' chunk
          mmioAscend(FIOHandle, @list_info, 0);          // finished the LIST chunk
          mmioAscend(FIOHandle, @ck_info, 0);            // and finished the RIFF chunk
          mmioClose(FIOHandle, 0);
          FIOHandle := 0;
          except
                ERaise('Error closing wav file!');
          end;
     end;
     ffdbn,ffbin,ffdat,ffasc:
     begin
         CloseRecord;
         if FileStream <> nil then FreeAndNil(FileStream);
     end;
     ffsfs,ffsgl:
     begin
         CloseRecord;
         if Strings.Count > 0 then strings.SaveToFile(FFileName);
     end;
     end;
     Strings.Clear;
     FileReady := False;
     FTotalRecordLength := 0;
     RecordInitialized := False;
end;

procedure TSignalWrite.SaveFile;
var fmt_info: TMMCKINFO;
begin
     CloseFile;
     if FileName = '' then ERaise('FileName = '+ ''''+ '''' + ' !');
     case FileFormat of
     ffdbn,ffbin,ffdat,ffasc:
          if not AppendFile then FileStream := TFileStream.Create(FileName, fmCreate OR fmShareDenyWrite) else
          begin
               FileStream := TFileStream.Create(FileName, fmCreate OR fmShareDenyWrite);
               FileStream.Seek(0, soFromEnd);
          end;
     ffwav:
          begin    {No appending support yet}
          with WaveFormat.Format.Format do
          begin
               wFormatTag := WAVE_FORMAT_PCM;         // it's PCM data
               nSamplesPerSec := Round(SamplingFrequency);
               nChannels := ChannelCount;
               wBitsPerSample := SizeOfPrecision(fPrecision,false)*8;
               nAvgBytesPerSec := (wBitsPerSample div 8)*nChannels*nSamplesPerSec;    // two bytes per sample
               nBlockAlign := nChannels*(wBitsPerSample div 8); // for 2-channel 16-bit audio
               cbSize := 0; //only wav PCM
          end;
          if ((SizeOfPrecision(fPrecision,false)*8) > 16) or (ChannelCount > 2) then
          begin
               WaveFormat.Format.Format.wFormatTag := WAVE_FORMAT_EXTENSIBLE;
               WaveFormat.Format.Format.cbSize := 22;
               if Precision = prSingle then WaveFormat.Format.SubFormat := KSDATAFORMAT_SUBTYPE_IEEE_FLOAT
                                       else WaveFormat.Format.SubFormat := KSDATAFORMAT_SUBTYPE_PCM;
               WaveFormat.Format.wValidBitsPerSample := WaveFormat.Format.Format.wBitsPerSample;
               WaveFormat.Format.dwChannelMask := SPEAKER_FRONT_LEFT OR SPEAKER_FRONT_RIGHT;
          end;
          case Precision of
          prInteger, prSmallInt, prInt24, prByte,prSingle: begin end;
          else ERaise('Unsupported wav format: Precision <> prInteger (32), prInt24 (24), prSmallInt (16),  prByte (8), prSingle(32)!');
          end;
          try
                FIOHandle := mmioOpen(PChar(FileName), nil, MMIO_CREATE or MMIO_WRITE or MMIO_EXCLUSIVE);
                ck_info.fccType := mmioStringToFOURCC ('WAVE', 0);
                mmioCreateChunk (FIOHandle, @ck_info, MMIO_CREATERIFF);
                fmt_info.ckid := mmioStringToFOURCC ('fmt', 0);
                mmioCreateChunk (FIOHandle, @fmt_info, 0);      // create wave format chunk
                mmioWrite(FIOHandle, @WaveFormat, SizeOf(TWaveFormatExtensible));
                mmioAscend(FIOHandle, @fmt_info, 0);           // finished 'fmt ' chunk
                // next, there's a data sub-chunk of the PCM wave data itself
                data_info.ckid := mmioStringToFOURCC ('data', 0);
                mmioCreateChunk(FIOHandle, @data_info, 0);     // create the data chunk
          except
               ERaise('Error creating wave file!');
          end;
          end;
     end;
     FileReady := True;
end;

procedure TSignalWrite.CloseRecord;
var i: Int64;
    as1: single;
    ad1: double;
begin
     case FileFormat of
     ffsfs: if Strings.Count >= 2 then
            begin
            Strings[0] := IntToStr(FTotalRecordLength);
            Strings[1] := FloatToStr(FTotalRecordLength*Input.Dt);
            end;
     ffasc,ffsgl: begin { no modifications required;} end;
     ffdat: if Assigned(FileStream) then
            begin
            i := FileStream.Position;
            FileStream.Seek(RecordStartOffset, soFromBeginning);
            FileStream.Write(FTotalRecordLength, SizeOf(Integer));
            FileStream.Position := i;
            end;
     ffbin: if Assigned(FileStream) then
            begin
            i := FileStream.Position;
            FileStream.Seek(RecordStartOffset, soFromBeginning);
            FileStream.Write(FTotalRecordLength, SizeOf(Integer));
            as1 := FTotalRecordLength/Input.SamplingFrequency;
            FileStream.Write(as1, SizeOf(Single));
            FileStream.Position := i;
            end;
     ffdbn: if Assigned(FileStream) then
            begin
            i := FileStream.Position;
            FileStream.Seek(RecordStartOffset, soFromBeginning);
            FileStream.Write(FTotalRecordLength, SizeOf(Integer));
            ad1 := FTotalRecordLength/Input.SamplingFrequency;
            FileStream.Write(ad1, SizeOf(double));
            FileStream.Position := i;
            end;
     ffwav: begin {all modifications done in CloseFile; }end;
     end;
     RecordInitialized := false;
end;

procedure TSignalWrite.InitRecord;
begin
     if RecordInitialized then CloseRecord;
     DoInitRecord := True;
     SaveRecord;
     DoInitRecord := False;
end;

procedure TSignalWrite.SaveBlock;     {writes only block values}
var i: integer;
    s: string;
begin
     if not Active then Exit;
     if not FileReady then SaveFile;
     if not RecordInitialized then InitRecord;
     case FileFormat of
     ffsfs:  Input.Data.ValuesToStrings(Strings,'','');
     ffasc:  begin
             Strings.Clear;
             SaveAscBlock;
             s := Strings.Text;
             FileStream.WriteBuffer(Pointer(S)^, System.Length(S));
             end;
     ffdbn:  Input.Data.WriteValues(FileStream,prDouble);
     ffbin:  Input.Data.WriteValues(FileStream,prSingle);
     ffdat:  Input.Data.WriteValues(FileStream,Precision,Rounding);
     ffwav:  begin
             i := FTotalRecordLength;
             SaveRecord;
             FTotalRecordLength := i;
             end;
     else Eraise('Block save not supported for this FileFormat!');
     end;
     FTotalRecordLength := FTotalRecordLength + Input.Length;
end;

procedure TSignalWrite.SaveAscBlock;
var  AMtx: TMtx;
     RVec: TVec;
begin
     MtxVec.CreateIt(AMtx);
     MtxVec.CreateIt(RVec);
     try
     RVec.Size(Input.Data);
     RVec.Ramp(FTotalRecordLength*Input.SamplingTime,Input.SamplingTime);
     AMtx.Size(Input.Length,2, Input.Complex);
     AMtx.SetCol(Input.Data,1);
     AMtx.SetCol(RVec, 0);
     AMtx.ValuesToStrings(Strings,kTab,'','');
     finally
          MtxVec.FreeIt(AMtx);
          MtxVec.FreeIt(RVec);
     end;
end;

procedure TSignalWrite.SaveRecord;     {writes the time signal length}
var  i: integer;
     AValues: double;
     AMtx: TMtx;
     AVec: TVec;
begin
     if not Active then Exit;
     if not FileReady then SaveFile;
     RecordInitialized := True;
     case FileFormat of
     ffsgl:
     begin     {Complex capable}
         if DoInitRecord then Exit;
         Strings.Add(IntToStr(Input.Length));
         Strings.Add(FloatToStr(Input.SamplingTime));
         MtxVec.CreateIt(AMtx);
         try
              AMtx.CopyVec(Input.Data,1);
              AMtx.StringsToValues(Strings,';');
              Strings.Add('');
         finally
              FreeIt(AMtx);
         end;
          FTotalRecordLength := Input.Length;
     end;
     ffsfs:
     begin     {Complex capable, but not multirecord and not streaming.}
         Strings.Clear;
         Strings.Add(IntToStr(Input.Length));  //just dummy for the start
         Strings.Add(FormatSample(Input.SamplingTime));
         Strings.Add('');
         if not DoInitRecord then
         begin
            Input.Data.ValuesToStrings(Strings,'','');
            FTotalRecordLength := Input.Length;
         end;
     end;
     ffdbn:
     begin
         if (FileStream = nil) then ERaise('FileStream = nil');
         DataSize := SizeOf(double);
         RecordStartOffset := FileStream.Position;
         FileStream.Write(Input.Length, SizeOf(Integer));
         AValues := Input.SamplingTime;
         FileStream.Write(AValues, DataSize);
         if not DoInitRecord then
         begin
            Input.Data.WriteValues(FileStream,prDouble);
            FTotalRecordLength := Input.Length;
         end;
     end;
     ffbin:
     begin
         if (FileStream = nil) then ERaise('FileStream = nil');
         DataSize := SizeOf(Single);
         RecordStartOffset := FileStream.Position;
         FileStream.Write(Input.Length, SizeOf(Integer));
         AValues := Input.SamplingTime;
         FileStream.Write(AValues, SizeOf(single));
         if not DoInitRecord then
         begin
             Input.Data.WriteValues(FileStream,prSingle);
             FTotalRecordLength := Input.Length;
         end;
     end;
     ffdat:
     begin
         if (FileStream = nil) then ERaise('FileStream = nil');
//         DataSize := SizeOfPrecision(Precision,Input.Complex);
         RecordStartOffset := FileStream.Position;
         FileStream.Write(Input.Length, SizeOf(Integer));  //RecordLength =4
         AValues := Input.SamplingFrequency; //SamplingFrequency =8
         FileStream.Write(AValues, SizeOf(double));
         i := Integer(Precision);  //Precision = 4
         FileStream.Write(i, SizeOf(Integer));
         i := Byte(Input.Complex);  //Complex = 1
         FileStream.Write(i, SizeOf(Integer));
         i := Input.ChannelCount;  //ChannelCount; =4
         FileStream.Write(i, SizeOf(Integer));
         if not DoInitRecord then
         begin
             Input.Data.WriteValues(FileStream,Precision,Rounding);
             FTotalRecordLength := Input.Length;
         end;
     end;
     ffasc:
     begin  {Complex capable}
         Strings.Clear; {not multi record, but block capable}
         if not DoInitRecord then
         begin
             SaveAscBlock;
             FTotalRecordLength := Input.Length;
         end;
     end;
     ffwav:
     begin
         if DoInitRecord then Exit;
         if FIOHandle = 0 then ERaise('FIOHandle = nil');

         case Precision of
         prByte, prSmallInt, prInt24, prInteger, prSingle: begin end;
         else ERaise('Dynamics not supported WaveFormat.wBitsPerSample = ' + IntToStr(WaveFormat.Format.Format.wBitsPerSample));
         end;

         CreateIt(AVec); //do not use GetMem, because of memory alignment with P4
         try
            AVec.Size(Input.Data);
            if Precision = prByte then Input.Data.Offset(128);
            WriteBinaryValues(AVec.PValues1D(0),Input.Data.PValues1D(0),Precision, Rounding,Input.Length,false);
            if Precision = prByte then Input.Data.Offset(-128);
            mmioWrite(FIOHandle, PAPointer(AVec.PValues1D(0)), Input.Length*SizeOfPrecision(Precision,false));
         finally
            FreeIt(AVec);
         end;

         FTotalRecordLength := Input.Length;
         end;
     end;
end;


procedure TSignalWrite.SetAppendFile(const Value: boolean);
begin
  FAppendFile := Value;
end;

procedure TSignalWrite.AppendRecord;
var aAppend: boolean;
begin
     aAppend := AppendFile;
     AppendFile := True;
     SaveFile;
     SaveRecord;
     CloseFile;
     AppendFile := aAppend;
end;

procedure TSignalWrite.SetRounding(const Value: TRounding);
begin
     fRounding := Value;
end;

function TSignalWrite.InternalUpdate: TPipeState;
begin
     ChannelCount := Input.ChannelCount;
     SamplingFrequency := Input.SamplingFrequency;
     SaveBlock;
     Result := pipeOK; //always returns true even if Active is false
end;

function TSignalWrite.SeekRecordNumber: boolean;
var i,j: integer;
begin
     Result := false;
     if not Assigned(FileStream) then Exit;
     FileStream.Position := 0;
     j := FileStream.Read(i,4);
     i := 0;
     while (j > 0) and (i <> RecordNumber) do
     begin
           Inc(i);
           FileStream.Seek((j+1)*DataSize,soFromBeginning);
           j := FileStream.Read(i,4);
     end;
     Result := (i = (RecordNumber));
end;

procedure TSignalWrite.SetRecordNumber(const Value: integer);
begin
    FRecordNumber := Value;
    SeekRecordNumber;
end;

procedure TSignalWrite.SetPrecision(const Value: TPrecision);
begin
  if (SizeOf(TSample) = 4) and (Value = prDouble) then FPrecision := prSingle
                                                  else FPrecision := Value;
  //If MtxVec is in single precision there is no reason to save as double precision
end;

procedure TSignalWrite.SetRecordLength(const Value: integer);
begin
//  FTotalRecordLength := Value;
end;

procedure TSignalWrite.SetRecordTime(const Value: TSample);
begin
//  FRecordTime := Value;
end;

function TSignalWrite.GetRecordLength: integer;
begin
    Result := FTotalRecordLength div ChannelCount;
end;

function TSignalWrite.GetRecordTime: TSample;
begin
    Result := RecordLength/SamplingFrequency;
end;

procedure TSignalWrite.SetTotalRecordLength(const Value: integer);
begin
//  FTotalRecordLength := Value;
end;

function TSignalWrite.FileIsOpen: boolean;
begin
     Result := FileReady;
end;

procedure TSignalWrite.SetAuthorInfo(const Value: string);
begin
  FAuthorInfo := Value;
end;

procedure TSignalWrite.SaveDataToFile(const aFileName: string);
begin
    FileName := aFileName;
    SaveFile;
    SaveBlock;
    CloseFile;
end;

{ TSignalReadList }

procedure TSignalReadList.Add;
begin
      inherited Add(AddItem);
end;

function TSignalReadList.AddItem: TMtxComponent;
begin
  Result := TSignalRead.Create(nil);
end;

procedure TSignalReadList.CloseFiles;
var i: integer;
begin
    for i := 0 to Count-1 do Items[i].CloseFile;
end;

function TSignalReadList.GetItems(index: integer): TSignalRead;
begin
       Result := TSignalRead(AList.Items[Index]);
end;

procedure TSignalReadList.SetItems(index: integer;
  const Value: TSignalRead);
begin
      raise ENoOperation.Create;
end;

{ TSignalWriteList }

procedure TSignalWriteList.Add;
begin
       inherited Add(addItem);
end;

function TSignalWriteList.AddItem: TMtxComponent;
begin
      Result := TSignalWrite.Create(nil); 
end;

procedure TSignalWriteList.CloseFiles;
var i: integer;
begin
    for i := 0 to Count-1 do Items[i].CloseFile;
end;

function TSignalWriteList.GetItems(index: integer): TSignalWrite;
begin
       Result := TSignalWrite(AList.Items[Index]);
end;

procedure TSignalWriteList.SaveFiles;
var i: integer;
begin
    for i := 0 to Count-1 do Items[i].CloseFile;
end;

procedure TSignalWriteList.SetItems(index: integer;
  const Value: TSignalWrite);
begin
       raise ENoOperation.Create;
end;

{ TSignalBrowse }

constructor TSignalBrowse.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIncrement := 100;
  FSpanLimit := 8192;
  FSpanLength := 16384;
  FProgressThread := TMtxProgressDialog.Create(nil);
  FPeakFile := TSignalRead.Create(nil);
  FSignalFile := TSignalRead.Create(nil);
  SR := FSignalFile;
  FThreaded := True;
  FData := TVec.Create;
end;

procedure TSignalBrowse.DownSampleMultiChannel(Src, Dest: TSignal; W1,W2: TVec);
var i: integer;
begin
      for i := 0 to Src.ChannelCount-1 do
      begin
           Demultiplex(Src.Data, W1, Src.ChannelCount, i);
           W2.PixelDownSample(Trunc(W1.Length/(FIncrement*2)),W1);
           Multiplex(W2, Dest.Data, Src.ChannelCount, i);
      end;
end;

procedure TSignalBrowse.CreateFileOnCompute(Sender: TObject);
var i: integer;
begin
    for i := 0 to SR.NumberOfRecords-1 do
    begin
        SR.RecordNumber := i;   {Must also set: Complex, SamplingTime, Precision, ChannelCount}
        ProgressThread.DefineLoop(0,Sr.MaxFrames);
        {Smaller block size is more CPU efficient (32 tested out)}
        SR.Length := Max(SR.ChannelCount,16)*FIncrement;   {Set how much data to read}
        SR.FirstFrame;   {Load first frame}

        SW.Precision := SR.Precision;   {Prepare the writer object}
        SW.ChannelCount := SR.ChannelCount;
        SW.Complex := SR.Complex;
        SW.SamplingFrequency := SR.SamplingFrequency/FIncrement;

        DownSampleMultiChannel(SR,SW,W1,W2);         {Prepare downsampled data}
        SW.SaveRecord;                  {initialize record writing}
        while SR.Pull <> pipeEnd do                {Go through entire record}
        begin
            DownSampleMultiChannel(SR,SW,W1,W2);     {Prepare downsampled data}
            Inc(ProgressThread.Counter);
            SW.SaveBlock;
            if FThreaded and ProgressThread.Cancel then Break;
        end;
        DownSampleMultiChannel(SR,SW,W1,W2);     {Prepare downsampled data}
        SW.SaveBlock;
        SW.CloseRecord;                 {Close record}
        if FThreaded and ProgressThread.Cancel then Break;
    end;
end;

procedure TSignalBrowse.DoProgressUpdate(Event: TMtxProgressEvent);
begin
    If Assigned(FOnProgressUpdate) then
    begin
         if not (csDestroying in ComponentState) then OnProgressUpdate(Self,Event);
    end;
end;

procedure TSignalBrowse.CreateFileProgressUpdate(Sender: TObject; Event: TMtxProgressEvent);
begin
     case Event of
     peInit:    begin
                PeakFile.CloseFile;
                SW := TSignalWrite.Create(nil);
                W1 := TVec.Create;
                W2 := TVec.Create;
                SW.AutoFileFormat := False;
                SW.FileName := ChangeFileExt(SR.FileName,'.pk');
                SW.FileFormat := ffDat;
                SW.Input := SW;
                SW.SaveFile;
                SR.OpenFile;  {Must set also: NumberOfRecords}
                DoProgressUpdate(peInit);
                end;
     peCycle:   begin
                DoProgressUpdate(peCycle);
                end;
     peCleanUp: begin
                FreeAndNil(W1);
                FreeAndNil(W2);
                FreeAndNil(SW);
                OpenBrowseFiles;
                DoProgressUpdate(peCleanUp);
                end;
     end;
end;

procedure TSignalBrowse.CreateBrowseFile(AFileName: string);
begin
     ProgressThread.InternalLoop := False;
     ProgressThread.OnCompute := CreateFileOnCompute;
     ProgressThread.OnProgressUpdate := CreateFileProgressUpdate;
     Sr.FileName := AFileName;
     PeakFile.CloseFile;
     if FThreaded then ProgressThread.Start else
     begin
          CreateFileProgressUpdate(Self,peInit);
          CreateFileOnCompute(Self);
          CreateFileProgressUpdate(Self,peCleanUp);
     end;
end;

destructor TSignalBrowse.Destroy;
begin
  FProgressThread.Destroy;
  FPeakFile.Destroy;
  FSignalFile.Destroy;
  FData.Destroy;
  inherited;
end;

function TSignalBrowse.InternalUpdate: TPipeState;
begin
     Result := pipeOk;
end;

procedure TSignalBrowse.LoadFullRecord;
begin
     SpanLength := SignalFile.RecordLength;
     RecordPosition := 0;
end;

procedure TSignalBrowse.OpenBrowseFiles;
begin
     SignalFile.OpenFile;
     PeakFile.AutoFileFormat := False;
     PeakFile.FileName := ChangeFileExt(SignalFile.FileName,'.pk');
     PeakFile.FileFormat := ffDat;
     PeakFile.OpenFile;
end;

procedure TSignalBrowse.OpenBrowseFile(AFileName: string);
var s: string;
    PeakFileOlder: boolean;
begin
     SignalFile.FileName := AFileName;
     s := ChangeFileExt(AFileName,'.pk');
     if not FileExists(s) then CreateBrowseFile(AFileName) else
     begin
          PeakFileOlder := (FileDateToDateTime(FileAge(AFilename))-
                            FileDateToDateTime(FileAge(s))) > 0;
          if PeakFileOlder then
          begin
               SysUtils.DeleteFile(s);
               CreateBrowseFile(AFileName);
          end else CreateFileProgressUpdate(Self,peCleanUp);
     end;
end;

procedure TSignalBrowse.SetIncrement(const Value: integer);
begin
   FIncrement := Max(Value,1);
end;

{procedure TSignalBrowse.SetSignalFile(const Value: TSignalRead);
begin
   if (FSignalFile <> Value) and not BlockAssign then
   begin
      FSignalFile := Value;
      if Assigned(FSignalFile) then FSignalFile.FreeNotification(Self);
   end;
end;   }

procedure TSignalBrowse.SetSpanTime(const Value: TSample);
begin
    if Assigned(SignalFile) then
    begin
        FSpanLength := Trunc(Value*SignalFile.SamplingFrequency);
        FSpanTime := FSpanLength/SignalFile.SamplingFrequency;
    end else FSpanTime := Value;
end;

procedure TSignalBrowse.Notification(AComponent: TComponent; Operation: TOperation);
begin
    if (Operation = opRemove) and  (AComponent <> Self) and (AComponent <> nil) then
    begin
{       if Assigned(FSignalFile) and (AComponent=FSignalFile) then FSignalFile := nil;
       if Assigned(FPeakFile) and (AComponent=FPeakFile) then FPeakFile := nil;
       if Assigned(FProgressThread) and (AComponent=FProgressThread) then FProgressThread := nil;}
    end;
    inherited;
end;


{procedure TSignalBrowse.SetPeakFile(const Value: TSignalRead);
begin
   if (FPeakFile <> Value) and not BlockAssign then
   begin
      FPeakFile := Value;
      if Assigned(FPeakFile) then FPeakFile.FreeNotification(Self);
   end;
end;   }

procedure TSignalBrowse.SetSpanLimit(const Value: integer);
begin
     FSpanLimit := Value;
end;

procedure TSignalBrowse.SetRecordPosition(const Value: integer);
begin
     if SpanLength > SpanLimit then
     begin
          PeakFile.Length := Trunc(SpanLength/FIncrement)*PeakFile.ChannelCount;
          PeakFile.RecordPosition := TruncDiv(Value/FIncrement, PeakFile.ChannelCount); {this div ensures channel allignment,}
          Data.Copy(PeakFile.Data);
     end else
     begin
          SignalFile.Length := SpanLength*SignalFile.ChannelCount;
          SignalFile.RecordPosition := TruncDiv(Value,SignalFile.ChannelCount);
          Data.Copy(SignalFile.Data);
     end;
end;

function TSignalBrowse.GetRecordPosition: integer;
begin
     if SpanLength > SpanLimit then Result := PeakFile.RecordPosition*Increment
                               else Result := SignalFile.RecordPosition;
end;

function TSignalBrowse.GetRecordTimePosition: TSample;
begin
     if SpanLength > SpanLimit then Result := PeakFile.RecordTimePosition
                               else Result := SignalFile.RecordTimePosition;
end;

procedure TSignalBrowse.SetSpanLength(const Value: integer);
begin
  if Assigned(SignalFile) then
  begin
      FSpanLength := Value;
      FSpanTime := FSpanLength/SignalFile.SamplingFrequency;
  end else FSpanLength := Value;
end;

procedure TSignalBrowse.SetRecordTimePosition(const Value: TSample);
begin
  if Assigned(SignalFile) then RecordPosition := Trunc(Value*SignalFile.SamplingFrequency);
end;

function TSignalBrowse.GetRecordNumber: integer;
begin
     if SpanLength > SpanLimit then Result := PeakFile.RecordNumber
                               else Result := SignalFile.RecordNumber;
end;

function TSignalBrowse.GetRecordTime: TSample;
begin
     if SpanLength > SpanLimit then Result := PeakFile.RecordTime
                               else Result := SignalFile.RecordTime;
end;

procedure TSignalBrowse.SetRecordNumber(const Value: integer);
begin
     SignalFile.RecordNumber := Value;
     PeakFile.RecordNumber := Value
end;

procedure TSignalBrowse.SetRecordTime(const Value: TSample);
begin
   //
end;

procedure TSignalBrowse.SetOnProgressUpdate(const Value: TProgressUpdateEvent);
begin
  FOnProgressUpdate := Value;
end;

procedure TSignalBrowse.SetThreaded(const Value: boolean);
begin
  FThreaded := Value;
end;

procedure TSignalBrowse.SetData(const Value: TVec);
begin
//  FData := Value;
end;

function TSignalBrowse.GetChannelCount: integer;
begin
     if SpanLength > SpanLimit then Result := PeakFile.ChannelCount
                               else Result := SignalFile.ChannelCount;
end;

function TSignalBrowse.GetDt: TSample;
begin
     if SpanLength > SpanLimit then Result := PeakFile.Dt
                               else Result := SignalFile.Dt;
end;

function TSignalBrowse.GetSamplingFrequency: TSample;
begin
     if SpanLength > SpanLimit then Result := PeakFile.SamplingFrequency
                               else Result := SignalFile.SamplingFrequency;
end;

function TSignalBrowse.GetSamplingTime: TSample;
begin
     if SpanLength > SpanLimit then Result := PeakFile.SamplingTime
                               else Result := SignalFile.SamplingTime;
end;

function TSignalBrowse.IsOverview: boolean;
begin
     Result := SpanLength > SpanLimit;
end;
{     case i of
     ACMERR_NOTPOSSIBLE: AStr := 'The requested operation cannot be performed.';
     MMSYSERR_INVALFLAG: AStr := 'At least one flag is invalid.';
     MMSYSERR_INVALHANDLE: AStr := 'The specified handle is invalid.';
     MMSYSERR_INVALPARAM: AStr := 'At least one parameter is invalid.';
     MMSYSERR_NOMEM: AStr := 'The system is unable to allocate resources.'
     end;

     case i of
     MMSYSERR_INVALFLAG : AStr :='At least one flag is invalid.';
     MMSYSERR_INVALHANDLE: AStr := 'The specified handle is invalid.';
     MMSYSERR_INVALPARAM: AStr := 'At least one parameter is invalid.';
     MMSYSERR_NOMEM: AStr := 'The system is unable to allocate resources.';
     end;

     }

{ TACMConverter }

constructor TACMConverter.Create;
begin
  SrcData := TVec.Create;
  DstData := TVec.Create;
  HeaderInitialized := false;
  StreamInitialized := false;
end;

destructor TACMConverter.Destroy;
begin
  Close;
  SrcData.Destroy;
  DstData.Destroy;
  inherited;
end;

function TACMConverter.FormatDescription(Format: TAcmWaveFormat): string;
var Details: tACMFORMATDETAILS;
begin
     FillChar(Details,SizeOf(Details),0);
     Details.cbStruct := SizeOf(Details);
     Details.dwFormatTag := Format.Format.Format.wFormatTag;
     Details.pwfx := @Format;
     Details.cbwfx := SizeOf(Format);

     if Details.dwFormatTag <> WAVE_FORMAT_EXTENSIBLE then
     begin
         acmFormatDetails(nil,Details,ACM_FORMATDETAILSF_FORMAT);
         Result := Details.szFormat;
     end else
     begin
         Result := IntToStr(Format.Format.Format.nSamplesPerSec) + 'Hz, ' +
                   IntToStr(format.format.Format.wBitsPerSample) + 'bit, '+
                   IntToStr(format.format.Format.nChannels) + 'ch ';
     end;
end;

function TACMConverter.FormatTagDescription(Format: TAcmWaveFormat): string;
var Details: tACMFORMATTAGDETAILS;
begin
     FillChar(Details,SizeOf(Details),0);
     Details.cbStruct := SizeOf(Details);
     Details.dwFormatTag := Format.Format.Format.wFormatTag;

     if Details.dwFormatTag <> WAVE_FORMAT_EXTENSIBLE then
     begin
         acmFormatTagDetails(nil,Details,ACM_FORMATDETAILSF_FORMAT);
         Result := Details.szFormatTag;
     end else
     begin
         Result := 'Extended format';
     end;
end;

function TACMConverter.SuggestFormat(ChannelCount, SamplingFrequency,
                                      BitCount, FormatTag: boolean): boolean;
var ac: cardinal;
    i: integer;
begin
     Result := True;
     ac := 0;
     if ChannelCount      then ac := ac or ACM_FORMATSUGGESTF_NCHANNELS;
     if SamplingFrequency then ac := ac or ACM_FORMATSUGGESTF_NSAMPLESPERSEC;
     if BitCount          then ac := ac or ACM_FORMATSUGGESTF_WBITSPERSAMPLE;
     if FormatTag         then ac := ac or ACM_FORMATSUGGESTF_WFORMATTAG;
     i := acmFormatSuggest(nil,SrcFormat.Format.Format,DstFormat.Format.Format, SizeOf(TACMWaveFormat),ac);
     case i of
     MMSYSERR_INVALFLAG:  ErrorStr := 'At least one flag is invalid.';
     MMSYSERR_INVALHANDLE: ErrorStr := 'The specified handle is invalid.';
     MMSYSERR_INVALPARAM: ErrorStr := 'At least one parameter is invalid.'
     end;
     if i <> 0 then Result := false;
end;


procedure TACMConverter.SuggestPcmFormat;
var i: integer;
begin
    DstFormat := SrcFormat;
    if SrcFormat.Format.Format.wFormatTag <> WAVE_FORMAT_EXTENSIBLE then
    begin
         DstFormat.Format.Format.wFormatTag := WAVE_FORMAT_PCM;
         if not CompareMem(@DstFormat,@SrcFormat,SizeOf(TACMWaveFormat)) then //check if equal
         begin
             i := acmFormatSuggest(nil,SrcFormat.Format.Format,DstFormat.Format.Format, SizeOf(TACMWaveFormat),
                                   ACM_FORMATSUGGESTF_NCHANNELS OR
                                   ACM_FORMATSUGGESTF_NSAMPLESPERSEC OR
                                   ACM_FORMATSUGGESTF_WFORMATTAG);

             case i of
             MMSYSERR_INVALFLAG:  ErrorStr := 'At least one flag is invalid.';
             MMSYSERR_INVALHANDLE: ErrorStr := 'The specified handle is invalid.';
             MMSYSERR_INVALPARAM: ErrorStr := 'At least one parameter is invalid.'
             end;
             if i <> 0 then ERaise('Error calling acmFormatSuggest!');

    //         FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM
         end;
    end;
    //Extensible format supported only for uncompressed files (no MPEG or AC3 decompression).
end;

procedure TACMConverter.Convert;
var i: integer;
begin
    if SrcFormat.Format.Format.wFormatTag <> WAVE_FORMAT_EXTENSIBLE then
    begin
        Initialize;
        if FinitialByteCount > FSrcByteCount then Eraise('FinitialByteCount > FSrcByteCount');
        streamHeader.cbSrcLength := FInitialByteCount; //actual bytes to convert
        i := acmStreamConvert(streamHandle,streamHeader,ACM_STREAMCONVERTF_BLOCKALIGN);
        if i <> 0 then ERaise('Error converting with acm!');
    end else
    begin
        DstData.Copy(SrcData); //EXTENSIBLE format only for uncompressed (No AC3, MPEG II etc..)
    end;
end;

procedure TACMConverter.HeaderClose;
var i: integer;
begin
    if HeaderInitialized then
    begin
        StreamHeader.cbSrcLength := fSrcLengthBackup;
        i := acmStreamUnPrepareHeader(streamHandle,StreamHeader,0);
        if i <> 0 then ERaise('Error unpreparing acm header!');
        HeaderInitialized := False;
    end;
end;

procedure TACMConverter.StreamClose;
var i: integer;
begin
    HeaderClose;
    if StreamInitialized then
    begin
        i := acmStreamClose(streamHandle,0);
        if i <> 0 then ERaise('Error closing acm stream!');
        StreamInitialized := False;
    end;
end;


procedure TACMConverter.Close;
begin
    StreamClose;
end;

procedure TACMConverter.InitializeStream;
var i: integer;
begin
    if SrcFormat.Format.Format.wFormatTag <> WAVE_FORMAT_EXTENSIBLE then
    begin
        if StreamInitialized then Exit;
        i := acmStreamOpen(streamHandle, nil, SrcFormat.Format.Format, DstFormat.Format.Format, nil,0,0, ACM_STREAMOPENF_NONREALTIME);
        if i <> 0 then ERaise('Error opening acm stream!');
        StreamInitialized := True;
    end;
end;

procedure TACMConverter.Initialize;
begin
     InitializeStream;
     InitializeHeader;
end;

procedure TACMConverter.InitializeHeader;
var i: integer;
begin
     if HeaderInitialized then Exit;
     InitializeStream;     
     //must be:
      // - block alligned! Otherwise it wont process integer number of samples per iteration.
      // - fixed bitrate. Otherwise it cannot determine position in file.
     StreamHeader.cbStruct := SizeOf(TacmStreamHeader);
     StreamHeader.fdwStatus := 0;
     StreamHeader.dwUser := 0;
     StreamHeader.dwSrcUser := 0;
     StreamHeader.dwDstUser := 0;
     StreamHeader.pbSrc := PAPointer(SrcData.PValues1D(0));
     StreamHeader.cbSrcLength := FSrcByteCount; //usually equal to FSrcByteCount
     StreamHeader.cbSrcLengthUsed := 0; // returned

     FSrcLengthBackup := FSrcByteCount; //remember that for UnprepareHeader

     StreamHeader.pbDst := PAPointer(DstData.PValues1D(0));
     StreamHeader.cbDstLength := FDstByteCount;
     StreamHeader.cbDstLengthUsed := 0; // returned

     i := acmStreamPrepareHeader(streamHandle,StreamHeader,0);
     if i <> 0 then ERaise('Error preparing acm header!');

     HeaderInitialized := True;
end;

procedure TACMConverter.SetErrorStr(const Value: string);
begin
  FErrorStr := Value;
end;

function TACMConverter.SuggestSampleCount(Count: integer): boolean;
var SrcLen,DstLen,DstLen1: cardinal;
    i: integer;
begin //1.) Try to set the Count explicitely
    if not StreamInitialized then InitializeStream;
    if Count = -1 then Count := 1024;
    SrcLen := Count*SrcFormat.Format.Format.wBitsPerSample div 8;
    DstLen := Count*DstFormat.Format.Format.wBitsPerSample div 8;
    if SrcFormat.Format.Format.wFormatTag <> WAVE_FORMAT_EXTENSIBLE then
    begin
         DstLen1 := High(Cardinal);
         acmStreamSize(streamHandle,SrcLen,DstLen1,ACM_STREAMSIZEF_SOURCE);
         if DstLen = DstLen1 then
         begin
             SrcByteCount := SrcLen;
             DstByteCount := DstLen;
             Result := True;
         end else
         begin
             SrcLen := SrcFormat.Format.Format.nBlockAlign; //ensure at least 4096 bytes
             while SrcLen < 4096 do SrcLen := SrcLen*2; //bytes
             i := acmStreamSize(streamHandle,SrcLen,DstLen,ACM_STREAMSIZEF_SOURCE);
             if (i <> 0) or (DstLen = 0) then ERaise('Problem with acmStreamSize!');

             {for writing/compression: }

    {        DstLen := DstFormat.Format.nBlockAlign; //ensure at least 8192 bytes
             while DstLen < 8192 do DstLen := DstLen*2; //bytes
             i := acmStreamSize(streamHandle,DstLen,SrcLen,ACM_STREAMSIZEF_DESTINATION);
             if (i <> 0) or (DstLen = 0) then ERaise('Problem with acmStreamSize!');}

             SrcByteCount := SrcLen;
             DstByteCount := DstLen;
             Result := False;
         end;
    end else
    begin
         SrcLen := Round(Max(SrcLen,SrcFormat.Format.Format.nBlockAlign)); //at least one sample
         DstLen := SrcLen;
         SrcByteCount := SrcLen;
         DstByteCount := DstLen;
         Result := True;
    end;
end;

procedure TACMConverter.SetSrcByteCount(const Value: integer);
begin
  if FSrcByteCount <> Value then
  begin
      FSrcByteCount := Value;
      HeaderClose;      
      SrcData.Length := Value div SizeOf(TSample)+1;
  end;
end;

procedure TACMConverter.SetDstByteCount(const Value: integer);
begin
  if FDstByteCount <> Value then
  begin
      FDstByteCount := Value;
      HeaderClose;      
      DstData.Length := Value div SizeOf(TSample)+1;
  end;
end;

procedure TACMConverter.SetBlockSize(const Value: integer);
begin
//  FBlockSize := Value;
end;

function TACMConverter.GetBlockSize: integer;
begin
    Result := SrcFormat.Format.Format.nBlockAlign;
end;

procedure TACMConverter.SetFinalByteCount(const Value: integer);
begin
//  FFinalByteCount := Value;
end;

function TACMConverter.GetFinalByteCount: integer;
begin //valid after conversion.
     if SrcFormat.Format.Format.wFormatTag <> WAVE_FORMAT_EXTENSIBLE then
     begin
          Result := StreamHeader.cbDstLengthUsed;
     end else
     begin
          Result := FInitialByteCount;
     end
end;

procedure TACMConverter.SetInitialByteCount(const Value: integer);
begin
     FInitialByteCount := Value;
end;

function TSignalRead.FormatDescription: string;
begin
     Result := '';
     if FileReady then
     case FileFormat of
     ffWav: Result := acm.FormatDescription(acm.SrcFormat);
     else
     begin
          Result := SampleToStr(SamplingFrequency,0,7) + ' Hz, ' +
                    PrecisionToStr(Precision) + ', ' +
                    'Ch: ' + IntToStr(ChannelCount);
          if NumberOfRecords > 0 then
          Result := Result + ', Records: ' + IntToStr(NumberOfRecords);
     end;
     end;
end;

function TSignalRead.FormatTagDescription: string;
begin
     Result := '';
     if FileReady then
     case FileFormat of
     ffDat: Result := 'Binary DAT';
     ffSgl: Result := 'Text SGL';
     ffBin: Result := 'Binary BIN';
     ffWav: Result := acm.FormatTagDescription(acm.SrcFormat);
     ffSfs: Result := 'Text SFS';
     ffAsc: Result := 'Text ASC';
     ffDbn: Result := 'Binary DBN';
     end;
end;

{ TSignalBrowseList }

procedure TSignalBrowseList.Add;
begin
      inherited Add(AddItem);
end;

function TSignalBrowseList.AddItem: TMtxComponent;
begin
      Result := TSignalBrowse.Create(nil);
end;

function TSignalBrowseList.GetItems(index: integer): TSignalBrowse;
begin
      Result := TSignalBrowse(AList.Items[Index]);
end;

procedure TSignalBrowseList.SetItems(index: integer;
  const Value: TSignalBrowse);
begin
   raise ENoOperation.Create;
end;

initialization
RegisterClass(TSignalRead);
RegisterClass(TSignalWrite);
RegisterClass(TSignalBrowse);
RegisterClass(TSignalReadList);
RegisterClass(TSignalWriteList);
RegisterClass(TSignalBrowseList);

finalization
UnRegisterClass(TSignalRead);
UnRegisterClass(TSignalWrite);
UnRegisterClass(TSignalBrowse);
UnRegisterClass(TSignalReadList);
UnRegisterClass(TSignalWriteList);
UnRegisterClass(TSignalBrowseList);

end.

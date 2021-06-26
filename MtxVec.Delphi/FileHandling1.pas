unit FileHandling1;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic2, StdCtrls, ExtCtrls, ActnList, MtxVec,MtxVecEdit, ComCtrls,
  Buttons, MtxExpr;

type
  TFileH1 = class(TBasicForm2)
    CheckBox1: TCheckBox;
    Label1: TLabel;
    RichEdit2: TRichEdit;
    Button1: TBitBtn;                            
    Button2: TBitBtn;
    Button3: TBitBtn;
    Button4: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    AMtx: Matrix;
    AVec: Vector;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FileH1: TFileH1;

implementation

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TFileH1.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines do
  begin
    Clear;
    Add('Importing and exporting values is an important feature '
      + 'of MtxVec. MtxVec offers you the ability to save vector/'
      + 'matrix to memory stream, binary files, text files, BLOBs, Clipboard ...');
    Add('Click on buttons bellow to introduce yourself with various '
      + 'methods available. If "View loaded values" option is '
      + 'checked, you''ll get a visual representation of loaded matrix/vector.');
  end;
end;

procedure TFileH1.Button1Click(Sender: TObject);
var AStream : TMemoryStream;
    tmpMtx : Matrix;
{    AStream1: MemoryStream; }
begin
  With RichEdit2.Lines, RichEdit2 do
  begin
    Clear;
    Add('AMtx.Size(10,10);');
    Add('AMtx.RandGauss; {add random data }');
    SelAttributes.Style := [fsItalic];
    Add('{ save header & values to stream}');
    Add('AStream := TMemoryStream.Create;');
    Add('try');
    Add(' AMtx.SaveToStream(AStream);');
    SelAttributes.Style := [fsItalic];
    Add(' { now load header & values from stream }');
    Add(' CreateIt(tmpMtx);');
    Add(' try');
    Add('   AStream.Seek(0,0);');
    Add('   tmpMtx.LoadFromStream(AStream);');
    Add('   If CheckBox1.Checked then ViewValues(AMtx);');
    Add(' finally');
    Add('   FreeIt(tmpMtx);');
    Add(' end;');
    Add('finally');
    Add('  AStream.Free;');
    Add('end;');
  end;
  AMtx.Size(10,10);
  AMtx.RandGauss; {add random data }

  {$IFNDEF CLR}

  { save header & values to stream}
  AStream := TMemoryStream.Create;
  try
     AMtx.SaveToStream(AStream);
    { now load header & values from stream }
     {$IFDEF CLR}
     AStream.Seek(0,soFromBeginning);
     {$ELSE}
     AStream.Seek(0,0);
     {$ENDIF}
     tmpMtx.LoadFromStream(AStream);
     If CheckBox1.Checked then ViewValues(AMtx,'Memory stream',true);
  finally
     AStream.Free;
  end;

  {$ELSE}

  { save header & values to stream}
  AStream1 := MemoryStream.Create;
  try
     AMtx.SaveToStream(AStream1);
    { now load header & values from stream }
     {$IFDEF CLR}
     AStream1.Seek(0,SeekOrigin.Begin);
     {$ELSE}
     AStream1.Seek(0,0);
     {$ENDIF}
     tmpMtx.LoadFromStream(AStream1);
     If CheckBox1.Checked then ViewValues(AMtx,'Memory stream',true);
  finally
     AStream.Free;
  end;

  {$ENDIF}
end;

procedure TFileH1.Button2Click(Sender: TObject);
var tmpVec: Vector;
begin
  With RichEdit2.Lines, RichEdit2 do
  begin
    Clear;
    Add('AVec.Size(100);');
    Add('AVec.RandUniform(-2,2);');
    SelAttributes.Style := [fsItalic];
    Add('{save header & values to file}');
    Add('AVec.SaveToFile(''TestVec1.vec'');');
    Add('CreateIt(tmpVec);');
    Add('try');
    SelAttributes.Style := [fsItalic];
    Add(' { load header & values into tmpVec}');
    Add(' tmpVec.LoadFromFile(''TestVec1.vec'');');
    Add(' if CheckBox1.Checked then ViewValues(tmpVec);');
    Add('finally');
    Add(' FreeIt(tmpVec);');
    Add('end;');
  end;
  AVec.Size(100);
  AVec.RandUniform(-2,2);
  {save header & values to file}
  AVec.SaveToFile('TestVec1.vec');

  { load header & values into tmpVec}
  tmpVec.LoadFromFile('TestVec1.vec');
  if CheckBox1.Checked then ViewValues(tmpVec,'File Stream',true);
end;

procedure TFileH1.Button4Click(Sender: TObject);
var StringList : TStringList;
    tmpMtx: Matrix;
begin

  With RichEdit2.Lines, RichEdit2 do
  begin
    Clear;
    Add('AMtx.Size(20,20,true);');
    Add('AMtx.RandUniform(-1,2);');
    Add('StringList := TStringList.Create;');
    Add('try');
    SelAttributes.Style := [fsItalic];
    Add(' { use tab = chr(9) as delimiter }');
    Add(' AMtx.ValuesToStrings(StringList,#9);');
    SelAttributes.Style := [fsItalic];
    Add(' { Save matrix values to txt file }');
    Add(' StringList.SaveToFile(''ASCIIMtx.txt'');');
    Add('finally');
    Add(' StringList.Free;');
    Add('end;');
    Add('');
    Add('StringList := TStringList.Create;');
    Add('CreateIt(tmpMtx);');
    Add('try');
    SelAttributes.Style := [fsItalic];
    Add(' { get matrix values from text file }');
    Add(' StringList.LoadFromFile(''ASCIIMtx.txt'');');
    SelAttributes.Style := [fsItalic];
    Add(' { use tab = chr(9) as delimiter }');
    Add(' tmpMtx.StringsToValues(StringList,#9);');
    Add(' if CheckBox1.Checked then ViewValues(tmpMtx);');
    Add('finally');
    Add(' FreeIt(tmpMtx);');
    Add(' StringList.Free;');
    AdD('end;');
  end;

  AMtx.Size(20,20,true);
  AMtx.RandUniform(-1,2);
  StringList := TStringList.Create;
  try
     { use tab = chr(9) as delimiter }
     AMtx.ValuesToStrings(StringList,#9);
     { Save matrix values to txt file }
     StringList.SaveToFile('ASCIIMtx.txt');
  finally
     StringList.Free;
  end;

  StringList := TStringList.Create;
  try
     { get matrix values from text file }
     StringList.LoadFromFile('ASCIIMtx.txt');
     { use tab = chr(9) as delimiter }
     tmpMtx.StringsToValues(StringList,#9);
     if CheckBox1.Checked then ViewValues(tmpMtx,'TEXT file',true);
  finally
     StringList.Free;
  end;
end;

procedure TFileH1.Button3Click(Sender: TObject);
(*
var
    tmpBlob : TStream;
    Table1  : TTable;
*)
begin
  With RichEdit2.Lines, RichEdit2 do
  begin
    Clear;
    Add('AVec.Size(100);');
    Add('AVec.RandGauss(0,1);');
    Add('AVec.SortAscend;');
    Add('Table1 := TTable.Create(Self);');
    Add('With Table1 do');
    Add(' try');
    Add(' DatabaseName := ''DBDemos'';');
    Add(' TableType := ttDefault;');
    Add(' TableName := ''TableVec'';');
    Add(' with FieldDefs do');
    Add(' begin');
    Add('   Clear;');
    Add('   with AddFieldDef do');
    Add('   begin');
    Add('     Name := ''Field1'';');
    Add('     DataType := ftBLOB;');
    Add('     Required := False;');
    Add('   end;');
    Add(' end;');
    Add(' CreateTable;');
    SelAttributes.Style := [fsItalic];
    Add(' { save to table1}');
    Add(' Active := true;');
    Add(' Insert;');
    Add(' tmpBLOB := CreateBLOBStream(FieldByName(''Field1''),bmReadWrite);');
    Add(' CreateIt(tmpVec);');
    Add(' try');
    Add('   AVec.SaveToStream(tmpBlob);');
    Add('   Post;');
    Add('   tmpBlob.Seek(0,0); { "reset" BLOB stream}');
    Add('   tmpVec.LoadFromStream(tmpBlob);');
    Add('   If CheckBox1.Checked then ViewValues(tmpVec);');
    Add(' finally');
    Add('   FreeIt(tmpVec);');
    Add('   tmpBLOB.Free;');
    Add(' end;');
    Add('finally');
    Add(' Active := false;');
    Add(' DeleteTable;');
    Add(' Destroy;');
    Add('end;');
  end;
{
  AVec.Size(100);
  AVec.RandGauss(0,1);
  AVec.SortAscend;
  Table1 := TTable.Create(Self);
  With Table1 do
  try
     DatabaseName := 'DBDemos';
     TableType := ttDefault;
     TableName :='TableVec';
     with FieldDefs do
     begin
      Clear;
      with AddFieldDef do
      begin
        Name := 'Field1';
        DataType := ftBlob;
        Required := False;
      end;
     end;
     CreateTable;

  //   save to table1
     Active := true;
     Insert;
     tmpBLOB := CreateBLOBStream(FieldByName('Field1'),bmReadWrite);
     CreateIt(tmpVec);
     try
        AVec.SaveToStream(tmpBlob);
        Post;
        tmpBlob.Seek(0,0); // "reset" BLOB stream
        tmpVec.LoadFromStream(tmpBlob);
        if CheckBox1.Checked then ViewValues(tmpVec,'BLOB Stream',true);
     finally
        FreeIt(tmpVec);
        tmpBLOB.Free;
     end;
  finally
     Active := false;
     DeleteTable;
     Destroy;
  end;
}
end;

initialization
   RegisterClass(TFileH1);
end.



unit List_Func;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ExtCtrls;

type
  TfrmListFunc = class(TForm)
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    LastIndex: Integer;
    LastSearchText: String;
    LastFindAll: boolean;
    function ListToStringGrid(AFileName: String): Integer;
    function DoSearch(FindText: String; FindAllWords: boolean): Integer;
  public
    { Public declarations }
  end;

var
  frmListFunc: TfrmListFunc;

implementation

Uses Find_Form;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

function TfrmListFunc.DoSearch(FindText: String; FindAllWords: boolean): Integer;

var SearchText : Array[1..100] of String;
    NumWords   : Integer;

  function FoundTextIn(S: String): boolean;
  var i: Integer;
  begin
    Result := False;
    S := UpperCase(S);

    if FindAllWords then
    begin
      for i:=1 to NumWords do
         if Pos(SearchText[i],S) = 0 then exit;
     result := true;
    end else
    begin
      for i:=1 to NumWords do
        if Pos(SearchText[i],S)>0 then
        begin
          result := true;
           exit;
        end;
    end;
  end;

  Function SearchInLines(Lines:TStrings):Boolean;
  var i : Integer;
  begin
    result:=False;
    for i:=0 to Lines.Count-1 do
      if FoundTextIn(Lines[i]) then
      begin
        result:=True;
        break;
      end;
  end;

  Procedure SplitWords(S: String);
  var i : Integer;
  begin
    NumWords:=0;
    Repeat
      i:=Pos(' ',S);
      if i>0 then
      begin
        Inc(NumWords);
        SearchText[NumWords]:=UpperCase(Copy(S,1,i-1));
        Delete(S,1,i);
      end;
    Until (i=0) or (S='');
    if S<>'' then
    begin
      Inc(NumWords);
      SearchText[NumWords]:=UpperCase(S);
    end;
  end;

var tmpText: String;
    i: Integer;
    FirstIndex: Integer;
begin
  Result := -1;
  tmpText := FindText;
  SplitWords(tmpText);
  FirstIndex := LastIndex+1;
  for i := FirstIndex to StringGrid1.RowCount-1 do
    if SearchInLines(StringGrid1.Rows[i]) then
    begin
      Result := i;
      StringGrid1.Row := i;
      break;
    end;
end;


procedure TfrmListFunc.FormCreate(Sender: TObject);
var Total : Integer;
begin
  Total := ListToStringGrid('List_Functions.txt');
  Label1.Caption := 'Function list: Count = '+IntToStr(Total) + '  (not counting overloaded functions)';
  LastIndex := -1;
  LastSearchText := '';
  LastFindAll := false;
end;

function TfrmListFunc.ListToStringGrid(AFileName: String): Integer;
var i,j, Len: Integer;
    StrList: TStringList;
begin
  Result := 0;
  With StringGrid1 do
  begin
    RowCount :=1;
    Cells[0,0] := '(Unit) Name';
    Cells[1,0] := 'Description';
  end;
  If FileExists(AFileName) then
  begin
    StrList := TStringList.Create;
    try
      StrList.LoadFromFile(AFileName);
      for i := 0 to StrList.Count-1 do
      begin
          StringGrid1.RowCount := i+1;
          Len := Length(StrList[i]);
          j:= Pos(Chr(9),StrList[i]);
          StringGrid1.Cells[0,i] := Copy(StrList[i],0,j-1);
          StringGrid1.Cells[1,i] := Copy(StrList[i],j+1,len-j);
          if StringGrid1.Cells[1,i]<>'' then Result := Result +1;
      end;
      StringGrid1.FixedRows := 1;
    finally
      StrList.Free;
    end;
  end;
end;

procedure TfrmListFunc.FormResize(Sender: TObject);
begin
  StringGrid1.ColWidths[1] := StringGrid1.Width - StringGrid1.ColWidths[0];
end;

procedure TfrmListFunc.Button1Click(Sender: TObject);
begin
  if LastIndex <> -1 then LastIndex := DoSearch(LastSearchText,LastFindAll)
  else
  with TfrmFind.Create(Self) do
  try
    ShowModal
  finally
    if ModalResult = mrOk	then
    begin
      LastIndex := DoSearch(FindText,FindAll);
      LastSearchText := FindText;
      LastFindAll := FindAll;
    end;
    Free;
  end;
  if LastIndex <> -1 then Button1.Caption := 'Next'
  else Button1.Caption := 'Find';
end;

procedure TfrmListFunc.Button2Click(Sender: TObject);
begin
    LastIndex := -1;
    LastSearchText := '';
    LastFindAll := false;
    Button1.Caption := 'Find';
end;

initialization
  RegisterClass(TfrmListFunc);

end.

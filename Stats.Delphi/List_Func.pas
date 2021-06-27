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
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    function ListToStringGrid(AFileName: String): Integer;
  public
    { Public declarations }
  end;

var
  frmListFunc: TfrmListFunc;

implementation

{$R *.DFM}

procedure TfrmListFunc.FormCreate(Sender: TObject);
var Total : Integer;
begin
  Total := ListToStringGrid('List_Functions.txt');
  Label1.Caption := 'Function list: Count = '+IntToStr(Total) + '  (not counting overloaded functions)';
end;

function TfrmListFunc.ListToStringGrid(AFileName: String): Integer;
var f: TextFile;
  tmpStr: String;
  i,j, Len: Integer;
begin
  Result := 0;
  With StringGrid1 do
  begin
    RowCount :=1;
    Cells[0,0] := '(Unit) Name';
    Cells[1,0] := 'Description';
  end;
  i := 0;
  If FileExists(AFileName) then
  begin
    AssignFile(f,AFileName);
    try
      Reset(f);
      While Not Eof(f) do
      begin
        readln(f,tmpStr);
        Inc(i);
        StringGrid1.RowCount := i+1;
        Len := Length(tmpStr);
        j:= Pos(Chr(9),tmpStr);
        StringGrid1.Cells[0,i] := Copy(tmpStr,0,j-1);
        StringGrid1.Cells[1,i] := Copy(tmpStr,j+1,len-j);
        if StringGrid1.Cells[1,i]<>'' then Result := Result +1;
      end;
      StringGrid1.FixedRows := 1;
    finally
      CloseFile(f);
    end;
  end;
end;

procedure TfrmListFunc.FormResize(Sender: TObject);
begin
  StringGrid1.ColWidths[1] := StringGrid1.Width - StringGrid1.ColWidths[0];
end;

initialization
  RegisterClass(TfrmListFunc);

end.

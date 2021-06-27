unit Basic_DB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DB,
  DBTables, Basic_Form, StdCtrls, ExtCtrls;

type
  TfrmBasicDB = class(TfrmBasic)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBasicDB: TfrmBasicDB;

procedure CheckTable(ATable: TTable);

implementation

{$R *.DFM}

procedure CheckTable(ATable: TTable);
var tmp : TStringList;
begin
  tmp:=TStringList.Create;
  try
    Session.GetAliasNames(tmp);
    if tmp.IndexOf(ATable.DatabaseName)=-1 then
    begin
      if tmp.IndexOf('BCDEMOS')=-1 then
         Raise Exception.Create('Database BDE Alias "BCDEMOS" cannot be found.');
      ATable.DatabaseName:='BCDEMOS';
    end;
  finally
    tmp.Free;
  end;
end;


end.
 
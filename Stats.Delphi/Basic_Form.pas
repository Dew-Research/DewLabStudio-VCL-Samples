unit Basic_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmBasic = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBasic: TfrmBasic;

implementation

{$R *.DFM}

procedure TfrmBasic.FormCreate(Sender: TObject);
begin
  {}
end;

end.

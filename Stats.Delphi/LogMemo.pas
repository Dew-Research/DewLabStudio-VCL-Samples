unit LogMemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmLogForm = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogForm: TfrmLogForm;

implementation

{$R *.DFM}

procedure TfrmLogForm.Button1Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

end.

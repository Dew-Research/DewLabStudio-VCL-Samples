unit Find_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmFind = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    FindAll: boolean;
    FindText: String;
  end;

var
  frmFind: TfrmFind;

implementation

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TfrmFind.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FindText := Edit1.Text;
  FindAll := CheckBox1.Checked;
end;

end.

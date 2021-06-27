unit Basic2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls;

type
  TBasicForm2 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    RichEdit1: TRichEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    TimeCheck : DWord;
    TimeElapsed : DWord;
    { Public declarations }
  end;

var
  BasicForm2: TBasicForm2;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}


procedure TBasicForm2.FormCreate(Sender: TObject);
begin
     RichEdit1.Lines.Clear;

end;

end.

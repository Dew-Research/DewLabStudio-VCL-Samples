unit Basic3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TBasicForm3 = class(TForm)
    RichEdit1: TRichEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public                                                             
    { Public declarations }
  end;

var
  BasicForm3: TBasicForm3;

implementation

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TBasicForm3.FormCreate(Sender: TObject);
begin
     RichEdit1.Lines.Clear;
     RichEdit1.DefAttributes.Size := 10;
     RichEdit1.DefAttributes.Style := [];
end;

end.

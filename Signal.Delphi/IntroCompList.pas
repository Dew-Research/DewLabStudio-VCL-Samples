unit IntroCompList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroCompListForm = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IntroCompListForm: TIntroCompListForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TIntroCompListForm.FormCreate(Sender: TObject);
begin
  inherited;
  RichEdit1.Lines.Clear;
  RichEdit1.Lines.LoadFromFile(ExtractFilePath(Application.ExeName)+'Components.rtf');
end;

initialization
   RegisterClass(TIntroCompListForm);

end.

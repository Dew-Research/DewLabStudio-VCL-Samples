unit IntroUnderConstr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroUnderConstrForm = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IntroUnderConstrForm: TIntroUnderConstrForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TIntroUnderConstrForm.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    DefAttributes.Size := 12;
    DefAttributes.Style := [fsBold];
    SelAttributes.Size := 14;

    SelAttributes.Color := RGB(51,51,153);
    Add('Under construnction!');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
//    Add('Zoom-spectrum filter'+#10+#13);
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
  end;
end;

initialization
  RegisterClass(TIntroUnderConstrForm);

end.

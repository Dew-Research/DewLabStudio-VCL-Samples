unit IntroKalman;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroKalmanForm = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IntroKalmanForm: TIntroKalmanForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TIntroKalmanForm.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    DefAttributes.Size := 10;
    DefAttributes.Style := [fsBold];
    SelAttributes.Size := 12;

    SelAttributes.Color := RGB(51,51,153);
    Add('Kalman filtering:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;

    Add('Standard and extended Kalman filtering algorithms.');
    Add('Fully customizable user interface allowing variation of all variables with every iteration.');
		Add('Vectorized implementation optimized for handling of large states.');

    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
  end;
end;

initialization
  RegisterClass(TIntroKalmanForm);

end.

unit RegisterSignal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TRegisterSignalForm = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegisterSignalForm: TRegisterSignalForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TRegisterSignalForm.FormCreate(Sender: TObject);
begin
  inherited;
  RichEdit1.Lines.Clear;
  RichEdit1.Lines.LoadFromFile(ExtractFilePath(Application.ExeName)+'RegisterSignal.rtf');
end;

initialization
   RegisterClass(TRegisterSignalForm);

end.

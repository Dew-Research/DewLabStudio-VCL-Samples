unit IntroApplication;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroApplicationForm = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IntroApplicationForm: TIntroApplicationForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TIntroApplicationForm.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    DefAttributes.Size := 10;
    DefAttributes.Style := [fsBold];
    SelAttributes.Size := 12;

    SelAttributes.Color := RGB(51,51,153);
    Add('Building applications:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('All key components have ready to use user dialogs.');
    Add('All components support streaming of their states and/or data ' +
        'to and from TStream. Partial or complete application configuration ' +
        'can be saved or restored instantly.');
    Add('With only a few drop-in components a signal analysis ' +
        'application with complete user interface can be built!');
    Add('Real-time and off-line processing.');
    Add('By changing a DEFINE statement the application can be recompiled ' +
        'in double or single precision!');
    Add('Instant support for latest CPU architectures via dll update!');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
  end;
end;

initialization
   RegisterClass(TIntroApplicationForm);


end.

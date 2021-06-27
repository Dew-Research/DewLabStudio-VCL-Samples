unit IntroDesign;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroDesignForm = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IntroDesignForm: TIntroDesignForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TIntroDesignForm.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    DefAttributes.Size := 10;
    DefAttributes.Style := [fsBold];

    SelAttributes.Size := 12;
    SelAttributes.Color := RGB(51,51,153);
    Add('Architecture of the library is organized in three ' +
        'layers: ');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Complete set of signal processing routines based on MtxVec.');
    Add('With a set of components based on signal processing routines ' +
        ' your application gets a jump start in user interface and processing power.');
    Add('Connectivity layer gives you the capability to visually programm ' +
        'DSP algorithm''s by connecting components.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
  end;
end;

initialization
   RegisterClass(TIntroDesignForm);

end.

unit IntroVectors;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroVec = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IntroVec: TIntroVec;

implementation

{$R *.DFM}

procedure TIntroVec.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    DefAttributes.Size := 12;
    DefAttributes.Style := [fsBold];
    SelAttributes.Size := 14;

    SelAttributes.Color := RGB(51,51,153);
    Add('UnderConstruction');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Real and complex FFT');
    Add('Auto and cross correlations');
    Add('Convolution and filtering');
    Add('Complete vector arithmetic');
    Add('Sorting real and complex numbers');
    Add('Random generators'+#10+#13);
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
  end;
  TButton(Self.Owner.FindComponent('btnHelp')).Enabled := false;
end;

initialization
  RegisterClass(TIntroVec);

end.

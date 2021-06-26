unit IntroExport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroExpImp = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
                                                                     
var
  IntroExpImp: TIntroExpImp;

implementation

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TIntroExpImp.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('Quick and easy Export/Import to screen, file, '
      + 'database... text or binary.');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Values to string, Strings to values (real and complex)');
    Add('Read/Write stream');
    Add('Read/Write file');
    Add('Read/Write string grid');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('Ready to use Matrix Viewer and charting tools:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Use ViewValues to display the contents of the matrix or vector');
    Add('Edit data on the fly');
    Add('Draw data while viewing');
    Add('Save/Load from file');
    Add('Use DrawValues and DrawIt for immediate data display');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
  end;
end;

initialization
   RegisterClass(TIntroExpImp);

end.

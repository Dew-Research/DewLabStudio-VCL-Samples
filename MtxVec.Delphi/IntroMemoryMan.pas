unit IntroMemoryMan;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroMemMan = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
                                                     
var
  IntroMemMan: TIntroMemMan;

implementation

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TIntroMemMan.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('Enhanced memory handling:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Built in dynamic memory allocation makes it easier for the user');
    Add('Object cache with object precreation speeds up Create and Destroy');
    Add('Memory preallocation gives instant access to new memory.');
    Add('Super conductive object cache allows linear multi-core scaling with CPU core count!');
    Add('Dedicated memory allocated per thread typically does not exceed CPU cache size (2MB). This makes the processing memory and CPU cache efficient.');
    Add('Object cache does not interfere with other parts of the application which continue to use the default memory manager. Only those parts of code running via TMtxThread and using MtxVec object cache are affected.');

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('Array access options:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Default arrays allow cleaner syntax');
    Add('Array pointers give you more speed');
    Add('Single memory block matrices allow even faster matrix operations');

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
  end;
end;

initialization
   RegisterClass(TIntroMemMan);

end.

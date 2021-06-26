unit DemoHowTo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Basic3, StdCtrls, ComCtrls;

type
  TfrmDemoHowTo = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDemoHowTo: TfrmDemoHowTo;

implementation

{$IFDEF CLR}
  {$R *.NFM}
{$ELSE}
  {$R *.DFM}
{$ENDIF}

procedure TfrmDemoHowTo.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('Usage instructions for the demo app:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('You can see the source code of each form by pressing the "Source Code" tab at the bottom of the form.');
    Add('Each form can be recompiled as a standalone application. ' +
        'All you have to do is add the form to a newly created project and press F9.');
    Add('There are no code dependancies between individual forms. Each form is a ' +
        'standalone working application and entire source required to implement the ' +
        'behaviour is implemented in that one unit.');
    Add('Many forms have usage instructions at the top of the window.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');
  end;

end;

initialization
  RegisterClass(TfrmDemoHowTo);

end.

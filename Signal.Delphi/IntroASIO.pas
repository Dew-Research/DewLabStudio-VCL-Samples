unit IntroASIO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroASIOForm = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IntroASIOForm: TIntroASIOForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TIntroASIOForm.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    DefAttributes.Size := 10;
    DefAttributes.Style := [fsBold];
    SelAttributes.Size := 12;

    SelAttributes.Color := RGB(51,51,153);
    Add('Real time audio processing using Steinberg ASIO:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('High performance wrappers for concurrent playback and recording');
    Add('Support for processing within and outside of the drivers thread.');
    Add('Auto bit-depth conversion');
    Add('Auto buffer size conversion');
    Add('Click protection for start, stop and pause.');
    Add('Implements playback and recording skip protection buffers.');
    Add('Real-time monitoring of playback and recording streams.');
    Add('Support for multiple ASIO devices.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

//    DefAttributes.Size := 10;
//    DefAttributes.Style := [fsBold];
//    SelAttributes.Size := 12;

    SelAttributes.Color := RGB(51,51,153);
    Add('Important notes:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Use of ASIO drivers requires hardware (sound card) which includes ASIO drivers.');
    Add('ASIO bit-depth and sampling frequency is defined by the driver and cannot be changed from the application.');
    Add('Both playback and recording use same bit-depth and sampling frequency.');
    Add('A single ASIO driver can only be used by one application at one time.');
    Add('ASIO drivers can be simulated with ASIO4ALL (free driver set).');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
  end;
end;

initialization
  RegisterClass(TIntroASIOForm);

end.

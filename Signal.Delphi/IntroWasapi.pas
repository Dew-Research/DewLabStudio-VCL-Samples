unit IntroWasapi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroWASAPIForm = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IntroWASAPIForm: TIntroWASAPIForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TIntroWASAPIForm.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    DefAttributes.Size := 10;
    DefAttributes.Style := [fsBold];
    SelAttributes.Size := 12;

    SelAttributes.Color := RGB(51,51,153);
    Add('Real time audio processing using low level Windows WASAPI drivers:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('High performance low latency playback and recording (5ms latency)');
    Add('Allows bypass of all Windows audio processing with Exclusive mode. Especially usefull when recording.');
    Add('Support for processing within and outside of the drivers thread.');
    Add('Auto bit-depth conversion');
    Add('Auto buffer size conversion');
    Add('Auto sample rate conversion for both recording and playback if required.');
    Add('Click protection for start, stop and pause.');
    Add('Implements playback and recording skip protection buffers.');
    Add('Real-time monitoring of playback and recording streams.');
    Add('Support for shared and exclusive mode.');
    Add('Device capability detection (bit depth, sampling frequency).');
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
    Add('Requires Windows Vista Update 1.');
    Add('In case of Exclusive mode the bit-depth and sampling frequency are defined by the driver.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
  end;
end;

initialization
  RegisterClass(TIntroWASAPIForm);

end.

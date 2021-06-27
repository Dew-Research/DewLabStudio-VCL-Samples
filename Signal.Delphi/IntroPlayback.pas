unit IntroPlayback;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroPlaybackForm = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IntroPlaybackForm: TIntroPlaybackForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TIntroPlaybackForm.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    DefAttributes.Size := 10;
    DefAttributes.Style := [fsBold];
    SelAttributes.Size := 12;

    SelAttributes.Color := RGB(51,51,153);
    Add('Playback and record with Windows Multimedia API (Legacy drivers):');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('96kHz/24 bit extensible audio format support.');
    Add('8,16,24 and 32 bit support for reading/writing, playback/recording');
    Add('Support for Windows XP and forward.');
    Add('Arbitrary sampling frequency.');            
    Add('Multichannel audio card support.');
    Add('Audio compression manager support when reading wav files.');    
    Add('Real time signal monitor during playback and recording.');
    Add('Triggering support with pre-trigger, post-trigger,..');
    Add('Configurable display delay and skip protection for trigger and monitoring.');
    Add('Full access to audio buffers.');
    Add('Additional binary/text file format support.');
    Add('Ready to use user interface instantly adds playback/recording capabilities to any application.');    
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
  end;
end;

initialization
   RegisterClass(TIntroPlaybackForm);


end.

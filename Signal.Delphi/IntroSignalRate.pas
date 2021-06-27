unit IntroSignalRate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroSignalRateForm = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IntroSignalRateForm: TIntroSignalRateForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TIntroSignalRateForm.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    DefAttributes.Size := 10;
    DefAttributes.Style := [fsBold];
    SelAttributes.Size := 12;

    SelAttributes.Color := RGB(51,51,153);
    Add('Fractional rate conversion algorithms:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Unique filtering logic with exceptional speed.');
    Add('All linear phase, multi-rate filter design.');
    Add('All filter designs allow 160dB maximum stop band attenuation.');
    Add('User definable transition bandwidth.');
    Add('Real number sampling rate conversion factor.');
    Paragraph.Numbering := nsNone;    
    Paragraph.FirstIndent := 0;
  end;
end;

initialization
  RegisterClass(TIntroSignalRateForm);

end.

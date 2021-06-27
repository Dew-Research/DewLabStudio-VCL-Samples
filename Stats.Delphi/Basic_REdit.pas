unit Basic_REdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, RichEdit;

type
  TfrmBaseRichEdit = class(TForm)
    RichEdit1: TRichEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBaseRichEdit: TfrmBaseRichEdit;

implementation

{$R *.dfm}

procedure InitRichEditURLDetection(RE: TRichEdit);
var mask: Word;
begin
  {$R-}
  mask := SendMessage(RE.Handle, EM_GETEVENTMASK, 0, 0);
  SendMessage(RE.Handle, EM_SETEVENTMASK, 0, mask or ENM_LINK);
  SendMessage(RE.Handle, EM_AUTOURLDETECT, Integer(True), 0);
end;


procedure TfrmBaseRichEdit.FormCreate(Sender: TObject);
begin
  InitRichEditURLDetection(RichEdit1);
end;

end.

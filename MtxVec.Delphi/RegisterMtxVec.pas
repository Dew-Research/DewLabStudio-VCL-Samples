unit RegisterMtxVec;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TRegisterM = class(TBasicForm3)     
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegisterM: TRegisterM;

implementation

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TRegisterM.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    Add('');
    Add('You may use MtxVec trial version without any costs for the period of one month. MtxVec trial version runs within IDE only. '
      + 'If you wish to keep on using it after one month, you need to pay a license fee.');
    Add('');
    Add('MtxVec will still function even if you don''t register after one month. If the trial version is used for educational '
      + 'purposes, it can be used for a longer period, but you need to register it''s use by sending an email to support@dewresearch.com');
    Add('');
    Add('When new versions of MtxVec are released, you will be able to download them from www.dewresearch.com.  Your MtxVec license '
      + 'will be valid for all future minor and major version upgrades of MtxVec for a period of one year. Tech support is fee free with 48hrs response.');
    Add('');
    Add('For MtxVec pricing info and offline and online ordering methods, please visit http://www.dewresearch.com/order where '
      + 'you will find all the information that you need.  If you would still have any questions, send an email to sales@dewresearch.com.');
  end;
end;

initialization
   RegisterClass(TRegisterM);

end.

unit Oder_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Basic_REdit, StdCtrls, ComCtrls;

type
  TfrmOrder = class(TfrmBaseRichEdit)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOrder: TfrmOrder;

implementation

{$R *.dfm}

procedure TfrmOrder.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1, RichEdit1.Lines do
  begin
    Clear;
    DefAttributes.Size := 11;
    SelAttributes.Size := 16;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Ordering Stats Master');
    Add('');
    Add('You may use Stats Master trial version without any costs '+
        'for the period of one month. Applications which include '+
        'Stats Master Trial version will allways start with a nag screen '+
        'reminding you are using Trial version. If you wish to keep '+
        'on using it after one month, you have to register it with the '+
        'Dew Research and pay a registration fee. Stats Master will still '+
        'function even if you don''t register after one month. If the '+
        'trial version is used for educational purposes, it can be used '+
        'for a longer period, but you have to register it''s use by sending '+
        'an email to info@dewresearch.com .');
    Add('Once you have registered, you will receive fully functional packages ' +
        'and links to our dll repository by email. When new versions of Stats Master '+
        'are released, you will be able to download them from www.dewresearch.com.');
    Add('Your Stats Master license will be valid for minor and major version '+
        'upgrades for a period of one year from the date of purchase. From that date ' +
        'on you will have the option to extend the subscription period. Tech ' + 
        'support is fee free with 48h response.');
    Add(chr(10));
    Add('NOTE: Stats Master is build on top of the latest MtxVec package and therefore requres it.' +
        'For MtxVec and Stats Master pricing info and offline and online ordering methods, '+
        'please visit http://www.dewresearch.com/order.htm where you will find all the '+
        'information that you need. If you would still have any questions, send an email '+
        'to sales@dewresearch.com.');
  end;
end;

initialization
  RegisterClass(TfrmOrder);

end.

unit Wizard_Hotelling;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Basic_Form, StdCtrls, ExtCtrls;

type
  TfrmShowHotellingWizard = class(TfrmBasic)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmShowHotellingWizard: TfrmShowHotellingWizard;

implementation

Uses HotellingT2;

{$R *.dfm}

procedure TfrmShowHotellingWizard.FormCreate(Sender: TObject);
begin
  inherited;
  With Memo1.Lines do
  begin
    Clear;
    Add('One or two sample Hotelling-T2 test');
    Add(chr(13));
    Add('Hotelling''s T2 test is the multivariate extension of the Student t-test. In a t-test, differences in'
      + 'the mean response between populations are studied. T2 is used when the number of response variables '
      + 'are two or more, although it can be used when there is only one response variable. '
      + 'The null hypothesis is that the group means for all response variables are equal. Alternatively, '
      + 'you can also specify the mean for each variable and test against this hypothesis.');
  end;

  With TfrmHotellingWizard.Create(Self) do
  begin
    Align := alClient;
    Parent := Self;
    BorderStyle := bsNone;
    BtnCancel.Visible := false; { in this case hide Cancel button }
    { load prepared data }
    X1.SetIt(20,3,false,[3.7,48.5,9.3,5.7,65.1,8.0,3.8,47.2,10.9,3.2,53.2,12.0,3.1,55.5,9.7,4.6,36.1,7.9,2.4,24.8,14.0,7.2,33.1,7.6,6.7,47.4,8.5,5.4,54.1,11.3,3.9,36.9,12.7,4.5,58.8,12.3,3.5,27.8,9.8,4.5,40.2,8.4,1.5,13.5,10.1,8.5,56.4,7.1,4.5,71.6,8.2,6.5,52.8,10.9,4.1,44.1,11.2,5.5,40.9,9.4]);
    Means.SetIt([4,50,10]);

    Show();
  end;
end;

initialization
  RegisterClass(TfrmShowHotellingWizard);

end.

unit Wizard_ARIMA;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Basic_Form, StdCtrls, ExtCtrls;

type
  TfrmWizardARIMA = class(TfrmBasic)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWizardARIMA: TfrmWizardARIMA;

implementation

{$R *.dfm}

Uses ARIMAWizard; { <--- ARMA/ARIMA wizard }

procedure TfrmWizardARIMA.FormCreate(Sender: TObject);
begin
  inherited;
  With Memo1.Lines do
  begin
    Clear;
    Add('ARMA/ARIMA model fitting and forecasting');
    Add(chr(13));
    Add('Time series analysis by using ARMA/ARIMA models');
    Add('This form demonstrates how you can use time series analysis routines for '+
        ' approximating and forecasting time series values with ARMA/ARIMA models. '+
        '  In this case sample time series is preloaded with it''s mean value removed.' +
        ' Time series still doesn''t "look" stationary. Try differencing time series to obtain'+
        ' approximately stationary series.');
    Add('You can also test this wizard with your data - just press the "Load" '+
        ' button on the first wizard page.');
  end;

  with TfrmARIMAWizard.Create(Self) do
  begin
    Align := alClient;
    Parent := Self;
    BorderStyle := bsNone;
    BtnCancel.Visible := false; { in this case hide Cancel button }
    { load prepared data }
    try
      TimeSeries.LoadFromFile('dowjones.vec');
      TimeSeries.Caption := 'dowjones.vec';
    except
    end;
    Show();
  end;
end;

initialization
  RegisterClass(TfrmWizardARIMA);

end.

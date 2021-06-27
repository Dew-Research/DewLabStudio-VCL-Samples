unit Changes11;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Basic_REdit, StdCtrls, ComCtrls;

type
  TfrmChanges11 = class(TfrmBaseRichEdit)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChanges11: TfrmChanges11;

implementation

{$R *.dfm}

procedure TfrmChanges11.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1, RichEdit1.Lines do
  begin
    Clear;
    SelAttributes.Size := 14;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Release 1.1: List of changes');
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('Statistics.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Added Chi-Squared and F tests for comparing variance(s).');
    Add('Added Spearman rank correlation test.');
    Add('Added LogNormalFit routine for fitting log-normally distributed values.');
    Add('Fixed the internal TiedRank routine (in some special cases ranks were not calculated correctly) '
      + 'and moved it to public section.');
    Add('Added autocovariance, autocorrelation and partial autocorellation functions.');
    Add('Added Chi2 Goodness of fit test routines.');
    Add('Added Shapiro-Wilks and Shapiro-Francia Goodness of fit test routines.');
    Add('Minor bug fixes.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('StatSeries.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Added control limits calculation for R-Chart.');
    Add('Added EWMA chart calculation.');
    Add('Removed the probability axis tool. Now the relevant code is included '
      + 'in probability series (simplified code - see updated example in Statistics demo).');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('Regress.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Fixed R2 calculation for Constant := false case.');
    Add('Added logistic (simple and ordinal) regression routines.');
    Add('Minor bug fixes');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('StatTools.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('New TMtxLogistReg component which encapsulates '
      + 'logistic regression routines.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('StatARIMA.pas (ALPHA VERSION, NOT YET OFFICIALLY SUPPORTED)');
    Add('');
    Add('New unit which introduces several routines for ARMA and ARIMA processes. '
      + 'These routines are still in testing and not yet fully developed. This goes for '
      + 'EstimateArima and PredictArima routines.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
  end;
end;

initialization
  RegisterClass(TfrmChanges11);
end.

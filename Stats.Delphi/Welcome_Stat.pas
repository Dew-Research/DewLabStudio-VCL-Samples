unit Welcome_Stat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Basic_REdit, StdCtrls, ComCtrls;

type
  TfrmWelcome = class(TfrmBaseRichEdit)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWelcome: TfrmWelcome;

implementation

{$R *.dfm}

procedure TfrmWelcome.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1, RichEdit1.Lines do
  begin
    Clear;
    DefAttributes.Size := 10;
    SelAttributes.Size := 14;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Welcome to Stats Master');
    Add('');
    Add('Stats Master is a (c) MtxVec Add-On library with many statistical and mathematical routines.' +
        ' It comes with:');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('25 different distributions random generators');
    Add('One and two parameter(s) hypothesis testing');
    Add('Non-parametric hypothesis testing');
    Add('Analysis of variance');
    Add('Principal component analysis');
    Add('Multidimensional scaling, FA');
    Add('Linear and multiple linear regression');
    Add('Non-linear regression');
    Add('Poissom, Logistic regression');
    Add('Special statistical plots');
    Add('Quality control charts');
    Add('Time series analysis and prediction');
    Add('Easy-to-use set of components');
    Add('and many more...');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    Add('Stats Master demonstrates how easy, fast and performance efficient it'+
        ' is to build advanced numerical algorithms with MtxVec. Many of the essential'+
        ' statistical routines presented in this package were not available to'+
        ' Delphi developers at all - until now.');
    Add('');
    Add('Navigate through the demo application, to learn more '+
        'about Stats Master and experience it''s unmatched '+
        ' performance and ease of use.');
  end;
end;

initialization
  RegisterClass(TfrmWelcome);

end.

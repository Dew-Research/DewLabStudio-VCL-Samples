unit Quick_Start;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TfrmQuickStart = class(TForm)
    RichEdit1: TRichEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQuickStart: TfrmQuickStart;

implementation

{$R *.DFM}

procedure TfrmQuickStart.FormCreate(Sender: TObject);
var St: String;
begin
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    DefAttributes.Size := 11;
    SelAttributes.Size := 16;
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    Add('Quick start: Multiple linear regression.');
    Add('');
    Add('With Stats Master it''s not difficult to do complex tasks. Doing multiple linear '+
        'regression is a peace of cake:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Add MtxVecEdit, MtxVec to Uses section.');
    Add('Drop TMtxMulLinReg component and TButton on the form.');
    Add('Bring up the TMtxMulLinReg design time editor by double  clicking  on MtxMulLinReg1.');
    Add('Define Y, A and (optionally) Weights. You can do this at design time or at runtime (load values from file, stream...).'+
      'Close TMtxMulLinReg editor.');
    Add('Double click on Button1 and add the following code:');
    Paragraph.FirstIndent := 20;
    Paragraph.Numbering := nsNone;
    Add('');
    St := 'MtxMulLinReg1.Recalculate;'+#13+
          'ViewValues(MtxMulLinReg1.RegressResult.B,''Regression coefficients'',True,False);';
    SelAttributes.Name := 'Courier New';
    Add(st);
    Paragraph.FirstIndent := 0;
    Add('');
    Add('Other thing to try:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Access RegressResult properties (YCalc, Residuals). Draw these  values by using '+
        'DrawValues method (in this case add MtxVecTee to Uses section).');
    Add('Copy Y, A data from Excel table. Repeat procedure.');
    Add('Load Y,A data from ASCII file (demonstrated in demo). Repeat  procedure.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');
  end;
end;

initialization
  RegisterClass(TfrmQuickStart);

end.

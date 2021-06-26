unit Changes101;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TfrmChanges101 = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChanges101: TfrmChanges101;

implementation

{$IFDEF CLR}
  {$R *.NFM}
{$ELSE}
  {$R *.DFM}
{$ENDIF}

procedure TfrmChanges101.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('List of new features in v1.0.1:');
    Add('');

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('MtxVec.pas and Math387.pas :');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('More thread safety for dlls and MtxVec.pas');
    Add('Better single precision support for Delphi');
    Add('StrToCplx now works with any string formating');
    Add('StrToVal same as StrToFloat except for NAN and INF');
    Add('StringsToValues uses new StrToCplx and StrToVal methods');
    Add('SaveToStream now has a parameter for precision rounding type');
    Add('LoadFromStream now loads any precision and has new version control');
    Add('LoadFromFile now uses LoadFromStream');
    Add('Added property editors and IDE streaming to TMtx and TVec objects');
    Add('TVec Rotate method now accepts negative indexes');
    Add('Most trigonometric functions now use VML');
    Add('TVec : added DivideVec, Cbrt, InvCbrt, InvSqrt methods');
    Add('Improved algorithm for CreateIt and FreeIt procedures'+#10+#13);

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('Probabilities.pas :');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Added 4 new distributions : Cauchy, Maxwell, '
      + 'Pareto and  Rayleigh PDF,CDF and inverse CDF'+#10+#13);

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('Optimization.pas :');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Removed global variables/functions. Now all '
        + 'procedures/functions are thread-safe');
    Add('Improved the numerical gradient and Hessian '
        + 'matrix calculation algorithm');
    Add('Improved BFGS method');
    Add('MinBrent now returns number of iterations '
        + 'needed to reach minimum value. Minimum position '
        + 'is now stored in MinX variable'+#10+#13);

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('MtxVecEdit.pas :');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('MtxVecEdit form does not save changes if not '
        + 'displayed modaly');
    Add('"Copy as Real" option allows copying complex '
        + 'matrix as real columns');
    Add('"Paste as Complex" option allows pasting '
        + 'real colums as complex matrix');
    Add('The new "Copy as Real" and "Paste as Complex" '
        + 'options allow copying/pasting tables from '
        + 'Word or Excel');
    Add('TeeChart dependant code has been moved from '
        + 'MtxVecEdit to MtxVecTee unit'+#10+#13);

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('MtxVecTools.pas :');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('New unit encapsulates all MtxVec components');
    Add('TMtxOptimization component - interfaces Optimization unit'+#10+#13);

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('MtxDBTools.pas :');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('New unit encapsulates all MtxVec DB components');
    Add('TMtxDataset component - provides direct read/write '
        + 'access to any TDataset descendant'+#10+#13);

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('Miscellaneous :');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('New installer automatically instals help files, '
        + 'runtime/design time packages and all MtxVec files.'+#10+#13);
  end;
end;

initialization
  RegisterClass(TfrmChanges101);


end.

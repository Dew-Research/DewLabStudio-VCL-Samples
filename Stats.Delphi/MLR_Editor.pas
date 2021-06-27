unit MLR_Editor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_Form, StdCtrls, ExtCtrls, StatTools, MtxBaseComp, StatMulLinRegEditor, StatToolsDialogs;

type
  TfrmMLREditor = class(TfrmBasic)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    RegDialog: TMulLinRegDialog;
    MtxMulLinReg: TMtxMulLinReg;
    { Private declarations }
    procedure CustomizeEditorForm(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmMLREditor: TfrmMLREditor;

implementation

{$R *.DFM}

{ This example also demonstrates, how you can fully
  custmize component editor
}
procedure TfrmMLREditor.CustomizeEditorForm(Sender: TObject);
begin
  with TMulLinRegressEditor(Sender) do
  begin
    ButtonOK.Visible := false;
    ButtonCancel.Visible := false;
  end;
end;

procedure TfrmMLREditor.FormCreate(Sender: TObject);
begin
  inherited;
  With Memo1.Lines do
  begin
    Clear;
    Add('Ready to use multiple linear regression editor can be '+
        ' invoked with a single  procedure call (see the code) or '+
        ' simply by dropping a TMtxMulLinReg component on the form '+
        ' and then double clicking on it.');
    Add('Try changing data and parameters ...');

  end;
  MtxMulLinReg := TMtxMulLinReg.Create(Self);
  { load prepared data }
  try
    MtxMulLinReg.Y.LoadFromFile('MulLinReg_Y.vec');
    MtxMulLinReg.A.LoadFromFile('MulLinReg_A.mtx');
  except
  end;
  { invoke editor }
  { normally you would use ShowDialog(....) procedure }
  RegDialog := TMulLinRegDialog.Create(Self);

  RegDialog.OnBeforeUpdate := CustomizeEditorForm; { here we customize editor form }
  RegDialog.Source := MtxMulLinReg;
  RegDialog.Execute(Self);
end;


procedure TfrmMLREditor.FormDestroy(Sender: TObject);
begin
  MtxMulLinReg.Free;
  RegDialog.Free;
  inherited;
//
end;

initialization
  RegisterClass(TfrmMLREditor);
end.


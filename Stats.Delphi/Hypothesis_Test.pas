unit Hypothesis_Test;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_Form, StdCtrls, ExtCtrls, StatTools, MtxBaseComp;

type
  TfrmHypTest = class(TfrmBasic)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    MtxHypTest: TMtxHypothesisTest;
    procedure CustomizeEditorForm(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmHypTest: TfrmHypTest;

implementation

Uses StatHypTestEditor, { <--- Hypothesis editor }
     StatToolsDialogs, Math387;
{$R *.DFM}

{ This example also demonstrates, how you can fully
  custmize component editor
}
procedure TfrmHypTest.CustomizeEditorForm(Sender: TObject);
begin
  with THypothesisTestEditor(Sender) do
  begin
    ButtonOK.Visible := false;
    ButtonCancel.Visible := false;
  end;
end;

procedure TfrmHypTest.FormCreate(Sender: TObject);
begin
  inherited;
  With Memo1.Lines do
  begin
    Clear;
    Add('Ready-to use hypothesis testing editor can be invoked with a single '+
        ' procedure call (see the code) or simply by dropping a TMtxHypothesisTest '+
        ' component on the form and then double clicking on it.');
    Add('Try changing data, hypothesis type and hypothesis method...');
  end;
  MtxHypTest := TMtxHypothesisTest.Create(Self);
  { add some sample data }
  MtxHypTest.DataVec1.Size(50);
  MtxHypTest.DataVec2.Size(50);
  MtxHypTest.DataVec1.RandGauss(5.0,0.2);
  MtxHypTest.DataVec2.RandGauss(3,0.2);
  MtxHypTest.Mean := 5.0;
  MtxHypTest.Sigma := 0.2;
  { invoke editor }
  { normally you would use ShowDialog(....) procedure }
  with THypothesisTestDialog.Create(Self) do
  begin
    OnBeforeUpdate := CustomizeEditorForm; { here we customize editor form }
    Source := MtxHypTest;
    Execute(Self);
  end;
end;

procedure TfrmHypTest.FormDestroy(Sender: TObject);
begin
  MtxHypTest.Free;
  inherited;
end;

initialization
  RegisterClass(TfrmHypTest);

end.

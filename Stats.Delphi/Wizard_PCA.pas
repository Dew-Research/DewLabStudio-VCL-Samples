unit Wizard_PCA;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_Form, StdCtrls, ExtCtrls;

type
  TfrmShowPCAWizard = class(TfrmBasic)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmShowPCAWizard: TfrmShowPCAWizard;

implementation

Uses PCAWizard, Statistics;

{$R *.DFM}

procedure TfrmShowPCAWizard.FormCreate(Sender: TObject);
begin
  inherited;
  With Memo1.Lines do
  begin
    Clear;
    Add('Principal Component Analysis (PCA)');
    Add(chr(13));
    Add('PCA can be done with only one procedure call :');
    Add('PCA(Data,PrinCom,EigValues,ZScores,VarPercent);');
    Add('This form demonstrates how you can use basic and advanced '+
        ' Statistics procedures. In this case PCA data is pre-loaded.' +
        ' But you can test this with your data - just press the "Edit" '+
        ' button...');
  end;

  With TfrmPCAWiz.Create(Self) do
  begin
    Align := alClient;
    Parent := Self;
    BorderStyle := bsNone;
    BtnCancel.Visible := false; { in this case hide Cancel button }
    { load prepared data }
    try
      MTXPCA.Data.LoadFromFile('PCA_Data.mtx');
      MTXPCA.PCAMode := PCARawData;
    except
    end;
    Show();
  end;
end;

initialization
  RegisterClass(TfrmShowPCAWizard);

end.

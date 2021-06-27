unit Wizard_MLReg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_Form, StdCtrls, ExtCtrls;
                              
type
  TfrmShowMLRWizard = class(TfrmBasic)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmShowMLRWizard: TfrmShowMLRWizard;

implementation

uses MLRegWizard;  { <--- Custom wizard, you can chage it at will <g> }

{$R *.DFM}

procedure TfrmShowMLRWizard.FormCreate(Sender: TObject);
begin
  inherited;
  With Memo1.Lines do
  begin
    Clear;
    Add('By using TMtxMulLinReg component you can easiliy perform'+
        ' multiple linear regression. Just add a matrix of independent'+
        ' variables, vector of dependent variable and (optionally)'+
        ' weights and let Statistics regression routines do the rest.');
  end;

  With TfrmMulLinRegWiz.Create(Self) do
  begin
    Align := alClient;
    Parent := Self;
    BorderStyle := bsNone;
    BtnCancel.Visible := false; { in this case hide Cancel button }
    { load prepared data }
    try
      MtxMulLinReg.Y.LoadFromFile('MulLinReg_Y.vec');
      MtxMulLinReg.A.LoadFromFile('MulLinReg_A.mtx');
    except
    end;
    Show();
  end;
end;

initialization
  RegisterClass(TfrmShowMLRWizard);

end.

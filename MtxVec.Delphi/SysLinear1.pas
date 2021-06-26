unit SysLinear1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic2, StdCtrls, ExtCtrls,MtxVecEdit,MtxVec, Grids, ComCtrls, MtxExpr;

type
  TLinearSystem1 = class(TBasicForm2)
    StringGrid1: TStringGrid;
    Label1: TLabel;
    StringGrid2: TStringGrid;                 
    Label2: TLabel;
    Label3: TLabel;
    StringGrid3: TStringGrid;
    Label4: TLabel;
    Label5: TLabel;
    Button1: TButton;
    Panel4: TPanel;
    Memo2: TMemo;
    RadioGroup1: TRadioGroup;
    CheckBox1: TCheckBox;
    Label6: TLabel;
    ComboBox1: TComboBox;
    Panel5: TPanel;
    Label7: TLabel;
    StringGrid4: TStringGrid;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    A: Matrix;
    b,x,S : Vector;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LinearSystem1: TLinearSystem1;

implementation

Uses MtxDialogs;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TLinearSystem1.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    Add('MtxVec offers three different methods to solve a system '
      + 'of linear equations : LU, LQR and singular value '
      + 'decomposition. Each of these methods has its advantages '
      + 'and disadvantages. Try changing values in matrix A, '
      + 'vector b and method used to calculate the solution vector '
      + 'x. The displayed matrix is nearly singular. You can add '
      + 'more non-zero elements to the diagonal to make it non-singular.');
    Add('In practice, most computations are performed with rounding '
      + 'errors. The LUSolve method offers you additional tools for '
      + 'refining the solution and estimating its error. They are '
      + 'evaluated only if RefineSolution is set to true');
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('Parameters in this demo :');
    Add('ConditionNr: If your matrix is ill-conditioned '
      + '(that is, it''s ConditionNr is very small), then the error in '
      + 'the solution x is also large. ');
    Add('BackError: the smallest relative perturbation in elements '
      + 'of A and b such that x is the exact solution of the perturbed '
      + 'system.');
    Add('ForwError: the component-wise forward error in the computed '
      + 'solution.');
    Add('');
    Add('Try changing the matrix values and observe the solution, CondtionNr, ForwError and BackError.');
  end;
  A.SetIt(4,4,false,[0.001,  0,     0, 0,
                     3    ,0.001,   0, 0,
                     2.5  ,  2,     3, 0,
                     4    , -1,   0.5, 0.1]);
  b.Size(4);
  b.Setit([3,1.5,-2,4]);
  X.Size(0);
  S.Size(0);
  ValuesToGrid(A,StringGrid1,0,0,'0.0000',false);
  ValuesToGrid(b,StringGrid3,0,0,'0.0000',false);
  ComboBox1.ItemIndex := 0;
  ComboBox1Change(ComboBox1);
  CheckBox1Click(CheckBox1);
  RadioGroup1Click(RadioGroup1);
end;

procedure TLinearSystem1.Button1Click(Sender: TObject);
begin
  GridToValues(A,StringGrid1,A.Complex,false);
  GridToValues(b,StringGrid3,b.Complex,true,false);
  Case ComboBox1.ItemIndex of
  0:begin
      A.LUSolve(b,x);
      Memo2.Lines.Clear;
      if CheckBox1.Checked and (RadioGroup1.ItemIndex <> 0) then
      begin
           Memo2.Lines.Add('Forward error = '+ FormatFloat('0.0000E+00 ',A.ForwError));
           Memo2.Lines.Add('Backward error = '+ FormatFloat('0.0000E+00 ',A.BackError));
           Memo2.Lines.Add('ConditionNr = '+ FormatFloat('0.0000E+00',A.ConditionNr));
      end;
    end;
  1:begin
      A.SVDSolve(b,x,S);
      ValuesToGrid(S,StringGrid4,0,0,'0.0000E+00',false);
    end;
  end;
  ValuesToGrid(x,StringGrid2,0,0,'0.0000E+00',false);
end;

procedure TLinearSystem1.CheckBox1Click(Sender: TObject);
begin
  A.RefineSolution := TCheckBox(Sender).Checked;
end;

procedure TLinearSystem1.RadioGroup1Click(Sender: TObject);
begin
     Case TRadioGroup(Sender).ItemIndex of
       0:   A.ConditionNumber := cnNone;
       1:   A.ConditionNumber := cnNorm1;
       2:   A.ConditionNumber := cnNormInf;
     end;
end;

procedure TLinearSystem1.ComboBox1Change(Sender: TObject);
begin
  Panel4.Visible := TComboBox(Sender).ItemIndex = 0;
  Panel5.Visible := TComboBox(Sender).ItemIndex = 1;
  Memo2.Lines.Clear;
end;

initialization
   RegisterClass(TLinearSystem1);

end.

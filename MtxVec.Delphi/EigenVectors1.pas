unit EigenVectors1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic2, StdCtrls, ComCtrls, ExtCtrls,MtxVec,Math387, Grids,
  Buttons, MtxExpr;

type
  TEigVec1 = class(TBasicForm2)
    StringGrid4: TStringGrid;
    StringGrid2: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;                                     
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    Label3: TLabel;
    StringGrid1: TStringGrid;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Button1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    A,EigL,EigR: Matrix;
    EigValues : Vector;
    VecForm : TVectorForm;
    Bal     : TBalanceType;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EigVec1: TEigVec1;

implementation

Uses MtxDialogs;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TEigVec1.FormCreate(Sender: TObject);
begin
    inherited;
    With RichEdit1.Lines, RichEdit1 do
    begin
      Add('The Eig method is a powerful tool. With it you can '
        + 'easily calculate eigenvalues and left/right eigenvectors.');
      SelAttributes.Style := [fsBold];
      Add('');
      Add('VectorForm');
      Add('If  "Vector Form" is vfEig, then full balance will '
        + 'be used to find eigenvalues eigenvectors (check help '
        + 'file for more on this topic). The computed eigenvectors '
        + 'are normalized to have Euclidean norm equal to 1 and '
        + 'largest component real and are stored in the rows of '
        + 'the VL and VR matrices. If "Vector Form" is vfSchur '
        + 'then  user defined balance will be used to find eigenvalues '
        + 'eigenvectors (check help file for more on this topic)');
      Add('');
      SelAttributes.Style := [fsBold];
      Add('Balance');
      Add('Balancing the matrix can be very useful when calculating the '
        + 'eigenvalues and eigenvector. Balancing operation can perform '
        + 'one or both of the following similarity transformations:');
      Add('1) Permutation, 2) Similarity transformation.');
      Add('');
      Add('Try changing A matrix values, "Vector Form"  and (optionally) '
        +'"Balance". The "Left" and "Right" buttons show left and right '
        + '(check help for more info on this topic) eigenvectors.');
    end;
    A.SetIt(4,4,false,[1,-3,5,-3,
                       -1,12,0.3,2.5,
                       5,1.22,2.33,-0.5,
                       2.4,-1,5,3]);
    ValuesToGrid(A,StringGrid4,0,0,' 0.000;-0.000');
    RadioGroup1Click(RadioGroup1);
    RadioGroup2Click(RadioGroup2);
end;

procedure TEigVec1.Button1Click(Sender: TObject);
var MtxType: TMtxType;
begin
    EigL.Size(0,0);
    EigR.Size(0,0);
    EigValues.Size(0);
  
    { get values for A }
    GridToValues(A,StringGrid4);
    MtxType := A.DetectMtxType;
    { find eigenvalues and eigenvectors }
    A.Balance := Bal;
    A.Eig(EigL,EigValues,EigR,MtxType,VecForm);
    { write results to grids,
      write eigenvalues as diagonal matrix }
    StringGrid2.Cells[0,0] := 'D 4x1';
    ValuesToGrid(EigValues,StringGrid2,0,0,'0.000E+00');
    If SpeedButton1.Down then SpeedButton1Click(SpeedButton1)
    else SpeedButton2Click(SpeedButton2);
end;

procedure TEigVec1.RadioGroup1Click(Sender: TObject);
begin
    Case TRadioGroup(Sender).ItemIndex of
    0 : begin
             VecForm := vfEig;
             RadioGroup2.ItemIndex := 3;
             RadioGroup2.Enabled := false;
        end;
    1 : begin
             VecForm := vfSchur;
             RadioGroup2.Enabled := true;
        end;
    end;
end;

procedure TEigVec1.RadioGroup2Click(Sender: TObject);
begin
  Case TRadioGroup(Sender).ItemIndex of
  0:   Bal := btNone;
  1:   Bal := btScale;
  2:   Bal := btPerm;
  3:   Bal := btFull;
  end;
end;

procedure TEigVec1.SpeedButton1Click(Sender: TObject);
begin
  ValuesToGrid(EigL,StringGrid1,0,0,'0.000E+00');
  StringGrid1.Cells[0,0] := 'VL 4x4';
end;

procedure TEigVec1.SpeedButton2Click(Sender: TObject);
begin
  ValuesToGrid(EigR,StringGrid1,0,0,'0.000E+00');
  StringGrid1.Cells[0,0] := 'VR 4x4';
end;

initialization
   RegisterClass(TEigVec1);

end.

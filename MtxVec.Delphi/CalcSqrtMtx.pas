unit CalcSqrtMtx;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic2, StdCtrls, ComCtrls, ExtCtrls, MtxVec, Math387, Grids, Buttons;

type
  TfrmSqrtMtx = class(TBasicForm2)
    Button1: TBitBtn;
    Button2: TBitBtn;
    Button3: TButton;
    Panel4: TPanel;
    RadioGroup1: TRadioGroup;
    Panel5: TPanel;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;                                                        
    procedure Panel5Resize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure Button3Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    A,B, C: TMtx;
  public
    { Public declarations }
  end;

var
  frmSqrtMtx: TfrmSqrtMtx;

implementation

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

Uses MtxVecEdit, MtxDialogs, Types;

procedure MakeSymmetric(Mtx: TMtx);
var i,j : Integer;
begin
  for i := 0 to Mtx.Rows-1 do
    for j := 0 to Mtx.Cols -1 do
      if i > j then Mtx[i,j] := Mtx[j,i];
end;

procedure TfrmSqrtMtx.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines do
  begin
    Clear;
    Add('SqrtMtx is an example of a matrix function.');
    Add('');
    Add('You can apply any function (Log, Exp, Power...) '
      + 'to the matrix via the MtxFunction method. In this '
      + 'case the result is obtained via eigenvalue '
      + 'decomposition.');
  end;
  A := TMtx.Create;
  B := TMtx.Create;
  C := TMtx.Create;
  StringGrid1.Cells[0,0] := 'A';
  StringGrid2.Cells[0,0] := 'Sqrt(A)';
  Button1Click(Self);
end;

procedure TfrmSqrtMtx.Button1Click(Sender: TObject);
begin
  A.Size(4,4);
  { Resize StringGrid1 to A size}
  StringGrid1.RowCount := A.Rows + 1;
  StringGrid1.ColCount := A.Cols + 1;
  StringGrid2.RowCount := A.Rows + 1;
  StringGrid2.ColCount := A.Cols*2 + 1;
  A.RandUniform(2,10);
  { symmetric matrix }
  if RadioGroup1.ItemIndex = 0 then  MakeSymmetric(A);
  {Write A to StringGrid1 }
  ValuesToGrid(A,StringGrid1,0,0,'0.0000',true);
  Button2.Enabled := true;
  Button3.Enabled := false;
end;

procedure TfrmSqrtMtx.Button2Click(Sender: TObject);
begin
  { resize B to match the size of A }
  B.Size(A);
  { copy values for StringGrid1 }
  GridToValues(B,StringGrid1,B.Complex,True);
  { calculate the inverse }
  if RadioGroup1.ItemIndex = 0 then
      C.MtxSqrt(B,mtSymmetric)
  else
      C.MtxSqrt(B,mtGeneral);
  {show the SQRT(matrix) in StringGrid2 }
  ValuesToGrid(C,StringGrid2,0,0,'0.0000',True);
  Button3.Enabled := true;
end;

procedure TfrmSqrtMtx.StringGrid1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  try
     StrToFloat(Value);
  except
  end;
end;

procedure TfrmSqrtMtx.Button3Click(Sender: TObject);
begin
  B.Mul(C,C,opNone,opNone);

  if B.Complex then C.RealPart(B) { get only real part }
               else C.Copy(B);
  { compare }
  if C.Equal(A,1.0E-3) then ShowMessageBox('Succeeded!')
                       else ShowMessageBox('Failed!');
  Button3.Enabled := False;
end;

procedure TfrmSqrtMtx.FormDestroy(Sender: TObject);
begin
  A.Free;
  B.Free;
  C.Free;
  inherited;
end;

procedure TfrmSqrtMtx.Panel5Resize(Sender: TObject);
begin
  inherited;
  StringGrid1.Width := Panel5.Width - 2;
  StringGrid1.Left := 1;
  StringGrid1.Top := 1;
  StringGrid1.Height := Panel5.Height div 2 - 2;

  StringGrid2.Left := 1;
  StringGrid2.Top := StringGrid1.Height + 5;
  StringGrid2.Width := StringGrid1.Width;
  StringGrid2.Height := StringGrid1.Height;
end;

initialization
  RegisterClass(TfrmSqrtMtx);

end.

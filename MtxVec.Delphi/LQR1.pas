unit LQR1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic2, StdCtrls, ComCtrls, ExtCtrls, MtxVec, Math387, Grids, MtxVecEdit,
  Buttons, MtxExpr;

type
  TLQRDemo = class(TBasicForm2)
    RadioGroup1: TRadioGroup;
    StringGrid1: TStringGrid;
    Label1: TLabel;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    CheckBox1: TCheckBox;
    Button1: TBitBtn;
    Button2: TBitBtn;
    Button3: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    tmpM1,tmpM2, tmpM3,
    A,L,Q,R : Matrix;
    S       : Vector;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LQRDemo: TLQRDemo;

implementation

Uses MtxDialogs;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure RefreshGrid(AStringGrid: TStringGrid; Mtx: TMtx);
begin
  With AStringGrid do
  begin
       RowCount := Mtx.Rows+1;
       ColCount := Mtx.Cols+1;
       Width := (ColCount)* DefaultColWidth+10;
       Height := (RowCount)* DefaultRowHeight+10;
  end;
  ValuesToGrid(Mtx,AStringGrid,0,0);
  AStringGrid.Cells[0,0] := Mtx.Caption;
end;

procedure TLQRDemo.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    Add('MtxVec offers several methods for matrix decomposition. '
      + 'If matrix is squared, then LU decomposition can be used. '
      + 'If this is not the case (number of rows <> number of columns) '
      + 'then either LQ,QR, or SVD decomposition method can be used. '
      + 'All these methods are used extensively for solving system of '
      + 'linear equations (LUSolve, LQRSolve, SVDSolve). In this example '
      + 'the following decompositions are demonstrated.');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('LQ decomposition : Mtx.Rows < Mtx.Cols;  Mtx = L*Q; Mtx must have full rank');
    Add('QR decomposition : Mtx.Rows > Mtx.Cols; Mtx = Q*R; Mtx must have full rank');
    Add('SVD decomposition : Mtx = U*S*V''; Mtx does not have full rank'+#10+#13);

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');
    Add('The "Economy size" checkbox indicates economy size matrices will be calculated. '
      + 'For more on this check the help file.');
  end;
  S.Caption := 'Singular values';
  RadioGroup1Click(RadioGroup1);

  A.Size(0,0);
  L.Size(0,0);
  Q.Size(0,0);
  R.Size(0,0);
end;

procedure TLQRDemo.RadioGroup1Click(Sender: TObject);
begin
  if TRadioGroup(Sender).ItemIndex = 0 then
  begin
       A.Size(2,4);
       A.RandUniform(2,10);
       Button3.Caption := 'LQ = A ? ';
  end else if TRadioGroup(Sender).ItemIndex = 1 then
  begin
       A.Size(3,2);
       A.RandUniform(-10,-3);
       Button3.Caption := 'QR = A ? ';
  end else if TRadioGroup(Sender).ItemIndex = 2 then
  begin
       A.Size(2,4);
       A.RandUniform(2,10);
       A.SetZero(0,0,1,0);
       Button3.Caption := 'USV'+''''+' = A ? ';
  end else if TRadioGroup(Sender).ItemIndex = 3 then
  begin
       A.Size(3,2);
       A.RandUniform(2,10);
       A.SetZero(0,0,0,1);
       Button3.Caption := 'USV'+''''+' = A ? ';
  end;
  Button3.Enabled := false;
  Button2.Enabled := false;
  A.Caption := 'A '+IntToStr(A.Rows)+'x'+IntToStr(A.Cols);
  RefreshGrid(StringGrid1,A);
end;

procedure TLQRDemo.Button1Click(Sender: TObject);
begin
  GridToValues(A,StringGrid1);
  Case RadioGroup1.ItemIndex of
  0:
    begin
       A.LQR(L,Q,nil,CheckBox1.Checked);
       L.Caption := 'L';
       Q.Caption := 'Q';
       RefreshGrid(StringGrid2,L);
       RefreshGrid(StringGrid3,Q);
    end;
  1:
    begin
       A.LQR(nil,Q,R,CheckBox1.Checked);
       R.Caption := 'R';
       Q.Caption := 'Q';
       RefreshGrid(StringGrid2,Q);
       RefreshGrid(StringGrid3,R);
    end;
  2,3:
    begin
       Button2.Enabled := true;
       A.SVD(L,S,Q,CheckBox1.Checked);
       L.Caption := 'U';
       Q.Caption := 'V';
       RefreshGrid(StringGrid2,L);
       RefreshGrid(StringGrid3,Q);
    end;
  end;
  Button3.Enabled := true;
  StringGrid3.Left := StringGrid2.Left+StringGrid2.Width+10;
end;

procedure TLQRDemo.Button2Click(Sender: TObject);
begin
  { Q.Cols because we are multiplying with V' }
  tmpM1.Size(L.Cols,Q.Cols,S.Complex); {  D size }

  tmpM1.SetZero;
  tmpM1.Diag(S,0);
  ViewValues(tmpM1,'Singular values',true);
end;

procedure TLQRDemo.Button3Click(Sender: TObject);
begin
  Case RadioGroup1.ItemIndex of
  0:
    begin
         tmpM2.Mul(L,Q,opNone);
         ViewValues(tmpM2,'LQ = A ?',true);
    end;
  1:
    begin
        tmpM2.Mul(Q,R,opNone);
        ViewValues(tmpM2,'QR = A ?',true);
    end;
  2,3:
    begin
         { Q.Cols because we are multiplying with V' }
         { First, calculate S  }
         tmpM1.Size(L.Cols,Q.Cols,S.Complex);
         tmpM1.SetZero;
         tmpM1.Diag(S,0);
         { Multiply S by V'=Q' }
         tmpM2.Mul(tmpM1,Q,opNone,opTran);
         { Multiply from left by U=L }
         tmpM3.Mul(L,tmpM2,opNone);
         ViewValues(tmpM3,'U*S*V'+''''+' = A ?',true);
    end;
  end;
end;

initialization
   RegisterClass(TLQRDemo);

end.

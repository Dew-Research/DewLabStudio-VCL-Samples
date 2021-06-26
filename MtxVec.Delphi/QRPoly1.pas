unit QRPoly1;

interface

uses
  System.Types,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic1, TeeProcs, TeEngine, Chart, StdCtrls, ExtCtrls, ComCtrls, Series,
  MtxVec, Polynoms, MtxVecEdit, Math387, MtxExpr;

type
  TLQRPoly = class(TBasicForm1)
    TrackBar1: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Series1: TPointSeries;
    Series2: TLineSeries;
    Button1: TButton;
    TrackBar2: TTrackBar;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button2: TButton;                                   
    Button3: TButton;
    Series3: TLineSeries;
    Series4: TLineSeries;
    procedure TrackBar1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckDownSampleClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    PolyOrder, DegF : Integer;
    Factor : Integer;
    X,Y,Coeff, Delta: Vector;
    R: Matrix;
    intX,intY : Vector;
    L2R: double;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LQRPoly: TLQRPoly;

implementation

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

Uses MtxVecTee, AbstractMtxVec, MtxVecBase;

procedure TLQRPoly.TrackBar1Change(Sender: TObject);
begin
  inherited;
  PolyOrder := TTrackBar(Sender).Position;
  Label2.Caption := IntToStr(PolyOrder);
  Button2.Enabled := false;
  Button3.Enabled := false;
end;

procedure TLQRPoly.FormCreate(Sender: TObject);
var i : Integer;
    tmp : double;
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    Add('Fitting a polynomial of high degree is a peace of '
      + 'cake. MtxVec offers you the ability to create '
      + 'Vandermonde matrix and then use it to find the desired '
      + 'polynomial coefficients via the LQR decomposition. '
      + 'Here is the code used to find the polynomial coefficients:');
    Add('');
    Add('procedure PolyFit(XData,YData: TVec; Degree: Integer; Coeff: TVec);');
    Add('var V: TMtx;');
    Add('begin');
    SelAttributes.Style := [fsItalic];
    Add('  { num coeff = Degree +1 } ');
    Add('  CreateIt(V);');
    Add('    V.VanderMonde(Degree+1,XData);');
    Add('    V.LQRSolve(YData,Coeff);');
    Add('  finally');
    Add('    FreeIt(V);');
    Add('  end');
    Add('end;');
  end;
  TrackBar1Change(TrackBar1);
  TrackBar2Change(TrackBar2);

{  R := TMtx.Create;
  X := TVec.Create;
  Y := TVec.Create;
  intX := TVec.Create;
  intY := TVec.Create;
  Delta := TVec.Create;     }


  Coeff.Size(0);
  Delta.Size(0);
  R.Size(0,0);
  intX.Size(0);
  intY.Size(0);

  X.Size(1000);
  Y.Size(X);
  Randomize;
  tmp := Random(1000);
  X.Ramp;
  for i := 0 to Y.Length - 1 do
  begin
    tmp := tmp+Random(1000)-500;
    Y.Values[i] := tmp;
  end;
  DrawValues(Y,Series1);
end;

procedure TLQRPoly.Button1Click(Sender: TObject);
begin
  TimeCheck := GetTickCount;
  Screen.Cursor := crHourGlass;

  PolyFit(X,Y,PolyOrder,Coeff,R, DegF,L2R);
  IntX.Size(X.Length*Factor);
  IntX.Ramp(0,1/Factor);
  PolyEval(intX,Coeff,R,DegF,L2R,intY,Delta);
  TimeElapsed := GetTickCount - TimeCheck;
  Label5.Caption := IntToStr(TimeElapsed)+ ' ms';
  DrawValues(intY,Series2,0,1/Factor,DownSize);
  DrawValues(intY - Delta,Series4,0,1/Factor,DownSize);
  DrawValues(IntY + Delta*2,Series3,0,1/Factor,DownSize);

  Screen.Cursor := crDefault;
  Button2.Enabled := true;
  Button3.Enabled := true;
end;

procedure TLQRPoly.TrackBar2Change(Sender: TObject);
begin
  Factor := TTrackBar(Sender).Position;
  Label3.Caption := IntToStr(Factor);
  Button2.Enabled := false;
  Button3.Enabled := false;
end;

procedure TLQRPoly.Button2Click(Sender: TObject);
begin
  ViewValues(Coeff,'Coefficients',true);
end;

procedure TLQRPoly.CheckDownSampleClick(Sender: TObject);
begin
  inherited;
  Button2.Enabled := false;
  Button3.Enabled := false;
end;

procedure TLQRPoly.Button3Click(Sender: TObject);
begin
  ViewValues(Delta,'Delta',true);
end;

initialization
  RegisterClasS(TLQRPoly);

end.

(*The example is based on the tutorial
written by Jose Manuel Rodriguez,
Universidad Politecnica de Cataluña, Spain
Based on the Technical Document by
Juan Andrade-Cetto, "The Kalman Filter", March 2002 *)

unit KalmanDemo3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Types, Dialogs, StdCtrls, ExtCtrls, TeEngine, TeeProcs, Chart, Series, MtxComCtrls, Math387,
  MtxVec, MtxExpr, MtxExprInt, MtxVecInt, MtxVecTee, ComCtrls,
  AdaptiveFiltering, Menus, TeeGDIPlus;

type
  TKalmanFilterForm3 = class(TForm)
    Chart1: TChart;
    Chart2: TChart;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Button1: TButton;
    ErrorSeries: TFastLineSeries;
    EstimatedSeries: TFastLineSeries;
    MeasuredSeries: TFastLineSeries;
    rEdit: TMtxFloatEdit;
    Label1: TLabel;
    Label2: TLabel;
    qEdit: TMtxFloatEdit;
    DesiredSeries: TFastLineSeries;
    RichEdit1: TRichEdit;
    procedure Button1Click(Sender: TObject);
    procedure qEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rEditChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    n_iter: integer;
    Zv, Xv: Vector;
    KalmanFilter: TExtendedKalmanFilter;
    procedure Compute;
    procedure GenerateMeasurement(z: TMtx);
    procedure GenerateProcess(x: TMtx);

  public
    { Public declarations }
  end;


var
  KalmanFilterForm3: TKalmanFilterForm3;

implementation

uses SignalUtils, StringVar, AbstractMtxVec, MtxVecBase;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TKalmanFilterForm3.Button1Click(Sender: TObject);
begin
//   z := RandGauss(n_iter,x,NoiseSigma); //would need to recreate the tone with different noise
   Compute;
end;

(*

x is the real plant behavior, in this case a sinus wave
with the following formulation:

x(time)=sin(frec(@ time-1)*time-1) + ramdom error signal("sigmav")
frec(time)=frec(@ time-1)

x_ is the predicted state, this is where Kalman filter will come
and where we will correct our estimations using an observation

z is the observation of the real plant, in this case corresponding only to
the position at a given time. Note that this observation is subject to an
error, therefore the resulting equation is: z(time)=x(time)+ramdom error("sigmaw")

Our first prediction will come from the plant ideal behavior, then
using the observations and error covariance we will obtain a better estimate.

xc is the ideal plant behavior... this is used just for comparison

P is the state error covariances at a given time of all the involved variables,
note that we are forming x as a 2 by 1 matrix with the following:
x(1,n) -> position
x(2,n) -> frecuency

Our functions are as following for this example:
Let's say:
f1: x1(time)=sin(x2(time-1)*(time-1))+ w     w->ramdom plant error
f2: x2(time)=x2(time-1)
h:  y=x1+ v                                  v->ramdom sensor error

A is the Jacobian of the transfer function due to the involved variables,
in this case these are x1 and x2, therefore A will be a 2 by 2 matrix
(always the matrix is square). The resulting A depends on time and must be
computed for every step that the system takes.

A is as follows:
A -> df1/dx1 = 0    df1/dx2 = cos(x2*time)*time
     df2/dx1 = 0    df2/dx1 = 1

*)

procedure TKalmanFilterForm3.GenerateProcess(x: TMtx);
var i: integer;
begin

   // x(k) = f (x(k – 1), u(k – 1), 0)

    i := KalmanFilter.Iter;
    x[0,0] := sin(x[1,0]*(i - 1));
    x[1,0] := x[1,0];

    //recalculate A(k) because f updated (!) and A is formed from df/dx

    KalmanFilter.A[0,0] := 0;
    KalmanFilter.A[1,0] := 0;

    KalmanFilter.A[0,1] := i*cos(x[1,0]*i);
    KalmanFilter.A[1,1] := 1;
end;

procedure TKalmanFilterForm3.GenerateMeasurement(z: TMtx);
begin

  // z(k) = h(x(k), 0)

    z[0,0] := KalmanFilter.x[0,0];
end;

procedure TKalmanFilterForm3.Compute;
var i: integer;
    P, xhat: Matrix;
begin
    KalmanFilter.Q[0,0] := qEdit.Position; //-5; // # process variance
    KalmanFilter.R[0,0] := rEdit.Position; //-5; // # process variance

    xhat.Size(n_iter, 2); // xhat=numpy.zeros(sz)      # a posteri estimate of x
    xhat.SetZero;

    P.Size(n_iter, 2);
    P.SetVal(0);

    //Initial error covariance
    KalmanFilter.P.SetIt(2,2, false, [ 0.01,    0,
                                          0, 0.01]);
    for i := 1 to n_iter-1 do
    begin
        KalmanFilter.z[0,0] := Zv[i]; //start with the second measurement
        KalmanFilter.Iter:= i+1; //just to compensate for index difference

        KalmanFilter.Update;

        //Get Results:
        xhat[i,0] := KalmanFilter.x[0,0];
        xhat[i,1] := KalmanFilter.x[1,0];

        P[i,0] := KalmanFilter.P[0,0];
        P[i,1] := KalmanFilter.P[1,1];
    end;

    DrawValues(zV,MeasuredSeries);
    DrawValues(Col(xhat, 0),EstimatedSeries);
    DrawValues(xV, DesiredSeries);
    DrawValues(Select(Col(P,0),1,P.Rows-1), ErrorSeries);
end;


procedure TKalmanFilterForm3.FormCreate(Sender: TObject);
var sigmav, sigmaw: double;
    tmp: Vector;
begin
    RichEdit1.Lines.Clear;
    RichEdit1.Lines.Add('Lesson 3. Filtering a non-linear process using Extended Kalman Filter. ');

    KalmanFilter := TExtendedKalmanFilter.Create;

    sigmaw := 0.1; //  the covariance coeficient for the position error (plant)
    sigmav := 0.5; //  the covariance coeficient for the frequency error (sensor)

    n_iter := 1000;
    Tone(xV, n_iter, 8/1000, 0, 1);            //generate process without noise
    tmp := xV + RandGauss(n_iter, tmp.FloatPrecision, 0,sigmaw);  //get process (plant) with noise
    Zv := tmp + RandGauss(n_iter, tmp.FloatPrecision, 0,sigmav);  //get measurement with noise ( = plant + plant noise + measurement noise)

//    StrList.LoadFromFile('c:\ekf_example.txt');
//    tmpM.StringsToValues(StrList);
//    zV.GetRow(tmpM,2);
//    xV.GetRow(tmpM,0);
//    n_iter := xV.Length;


    KalmanFilter.A.Size(2,2);

//    KalmanFilter.x.Size(2,1);
    KalmanFilter.x.SetIt(2,1,false, [0, 0.04]);

    KalmanFilter.z.Size(1,1);
    KalmanFilter.z[0,0] := zV[0];

    KalmanFilter.Q[0,0] := sqr(sigmaw); //sized to scalar by default
    KalmanFilter.R[0,0] := sqr(sigmav); //sized to scalar by default

    KalmanFilter.H.Size(1,2);
    KalmanFilter.H[0,0] := 1;
    KalmanFilter.H[0,1] := 0;

    KalmanFilter.W.Size(2,1);
    KalmanFilter.W[0,0] := 1;
    KalmanFilter.W[1,0] := 0;

    KalmanFilter.OnGenerateProcess := GenerateProcess;
    KalmanFilter.OnGenerateMeasurement := GenerateMeasurement;

    rEdit.Position := sqr(sigmav);
    qEdit.Position := sqr(sigmaw);
end;

procedure TKalmanFilterForm3.FormDestroy(Sender: TObject);
begin
    KalmanFilter.Free;
end;

procedure TKalmanFilterForm3.qEditChange(Sender: TObject);
begin
    Compute;
end;

procedure TKalmanFilterForm3.rEditChange(Sender: TObject);
begin
    Compute;
end;


initialization
  RegisterClass(TKalmanFilterForm3);

end.

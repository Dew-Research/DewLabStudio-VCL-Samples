unit BasicKalman;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Types, Dialogs, StdCtrls, ExtCtrls, TeEngine, TeeProcs, Chart, Series, MtxComCtrls, Math387,
  MtxVec, MtxExpr, MtxExprInt, MtxVecInt, MtxVecTee, ComCtrls,
  AdaptiveFiltering, Menus, TeeGDIPlus;

type
  TBasicKalmanForm = class(TForm)
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
  private
    { Private declarations }
    X, NoiseSigma: TSample;
    n_iter: integer;
    Z: Vector;
    procedure Compute;
  public
    { Public declarations }
  end;


var
  BasicKalmanForm: TBasicKalmanForm;

implementation

uses AbstractMtxVec, MtxVecBase;

{$R *.dfm}

procedure TBasicKalmanForm.Button1Click(Sender: TObject);
begin
   z := RandGauss(n_iter,z.FloatPrecision, x,NoiseSigma); //Keep signal noise the same, just recreate the series
   Compute;
end;

procedure TBasicKalmanForm.Compute;
var  i: integer;
     Q: TSample;
     xhat, P, xhatminus, pMinus, K, TruthValue: Vector;
     R: TSample;
begin
    Q := qEdit.Position; //-5; // # process variance

//    # allocate space for arrays

    truthValue.Size(n_iter);
    truthValue.SetVal(x);

    xhat.Size(n_iter); //  # a posteri estimate of x
    xhat.SetZero;

    p.Size(n_iter);     //  # a posteri error estimate
    p.SetZero;

    xhatminus.Size(n_iter); //# a priori estimate of x
    xhatminus.SetZero;

    PMinus.Size(n_iter); //  # a priori error estimate
    PMinus.SetZero;

    K.Size(n_iter);      //     # gain or blending factor
    K.SetZero;

    //Variance = E((X[i] - mu)^2)
    //StdDev = sqrt(Variance);
    R := rEdit.Position; // # estimate of measurement variance, change to see effect

//    # intial guesses
    xhat[0] := 0.0;
    P[0] := 1.0;

    for i := 1 to n_iter-1 do
    begin
//        # time update
        xhatminus[i] := xhat[i-1];
        Pminus[i] := P[i-1] + Q;

//        # measurement update
        K[i] := Pminus[i]/( Pminus[i] + R );
        xhat[i] := xhatminus[i] + K[i]*(z[i]-xhatminus[i]);
        P[i] := (1-K[i])*Pminus[i];
    end;

    DrawValues(z,MeasuredSeries);
    DrawValues(xhat,EstimatedSeries);
    DrawValues(truthValue, DesiredSeries);

    pMinus.SetSubRange(2,n_iter-2);
    DrawValues(pMinus, ErrorSeries);
end;

procedure TBasicKalmanForm.FormCreate(Sender: TObject);
begin
    RichEdit1.Lines.Clear;
    RichEdit1.Lines.Add('Lesson 1. To use the Kalman filter the mathemathical model for the process has to be known. ' +
                        'When we perform filtering we use the mathemathical model as a source of additional information ' +
                        'to reduce the measurement noise. We are therefore reducing noise for a known system. ' +
                        'The example demonstrates the effect of Q (process variance) ' +
                        'and the effect of R (measurement variance). Both parameters are inputs ' +
                        'for the Kalman filter:');
    RichEdit1.Lines.Add('');
    RichEdit1.Lines.Add(' - Q is the square of the standard deviation (variance) of the process without noise. ');
    RichEdit1.Lines.Add(' - R is the square of the standard deviation (variance) of the measurement noise. ');
    RichEdit1.Lines.Add('');
    RichEdit1.Lines.Add('Both Q and R have to be estimated one way (trial and error) or the other (computed somehow) ' +
                        'before we can start filtering.');
    RichEdit1.Lines.Add('');
    RichEdit1.Lines.Add('The process estimated in this example is a simple straight line at -0.37727 ' +
                        'and the code exploits all the simplifications in the Kalman filtering ' +
                        'algoritm arising from that.');

    n_iter := 250;
    x := -0.37727; //# truth value (typo in example at top of p. 13 calls this z)
    NoiseSigma := 0.1;
    z := RandGauss(n_iter, z.FloatPrecision, x,NoiseSigma);
//    z.LoadFromFile('C:\TestFile.vec');

    rEdit.Position := sqr(NoiseSigma);
    qEdit.Position := 1E-5;
end;

procedure TBasicKalmanForm.qEditChange(Sender: TObject);
begin
    Compute;
end;

procedure TBasicKalmanForm.rEditChange(Sender: TObject);
begin
    Compute;
end;

initialization
  RegisterClass(TBasicKalmanForm);


end.

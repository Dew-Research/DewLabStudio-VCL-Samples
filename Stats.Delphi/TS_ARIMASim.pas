unit TS_ARIMASim;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Basic_Chart, StdCtrls, TeeProcs, TeEngine, Chart, ExtCtrls,
  ComCtrls, MtxVec, Series, TeeGDIPlus;

type
  TfrmARIMASim = class(TfrmBasicChart)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditAR: TEdit;
    EditMA: TEdit;
    EditD: TEdit;
    Label4: TLabel;
    EditN: TEdit;
    UpDownAR: TUpDown;
    UpDownMA: TUpDown;
    UpDownD: TUpDown;
    UpDownN: TUpDown;
    Button2: TButton;
    Button3: TButton;
    Series1: TLineSeries;
    Button4: TButton;
    Button5: TButton;
    RadioGroupCT: TRadioGroup;
    Series2: TLineSeries;
    MemoLog: TMemo;
    procedure EditARChange(Sender: TObject);
    procedure EditMAChange(Sender: TObject);
    procedure EditDChange(Sender: TObject);
    procedure EditNChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure RadioGroupCTClick(Sender: TObject);
  private
    { Private declarations }
    d,n: Integer;
    Phi,Theta,zinit,timeSer: TVec;
    procedure Simulate;
    procedure PlotSeries(stype: Integer);
  public
    { Public declarations }
  end;

var
  frmARIMASim: TfrmARIMASim;

implementation

Uses StatTimeSerAnalysis, MtxVecTee, MtxVecEdit, Math387, AbstractMtxVec, Statistics, Types;
{$R *.dfm}

{ TfrmARIMASim }

procedure TfrmARIMASim.Simulate;
var s2: double;
    i: Integer;
    phiest,thetaest: TVec;
begin
  MemoLog.Lines.Clear;
  if d=0 then
  begin
    ARMASimulate(Phi,Theta,n,timeSer);
    phiest := TVec.Create;
    thetaest := TVec.Create;
    try
      phiest.Length := phi.Length;
      thetaest.Length := theta.Length;
      if (Phi.Length<>0) and (Theta.Length=0) then ARYuleWalkerFit(timeSer,phiest,s2)
      else if (Phi.Length=0) and (Theta.Length<>0) then ARMAInnovationsFit(timeSer,thetaest,s2)
      else ARMAInnovationsFit(timeSer,phiest,thetaest,s2);
      with MemoLog.Lines do
      begin
        Add('Initial estimates');
        if Phi.Length>0 then
        begin
          Add('AR coefficients');
          for i := 0 to Phi.Length-1 do Add('AR['+IntToStr(i+1)+']=' + FormatSample('0.000', phiest[i]));
        end;
        if Theta.Length>0 then
        begin
          Add('MA coefficients');
          for i := 0 to Theta.Length-1 do Add('MA['+IntToStr(i+1)+']=' + FormatSample('0.000', thetaest[i]));
        end;
      end;
    finally
      phiest.Destroy;
      thetaest.Destroy;
    end;
end
  else ARIMASimulate(Phi,Theta,d,zinit,n,timeSer);

  With Chart1.Title.Text do
  begin
    Clear;
    Add('Simulating :');
    if d=0 then Add('ARMA ('+IntToStr(Phi.Length)+','+IntToStr(Theta.Length)+') process')
    else Add('ARIMA ('+IntToStr(Phi.Length)+','+IntToStr(Theta.Length)+','+IntToStr(d)+') process')
  end;
  PlotSeries(RadioGroupCT.ItemIndex);
end;

procedure TfrmARIMASim.EditARChange(Sender: TObject);
begin
  Phi.Length := StrToInt(EditAR.Text);
  Phi.SetZero;
  Series1.Clear;
end;

procedure TfrmARIMASim.EditMAChange(Sender: TObject);
begin
  Theta.Length := StrToInt(EditMA.Text);
  Theta.SetZero;
  Series1.Clear;
end;

procedure TfrmARIMASim.EditDChange(Sender: TObject);
begin
  d := StrToInt(EditD.Text);
  { an example ONLY }
  zinit.Size(d);
  zinit.SetZero;
  Series1.Clear;
end;

procedure TfrmARIMASim.EditNChange(Sender: TObject);
begin
  N := StrToInt(EditN.Text);
  Series1.Clear;
end;

procedure TfrmARIMASim.Button2Click(Sender: TObject);
begin
  ViewValues(Phi,'AR coefficients',True,False,True);
end;

procedure TfrmARIMASim.Button3Click(Sender: TObject);
begin
  ViewValues(Theta,'MA coefficients',True,False,True);
end;

procedure TfrmARIMASim.FormCreate(Sender: TObject);
begin
  inherited;
  With Memo1.Lines do
  begin
    Clear;
    Add('New in Stats Master 2.1: ARMA/ARIMA routines.');
    Add('This example demonstrates usage of ARMA and ARIMA simulation and prediction routines.'
        + ' Change AR, MA and d parameters to simulate different ARMA and ARIMA models.');
    Add('');
    Add('Press the "Simulate" button for random ARMA/ARIMA model time series.');
  end;
  Phi := TVec.Create;
  Theta := TVec.Create;
  timeSer := TVec.Create;
  zInit := TVec.Create;
end;

procedure TfrmARIMASim.FormDestroy(Sender: TObject);
begin
  Phi.Destroy;
  Theta.Destroy;
  timeSer.Destroy;
  zInit.Destroy;
  inherited;
end;

procedure TfrmARIMASim.Button4Click(Sender: TObject);
begin
  Simulate;
end;

procedure TfrmARIMASim.Button5Click(Sender: TObject);
begin
  ViewValues(zinit,'initial values for d',True,False,True);
end;

procedure TfrmARIMASim.RadioGroupCTClick(Sender: TObject);
begin
  PlotSeries(RadioGroupCT.ItemIndex);
end;

procedure TfrmARIMASim.PlotSeries(stype: Integer);
var acfv,pacfv: TVec;
begin
  CreateIt(acfv,pacfv);
  try
    Series2.Active := False;
    case sType of
      0:  begin
            DrawValues(timeSer,Series1);
            Series1.Title := 'Time series';
          end;
      1:  begin {ACF}
            ACF(timeSer,acfv,timeSer.Length div 2);
            Series1.Title := 'Time series ACF';
            DrawValues(acfv,Series1);
            if d = 0 then
            begin
              Series2.Active := True;
              ARMAAcf(Phi,Theta,timeSer.Length div 2,pacfv);
              DrawValues(pacfv,Series2);
            end
          end;
      2:  begin
            ACF(timeSer,acfv,timeSer.Length div 2);
            PACF(acfv,pacfv);
            Series1.Title := 'Time series PACF';
            DrawValues(pacfv,Series1);
          end;
    end;
  finally
    FreeIt(acfv,pacfv);
  end;
end;

initialization
  RegisterClass(TfrmArimaSim);

end.

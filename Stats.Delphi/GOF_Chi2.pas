unit GOF_Chi2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_Chart, StdCtrls, TeeProcs, TeEngine, Chart, ExtCtrls, MtxVec, Math387,
  ComCtrls, Series, StatChar, Statistics, TeeGDIPlus;

type
  TfrmGOFChi2 = class(TfrmBasicChart)
    Series1: THistogramSeries;
    Series2: TLineSeries;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    GroupBox2: TGroupBox;
    Button2: TButton;
    Label3: TLabel;
    ComboBox2: TComboBox;
    lblDistName: TLabel;
    lblPar1: TLabel;
    lblPar2: TLabel;
    EditPar1: TEdit;
    EditPar2: TEdit;
    Button3: TButton;
    Label4: TLabel;
    Edit2: TEdit;
    Memo2: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    numBins: Integer;
    DataVec: TVec;
    DistName: String;
    Alpha: double;
    procedure DrawDataHistogram;
    procedure DoChi2Test;
  public
    { Public declarations }
  end;

var
  frmGOFChi2: TfrmGOFChi2;

implementation

{$R *.DFM}

Uses Probabilities, StatRandom, MtxVecTee;

// This procedure generates observed and expected frequencies for specific distribution
// You could also use Statistics.pas GOFChi2Test oveload to do all this in one routine call,
// but since we have to plot observed and expected frequency histograms, we're
// doing it "manually" in this unit.
procedure GOFChiFreqs(Data: TVec; Distribution: TDistribution; NumBins: Integer; Bins,Freq, OFreq: TVec; var dF: Integer);
var
  Pars: Array[0..1] of double;
  intPar: Integer;
begin
  case Distribution of
    distChiSquare:
    begin
      ChiSquareFit(Data,intPar);
      Pars[0] := intPar;
    end;
    distErlang:
    begin
      ErlangFit(Data,intPar,Pars[1]);
      Pars[0] := IntPar;
    end;
    distLaplace: LaplaceFit(Data,Pars[0],Pars[1]);
    distNormal : NormalFit(Data,Pars[0],Pars[1]);
    distExp : ExponentFit(Data,Pars[0]);
    distGamma : GammaFit(Data,Pars[0],Pars[1]);
    distWeibull : WeibullFit(Data,Pars[0],Pars[1]);
    distBeta : BetaFit(Data,Pars[0],Pars[1]);
    distRayleigh : RayleighFit(Data,Pars[0]);
    distLogNormal : LogNormalFit(Data,Pars[0],Pars[1]);
    distUniform : UniformFit(Data,Pars[0],Pars[1]);
    distMaxwell : MaxwellFit(Data,Pars[0]);
  end;


  Histogram(Data,NumBins,OFreq,Bins);

  case Distribution of
    distNormal :begin
                  NormalCDF(Bins,Pars[0],Pars[1],Freq);
                  dF := -3;
                end;
    distChiSquare:   begin
                ChiSquareCDF(Bins,Round(Pars[0]),Freq);
                    dF := -2
                end;
    distErlang: begin
                  ErlangCDF(Bins,Round(Pars[0]),Pars[1],Freq);
                  dF := -3;
                end;
    distExp :begin
                    ExpCDF(Bins,Pars[0],Freq);
                    dF := -2
                  end;
    distGamma : begin
                  GammaCDF(Bins,Pars[0],Pars[1],Freq);
                  dF := -3;
                end;
    distLaplace:  begin
                    LaplaceCDF(Bins,Pars[0],Pars[1],Freq);
                    dF := -3;
                  end;
    distWeibull : begin
                    WeibullCDF(Bins,Pars[0],Pars[1],Freq);
                    dF := -3;
                  end;
    distBeta : begin
                  BetaCDF(Bins,Pars[0],Pars[1],Freq);
                  dF := -3;
               end;
    distRayleigh : begin
                    RayleighCDF(Bins,Pars[0],Freq);
                    dF := -2;
                   end;
    distLogNormal : begin
                    LogNormalCDF(Bins,Pars[0],Pars[1],Freq);
                    dF := -2;
                   end;
    distUniform : begin
                    UniformCDF(Bins,Pars[0],Pars[1],Freq);
                    dF := -2;
                   end;
    distMaxwell : begin
                    MaxwellCDF(Bins,Pars[0],Freq);
                    dF := -2;
                   end;
  end;
  Freq.Difference;
  Freq.Scale(Data.Length);

  // calculate Chi2 distribution degrees of freedom
  // Nu = NumBins - NumberofParameters - 1
  Df := Df+OFreq.Length;
end;

procedure TfrmGOFChi2.FormCreate(Sender: TObject);
begin
  inherited;
  Button1.Visible := False;
  With Memo1.Lines do
  begin
    Clear;
    Add('The chi-square test (Snedecor and Cochran, 1989) is used to test if a '
      + 'sample of data came from a population with a specific distribution.');
    Add('An attractive feature of the chi-square goodness-of-fit test is that it '
      + 'can be applied to any univariate distribution for which you can calculate '
      + 'the cumulative distribution function (CDF). The chi-square goodness-of-'
      + 'fit test is applied to binned data (i.e., data put into classes). This '
      + 'is actually not a restriction since for non-binned data you can simply '
      + 'calculate a histogram or frequency table before generating the chi-square '
      + 'test. However, the value of the chi-square test statistic are dependent '
      + 'on how the data is binned. Another disadvantage of the chi-square test '
      + 'is that it requires a sufficient sample size in order for the chi-square '
      + 'approximation to be valid.');
    Add('If you press the "GENERATE" button, a new set of random values for specific '
      + 'distribution will be generated. Pressing the "GOF TEST" button will trigger '
      + 'Chi-Squared GOF test for any of supported distributions.');
    Add('NOTE: Data validity is not checked for specific distribution so for example, '
      + 'do not test for exponential distribution if values are negative!');
  end;
  DataVec := TVec.Create;

  // setup initial values
  Numbins := 25;
  Updown1.Position := NumBins;
  Alpha := 0.05;
  Edit2.Text := SampleToStr(Alpha);
end;

procedure TfrmGOFChi2.FormDestroy(Sender: TObject);
begin
  DataVec.Destroy;
  inherited;
end;

procedure TfrmGOFChi2.FormShow(Sender: TObject);
begin
  inherited;
  ComboBox1.ItemIndex := 4; // Gamma
  ComboBox1Change(Self);

  ComboBox2.ItemIndex := 4; // Gamma
  ComboBox2Change(Self);

  Button2Click(Self); // Generate data
  DoChi2Test;
end;

procedure TfrmGOFChi2.ComboBox1Change(Sender: TObject);
begin
  distName := ComboBox1.Items[ComboBox1.ItemIndex];
  With Chart1.Title.Text do
  begin
    Clear;
    Add('Goodness of fit for '+DistName+' distribution.');
  end;
end;

procedure TfrmGOFChi2.Edit1Change(Sender: TObject);
begin
  try
    NumBins := StrToInt(Edit1.Text);
  except
    NumBins := 25;
    Edit1.Text := IntToStr(NumBins);
  end;
  Series2.Clear;
  DrawDataHistogram;
end;

procedure TfrmGOFChi2.Button2Click(Sender: TObject);
var par1,par2: double;
begin
  DataVec.Size(1000);
  case ComboBox2.ItemIndex of
    0 : begin
          try
            par1 := StrToFloat(EditPar1.Text);
          except
            par1 := 1.3;
            EditPar1.Text := FormatFloat('0.00',par1);
          end;
          try
            par2 := StrToFloat(EditPar2.Text);
          except
            par2 := 0.7;
            EditPar2.Text := FormatFloat('0.00',par2);
          end;
          RandomBeta(par1,par2,DataVec);
        end;
    1 : begin
          try
            par1 := StrToInt(EditPar1.Text);
          except
            par1 := 3;
            EditPar1.Text := FormatFloat('0.00',par1);
          end;
          RandomChiSquare(Round(par1),DataVec);
        end;
    2 : begin
          try
            par1 := StrToFloat(EditPar1.Text);
          except
            par1 := 2;
            EditPar1.Text := IntToStr(Round(par1));
          end;
          try
            par2 := StrToFloat(EditPar2.Text);
          except
            par2 := 0.7;
            EditPar2.Text := FormatFloat('0.00',par2);
          end;
          RandomErlang(Round(par1),par2,DataVec);
        end;
    3 : begin
          try
            par1 := StrToFloat(EditPar1.Text);
          except
            par1 := 0.2;
            EditPar1.Text := FormatFloat('0.00',par1);
          end;
          RandomExponent(par1,DataVec);
        end;
    4 : begin
          try
            par1 := StrToFloat(EditPar1.Text);
          except
            par1 := 1.9;
            EditPar1.Text := FormatFloat('0.00',par1);
          end;
          try
            par2 := StrToFloat(EditPar2.Text);
          except
            par2 := 0.7;
            EditPar2.Text := FormatFloat('0.00',par2);
          end;
          RandomGamma(par1,par2,DataVec);
        end;
    5 : begin
          try
            par1 := StrToFloat(EditPar1.Text);
          except
            par1 := 1.8;
            EditPar1.Text := FormatFloat('0.00',par1);
          end;
          try
            par2 := StrToFloat(EditPar2.Text);
          except
            par2 := 0.7;
            EditPar2.Text := FormatFloat('0.00',par2);
          end;
          RandomLaplace(par1,par2,DataVec);
        end;
    6 : begin
          try
            par1 := StrToFloat(EditPar1.Text);
          except
            par1 := 7.2;
            EditPar1.Text := FormatFloat('0.00',par1);
          end;
          try
            par2 := StrToFloat(EditPar2.Text);
          except
            par2 := 1.3;
            EditPar2.Text := FormatFloat('0.00',par2);
          end;
          RandomLogNormal(par1,par2,DataVec);
        end;
    7 : begin
          try
            par1 := StrToFloat(EditPar1.Text);
          except
            par1 := 1.2;
            EditPar1.Text := FormatFloat('0.00',par1);
          end;
          RandomMaxwell(par1,DataVec);
        end;
    8 : begin
          try
            par1 := StrToFloat(EditPar1.Text);
          except
            par1 := 7.2;
            EditPar1.Text := FormatFloat('0.00',par1);
          end;
          try
            par2 := StrToFloat(EditPar2.Text);
          except
            par2 := 1.3;
            EditPar2.Text := FormatFloat('0.00',par2);
          end;
          RandomNormal(par1,par2,DataVec);
        end;
    9 : begin
          try
            par1 := StrToFloat(EditPar1.Text);
          except
            par1 := 2.2;
            EditPar1.Text := FormatFloat('0.00',par1);
          end;
          RandomRayleigh(par1,DataVec);
        end;
    10 : begin
          try
            par1 := StrToFloat(EditPar1.Text);
          except
            par1 := -2.3;
            EditPar1.Text := FormatFloat('0.00',par1);
          end;
          try
            par2 := StrToFloat(EditPar2.Text);
          except
            par2 := 1.5;
            EditPar2.Text := FormatFloat('0.00',par2);
          end;
          RandomUniform(par1,par2,DataVec);
        end;
    11 : begin
          try
            par1 := StrToFloat(EditPar1.Text);
          except
            par1 := 0.7;
            EditPar1.Text := FormatFloat('0.00',par1);
          end;
          try
            par2 := StrToFloat(EditPar2.Text);
          except
            par2 := 1.3;
            EditPar2.Text := FormatFloat('0.00',par2);
          end;
          RandomWeibull(par1,par2,DataVec);
        end;
  end;
  Series2.Clear;
  DrawDataHistogram;
end;

procedure TfrmGOFChi2.DrawDataHistogram;
var F,B: TVec;
begin
  CreateIt(F,B);
  try
    Histogram(DataVec,NumBins,F,B,True);
    DrawValues(B,F,Series1);
  finally
    FreeIt(F,B);
  end;
end;

{$WARNINGS OFF}
procedure TfrmGOFChi2.DoChi2Test;
var Signif: double;
  hRes: THypothesisResult;
  OFreq, PredFreq, Bins, SOS: TVec;
  Nu: Integer;
  dist: TDistribution;
begin
  Screen.Cursor := crHourGlass;
  try
    CreateIt(OFreq,PredFreq,Bins,SOS);
    try
      case ComboBox1.ItemIndex of
        0 : dist := distBeta;
        1 : dist := distChiSquare;
        2 : dist := distErlang;
        3 : dist := distExp;
        4 : dist := distGamma;
        5 : dist := distLaplace;
        6 : dist := distLogNormal;
        7 : dist := distMaxwell;
        8 : dist := distNormal;
        9 : dist := distRayleigh;
        10 : dist := distUniform;
        11 : dist := distWeibull;
      end;
      // Step 1: Generate necessary frequency lists,
      GOFChiFreqs(DataVec,dist,NumBins,Bins,PredFreq,OFreq,Nu);
      // Step 2: Plot theoretical frequency
      Sos.Length := Bins.Length-1;
      SOS.Add(Bins,Bins,0,1,0,Bins.Length-1);
      Sos.Scale(0.5);
      DrawValues(SOS,PredFreq,Series2);
      // Step 3: Do a Chi2 GOF test
      GOFChi2Test(OFreq,PredFreq,DataVec.Length,Nu,hRes,Signif,htTwoTailed,Alpha);
    finally
      FreeIt(OFreq,PredFreq,Bins,SOS);
    end;

    With Memo2.Lines do
    begin
      Clear;
      Add('CHI-SQUARED GOODNESS-OF-FIT TEST');
      Add('-------------------------------');
      Add('Ho: Distribution fits the data');
      Add('Ha: Distribution does not fit the data');
      Add('-------------------------------');
      Add('Test:');
      Add('Tested significance:  '+SampleToStr(Signif,4,5));
      Add('Alpha: '+SampleToStr(100*Alpha,2,4)+'%');
      if hRes = hrNotReject then Add('Data comes from tested distribution')
      else Add('Data does not come from tested distribution');
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;
{$WARNINGS ON}

procedure TfrmGOFChi2.ComboBox2Change(Sender: TObject);
begin
  case ComboBox2.ItemIndex of
    0 : begin
          lblDistName.Caption := 'Beta';
          lblPar2.Visible := True;
          lblPar1.Caption := 'a';
          lblPar2.Caption := 'b';
          EditPar2.Visible := lblPar2.Visible;
          EditPar1.Text := FormatFloat('0.00',1.3);
          EditPar2.Text := FormatFloat('0.00',0.7);
        end;
    1 : begin
          lblDistName.Caption := 'Chi Squared';
          lblPar2.Visible := False;
          lblPar1.Caption := 'Nu';
          EditPar2.Visible := lblPar2.Visible;
          EditPar1.Text := '3';
        end;
    2 : begin
          lblDistName.Caption := 'Erlang';
          lblPar2.Visible := true;
          lblPar1.Caption := 'k';
          lblPar2.Caption := 'lambda';
          EditPar2.Visible := lblPar2.Visible;
          EditPar1.Text := '2';
          EditPar2.Text := FormatFloat('0.00',0.7);
        end;
    3 : begin
          lblDistName.Caption := 'Exponential';
          lblPar2.Visible := False;
          lblPar1.Caption := 'Mu';
          EditPar2.Visible := lblPar2.Visible;
          EditPar1.Text := FormatFloat('0.00',0.2);
        end;
    4 : begin
          lblDistName.Caption := 'Gamma';
          lblPar2.Visible := true;
          lblPar1.Caption := 'a';
          lblPar2.Caption := 'b';
          EditPar2.Visible := lblPar2.Visible;
          EditPar1.Text := FormatFloat('0.00',1.8);
          EditPar2.Text := FormatFloat('0.00',0.7);
        end;
    5 : begin
          lblDistName.Caption := 'Laplace';
          lblPar2.Visible := true;
          lblPar1.Caption := 'm';
          lblPar2.Caption := 'b';
          EditPar2.Visible := lblPar2.Visible;
          EditPar1.Text := FormatFloat('0.00',1.8);
          EditPar2.Text := FormatFloat('0.00',0.7);
        end;
    6 : begin
          lblDistName.Caption := 'Log-Normal';
          lblPar2.Visible := True;
          lblPar1.Caption := 'mu';
          lblPar2.Caption := 'sigma';
          EditPar2.Visible := lblPar2.Visible;
          EditPar1.Text := FormatFloat('0.00',7.2);
          EditPar2.Text := FormatFloat('0.00',1.0);
        end;
    7 : begin
          lblDistName.Caption := 'Maxwell';
          lblPar2.Visible := False;
          lblPar1.Caption := 'a';
          EditPar2.Visible := lblPar2.Visible;
          EditPar1.Text := FormatFloat('0.00',1.2);
        end;
    8 : begin
          lblDistName.Caption := 'Normal';
          lblPar2.Visible := True;
          lblPar1.Caption := 'mu';
          lblPar2.Caption := 'sigma';
          EditPar2.Visible := lblPar2.Visible;
          EditPar1.Text := FormatFloat('0.00',7.2);
          EditPar2.Text := FormatFloat('0.00',1.0);
        end;
    9 : begin
          lblDistName.Caption := 'Rayleigh';
          lblPar2.Visible := False;
          lblPar1.Caption := 'b';
          EditPar2.Visible := lblPar2.Visible;
          EditPar1.Text := FormatFloat('0.00',2.2);
        end;
    10 : begin
          lblDistName.Caption := 'Uniform';
          lblPar2.Visible := True;
          lblPar1.Caption := 'low';
          lblPar2.Caption := 'high';
          EditPar2.Visible := lblPar2.Visible;
          EditPar1.Text := FormatFloat('0.00',-2.3);
          EditPar2.Text := FormatFloat('0.00',1.5);
        end;
    11 : begin
          lblDistName.Caption := 'Weibull';
          lblPar2.Visible := True;
          lblPar1.Caption := 'a';
          lblPar2.Caption := 'b';
          EditPar2.Visible := lblPar2.Visible;
          EditPar1.Text := FormatFloat('0.00',0.7);
          EditPar2.Text := FormatFloat('0.00',1.3);
        end;
    end;
end;

procedure TfrmGOFChi2.Button3Click(Sender: TObject);
begin
  DoChi2Test;
end;

procedure TfrmGOFChi2.Edit2Change(Sender: TObject);
begin
  try
    Alpha := StrToSample(Edit2.Text);
  except
    Alpha := 0.05;
    Edit2.Text := SampleToStr(Alpha);
  end;
end;

initialization
  RegisterClass(TfrmGOFChi2);

end.

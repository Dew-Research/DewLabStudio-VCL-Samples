unit DewProbWrapper;

interface

{$FINITEFLOAT OFF}  //required for VCL.NET

uses Classes, SysUtils, Probabilities, Math387;

type

  {:Probability parameter number type.
    Probability parameter number type.
    @enum parInteger integer.
    @enum parTSample double.
  }
  TProbParType = (parInteger, parTSample);

  (*<summary>Defines parameter domain.</summary>*)
  TParamDomain=(domUnbounded, domBounded, domPositive);

  TProbParameter = class; { fwd declaration }
  TProbParameters = class; { fwd declaration }

  TProbDistribution = class(TPersistent)
  private
    FDistParams: TProbParameters;
    FCaption: String;
    FDistType: TDistribution;
    FNumPoints: Integer;
    FUB: double;
    FLB: double;
    fInit: boolean;
    fMean, fVariance, fSkewness, fKurtosis: double;
    FX: TProbParameter;
    Fp: TProbParameter;
    procedure InitDistribution;
    procedure SetDistParams(const Value: TProbParameters);
    procedure SetCaption(const Value: String);
    function GetDiscrete: boolean;
    procedure SetDistType(const Value: TDistribution);
    procedure SetLB(const Value: double);
    procedure SetNumPoints(const Value: Integer);
    procedure SetUB(const Value: double);
    procedure CalcStats;
    procedure SetX(const Value: TProbParameter);
    procedure Setp(const Value: TProbParameter);
    function GetCDF: double;
    function GetPDF: double;
    function GetPPF: double;
    function GetCumHazard: double;
    function GetHazard: double;
    function GetSurvival: double;
  public
    (*::Returns true if distributions parameter values are valid.*)

    (*::@Returns distribution probability density function.*)
    function CalculatePDF(Value:double): double;
    (*::Returns distribution cumulative distribution function.*)
    function CalculateCDF(Value: double): double;
    (*::Returns distribution percent point function.*)
    function CalculatePPF(Value: double): double;
    (*::Returns distribution survival function.*)
    function CalculateS(Value: double): double;
    (*::Returns distribution hazard function.*)
    function CalculateH(Value: double): double;
    (*::Returns distribution cumulattive hazard function.*)
    function CalculateCumH(Value: double): double;

    procedure InitParameters;
    property PDF: double read GetPDF;
    property CDF: double read GetCDF;
    property PPF: double read GetPPF;
    property Survival: double read GetSurvival;
    property Hazard: double read GetHazard;
    property CumHazard: double read GetCumHazard;
    (*::True, if distribution is discrete.*)
    property Discrete: boolean read GetDiscrete;
    (*::Returns distribution mean estimate.*)
    property Mean: double read fMean;
    (*::Returns distribution variance estimate.*)
    property Variance: double read fVariance;
    (*::Returns distribution skewness estimate.*)
    property Skewness: double read fSkewness;
    (*::Returns distribution kurtosis estimate.*)
    property Kurtosis: double read fKurtosis;

    constructor Create;
    destructor Destroy; override;
  published
    property Caption: String read FCaption write SetCaption;
    (*::Defines specific distribution.*)
    property DistType: TDistribution read FDistType write SetDistType default distBeta;
    (*<summary>Distribution parameters.</summary>*)
    property DistParams: TProbParameters read FDistParams write SetDistParams;
    property X: TProbParameter read FX write SetX;
    property p: TProbParameter read Fp write Setp;
    property LB: double read FLB write SetLB;
    property UB: double read FUB write SetUB;
    property NumPoints: Integer read FNumPoints write SetNumPoints default 50;
  end;

  (*:Collection of distribution parameters.*)
  TProbParameters = class(TOwnedCollection)
  private
    function GetProbParameter(index: Integer): TProbParameter;
    procedure SetProbParameter(index: Integer;
      const Value: TProbParameter);
  public
    function Owner: TProbDistribution;
    function AddParameter(aName: String; aType: TProbParType; aNotes: String; aValue: double): TProbParameter; overload;
    function AddParameter(aName: String; aType: TProbParType; aLB, aUB: double; aNotes: String; aValue: double): TProbParameter; overload;
    property Items[index: Integer]: TProbParameter read GetProbParameter write SetProbParameter; default;
    constructor Create(AOwner: TProbDistribution);
  end;

  (*:Distribution parameter*)
  TProbParameter = class(TCollectionItem)
  private
    FCaption: String;
    FParameterType: TProbParType;
    FNotes: String;
    FValue: double;
    FUB: double;
    FLB: double;
    procedure SetName(const Value: String);
    procedure SetNotes(const Value: String);
    procedure SetValue(const Value: double);
    procedure SetLB(const Value: double);
    procedure SetUB(const Value: double);
    function GetParameterDomain: TParamDomain;
  public
    property Name: String read FCaption write SetName;
    property Notes: String read FNotes write SetNotes;
    property Value: double read FValue write SetValue;
    property LB: double read FLB write SetLB;
    property UB: double read FUB write SetUB;
    property Domain: TParamDomain read GetParameterDomain;
    property ParameterType: TProbParType read FParameterType;

    function IntValue: integer;
    function ValueIsValid: boolean;

    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  end;


implementation

{ TProbDistribution }

function TProbDistribution.CalculateCDF(Value: double): double;
begin
  Result := NAN;
  case FDistType of
    distBeta: Result := BetaCDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distBernoulli: Result := BernoulliCDF(Round(Value),FDistParams[0].Value);
    distBinom: Result := BinomCDF(Round(Value),FDistParams[0].IntValue,FDistParams[1].Value);
    distBOSEEINSTEIN: Result := BoseEinsteinCDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distCauchy: Result := CauchyCDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distChiSquare: Result := ChiSquareCDF(Value,FDistParams[0].IntValue);
    distErlang: Result := ErlangCDF(Value,FDistParams[0].IntValue,FDistParams[1].Value);
    distExp: Result := ExpCDF(Value,FDistParams[0].Value);
    distF: Result := FCDF(Value,FDistParams[0].IntValue,FDistParams[1].IntValue);
    distFatigue: Result := FatigueLifeCDF(Value,FDistParams[0].Value,FDistParams[1].Value,FDistParams[2].Value);
    distFermiDirac: Result := FermiDiracCDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distGamma: Result := GammaCDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distGenExtValue: Result := GenExtValueCDF(Value,FDistParams[0].Value,FDistParams[1].Value,FDistParams[2].Value);
    distGenPareto:  Result := GenParetoCDF(Value,FDistParams[0].Value,FDistParams[1].Value,FDistParams[2].Value);
    distGeometric: Result := GeometricCDF(Round(Value),FDistParams[0].Value);
    distGumbelMax: Result := GumbelCDF(Value,FDistParams[0].Value,FDistParams[1].Value,false);
    distGumbelMin: Result := GumbelCDF(Value,FDistParams[0].Value,FDistParams[1].Value,true);
    distHypGeometric: Result := HypGeometricCDF(Round(Value),FDistParams[0].IntValue,FDistParams[1].IntValue,FDistParams[2].IntValue);
    distInvChi2: Result := InverseChiSquareCDF(Value,FDistParams[0].IntValue);
    distInvGauss: Result := InverseGaussianCDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distJohnsonSB: Result := JohnsonSBCDF(Value,FDistParams[0].Value,FDistParams[1].Value,FDistParams[2].Value,FDistParams[3].Value);
    distJohnsonUB: Result := JohnsonUBCDF(Value,FDistParams[0].Value,FDistParams[1].Value,FDistParams[2].Value,FDistParams[3].Value);
    distLaplace: Result := LaplaceCDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distLogistic: Result := LogisticCDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distLogarithmic: Result := LogarithmicCDF(Round(Value),FDistParams[0].Value);
    distLogNormal: Result := LogNormalCDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distLogWeibull: Result := LogWeibullCDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distMaxwell: Result := MaxwellCDF(Value,FDistParams[0].Value);
    distNegBinom: Result := NegBinomCDF(Round(Value),FDistParams[0].Value,FDistParams[1].Value);
    distNormal: Result := NormalCDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distPareto: Result := ParetoCDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distPoisson: Result := PoissonCDF(Round(Value),FDistParams[0].Value);
    distPower: Result := PowerCDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distRayleigh: Result := RayleighCDF(Value,FDistParams[0].Value);
    distStudent: Result := StudentCDF(Value,FDistParams[0].IntValue);
    distTriangular: Result := TriangularCDF(Value,FDistParams[0].Value,FDistParams[1].Value,FDistParams[2].Value);
    distUniform: Result := UniformCDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distUniformD: Result := UniformDCDF(Round(Value),FDistParams[0].IntValue);
    distWeibull: Result := WeibullCDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distZipf: Result := ZipfCDF(Round(Value),FDistParams[0].Value,FDistParams[1].IntValue);
  end;
end;

function TProbDistribution.CalculateCumH(Value: double): double;
begin
  if Discrete then Result := NAN else Result := -Ln(1.0 - CalculateCDF(Value));
end;

function TProbDistribution.CalculateS(Value: double): double;
begin
  Result := 1.0 - CalculateCDF(Value);
end;

function TProbDistribution.CalculateH(Value: double): double;
begin
  if Discrete then Result := NAN else Result := CalculatePDF(Value)/(1.0 - CalculateCDF(Value));
end;

procedure TProbDistribution.CalcStats;
begin
  fMean := NAN;
  fVariance := NAN;
  fSkewness := NAN;
  fKurtosis := NAN;
  if Not(fInit) then
  begin
    case DistType of
    distBETA: BetaStat(DistParams[0].Value,DistParams[1].Value,fMean,fVariance,fSkewness,fKurtosis);
    distBERNOULLI: BernoulliStat(DistParams[0].Value,fMean,fVariance,fSkewness,fKurtosis);
    distBINOM: BinomStat(DistParams[0].IntValue,DistParams[1].Value,fMean,fVariance,fSkewness,fKurtosis);
    distCAUCHY: CauchyStat(DistParams[0].Value,DistParams[1].Value,fMean,fVariance,fSkewness,fKurtosis);
    distCHISQUARE: ChiSquareStat(DistParams[0].IntValue,fMean,fVariance,fSkewness,fKurtosis);
    distErlang: ErlangStat(DistParams[0].IntValue,DistParams[1].Value,fMean,fVariance,fSkewness,fKurtosis);
    distExp: ExponentStat(DistParams[0].Value,fMean,fVariance,fSkewness,fKurtosis);
    distF: FStat(DistParams[0].IntValue,DistParams[1].IntValue,fMean,fVariance,fSkewness,fKurtosis);
    distFatigue: FatigueLifeStat(DistParams[0].Value,DistParams[1].Value,DistParams[2].Value,fMean,fVariance,fSkewness,fKurtosis);
    distGamma: GammaStat(DistParams[0].Value,DistParams[1].Value,fMean,fVariance,fSkewness,fKurtosis);
    distGenExtValue: GenExtValueStat(DistParams[0].Value,DistParams[1].Value,DistParams[2].Value,fMean,fVariance,fSkewness,fKurtosis);
    distGenPareto: GenParetoStat(DistParams[0].Value,DistParams[1].Value,DistParams[2].Value,fMean,fVariance,fSkewness,fKurtosis);
    distGeometric: GeometricStat(DistParams[0].Value,fMean,fVariance,fSkewness,fKurtosis);
    distGumbelMax, distGumbelMin: GumbelStat(DistParams[0].Value,DistParams[1].Value,fMean,fVariance,fSkewness,fKurtosis);
    distHypGeometric: HypGeometricStat(DistParams[0].IntValue,DistParams[1].IntValue,DistParams[2].IntValue,fMean,fVariance,fSkewness,fKurtosis);
    distInvChi2: InverseChiSquareStat(FDistParams[0].IntValue,fMean,fVariance,fSkewness,fKurtosis);
    distInvGauss: InverseGaussianStat(DistParams[0].Value,DistParams[1].Value,fMean,fVariance,fSkewness,fKurtosis);
    distJohnsonSB: JohnsonSBStat(DistParams[0].Value,DistParams[1].Value,DistParams[2].Value,DistParams[3].Value,fMean,fVariance,fSkewness,fKurtosis);
    distJohnsonUB: JohnsonUBStat(DistParams[0].Value,DistParams[1].Value,DistParams[2].Value,DistParams[3].Value,fMean,fVariance,fSkewness,fKurtosis);
    distLaplace: LaplaceStat(DistParams[0].Value,DistParams[1].Value,fMean,fVariance,fSkewness,fKurtosis);
    distLogarithmic: LogarithmicStat(DistParams[0].Value,fMean,fVariance,fSkewness,fKurtosis);
    distLogistic: LogisticStat(DistParams[0].Value,DistParams[1].Value,fMean,fVariance,fSkewness,fKurtosis);
    distLogNormal: LogNormalStat(DistParams[0].Value,DistParams[1].Value,fMean,fVariance,fSkewness,fKurtosis);
    distLogWeibull: LogWeibullStat(DistParams[0].Value,DistParams[1].Value,fMean,fVariance,fSkewness,fKurtosis);
    distMaxwell: MaxwellStat(DistParams[0].Value,fMean,fVariance,fSkewness,fKurtosis);
    distNegBinom: NegBinomStat(DistParams[0].IntValue,DistParams[1].Value,fMean,fVariance,fSkewness,fKurtosis);
    distNormal: NormalStat(DistParams[0].Value,DistParams[1].Value,fMean,fVariance,fSkewness,fKurtosis);
    distPareto: ParetoStat(DistParams[0].Value,DistParams[1].Value,fMean,fVariance,fSkewness,fKurtosis);
    distPoisson: PoissonStat(DistParams[0].Value,fMean,fVariance,fSkewness,fKurtosis);
    distPower: PowerStat(DistParams[0].Value,DistParams[1].Value,fMean,fVariance,fSkewness,fKurtosis);
    distRayleigh: RayleighStat(DistParams[0].Value,fMean,fVariance,fSkewness,fKurtosis);
    distStudent: StudentStat(DistParams[0].IntValue,fMean,fVariance,fSkewness,fKurtosis);
    distTriangular: TriangularStat(DistParams[0].Value,DistParams[1].Value,DistParams[2].Value,fMean,fVariance,fSkewness,fKurtosis);
    distUniform: UniformStat(DistParams[0].Value,DistParams[1].Value,fMean,fVariance,fSkewness,fKurtosis);
    distUniformD: UniformDStat(DistParams[0].IntValue,fMean,fVariance,fSkewness,fKurtosis);
    distWeibull: WeibullStat(DistParams[0].Value,DistParams[1].Value,fMean,fVariance,fSkewness,fKurtosis);
    distZIPF: ZipfStat(DistParams[0].Value,DistParams[1].IntValue,fMean,fVariance,fSkewness,fKurtosis);
   end;
  end;
end;

function TProbDistribution.CalculatePPF(Value: double): double;
begin
  Result := NAN;
  case FDistType of
    distBeta: Result := BetaCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value);
    distBernoulli: Result := BernoulliCDFInv(Value,FDistParams[0].Value);
    distBinom: Result := BinomCDFInv(Value,FDistParams[0].IntValue,FDistParams[1].Value);
    distCauchy: Result := CauchyCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value);
    distChiSquare: Result := ChiSquareCDFInv(Value,FDistParams[0].IntValue);
    distErlang: Result := ErlangCDFInv(Value,FDistParams[0].IntValue,FDistParams[1].Value);
    distExp: Result := ExpCDFInv(Value,FDistParams[0].Value);
    distF: Result := FCDFInv(Value,FDistParams[0].IntValue,FDistParams[1].IntValue);
    distFatigue: Result := FatigueLifeCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value,FDistParams[2].Value);
    distGamma: Result := GammaCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value);
    distGenExtValue: Result := GenExtValueCdfInv(Value,FDistParams[0].Value,FDistParams[1].Value,FDistParams[2].Value);
    distGenPareto:  Result := GenParetoCdfInv(Value,FDistParams[0].Value,FDistParams[1].Value,FDistParams[2].Value);
    distGeometric: Result := GeometricCDFInv(Value,FDistParams[0].Value);
    distGumbelMax: Result := GumbelCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value,false);
    distGumbelMin: Result := GumbelCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value,true);
    distHypGeometric: Result := HypGeometricCDFInv(Value,FDistParams[0].IntValue,FDistParams[1].IntValue,FDistParams[2].IntValue);
    distInvChi2: Result := InverseChiSquareCDFInv(Value,FDistParams[0].IntValue);
    distInvGauss: Result := InverseGaussianCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value);
    distJohnsonSB: Result := JohnsonSBCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value,FDistParams[2].Value,FDistParams[3].Value);
    distJohnsonUB: Result := JohnsonUBCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value,FDistParams[2].Value,FDistParams[3].Value);
    distLaplace: Result := LaplaceCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value);
    distLogarithmic: Result := LogarithmicCDFInv(Value,FDistParams[0].Value);
    distLogistic: Result := LogisticCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value);
    distLogNormal: Result := LogNormalCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value);
    distLogWeibull: Result := LogWeibullCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value);
    distMaxwell: Result := MaxwellCDFInv(Value,FDistParams[0].Value);
    distNegBinom: Result := NegBinomCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value);
    distNormal: Result := NormalCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value);
    distPareto: Result := ParetoCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value);
    distPoisson: Result := PoissonCDFInv(Value,FDistParams[0].Value);
    distPower: Result := PowerCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value);
    distRayleigh: Result := RayleighCDFInv(Value,FDistParams[0].Value);
    distStudent: Result := StudentCDFInv(Value,FDistParams[0].IntValue);
    distTriangular: Result := TriangularCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value,FDistParams[2].Value);
    distUniform: Result := UniformCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value);
    distUniformD: Result := UniformDCDFInv(Value,FDistParams[0].IntValue);
    distWeibull: Result := WeibullCDFInv(Value,FDistParams[0].Value,FDistParams[1].Value);
    distZipf: Result := ZipfCDFInv(Value,FDistParams[0].Value,FDistParams[1].IntValue);
  end;
end;

function TProbDistribution.CalculatePDF(Value:double): double;
begin
  Result := NAN;
  case FDistType of
    distBeta: Result := BetaPDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distBernoulli: Result := BernoulliPDF(Round(Value),FDistParams[0].Value);
    distBinom: Result := BinomPDF(Round(Value),FDistParams[0].IntValue,FDistParams[1].Value);
    distBOSEEINSTEIN: Result := BoseEinsteinPDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distCauchy: Result := CauchyPDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distChiSquare: Result := ChiSquarePDF(Value,FDistParams[0].IntValue);
    distErlang: Result := ErlangPDF(Value,FDistParams[0].IntValue,FDistParams[1].Value);
    distExp: Result := ExpPDF(Value,FDistParams[0].Value);
    distF: Result := FPDF(Value,FDistParams[0].IntValue,FDistParams[1].IntValue);
    distFatigue: Result := FatigueLifePDF(Value,FDistParams[0].Value,FDistParams[1].Value,FDistParams[2].Value);
    distFermiDirac: Result := FermiDiracPDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distGamma: Result := GammaPDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distGenExtValue: Result := GenExtValuePDF(Value,FDistParams[0].Value,FDistParams[1].Value,FDistParams[2].Value);
    distGenPareto:  Result := GenParetoPDF(Value,FDistParams[0].Value,FDistParams[1].Value,FDistParams[2].Value);
    distGeometric: Result := GeometricPDF(Round(Value),FDistParams[0].Value);
    distGumbelMax: Result := GumbelPDF(Value,FDistParams[0].Value,FDistParams[1].Value,false);
    distGumbelMin: Result := GumbelPDF(Value,FDistParams[0].Value,FDistParams[1].Value,true);
    distHypGeometric: Result := HypGeometricPDF(Round(Value),FDistParams[0].IntValue,FDistParams[1].IntValue,FDistParams[2].IntValue);
    distInvChi2: Result := InverseChiSquarePDF(Value,FDistParams[0].IntValue);
    distInvGauss: Result := InverseGaussianPDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distJohnsonSB: Result := JohnsonSBPDF(Value,FDistParams[0].Value,FDistParams[1].Value,FDistParams[2].Value,FDistParams[3].Value);
    distJohnsonUB: Result := JohnsonUBPDF(Value,FDistParams[0].Value,FDistParams[1].Value,FDistParams[2].Value,FDistParams[3].Value);
    distLaplace: Result := LaplacePDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distLogarithmic: Result := LogarithmicPDF(Round(Value),FDistParams[0].Value);
    distLogistic: Result := LogisticPDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distLogNormal: Result := LogNormalPDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distLogWeibull: Result := LogWeibullPDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distMaxwell: Result := MaxwellPDF(Value,FDistParams[0].Value);
    distNegBinom: Result := NegBinomPDF(Round(Value),FDistParams[0].Value,FDistParams[1].Value);
    distNormal: Result := NormalPDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distPareto: Result := ParetoPDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distPoisson: Result := PoissonPDF(Round(Value),FDistParams[0].Value);
    distPower: Result := PowerPDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distRayleigh: Result := RayleighPDF(Value,FDistParams[0].Value);
    distStudent: Result := StudentPDF(Value,FDistParams[0].IntValue);
    distTriangular: Result := TriangularPDF(Value,FDistParams[0].Value,FDistParams[1].Value,FDistParams[2].Value);
    distUniform: Result := UniformPDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distUniformD: Result := UniformDPDF(Round(Value),FDistParams[0].IntValue);
    distWeibull: Result := WeibullPDF(Value,FDistParams[0].Value,FDistParams[1].Value);
    distZipf: Result := ZipfPDF(Round(Value),FDistParams[0].Value,FDistParams[1].IntValue);
  end;
end;



constructor TProbDistribution.Create;
begin
  inherited Create;
  FDistParams := TProbParameters.Create(Self);
  // Setup x and p
  FX := TProbParameter.Create(nil);
  FX.FParameterType := parTSample;
  fX.FCaption := 'x';

  fP := TProbParameter.Create(nil);
  fP.FParameterType := parTSample;
  fP.FCaption := 'p';
  fP.FLB := 0;
  fP.FUB := 1.0;

  FDistType := distBeta;
  InitDistribution;
end;

destructor TProbDistribution.Destroy;
begin
  FDistParams.Free;
  FX.Free;
  FP.Free;
  inherited Destroy;
end;

function TProbDistribution.GetCDF: double;
begin
   Result := CalculateCDF(fX.Value);
end;

function TProbDistribution.GetCumHazard: double;
begin
  Result := CalculateCumH(fX.Value);
end;

function TProbDistribution.GetHazard: double;
begin
  Result := CalculateH(fX.Value);
end;

function TProbDistribution.GetPDF: double;
begin
  Result := CalculatePDF(fX.Value);
end;

function TProbDistribution.GetSurvival: double;
begin
  Result := CalculateS(fX.Value);
end;

function TProbDistribution.GetPPF: double;
begin
  Result := CalculatePPF(fP.Value);
end;

function TProbDistribution.GetDiscrete: boolean;
begin
  Result := ((FDistType=distBinom) or (FDistType=distGeometric) or (FDistType=distHypGeometric)
            or (FDistType=distNegBinom) or (FDistType=distPoisson) or (FDistType=distUniformD))
            or (fDistType=distLogarithmic) or (fDistType=distBernoulli) or (fDistType=distZipf);
end;

procedure TProbDistribution.InitDistribution;
begin
    fInit := True;
    FDistParams.Clear;
    case FDistType of
    distBeta  : begin
                  FCaption := 'Beta';
                  fX.FParameterType := parTSample;
                  fX.Value := 0.44;
                  FdistParams.AddParameter('a',parTSample,EPS,INF,'a>0',0.5);
                  FdistParams.AddParameter('b',parTSample,EPS,INF,'b>0',1.5);
                  FLb := EPS;
                  FUB := 1.0-EPS;
                end;
    distBernoulli  : begin
                  FCaption := 'Bernoulli';
                  fX.FParameterType := parInteger;
                  fX.Value := 1;
                  FDistParams.AddParameter('p',parTSample,0,1,'0<=p<=1',0.44);
                  FLb := 0;
                  FUB := 1;
                end;
    distBinom  : begin
                  FCaption := 'Binomial';
                  fX.FParameterType := parInteger;
                  fX.Value := 3;
                  FDistParams.AddParameter('n',parInteger,0,INF,'n>0',6);
                  FDistParams.AddParameter('p',parTSample,0,1,'0<=p<=1',0.56);
                  FLB := 0.0;
                  FUB := 8.0;
                end;
    distBoseEinstein  : begin
                  FCaption := 'Bose-Einstein';
                  fX.FParameterType := parTSample;
                  fX.Value := 4;
                  FDistParams.AddParameter('mu',parTSample,-Inf,INF,'',1.12);
                  FDistParams.AddParameter('s',parTSample,EPS,INF,'s>0',1);
                  FLb := EPS;
                  FUB := 6;
                end;
    distCauchy  : begin
                  FCaption := 'Cauchy';
                  fX.FParameterType := parTSample;
                  fX.Value := 2.5;
                  FDistParams.AddParameter('m',parTSample,EPS,Inf,'m>0',3.2);
                  FDistParams.AddParameter('b',parTSample,EPS,Inf,'b>0',0.9);
                  FLb := -3;
                  FUB := 4;
                end;
    distChiSquare
                : begin
                  FCaption := 'Chi-Squared';
                  fX.FParameterType := parTSample;
                  fX.Value := 2.5;
                  FDistParams.AddParameter('nu',parInteger,2,Inf,'Nu>1',4);
                  FLb := EPS;
                  FUB := 7;
                end;
    distErlang : begin
                  FCaption := 'Erlang';
                  fX.FParameterType := parTSample;
                  fX.Value := 2.5;
                  FLb := 0;
                  FUB := 4;
                  FDistParams.AddParameter('k',parInteger,EPS,Inf,'k>0',3);
                  FDistParams.AddParameter('lambda',parTSample,EPS,Inf,'lambda>0',0.75);
                end;
    distExp  : begin
                  FCaption := 'Exponential';
                  fX.FParameterType := parTSample;
                  fX.Value := 2.5;
                  FDistParams.AddParameter('lambda',parTSample,EPS,Inf,'lambda>0',4.3);
                  FLb := EPS;
                  FUB := 6;
                end;
    distF  :   begin
                  FCaption := 'Fisher(F)';
                  fX.FParameterType := parTSample;
                  fX.Value := 2.5;
                  FLb := 0;
                  FUB := 7;
                  FDistParams.AddParameter('nu1',parInteger,1,Inf,'Nu1>1',3);
                  FDistParams.AddParameter('nu2',parInteger,1,Inf,'Nu2>1',4);
                end;
    distFatigue  : begin
                  FCaption := 'Fatigue Life';
                  FDistParams.AddParameter('mu',parTSample,-Inf,Inf,'',0.0);
                  FDistParams.AddParameter('gamma',parTSample,EPS,Inf,'gamma>0',0.5);
                  FDistParams.AddParameter('beta',parTSample,EPS,Inf,'beta>0',1.0);
                  fX.FParameterType := parTSample;
                  fX.Value := 1.4;
                  FLB := 0.0;
                  FUB := 4.0;
                end;
    distFermiDirac  : begin
                  FCaption := 'Fermi-Dirac';
                  fX.FParameterType := parTSample;
                  fX.Value := 4;
                  FDistParams.AddParameter('mu',parTSample,-Inf,Inf,'',2.5);
                  FDistParams.AddParameter('s',parTSample,EPS,Inf,'s>0',0.5);
                  FLB := 1.0;
                  FUB := 6.0;
                end;
    distGamma : begin
                  FCaption := 'Gamma';
                  fX.FParameterType := parTSample;
                  FDistParams.AddParameter('a',parTSample,Eps,Inf,'a>0',1.0);
                  FDistParams.AddParameter('b',parTSample,Eps,Inf,'b>0',0.2);
                  FLB := 0.0;
                  FUB := 4.5;
                end;
    distGenExtValue :
                begin
                  FCaption := 'Generalized extreme value';
                  fX.FParameterType := parTSample;
                  fX.Value := 2.5;
                  FDistParams.AddParameter('k',parTSample, -Inf,Inf,'',-0.08);
                  FDistParams.AddParameter('mu',parTSample,-Inf,Inf,'',2.0);
                  FDistParams.AddParameter('sigma',parTSample,Eps,Inf,'sigma>0',1.0);
                  FLB := 0;
                  FUB := 4.0;
                end;
    distGenPareto :
                begin
                  FCaption := 'Generalized Pareto';
                  fX.FParameterType := parTSample;
                  fX.Value := 2.5;
                  FDistParams.AddParameter('k',parTSample,-Inf,Inf,'',-0.5);
                  FDistParams.AddParameter('mu',parTSample,-Inf,Inf,'',1.2);
                  FDistParams.AddParameter('sigma',parTSample,EPS,Inf,'s>0',1.0);
                  FLB := 0;
                  FUB := 4.0;
                end;
    distGeometric
              : begin
                  FCaption := 'Geometric';
                  fX.FParameterType := parInteger;
                  fX.Value := 3;
                  FDistParams.AddParameter('p',parTSample,0,1,'0<=p<=1',0.4);
                  FLB := 0.0;
                  FUB := 6.5;
                end;
    distGumbelMax : begin
                  FCaption := 'Gumbel (maximum)';
                  fX.FParameterType := parTSample;
                  fX.Value := 1.2;
                  FDistParams.AddParameter('mu',parTSample,-Inf,Inf,'',0.3);
                  FDistParams.AddParameter('beta',parTSample,Eps,Inf,'beta>0',0.7);
                  FLB := -2;
                  FUB := 3;
                end;
    distGumbelMin : begin
                  FCaption := 'Gumbel (minimum)';
                  fX.FParameterType := parTSample;
                  fX.Value := 1.5;
                  FDistParams.AddParameter('mu',parTSample,-Inf,Inf,'',0.3);
                  FDistParams.AddParameter('beta',parTSample,Eps,Inf,'beta>0',0.7);
                  FLB := -2;
                  FUB := 3;
                end;
    distHypGeometric
              : begin
                  FCaption := 'Hypergeometric';
                  fX.FParameterType := parInteger;
                  fX.Value := 2;
                  FDistParams.AddParameter('M',parInteger,'0<=M<INF',15);
                  FDistParams.AddParameter('K',parInteger,'0<=K<=M',8);
                  FDistParams.AddParameter('N',parInteger,'0<=N<=m',9);
                  FLB := 0;
                  FUB := 9;
                end;
    distInvChi2: begin
                  FCaption := 'Inverse Chi-Squared';
                  fX.FParameterType := parTSample;
                  fX.Value := 1.0;
                  FDistParams.AddParameter('Nu',parInteger,1,INF,'Nu>=1',9);
                  FLB := 0;
                  FUB := 4;
                end;
    distInvGauss: begin
                  FCaption := 'Inverse Gaussian';
                  fX.FParameterType := parTSample;
                  fX.Value := 2.5;
                  FDistParams.AddParameter('mu',parTSample,Eps,Inf,'mu>0',2.0);
                  FDistParams.AddParameter('lambda',parTSample,Eps,Inf,'lambda>0',1.3);
                  FLB := 0;
                  FUB := 5;
                end;
    distJohnsonSB : begin
                  FCaption := 'Johnson SB';
                  FDistParams.AddParameter('gamma',parTSample,-Inf,Inf,'',1.8);
                  FDistParams.AddParameter('delta',parTSample,EPS,Inf,'delta>0',1.5);
                  FDistParams.AddParameter('lambda',parTSample,Eps,Inf,'lambda>0',1.5);
                  FDistParams.AddParameter('xi',parTSample,-Inf,Inf,'',0.0);
                  fX.FParameterType := parTSample;
                  fX.Value := 0.5;
                  FLB := 0;
                  FUB := 1.5;
                end;
    distJohnsonUB : begin
                  FCaption := 'Johnson UB';
                  fX.FParameterType := parTSample;
                  fX.Value := 0.5;
                  FDistParams.AddParameter('gamma',parTSample,-Inf,Inf,'',1.8);
                  FDistParams.AddParameter('delta',parTSample,Eps,Inf,'delta>0',1.5);
                  FDistParams.AddParameter('lambda',parTSample,Eps,Inf,'lambda>0',1.5);
                  FDistParams.AddParameter('xi',parTSample,-Inf,Inf,'',0.0);
                  FLB := 0;
                  FUB := 1.5;
                end;
    distLaplace : begin
                  FCaption := 'Laplace';
                  fX.FParameterType := parTSample;
                  fX.Value := 2.5;
                  FDistParams.AddParameter('m',parTSample,-Inf,Inf,'',1.0);
                  FDistParams.AddParameter('b',parTSample,Eps,Inf,'b>0',0.3);
                  FLB := -3;
                  FUB := 3;
                end;
    distLogarithmic : begin
                  FCaption := 'Logarithmic';
                  fX.FParameterType := parInteger;
                  fX.Value := 2;
                  FDistParams.AddParameter('p',parTSample,EPS,1-EPS,'0<p<1',0.65);
                  FLB := 0;
                  FUB := 5.0;
                end;
    distLogistic : begin
                  FCaption := 'Logistic';
                  fX.FParameterType := parTSample;
                  fX.Value := 2.5;
                  FDistParams.AddParameter('m',parTSample,-Inf,Inf,'',1.0);
                  FDistParams.AddParameter('b',parTSample,Eps,Inf,'b>0',0.3);
                  FLB := 0;
                  FUB := 2.0;
                end;
    distLogNormal
                 : begin
                  FCaption := 'Log-normal';
                  fX.FParameterType := parTSample;
                  fX.Value := 2.5;
                  FDistParams.AddParameter('mu',parTSample,-Inf,Inf,'',1.0);
                  FDistParams.AddParameter('sigma',parTSample,Eps,Inf,'sigma>0',0.2);
                  FLB := 0;
                  FUB := 4.0;
                end;
    distLogWeibull
                 : begin
                  FCaption := 'Log-Weibull';
                  fX.FParameterType := parTSample;
                  fX.Value := 2.5;
                  FDistParams.AddParameter('a',parTSample,-Inf,Inf,'',1.0);
                  FDistParams.AddParameter('b',parTSample,-Inf,Inf,'b<>0',0.2);
                  FLB := 0;
                  FUB := 4.0;
                end;
    distMaxwell
              : begin
                  FCaption := 'Maxwell';
                  fX.FParameterType := parTSample;
                  fX.Value := 1.5;
                  FDistParams.AddParameter('a',parTSample,Eps,Inf,'a>0',0.4);
                  FLB := 0;
                  FUB := 3.0;
                end;
    distNegBinom
              : begin
                  FCaption := 'Negative binomial';
                  fX.FParameterType := parInteger;
                  fX.Value := 2.5;
                  FDistParams.AddParameter('R',parTSample,EPS,INF,'R>0',3.5);
                  FDistParams.AddParameter('p',parTSample,0,1,'0<=p<=1',0.7);
                  FLB := 0;
                  FUB := 12.0;
                end;
    distNormal: begin
                  FCaption := 'Normal';
                  fX.FParameterType := parTSample;
                  fX.Value := 2.5;
                  FDistParams.AddParameter('mu',parTSample,-Inf,Inf,'',0.0);
                  FDistParams.AddParameter('sigma',parTSample,Eps,Inf,'sigma>0',1.0);
                  FLB := -3.0;
                  FUB := 3.0;
                end;
    distPareto: begin
                  FCaption := 'Pareto';
                  fX.FParameterType := parTSample;
                  fX.Value := 0.7;
                  FDistParams.AddParameter('a',parTSample,EPS,Inf,'a>0',2.0);
                  FDistParams.AddParameter('b',parTSample,EPS,Inf,'b>0',0.2);
                  FLB := 0.3;
                  FUB := 3.5;
                end;
    distPoisson
              : begin
                  FCaption := 'Poisson';
                  fX.FParameterType := parInteger;
                  fX.Value := 4;
                  FDistParams.AddParameter('lambda',parTSample,Eps,Inf,'lambda>0',2.3);
                  FLB := 0.0;
                  FUB := 10.0;
                end;
    distPower
               : begin
                  FCaption := 'Power';
                  fX.FParameterType := parTSample;
                  fX.Value := 0.5;
                  FDistParams.AddParameter('alpha',parTSample,Eps,Inf,'alpha>0',0.9);
                  FDistParams.AddParameter('beta',parTSample,Eps,Inf,'beta>0',0.3);
                  FLB := 0.0;
                  FUB := 3;
                end;
    distRayleigh
              : begin
                  FCaption := 'Rayleigh';
                  fX.FParameterType := parTSample;
                  fX.Value := 2.1;
                  FDistParams.AddParameter('b',parTSample,Eps,Inf,'b>0',0.9);
                  FLB := 0.1;
                  FUB := 2.2;
                end;
    distStudent
              : begin
                  FCaption := 'Student(T)';
                  fX.FParameterType := parTSample;
                  fX.Value := 2.5;
                  FDistParams.AddParameter('Nu',parInteger,1,Inf,'Nu>0',4);
                  FLB := 0.0;
                  FUB := 7.0;
                end;
    distTriangular
              : begin
                  FCaption := 'Triangular';
                  fX.FParameterType := parTSample;
                  fX.Value := 0.6;
                  FDistParams.AddParameter('a',parTSample,'a<b',0.2);
                  FDistParams.AddParameter('b',parTSample,'b>a',0.9);
                  FDistParams.AddParameter('c',parTSample,'a<=c<=b',0.7);
                  FLB := 0.0;
                  FUB := 1.0;
                end;
    distUniform
              : begin
                  FCaption := 'Uniform';
                  FDistParams.AddParameter('a',parTSample,-Inf,Inf,'',-2.1);
                  FDistParams.AddParameter('b',parTSample,FDistParams[0].Value+EPS,Inf,'b>a',3.5);
                  fX.FParameterType := parTSample;
                  fX.Value := 2.5;
                  FLb := 0;
                  FUB := 7;
                end;
    distUniformD
              : begin
                  FCaption := 'Uniform (discrete)';
                  fX.FParameterType := parInteger;
                  fX.Value := 2;
                  FDistParams.AddParameter('N',parInteger,1,Inf,'N>0',5);
                  FLb := 1;
                  FUB := 5;
                end;
    distWeibull
               : begin
                  FCaption := 'Weibull';
                  fX.FParameterType := parTSample;
                  fX.Value := 1.3;
                  FDistParams.AddParameter('a',parTSample,EPs,Inf,'a>0',0.5);
                  FDistParams.AddParameter('b',parTSample,Eps,Inf,'b>0',1.5);
                  FLb := EPS;
                  FUB := 7;
                end;
    distZipf
               : begin
                  FCaption := 'Zipf';
                  FDistParams.AddParameter('s',parTSample,EPS,Inf,'s>0',0.5);
                  FDistParams.AddParameter('N',parInteger,1,Inf,'N>0',5);
                  fX.FParameterType := parInteger;
                  fX.Value := 3;
                  FLb := 0;
                  FUB := 7;
                end;
  end;
  fInit := False;
  CalcStats;
  InitParameters;
end;

procedure TProbDistribution.InitParameters;
begin
    case FDistType of
    distBeta  : begin
                  fX.FLB := EPS;
                  fX.FUB := 1.0-EPS;
                  fX.Notes := '0<x<1';
                end;
    distBernoulli  : begin
                  fX.FLB := 0;
                  fX.FUB := 1;
                  fX.Notes := 'x={0,1}';
                end;
    distBinom  : begin
                  fX.FLB := 0;
                  fX.FUB := INF;
                  fX.Notes := '0<=x<Inf';
                end;
    distBoseEinstein  : begin
                  fX.FLB := 0.0;
                  fX.FUB := INF;
                  fX.Notes := '0<=x<Inf';
                end;
    distCauchy  : begin
                  fX.FLB := -Inf;
                  fX.FUB := Inf;
                  fX.Notes := '-Inf<x<Inf';
                end;
    distChiSquare: begin
                  fX.FLB := 0;
                  fX.FUB := Inf;
                  fX.Notes := '0<=x<Inf';
                  end;
    distErlang: begin
                  fX.FLB := 0.0;
                  fX.FUB := Inf;
                  fX.Notes := '0<=x<Inf';
                end;
    distExp  : begin
                  fX.FLB := 0.0;
                  fX.FUB := Inf;
                  fX.Notes := '0<=x<Inf';
                end;
    distF  :   begin
                  FCaption := 'Fisher(F)';
                  fX.FLB := 0.0;
                  fX.FUB := Inf;
                  fX.Notes := '0<=x<Inf';
                end;
    distFatigue  : begin
                  fX.FLB := FDistParams[0].Value+EPS;
                  fX.FUB := Inf;
                  fX.Notes := 'mu<x<Inf';
                end;
    distFermiDirac  : begin
                  fX.FLB := 0.0;
                  fX.FUB := Inf;
                  fX.Notes := '0<=x<Inf';
                end;
    distGamma : begin
                  fX.FLB := 0.0;
                  fX.FUB := Inf;
                  fX.Notes := '0<=x<Inf';
                end;
    distGenExtValue :
                begin
                  if FDistParams[0].Value = 0 then
                  begin
                    fX.FLB := -Inf;
                    fX.FUB := Inf;
                    fX.Notes := '-Inf<x<Inf';
                  end else
                  if FDistParams[0].Value>0 then
                  begin
                    fX.FLB := EPS+ FDistParams[1].Value - FDistParams[2].Value/FDistParams[0].Value;
                    fX.FUB := Inf;
                    fX.Notes := 'mu-sigma/k<x<Inf';

                  end else
                  begin
                    fX.FLB := -Inf;
                    fX.FUB := FDistParams[1].Value - FDistParams[2].Value/FDistParams[0].Value-EPS;
                    fX.Notes := '-Inf<x<mu-sigma/k';
                  end;
                end;
    distGenPareto :
                begin
                  fX.FLB := EPS;
                  fX.FUB := Inf;
                  fX.Notes := '0<x<Inf';
                end;
    distGeometric
              : begin
                  fX.FLB := 1;
                  fX.FUB := Inf;
                  fX.Notes := '0<x<Inf';
                end;
    distGumbelMax : begin
                  fX.FLB := -Inf;
                  fX.FUB := Inf;
                  fX.Notes := '-Inf<x<Inf';
                end;
    distGumbelMin : begin
                  fX.FLB := -Inf;
                  fX.FUB := Inf;
                  fX.Notes := '-Inf<x<Inf';
                end;
    distHypGeometric
              : begin
                  // 0<=x<=N
                  fX.FLB := 0;
                  fX.FUB := fDistParams[2].IntValue;
                  fX.Notes := '0<=x<N';
                  // M
                  fDistParams[0].FLB := 0;
                  fDistParams[0].fUB := INF;
                  // K
                  fDistParams[1].FLB := 0;
                  fDistParams[1].fUB := fDistParams[0].IntValue;
                  // N
                  fDistParams[2].FLB := 0;
                  fDistParams[2].fUB := fDistParams[0].IntValue;
                end;
    distInvChi2: begin
                  fX.FLB := EPS;
                  fX.FUB := Inf;
                  fX.Notes := '0<x<Inf';
                end;
    distInvGauss: begin
                  fX.FLB := EPS;
                  fX.FUB := Inf;
                  fX.Notes := '0<x<Inf';
                end;
    distJohnsonSB : begin
                  fX.FLB := FDistParams[3].Value;
                  fX.FUB := FDistParams[3].Value+FDistParams[2].Value;
                  fX.Notes := 'xi<=x<=lambda+xi';
                end;
    distJohnsonUB : begin
                  fX.FLB := -Inf;
                  fX.FUB := Inf;
                  fX.Notes := '-INF<x<INF';
                end;
    distLaplace : begin
                  fX.FLB := -Inf;
                  fX.FUB := Inf;
                  fX.Notes := '-INF<x<INF';
                end;
    distLogarithmic : begin
                  fX.FLB := 1;
                  fX.FUB := Inf;
                  fX.Notes := '1<x<INF';
                end;
    distLogistic : begin
                  fX.FLB := -Inf;
                  fX.FUB := Inf;
                  fX.Notes := '-INF<x<INF';
                end;
    distLogNormal
                 : begin
                  fX.FLB := Eps;
                  fX.FUB := Inf;
                  fX.Notes := '0<x<Inf';
                end;
    distLogWeibull
                 : begin
                  fX.FLB := Eps;
                  fX.FUB := Inf;
                  fX.Notes := '0<x<Inf';
                end;
    distMaxwell
              : begin
                  fX.FLB := Eps;
                  fX.FUB := Inf;
                  fX.Notes := '0<x<Inf';
                end;
    distNegBinom
              : begin
                  fX.FLB := 1;
                  fX.FUB := Inf;
                  fX.Notes := '0<x<Inf';
                end;
    distNormal: begin
                  fX.FLB := -Inf;
                  fX.FUB := Inf;
                  fX.Notes := '-Inf<x<Inf';
                end;
    distPareto: begin
                fX.LB := FDistParams[0].Value;
                fx.UB := Inf;
                fx.Notes := 'b<=x<INF';
                end;
    distPoisson: begin
                fX.LB := 1;
                fx.UB := Inf;
                fx.Notes := '0<x<=Inf';
                end;
    distPower: begin
                  fX.FLB := 0.0;
                  fX.FUB := 1/FDistParams[0].Value;
                  fX.Notes := '0<=x<=1/beta';
                end;
    distRayleigh
              : begin
                  fX.FLB := 0.0;
                  fX.FUB := Inf;
                  fX.Notes := '0<=x<INF';
                end;
    distStudent
              : begin
                  fX.FLB := -Inf;
                  fX.FUB := Inf;
                  fX.Notes := '-Inf<x<Inf';
                end;
    distTriangular
              : begin
                  fX.FLB := FDistParams[0].Value;
                  fX.FUB := FDistParams[1].Value;
                  fX.Notes := 'a<=x<=b';
                  // a<b
                  FDistParams[0].LB := -INF;
                  FDistParams[0].UB := FDistParams[1].Value-EPS;
                  FDistParams[1].LB := FDistParams[0].Value+EPS;
                  FDistParams[1].UB := INF;
                  // a<=c<=b
                  FDistParams[2].LB := FDistParams[0].Value;
                  FDistParams[2].UB := FDistParams[1].Value;
                end;
    distUniform
              : begin
                  fX.FLB := FDistParams[0].Value;
                  fX.FUB := FDistParams[1].Value;
                  fX.Notes := 'a<=x<=b';
                end;
    distUniformD
              : begin
                  fX.FLB := 1;
                  fX.FUB := FDistParams[0].Value;
                  fX.Notes := '0<x<=N';
                end;
    distWeibull
               : begin
                  fX.FLB := 0.0;
                  fX.FUB := Inf;
                  fX.Notes := '0<=x<Inf';
                end;
    distZipf
               : begin
                  fX.FLB := 1;
                  fX.FUB := FDistParams[1].IntValue-1;
                  fX.Notes := '0<x<N';
                end;
    end;

end;

procedure TProbDistribution.SetCaption(const Value: String);
begin
  FCaption := Value;
end;

procedure TProbDistribution.SetDistParams(const Value: TProbParameters);
begin
  FDistParams.Assign(Value);
end;

procedure TProbDistribution.SetDistType(const Value: TDistribution);
begin
  if Value<> FDistType then
  begin
    FDistType := Value;
    InitDistribution;
  end;
end;

procedure TProbDistribution.SetLB(const Value: double);
begin
  FLB := Value;
end;

procedure TProbDistribution.SetNumPoints(const Value: Integer);
begin
  FNumPoints := Value;
end;

procedure TProbDistribution.Setp(const Value: TProbParameter);
begin
  Fp := Value;
end;

procedure TProbDistribution.SetUB(const Value: double);
begin
  FUB := Value;
end;

function TProbParameter.GetParameterDomain: TParamDomain;
begin
  if (fLB>=0) and (fUb>fLb) then Result := domPositive
  else if (fLb<fUb) then Result := domBounded
  else Result := domUnbounded;
end;

procedure TProbDistribution.SetX(const Value: TProbParameter);
begin
  FX := Value;
end;


{ TProbParameters }

function TProbParameters.AddParameter(aName: String;
  aType: TProbParType; aNotes: String; aValue: double): TProbParameter;
begin
  Result := inherited Add as TProbParameter;
  with Result do
  begin
    Name := aName;
    fParameterType := aType;
    fNotes := aNotes;
    fValue := aValue;
  end;
end;

function TProbParameters.AddParameter(aName: String; aType: TProbParType; aLB,
  aUB: double; aNotes: String; aValue: double): TProbParameter;
begin
  Result := AddParameter(aName,aType,aNotes,aValue);
  With Result do
  begin
    flB := aLB;
    fUB := aUB;
  end;
end;

constructor TProbParameters.Create(AOwner: TProbDistribution);
begin
  inherited Create(AOwner,TProbParameter);
end;


function TProbParameters.GetProbParameter(index: Integer): TProbParameter;
begin
  Result := TProbParameter(inherited Items[Index]);
end;

function TProbParameters.Owner: TProbDistribution;
begin
  Result := TProbDistribution(GetOwner);
end;

procedure TProbParameters.SetProbParameter(index: Integer;
  const Value: TProbParameter);
begin
  Items[Index].Assign(Value);
end;

{ TProbParameter }

constructor TProbParameter.Create(Collection: TCollection);
begin
  if Assigned(Collection) and (Collection is TProbParameters) then
  begin
    inherited Create(Collection);
  end
  else inherited Create(nil);
end;

destructor TProbParameter.Destroy;
begin

  inherited;
end;

function TProbParameter.IntValue: integer;
begin
  Result := Round(FValue);
end;

procedure TProbParameter.SetName(const Value: String);
begin
  if Value <> FCaption then FCaption := Value;
end;

procedure TProbParameter.SetLB(const Value: double);
begin
  FLB := Value;
end;

procedure TProbParameter.SetNotes(const Value: String);
begin
  FNotes := Value;
end;

procedure TProbParameter.SetUB(const Value: double);
begin
  FUB := Value;
end;

procedure TProbParameter.SetValue(const Value: double);
begin
  FValue := Value;
  if Assigned(Collection) and (Collection is TProbParameters) then
        (Collection as TProbParameters).Owner.CalcStats;
end;

function TProbParameter.ValueIsValid: boolean;
begin
  Result := (fValue>=fLB) and (fValue<=fUB);
  if fParameterType=parInteger then Result := Result and (Abs(fValue-IntValue)<EPS);
end;

end.

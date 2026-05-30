//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "DewProbWrapper.h"
#include <math.h>
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// TProbDistribution
//---------------------------------------------------------------------------
__fastcall TProbDistribution::TProbDistribution()
  : TPersistent()
{
  FDistParams = new TProbParameters(this);
  FX = new TProbParameter(NULL);
  FX->FParameterType = parTSample;
  FX->FCaption = "x";

  Fp = new TProbParameter(NULL);
  Fp->FParameterType = parTSample;
  Fp->FCaption = "p";
  Fp->FLB = 0;
  Fp->FUB = 1.0;

  FDistType = distBETA;
  InitDistribution();
}
//---------------------------------------------------------------------------
__fastcall TProbDistribution::~TProbDistribution()
{
  delete FDistParams;
  delete FX;
  delete Fp;
}
//---------------------------------------------------------------------------
double __fastcall TProbDistribution::CalculateCDF(double Value)
{
  double Result = NAN;
  switch (FDistType)
  {
    case distBETA: Result = BetaCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distBERNOULLI: Result = BernoulliCDF(Math387::RoundToInt(Value), FDistParams->Items[0]->Value); break;
    case distBINOM: Result = BinomCDF(Math387::RoundToInt(Value), FDistParams->Items[0]->IntValue(), FDistParams->Items[1]->Value); break;
    case distBOSEEINSTEIN: Result = BoseEinsteinCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distCAUCHY: Result = CauchyCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distCHISQUARE: Result = ChiSquareCDF(Value, FDistParams->Items[0]->IntValue()); break;
    case distERLANG: Result = ErlangCDF(Value, FDistParams->Items[0]->IntValue(), FDistParams->Items[1]->Value); break;
    case distEXP: Result = ExpCDF(Value, FDistParams->Items[0]->Value); break;
    case distF: Result = FCDF(Value, FDistParams->Items[0]->IntValue(), FDistParams->Items[1]->IntValue()); break;
    case distFATIGUE: Result = FatigueLifeCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, FDistParams->Items[2]->Value); break;
    case distFERMIDIRAC: Result = FermiDiracCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distGAMMA: Result = GammaCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distGenExtValue: Result = GenExtValueCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, FDistParams->Items[2]->Value); break;
    case distGenPareto: Result = GenParetoCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, FDistParams->Items[2]->Value); break;
    case distGEOMETRIC: Result = GeometricCDF(Math387::RoundToInt(Value), FDistParams->Items[0]->Value); break;
    case distGUMBELMAX: Result = GumbelCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, false); break;
    case distGUMBELMIN: Result = GumbelCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, true); break;
    case distHYPGEOMETRIC: Result = HypGeometricCDF(Math387::RoundToInt(Value), FDistParams->Items[0]->IntValue(), FDistParams->Items[1]->IntValue(), FDistParams->Items[2]->IntValue()); break;
    case distINVChi2: Result = InverseChiSquareCDF(Value, FDistParams->Items[0]->IntValue()); break;
    case distINVGAUSS: Result = InverseGaussianCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distJOHNSONSB: Result = JohnsonSBCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, FDistParams->Items[2]->Value, FDistParams->Items[3]->Value); break;
    case distJOHNSONUB: Result = JohnsonUBCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, FDistParams->Items[2]->Value, FDistParams->Items[3]->Value); break;
    case distLAPLACE: Result = LaplaceCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distLOGISTIC: Result = LogisticCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distLOGARITHMIC: Result = LogarithmicCDF(Math387::RoundToInt(Value), FDistParams->Items[0]->Value); break;
    case distLOGNORMAL: Result = LogNormalCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distLOGWEIBULL: Result = LogWeibullCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distMAXWELL: Result = MaxwellCDF(Value, FDistParams->Items[0]->Value); break;
    case distNEGBINOM: Result = NegBinomCDF(Math387::RoundToInt(Value), FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distNORMAL: Result = NormalCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distPARETO: Result = ParetoCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distPOISSON: Result = PoissonCDF(Math387::RoundToInt(Value), FDistParams->Items[0]->Value); break;
    case distPOWER: Result = PowerCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distRAYLEIGH: Result = RayleighCDF(Value, FDistParams->Items[0]->Value); break;
    case distSTUDENT: Result = StudentCDF(Value, FDistParams->Items[0]->IntValue()); break;
    case distTRIANGULAR: Result = TriangularCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, FDistParams->Items[2]->Value); break;
    case distUNIFORM: Result = UniformCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distUNIFORMD: Result = UniformDCDF(Math387::RoundToInt(Value), FDistParams->Items[0]->IntValue()); break;
    case distWEIBULL: Result = WeibullCDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distZIPF: Result = ZipfCDF(Math387::RoundToInt(Value), FDistParams->Items[0]->Value, FDistParams->Items[1]->IntValue()); break;
    default: break;
  }
  return Result;
}
//---------------------------------------------------------------------------
double __fastcall TProbDistribution::CalculateCumH(double Value)
{
  if (Discrete) return NAN;
  return -Math387::Ln(1.0 - CalculateCDF(Value));
}
//---------------------------------------------------------------------------
double __fastcall TProbDistribution::CalculateS(double Value)
{
  return 1.0 - CalculateCDF(Value);
}
//---------------------------------------------------------------------------
double __fastcall TProbDistribution::CalculateH(double Value)
{
  if (Discrete) return NAN;
  return CalculatePDF(Value) / (1.0 - CalculateCDF(Value));
}
//---------------------------------------------------------------------------
void __fastcall TProbDistribution::CalcStats()
{
  fMean = NAN;
  fVariance = NAN;
  fSkewness = NAN;
  fKurtosis = NAN;
  if (!fInit)
  {
    switch (DistType)
    {
      case distBETA: BetaStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distBERNOULLI: BernoulliStat(DistParams->Items[0]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distBINOM: BinomStat(DistParams->Items[0]->IntValue(), DistParams->Items[1]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distCAUCHY: CauchyStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distCHISQUARE: ChiSquareStat(DistParams->Items[0]->IntValue(), fMean, fVariance, fSkewness, fKurtosis); break;
      case distERLANG: ErlangStat(DistParams->Items[0]->IntValue(), DistParams->Items[1]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distEXP: ExponentStat(DistParams->Items[0]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distF: FStat(DistParams->Items[0]->IntValue(), DistParams->Items[1]->IntValue(), fMean, fVariance, fSkewness, fKurtosis); break;
      case distFATIGUE: FatigueLifeStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, DistParams->Items[2]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distGAMMA: GammaStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distGenExtValue: GenExtValueStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, DistParams->Items[2]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distGenPareto: GenParetoStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, DistParams->Items[2]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distGEOMETRIC: GeometricStat(DistParams->Items[0]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distGUMBELMAX:
      case distGUMBELMIN: GumbelStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distHYPGEOMETRIC: HypGeometricStat(DistParams->Items[0]->IntValue(), DistParams->Items[1]->IntValue(), DistParams->Items[2]->IntValue(), fMean, fVariance, fSkewness, fKurtosis); break;
      case distINVChi2: InverseChiSquareStat(FDistParams->Items[0]->IntValue(), fMean, fVariance, fSkewness, fKurtosis); break;
      case distINVGAUSS: InverseGaussianStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distJOHNSONSB: JohnsonSBStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, DistParams->Items[2]->Value, DistParams->Items[3]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distJOHNSONUB: JohnsonUBStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, DistParams->Items[2]->Value, DistParams->Items[3]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distLAPLACE: LaplaceStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distLOGARITHMIC: LogarithmicStat(DistParams->Items[0]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distLOGISTIC: LogisticStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distLOGNORMAL: LogNormalStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distLOGWEIBULL: LogWeibullStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distMAXWELL: MaxwellStat(DistParams->Items[0]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distNEGBINOM: NegBinomStat(DistParams->Items[0]->IntValue(), DistParams->Items[1]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distNORMAL: NormalStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distPARETO: ParetoStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distPOISSON: PoissonStat(DistParams->Items[0]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distPOWER: PowerStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distRAYLEIGH: RayleighStat(DistParams->Items[0]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distSTUDENT: StudentStat(DistParams->Items[0]->IntValue(), fMean, fVariance, fSkewness, fKurtosis); break;
      case distTRIANGULAR: TriangularStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, DistParams->Items[2]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distUNIFORM: UniformStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distUNIFORMD: UniformDStat(DistParams->Items[0]->IntValue(), fMean, fVariance, fSkewness, fKurtosis); break;
      case distWEIBULL: WeibullStat(DistParams->Items[0]->Value, DistParams->Items[1]->Value, fMean, fVariance, fSkewness, fKurtosis); break;
      case distZIPF: ZipfStat(DistParams->Items[0]->Value, DistParams->Items[1]->IntValue(), fMean, fVariance, fSkewness, fKurtosis); break;
      default: break;
    }
  }
}
//---------------------------------------------------------------------------
double __fastcall TProbDistribution::CalculatePPF(double Value)
{
  double Result = NAN;
  switch (FDistType)
  {
    case distBETA: Result = BetaCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distBERNOULLI: Result = BernoulliCDFInv(Value, FDistParams->Items[0]->Value); break;
    case distBINOM: Result = BinomCDFInv(Value, FDistParams->Items[0]->IntValue(), FDistParams->Items[1]->Value); break;
    case distCAUCHY: Result = CauchyCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distCHISQUARE: Result = ChiSquareCDFInv(Value, FDistParams->Items[0]->IntValue()); break;
    case distERLANG: Result = ErlangCDFInv(Value, FDistParams->Items[0]->IntValue(), FDistParams->Items[1]->Value); break;
    case distEXP: Result = ExpCDFInv(Value, FDistParams->Items[0]->Value); break;
    case distF: Result = FCDFInv(Value, FDistParams->Items[0]->IntValue(), FDistParams->Items[1]->IntValue()); break;
    case distFATIGUE: Result = FatigueLifeCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, FDistParams->Items[2]->Value); break;
    case distGAMMA: Result = GammaCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distGenExtValue: Result = GenExtValueCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, FDistParams->Items[2]->Value); break;
    case distGenPareto: Result = GenParetoCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, FDistParams->Items[2]->Value); break;
    case distGEOMETRIC: Result = GeometricCDFInv(Value, FDistParams->Items[0]->Value); break;
    case distGUMBELMAX: Result = GumbelCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, false); break;
    case distGUMBELMIN: Result = GumbelCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, true); break;
    case distHYPGEOMETRIC: Result = HypGeometricCDFInv(Value, FDistParams->Items[0]->IntValue(), FDistParams->Items[1]->IntValue(), FDistParams->Items[2]->IntValue()); break;
    case distINVChi2: Result = InverseChiSquareCDFInv(Value, FDistParams->Items[0]->IntValue()); break;
    case distINVGAUSS: Result = InverseGaussianCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distJOHNSONSB: Result = JohnsonSBCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, FDistParams->Items[2]->Value, FDistParams->Items[3]->Value); break;
    case distJOHNSONUB: Result = JohnsonUBCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, FDistParams->Items[2]->Value, FDistParams->Items[3]->Value); break;
    case distLAPLACE: Result = LaplaceCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distLOGARITHMIC: Result = LogarithmicCDFInv(Value, FDistParams->Items[0]->Value); break;
    case distLOGISTIC: Result = LogisticCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distLOGNORMAL: Result = LogNormalCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distLOGWEIBULL: Result = LogWeibullCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distMAXWELL: Result = MaxwellCDFInv(Value, FDistParams->Items[0]->Value); break;
    case distNEGBINOM: Result = NegBinomCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distNORMAL: Result = NormalCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distPARETO: Result = ParetoCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distPOISSON: Result = PoissonCDFInv(Value, FDistParams->Items[0]->Value); break;
    case distPOWER: Result = PowerCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distRAYLEIGH: Result = RayleighCDFInv(Value, FDistParams->Items[0]->Value); break;
    case distSTUDENT: Result = StudentCDFInv(Value, FDistParams->Items[0]->IntValue()); break;
    case distTRIANGULAR: Result = TriangularCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, FDistParams->Items[2]->Value); break;
    case distUNIFORM: Result = UniformCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distUNIFORMD: Result = UniformDCDFInv(Value, FDistParams->Items[0]->IntValue()); break;
    case distWEIBULL: Result = WeibullCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distZIPF: Result = ZipfCDFInv(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->IntValue()); break;
    default: break;
  }
  return Result;
}
//---------------------------------------------------------------------------
double __fastcall TProbDistribution::CalculatePDF(double Value)
{
  double Result = NAN;
  switch (FDistType)
  {
    case distBETA: Result = BetaPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distBERNOULLI: Result = BernoulliPDF(Math387::RoundToInt(Value), FDistParams->Items[0]->Value); break;
    case distBINOM: Result = BinomPDF(Math387::RoundToInt(Value), FDistParams->Items[0]->IntValue(), FDistParams->Items[1]->Value); break;
    case distBOSEEINSTEIN: Result = BoseEinsteinPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distCAUCHY: Result = CauchyPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distCHISQUARE: Result = ChiSquarePDF(Value, FDistParams->Items[0]->IntValue()); break;
    case distERLANG: Result = ErlangPDF(Value, FDistParams->Items[0]->IntValue(), FDistParams->Items[1]->Value); break;
    case distEXP: Result = ExpPDF(Value, FDistParams->Items[0]->Value); break;
    case distF: Result = FPDF(Value, FDistParams->Items[0]->IntValue(), FDistParams->Items[1]->IntValue()); break;
    case distFATIGUE: Result = FatigueLifePDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, FDistParams->Items[2]->Value); break;
    case distFERMIDIRAC: Result = FermiDiracPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distGAMMA: Result = GammaPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distGenExtValue: Result = GenExtValuePDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, FDistParams->Items[2]->Value); break;
    case distGenPareto: Result = GenParetoPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, FDistParams->Items[2]->Value); break;
    case distGEOMETRIC: Result = GeometricPDF(Math387::RoundToInt(Value), FDistParams->Items[0]->Value); break;
    case distGUMBELMAX: Result = GumbelPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, false); break;
    case distGUMBELMIN: Result = GumbelPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, true); break;
    case distHYPGEOMETRIC: Result = HypGeometricPDF(Math387::RoundToInt(Value), FDistParams->Items[0]->IntValue(), FDistParams->Items[1]->IntValue(), FDistParams->Items[2]->IntValue()); break;
    case distINVChi2: Result = InverseChiSquarePDF(Value, FDistParams->Items[0]->IntValue()); break;
    case distINVGAUSS: Result = InverseGaussianPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distJOHNSONSB: Result = JohnsonSBPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, FDistParams->Items[2]->Value, FDistParams->Items[3]->Value); break;
    case distJOHNSONUB: Result = JohnsonUBPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, FDistParams->Items[2]->Value, FDistParams->Items[3]->Value); break;
    case distLAPLACE: Result = LaplacePDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distLOGARITHMIC: Result = LogarithmicPDF(Math387::RoundToInt(Value), FDistParams->Items[0]->Value); break;
    case distLOGISTIC: Result = LogisticPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distLOGNORMAL: Result = LogNormalPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distLOGWEIBULL: Result = LogWeibullPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distMAXWELL: Result = MaxwellPDF(Value, FDistParams->Items[0]->Value); break;
    case distNEGBINOM: Result = NegBinomPDF(Math387::RoundToInt(Value), FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distNORMAL: Result = NormalPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distPARETO: Result = ParetoPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distPOISSON: Result = PoissonPDF(Math387::RoundToInt(Value), FDistParams->Items[0]->Value); break;
    case distPOWER: Result = PowerPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distRAYLEIGH: Result = RayleighPDF(Value, FDistParams->Items[0]->Value); break;
    case distSTUDENT: Result = StudentPDF(Value, FDistParams->Items[0]->IntValue()); break;
    case distTRIANGULAR: Result = TriangularPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value, FDistParams->Items[2]->Value); break;
    case distUNIFORM: Result = UniformPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distUNIFORMD: Result = UniformDPDF(Math387::RoundToInt(Value), FDistParams->Items[0]->IntValue()); break;
    case distWEIBULL: Result = WeibullPDF(Value, FDistParams->Items[0]->Value, FDistParams->Items[1]->Value); break;
    case distZIPF: Result = ZipfPDF(Math387::RoundToInt(Value), FDistParams->Items[0]->Value, FDistParams->Items[1]->IntValue()); break;
    default: break;
  }
  return Result;
}
//---------------------------------------------------------------------------
double __fastcall TProbDistribution::GetCDF()    { return CalculateCDF(FX->Value); }
double __fastcall TProbDistribution::GetCumHazard() { return CalculateCumH(FX->Value); }
double __fastcall TProbDistribution::GetHazard() { return CalculateH(FX->Value); }
double __fastcall TProbDistribution::GetPDF()    { return CalculatePDF(FX->Value); }
double __fastcall TProbDistribution::GetSurvival() { return CalculateS(FX->Value); }
double __fastcall TProbDistribution::GetPPF()    { return CalculatePPF(Fp->Value); }
//---------------------------------------------------------------------------
bool __fastcall TProbDistribution::GetDiscrete()
{
  return ((FDistType == distBINOM) || (FDistType == distGEOMETRIC) || (FDistType == distHYPGEOMETRIC)
       || (FDistType == distNEGBINOM) || (FDistType == distPOISSON) || (FDistType == distUNIFORMD)
       || (FDistType == distLOGARITHMIC) || (FDistType == distBERNOULLI) || (FDistType == distZIPF));
}
//---------------------------------------------------------------------------
void __fastcall TProbDistribution::InitDistribution()
{
  fInit = true;
  FDistParams->Clear();
  switch (FDistType)
  {
    case distBETA:
      FCaption = "Beta";
      FX->FParameterType = parTSample;
      FX->Value = 0.44;
      FDistParams->AddParameter("a", parTSample, EPS, INF, "a>0", 0.5);
      FDistParams->AddParameter("b", parTSample, EPS, INF, "b>0", 1.5);
      FLB = EPS; FUB = 1.0 - EPS;
      break;
    case distBERNOULLI:
      FCaption = "Bernoulli";
      FX->FParameterType = parInteger;
      FX->Value = 1;
      FDistParams->AddParameter("p", parTSample, 0, 1, "0<=p<=1", 0.44);
      FLB = 0; FUB = 1;
      break;
    case distBINOM:
      FCaption = "Binomial";
      FX->FParameterType = parInteger;
      FX->Value = 3;
      FDistParams->AddParameter("n", parInteger, 0, INF, "n>0", 6);
      FDistParams->AddParameter("p", parTSample, 0, 1, "0<=p<=1", 0.56);
      FLB = 0.0; FUB = 8.0;
      break;
    case distBOSEEINSTEIN:
      FCaption = "Bose-Einstein";
      FX->FParameterType = parTSample;
      FX->Value = 4;
      FDistParams->AddParameter("mu", parTSample, -INF, INF, "", 1.12);
      FDistParams->AddParameter("s", parTSample, EPS, INF, "s>0", 1);
      FLB = EPS; FUB = 6;
      break;
    case distCAUCHY:
      FCaption = "Cauchy";
      FX->FParameterType = parTSample;
      FX->Value = 2.5;
      FDistParams->AddParameter("m", parTSample, EPS, INF, "m>0", 3.2);
      FDistParams->AddParameter("b", parTSample, EPS, INF, "b>0", 0.9);
      FLB = -3; FUB = 4;
      break;
    case distCHISQUARE:
      FCaption = "Chi-Squared";
      FX->FParameterType = parTSample;
      FX->Value = 2.5;
      FDistParams->AddParameter("nu", parInteger, 2, INF, "Nu>1", 4);
      FLB = EPS; FUB = 7;
      break;
    case distERLANG:
      FCaption = "Erlang";
      FX->FParameterType = parTSample;
      FX->Value = 2.5;
      FLB = 0; FUB = 4;
      FDistParams->AddParameter("k", parInteger, EPS, INF, "k>0", 3);
      FDistParams->AddParameter("lambda", parTSample, EPS, INF, "lambda>0", 0.75);
      break;
    case distEXP:
      FCaption = "Exponential";
      FX->FParameterType = parTSample;
      FX->Value = 2.5;
      FDistParams->AddParameter("lambda", parTSample, EPS, INF, "lambda>0", 4.3);
      FLB = EPS; FUB = 6;
      break;
    case distF:
      FCaption = "Fisher(F)";
      FX->FParameterType = parTSample;
      FX->Value = 2.5;
      FLB = 0; FUB = 7;
      FDistParams->AddParameter("nu1", parInteger, 1, INF, "Nu1>1", 3);
      FDistParams->AddParameter("nu2", parInteger, 1, INF, "Nu2>1", 4);
      break;
    case distFATIGUE:
      FCaption = "Fatigue Life";
      FDistParams->AddParameter("mu", parTSample, -INF, INF, "", 0.0);
      FDistParams->AddParameter("gamma", parTSample, EPS, INF, "gamma>0", 0.5);
      FDistParams->AddParameter("beta", parTSample, EPS, INF, "beta>0", 1.0);
      FX->FParameterType = parTSample;
      FX->Value = 1.4;
      FLB = 0.0; FUB = 4.0;
      break;
    case distFERMIDIRAC:
      FCaption = "Fermi-Dirac";
      FX->FParameterType = parTSample;
      FX->Value = 4;
      FDistParams->AddParameter("mu", parTSample, -INF, INF, "", 2.5);
      FDistParams->AddParameter("s", parTSample, EPS, INF, "s>0", 0.5);
      FLB = 1.0; FUB = 6.0;
      break;
    case distGAMMA:
      FCaption = "Gamma";
      FX->FParameterType = parTSample;
      FDistParams->AddParameter("a", parTSample, EPS, INF, "a>0", 1.0);
      FDistParams->AddParameter("b", parTSample, EPS, INF, "b>0", 0.2);
      FLB = 0.0; FUB = 4.5;
      break;
    case distGenExtValue:
      FCaption = "Generalized extreme value";
      FX->FParameterType = parTSample;
      FX->Value = 2.5;
      FDistParams->AddParameter("k", parTSample, -INF, INF, "", -0.08);
      FDistParams->AddParameter("mu", parTSample, -INF, INF, "", 2.0);
      FDistParams->AddParameter("sigma", parTSample, EPS, INF, "sigma>0", 1.0);
      FLB = 0; FUB = 4.0;
      break;
    case distGenPareto:
      FCaption = "Generalized Pareto";
      FX->FParameterType = parTSample;
      FX->Value = 2.5;
      FDistParams->AddParameter("k", parTSample, -INF, INF, "", -0.5);
      FDistParams->AddParameter("mu", parTSample, -INF, INF, "", 1.2);
      FDistParams->AddParameter("sigma", parTSample, EPS, INF, "s>0", 1.0);
      FLB = 0; FUB = 4.0;
      break;
    case distGEOMETRIC:
      FCaption = "Geometric";
      FX->FParameterType = parInteger;
      FX->Value = 3;
      FDistParams->AddParameter("p", parTSample, 0, 1, "0<=p<=1", 0.4);
      FLB = 0.0; FUB = 6.5;
      break;
    case distGUMBELMAX:
      FCaption = "Gumbel (maximum)";
      FX->FParameterType = parTSample;
      FX->Value = 1.2;
      FDistParams->AddParameter("mu", parTSample, -INF, INF, "", 0.3);
      FDistParams->AddParameter("beta", parTSample, EPS, INF, "beta>0", 0.7);
      FLB = -2; FUB = 3;
      break;
    case distGUMBELMIN:
      FCaption = "Gumbel (minimum)";
      FX->FParameterType = parTSample;
      FX->Value = 1.5;
      FDistParams->AddParameter("mu", parTSample, -INF, INF, "", 0.3);
      FDistParams->AddParameter("beta", parTSample, EPS, INF, "beta>0", 0.7);
      FLB = -2; FUB = 3;
      break;
    case distHYPGEOMETRIC:
      FCaption = "Hypergeometric";
      FX->FParameterType = parInteger;
      FX->Value = 2;
      FDistParams->AddParameter("M", parInteger, "0<=M<INF", 15);
      FDistParams->AddParameter("K", parInteger, "0<=K<=M", 8);
      FDistParams->AddParameter("N", parInteger, "0<=N<=m", 9);
      FLB = 0; FUB = 9;
      break;
    case distINVChi2:
      FCaption = "Inverse Chi-Squared";
      FX->FParameterType = parTSample;
      FX->Value = 1.0;
      FDistParams->AddParameter("Nu", parInteger, 1, INF, "Nu>=1", 9);
      FLB = 0; FUB = 4;
      break;
    case distINVGAUSS:
      FCaption = "Inverse Gaussian";
      FX->FParameterType = parTSample;
      FX->Value = 2.5;
      FDistParams->AddParameter("mu", parTSample, EPS, INF, "mu>0", 2.0);
      FDistParams->AddParameter("lambda", parTSample, EPS, INF, "lambda>0", 1.3);
      FLB = 0; FUB = 5;
      break;
    case distJOHNSONSB:
      FCaption = "Johnson SB";
      FDistParams->AddParameter("gamma", parTSample, -INF, INF, "", 1.8);
      FDistParams->AddParameter("delta", parTSample, EPS, INF, "delta>0", 1.5);
      FDistParams->AddParameter("lambda", parTSample, EPS, INF, "lambda>0", 1.5);
      FDistParams->AddParameter("xi", parTSample, -INF, INF, "", 0.0);
      FX->FParameterType = parTSample;
      FX->Value = 0.5;
      FLB = 0; FUB = 1.5;
      break;
    case distJOHNSONUB:
      FCaption = "Johnson UB";
      FX->FParameterType = parTSample;
      FX->Value = 0.5;
      FDistParams->AddParameter("gamma", parTSample, -INF, INF, "", 1.8);
      FDistParams->AddParameter("delta", parTSample, EPS, INF, "delta>0", 1.5);
      FDistParams->AddParameter("lambda", parTSample, EPS, INF, "lambda>0", 1.5);
      FDistParams->AddParameter("xi", parTSample, -INF, INF, "", 0.0);
      FLB = 0; FUB = 1.5;
      break;
    case distLAPLACE:
      FCaption = "Laplace";
      FX->FParameterType = parTSample;
      FX->Value = 2.5;
      FDistParams->AddParameter("m", parTSample, -INF, INF, "", 1.0);
      FDistParams->AddParameter("b", parTSample, EPS, INF, "b>0", 0.3);
      FLB = -3; FUB = 3;
      break;
    case distLOGARITHMIC:
      FCaption = "Logarithmic";
      FX->FParameterType = parInteger;
      FX->Value = 2;
      FDistParams->AddParameter("p", parTSample, EPS, 1 - EPS, "0<p<1", 0.65);
      FLB = 0; FUB = 5.0;
      break;
    case distLOGISTIC:
      FCaption = "Logistic";
      FX->FParameterType = parTSample;
      FX->Value = 2.5;
      FDistParams->AddParameter("m", parTSample, -INF, INF, "", 1.0);
      FDistParams->AddParameter("b", parTSample, EPS, INF, "b>0", 0.3);
      FLB = 0; FUB = 2.0;
      break;
    case distLOGNORMAL:
      FCaption = "Log-normal";
      FX->FParameterType = parTSample;
      FX->Value = 2.5;
      FDistParams->AddParameter("mu", parTSample, -INF, INF, "", 1.0);
      FDistParams->AddParameter("sigma", parTSample, EPS, INF, "sigma>0", 0.2);
      FLB = 0; FUB = 4.0;
      break;
    case distLOGWEIBULL:
      FCaption = "Log-Weibull";
      FX->FParameterType = parTSample;
      FX->Value = 2.5;
      FDistParams->AddParameter("a", parTSample, -INF, INF, "", 1.0);
      FDistParams->AddParameter("b", parTSample, -INF, INF, "b<>0", 0.2);
      FLB = 0; FUB = 4.0;
      break;
    case distMAXWELL:
      FCaption = "Maxwell";
      FX->FParameterType = parTSample;
      FX->Value = 1.5;
      FDistParams->AddParameter("a", parTSample, EPS, INF, "a>0", 0.4);
      FLB = 0; FUB = 3.0;
      break;
    case distNEGBINOM:
      FCaption = "Negative binomial";
      FX->FParameterType = parInteger;
      FX->Value = 2.5;
      FDistParams->AddParameter("R", parTSample, EPS, INF, "R>0", 3.5);
      FDistParams->AddParameter("p", parTSample, 0, 1, "0<=p<=1", 0.7);
      FLB = 0; FUB = 12.0;
      break;
    case distNORMAL:
      FCaption = "Normal";
      FX->FParameterType = parTSample;
      FX->Value = 2.5;
      FDistParams->AddParameter("mu", parTSample, -INF, INF, "", 0.0);
      FDistParams->AddParameter("sigma", parTSample, EPS, INF, "sigma>0", 1.0);
      FLB = -3.0; FUB = 3.0;
      break;
    case distPARETO:
      FCaption = "Pareto";
      FX->FParameterType = parTSample;
      FX->Value = 0.7;
      FDistParams->AddParameter("a", parTSample, EPS, INF, "a>0", 2.0);
      FDistParams->AddParameter("b", parTSample, EPS, INF, "b>0", 0.2);
      FLB = 0.3; FUB = 3.5;
      break;
    case distPOISSON:
      FCaption = "Poisson";
      FX->FParameterType = parInteger;
      FX->Value = 4;
      FDistParams->AddParameter("lambda", parTSample, EPS, INF, "lambda>0", 2.3);
      FLB = 0.0; FUB = 10.0;
      break;
    case distPOWER:
      FCaption = "Power";
      FX->FParameterType = parTSample;
      FX->Value = 0.5;
      FDistParams->AddParameter("alpha", parTSample, EPS, INF, "alpha>0", 0.9);
      FDistParams->AddParameter("beta", parTSample, EPS, INF, "beta>0", 0.3);
      FLB = 0.0; FUB = 3;
      break;
    case distRAYLEIGH:
      FCaption = "Rayleigh";
      FX->FParameterType = parTSample;
      FX->Value = 2.1;
      FDistParams->AddParameter("b", parTSample, EPS, INF, "b>0", 0.9);
      FLB = 0.1; FUB = 2.2;
      break;
    case distSTUDENT:
      FCaption = "Student(T)";
      FX->FParameterType = parTSample;
      FX->Value = 2.5;
      FDistParams->AddParameter("Nu", parInteger, 1, INF, "Nu>0", 4);
      FLB = 0.0; FUB = 7.0;
      break;
    case distTRIANGULAR:
      FCaption = "Triangular";
      FX->FParameterType = parTSample;
      FX->Value = 0.6;
      FDistParams->AddParameter("a", parTSample, "a<b", 0.2);
      FDistParams->AddParameter("b", parTSample, "b>a", 0.9);
      FDistParams->AddParameter("c", parTSample, "a<=c<=b", 0.7);
      FLB = 0.0; FUB = 1.0;
      break;
    case distUNIFORM:
      FCaption = "Uniform";
      FDistParams->AddParameter("a", parTSample, -INF, INF, "", -2.1);
      FDistParams->AddParameter("b", parTSample, FDistParams->Items[0]->Value + EPS, INF, "b>a", 3.5);
      FX->FParameterType = parTSample;
      FX->Value = 2.5;
      FLB = 0; FUB = 7;
      break;
    case distUNIFORMD:
      FCaption = "Uniform (discrete)";
      FX->FParameterType = parInteger;
      FX->Value = 2;
      FDistParams->AddParameter("N", parInteger, 1, INF, "N>0", 5);
      FLB = 1; FUB = 5;
      break;
    case distWEIBULL:
      FCaption = "Weibull";
      FX->FParameterType = parTSample;
      FX->Value = 1.3;
      FDistParams->AddParameter("a", parTSample, EPS, INF, "a>0", 0.5);
      FDistParams->AddParameter("b", parTSample, EPS, INF, "b>0", 1.5);
      FLB = EPS; FUB = 7;
      break;
    case distZIPF:
      FCaption = "Zipf";
      FDistParams->AddParameter("s", parTSample, EPS, INF, "s>0", 0.5);
      FDistParams->AddParameter("N", parInteger, 1, INF, "N>0", 5);
      FX->FParameterType = parInteger;
      FX->Value = 3;
      FLB = 0; FUB = 7;
      break;
    default: break;
  }
  fInit = false;
  CalcStats();
  InitParameters();
}
//---------------------------------------------------------------------------
void __fastcall TProbDistribution::InitParameters()
{
  switch (FDistType)
  {
    case distBETA: FX->FLB = EPS; FX->FUB = 1.0 - EPS; FX->Notes = "0<x<1"; break;
    case distBERNOULLI: FX->FLB = 0; FX->FUB = 1; FX->Notes = "x={0,1}"; break;
    case distBINOM: FX->FLB = 0; FX->FUB = INF; FX->Notes = "0<=x<INF"; break;
    case distBOSEEINSTEIN: FX->FLB = 0.0; FX->FUB = INF; FX->Notes = "0<=x<INF"; break;
    case distCAUCHY: FX->FLB = -INF; FX->FUB = INF; FX->Notes = "-INF<x<INF"; break;
    case distCHISQUARE: FX->FLB = 0; FX->FUB = INF; FX->Notes = "0<=x<INF"; break;
    case distERLANG: FX->FLB = 0.0; FX->FUB = INF; FX->Notes = "0<=x<INF"; break;
    case distEXP: FX->FLB = 0.0; FX->FUB = INF; FX->Notes = "0<=x<INF"; break;
    case distF:
      FCaption = "Fisher(F)";
      FX->FLB = 0.0; FX->FUB = INF; FX->Notes = "0<=x<INF"; break;
    case distFATIGUE: FX->FLB = FDistParams->Items[0]->Value + EPS; FX->FUB = INF; FX->Notes = "mu<x<INF"; break;
    case distFERMIDIRAC: FX->FLB = 0.0; FX->FUB = INF; FX->Notes = "0<=x<INF"; break;
    case distGAMMA: FX->FLB = 0.0; FX->FUB = INF; FX->Notes = "0<=x<INF"; break;
    case distGenExtValue:
      if (FDistParams->Items[0]->Value == 0) {
        FX->FLB = -INF; FX->FUB = INF; FX->Notes = "-INF<x<INF";
      } else if (FDistParams->Items[0]->Value > 0) {
        FX->FLB = EPS + FDistParams->Items[1]->Value - FDistParams->Items[2]->Value / FDistParams->Items[0]->Value;
        FX->FUB = INF; FX->Notes = "mu-sigma/k<x<INF";
      } else {
        FX->FLB = -INF;
        FX->FUB = FDistParams->Items[1]->Value - FDistParams->Items[2]->Value / FDistParams->Items[0]->Value - EPS;
        FX->Notes = "-INF<x<mu-sigma/k";
      }
      break;
    case distGenPareto: FX->FLB = EPS; FX->FUB = INF; FX->Notes = "0<x<INF"; break;
    case distGEOMETRIC: FX->FLB = 1; FX->FUB = INF; FX->Notes = "0<x<INF"; break;
    case distGUMBELMAX: FX->FLB = -INF; FX->FUB = INF; FX->Notes = "-INF<x<INF"; break;
    case distGUMBELMIN: FX->FLB = -INF; FX->FUB = INF; FX->Notes = "-INF<x<INF"; break;
    case distHYPGEOMETRIC:
      FX->FLB = 0;
      FX->FUB = FDistParams->Items[2]->IntValue();
      FX->Notes = "0<=x<N";
      FDistParams->Items[0]->FLB = 0; FDistParams->Items[0]->FUB = INF;
      FDistParams->Items[1]->FLB = 0; FDistParams->Items[1]->FUB = FDistParams->Items[0]->IntValue();
      FDistParams->Items[2]->FLB = 0; FDistParams->Items[2]->FUB = FDistParams->Items[0]->IntValue();
      break;
    case distINVChi2: FX->FLB = EPS; FX->FUB = INF; FX->Notes = "0<x<INF"; break;
    case distINVGAUSS: FX->FLB = EPS; FX->FUB = INF; FX->Notes = "0<x<INF"; break;
    case distJOHNSONSB:
      FX->FLB = FDistParams->Items[3]->Value;
      FX->FUB = FDistParams->Items[3]->Value + FDistParams->Items[2]->Value;
      FX->Notes = "xi<=x<=lambda+xi";
      break;
    case distJOHNSONUB: FX->FLB = -INF; FX->FUB = INF; FX->Notes = "-INF<x<INF"; break;
    case distLAPLACE: FX->FLB = -INF; FX->FUB = INF; FX->Notes = "-INF<x<INF"; break;
    case distLOGARITHMIC: FX->FLB = 1; FX->FUB = INF; FX->Notes = "1<x<INF"; break;
    case distLOGISTIC: FX->FLB = -INF; FX->FUB = INF; FX->Notes = "-INF<x<INF"; break;
    case distLOGNORMAL: FX->FLB = EPS; FX->FUB = INF; FX->Notes = "0<x<INF"; break;
    case distLOGWEIBULL: FX->FLB = EPS; FX->FUB = INF; FX->Notes = "0<x<INF"; break;
    case distMAXWELL: FX->FLB = EPS; FX->FUB = INF; FX->Notes = "0<x<INF"; break;
    case distNEGBINOM: FX->FLB = 1; FX->FUB = INF; FX->Notes = "0<x<INF"; break;
    case distNORMAL: FX->FLB = -INF; FX->FUB = INF; FX->Notes = "-INF<x<INF"; break;
    case distPARETO:
      FX->LB = FDistParams->Items[0]->Value;
      FX->UB = INF;
      FX->Notes = "b<=x<INF";
      break;
    case distPOISSON:
      FX->LB = 1; FX->UB = INF; FX->Notes = "0<x<=INF";
      break;
    case distPOWER:
      FX->FLB = 0.0;
      FX->FUB = 1 / FDistParams->Items[0]->Value;
      FX->Notes = "0<=x<=1/beta";
      break;
    case distRAYLEIGH: FX->FLB = 0.0; FX->FUB = INF; FX->Notes = "0<=x<INF"; break;
    case distSTUDENT: FX->FLB = -INF; FX->FUB = INF; FX->Notes = "-INF<x<INF"; break;
    case distTRIANGULAR:
      FX->FLB = FDistParams->Items[0]->Value;
      FX->FUB = FDistParams->Items[1]->Value;
      FX->Notes = "a<=x<=b";
      FDistParams->Items[0]->LB = -INF;
      FDistParams->Items[0]->UB = FDistParams->Items[1]->Value - EPS;
      FDistParams->Items[1]->LB = FDistParams->Items[0]->Value + EPS;
      FDistParams->Items[1]->UB = INF;
      FDistParams->Items[2]->LB = FDistParams->Items[0]->Value;
      FDistParams->Items[2]->UB = FDistParams->Items[1]->Value;
      break;
    case distUNIFORM:
      FX->FLB = FDistParams->Items[0]->Value;
      FX->FUB = FDistParams->Items[1]->Value;
      FX->Notes = "a<=x<=b";
      break;
    case distUNIFORMD:
      FX->FLB = 1;
      FX->FUB = FDistParams->Items[0]->Value;
      FX->Notes = "0<x<=N";
      break;
    case distWEIBULL: FX->FLB = 0.0; FX->FUB = INF; FX->Notes = "0<=x<INF"; break;
    case distZIPF:
      FX->FLB = 1;
      FX->FUB = FDistParams->Items[1]->IntValue() - 1;
      FX->Notes = "0<x<N";
      break;
    default: break;
  }
}
//---------------------------------------------------------------------------
void __fastcall TProbDistribution::SetCaption(const AnsiString& Value) { FCaption = Value; }
void __fastcall TProbDistribution::SetDistParams(TProbParameters* Value) { FDistParams->Assign(Value); }
void __fastcall TProbDistribution::SetDistType(TDistribution Value)
{
  if (Value != FDistType) {
    FDistType = Value;
    InitDistribution();
  }
}
void __fastcall TProbDistribution::SetLB(double Value) { FLB = Value; }
void __fastcall TProbDistribution::SetNumPoints(int Value) { FNumPoints = Value; }
void __fastcall TProbDistribution::Setp(TProbParameter* Value) { Fp = Value; }
void __fastcall TProbDistribution::SetUB(double Value) { FUB = Value; }
void __fastcall TProbDistribution::SetX(TProbParameter* Value) { FX = Value; }
//---------------------------------------------------------------------------
// TProbParameters
//---------------------------------------------------------------------------
__fastcall TProbParameters::TProbParameters(TProbDistribution* AOwner)
  : TOwnedCollection(AOwner, __classid(TProbParameter))
{
}
//---------------------------------------------------------------------------
TProbParameter* __fastcall TProbParameters::AddParameter(const AnsiString& aName, TProbParType aType,
                                                          const AnsiString& aNotes, double aValue)
{
  TProbParameter* Result = (TProbParameter*)Add();
  Result->Name = aName;
  Result->FParameterType = aType;
  Result->FNotes = aNotes;
  Result->FValue = aValue;
  return Result;
}
//---------------------------------------------------------------------------
TProbParameter* __fastcall TProbParameters::AddParameter(const AnsiString& aName, TProbParType aType,
                                                          double aLB, double aUB,
                                                          const AnsiString& aNotes, double aValue)
{
  TProbParameter* Result = AddParameter(aName, aType, aNotes, aValue);
  Result->FLB = aLB;
  Result->FUB = aUB;
  return Result;
}
//---------------------------------------------------------------------------
TProbParameter* __fastcall TProbParameters::GetProbParameter(int index)
{
  return (TProbParameter*)TOwnedCollection::Items[index];
}
//---------------------------------------------------------------------------
TProbDistribution* __fastcall TProbParameters::Owner()
{
  return (TProbDistribution*)GetOwner();
}
//---------------------------------------------------------------------------
void __fastcall TProbParameters::SetProbParameter(int index, TProbParameter* Value)
{
  Items[index]->Assign(Value);
}
//---------------------------------------------------------------------------
// TProbParameter
//---------------------------------------------------------------------------
__fastcall TProbParameter::TProbParameter(TCollection* Collection)
  : TCollectionItem(((Collection != NULL) && Collection->InheritsFrom(__classid(TProbParameters))) ? Collection : NULL)
{
}
//---------------------------------------------------------------------------
__fastcall TProbParameter::~TProbParameter()
{
}
//---------------------------------------------------------------------------
int __fastcall TProbParameter::IntValue()
{
  return Math387::RoundToInt(FValue);
}
//---------------------------------------------------------------------------
void __fastcall TProbParameter::SetName(const AnsiString& Value)
{
  if (Value != FCaption) FCaption = Value;
}
//---------------------------------------------------------------------------
void __fastcall TProbParameter::SetLB(double Value) { FLB = Value; }
void __fastcall TProbParameter::SetNotes(const AnsiString& Value) { FNotes = Value; }
void __fastcall TProbParameter::SetUB(double Value) { FUB = Value; }
//---------------------------------------------------------------------------
void __fastcall TProbParameter::SetValue(double Value)
{
  FValue = Value;
  if ((Collection != NULL) && Collection->InheritsFrom(__classid(TProbParameters)))
    ((TProbParameters*)Collection)->Owner()->CalcStats();
}
//---------------------------------------------------------------------------
bool __fastcall TProbParameter::ValueIsValid()
{
  bool Result = (FValue >= FLB) && (FValue <= FUB);
  if (FParameterType == parInteger)
    Result = Result && (fabs(FValue - IntValue()) < EPS);
  return Result;
}
//---------------------------------------------------------------------------
TParamDomain __fastcall TProbParameter::GetParameterDomain()
{
  if ((FLB >= 0) && (FUB > FLB)) return domPositive;
  else if (FLB < FUB) return domBounded;
  else return domUnbounded;
}
//---------------------------------------------------------------------------

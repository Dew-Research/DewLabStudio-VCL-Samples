//---------------------------------------------------------------------------
#ifndef DewProbWrapperH
#define DewProbWrapperH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <SysUtils.hpp>
#include <Probabilities.hpp>
#include <Math387.hpp>
//---------------------------------------------------------------------------
// Probability parameter number type.
enum TProbParType { parInteger, parTSample };

// Defines parameter domain.
enum TParamDomain { domUnbounded, domBounded, domPositive };

// Forward declarations
class TProbParameter;
class TProbParameters;
class TProbDistribution;

//---------------------------------------------------------------------------
class TProbParameter : public TCollectionItem
{
  friend class TProbParameters;
  friend class TProbDistribution;
private:
  AnsiString FCaption;
  TProbParType FParameterType;
  AnsiString FNotes;
  double FValue;
  double FUB;
  double FLB;
  void __fastcall SetName(const AnsiString& Value);
  void __fastcall SetNotes(const AnsiString& Value);
  void __fastcall SetValue(double Value);
  void __fastcall SetLB(double Value);
  void __fastcall SetUB(double Value);
  TParamDomain __fastcall GetParameterDomain();
public:
  __property AnsiString Name = { read = FCaption, write = SetName };
  __property AnsiString Notes = { read = FNotes, write = SetNotes };
  __property double Value = { read = FValue, write = SetValue };
  __property double LB = { read = FLB, write = SetLB };
  __property double UB = { read = FUB, write = SetUB };
  __property TParamDomain Domain = { read = GetParameterDomain };
  __property TProbParType ParameterType = { read = FParameterType };

  int __fastcall IntValue();
  bool __fastcall ValueIsValid();

  __fastcall TProbParameter(TCollection* Collection);
  __fastcall virtual ~TProbParameter();
};

//---------------------------------------------------------------------------
class TProbParameters : public TOwnedCollection
{
private:
  TProbParameter* __fastcall GetProbParameter(int index);
  void __fastcall SetProbParameter(int index, TProbParameter* Value);
public:
  TProbDistribution* __fastcall Owner();
  TProbParameter* __fastcall AddParameter(const AnsiString& aName, TProbParType aType,
                                          const AnsiString& aNotes, double aValue);
  TProbParameter* __fastcall AddParameter(const AnsiString& aName, TProbParType aType,
                                          double aLB, double aUB,
                                          const AnsiString& aNotes, double aValue);
  __property TProbParameter* Items[int index] = { read = GetProbParameter,
                                                  write = SetProbParameter };

  __fastcall TProbParameters(TProbDistribution* AOwner);
};

//---------------------------------------------------------------------------
class TProbDistribution : public TPersistent
{
  friend class TProbParameter;
private:
  TProbParameters* FDistParams;
  AnsiString FCaption;
  TDistribution FDistType;
  int FNumPoints;
  double FUB;
  double FLB;
  bool fInit;
  double fMean, fVariance, fSkewness, fKurtosis;
  TProbParameter* FX;
  TProbParameter* Fp;
  void __fastcall SetDistParams(TProbParameters* Value);
  void __fastcall SetCaption(const AnsiString& Value);
  bool __fastcall GetDiscrete();
  void __fastcall SetDistType(TDistribution Value);
  void __fastcall SetLB(double Value);
  void __fastcall SetNumPoints(int Value);
  void __fastcall SetUB(double Value);
  void __fastcall CalcStats();
  void __fastcall SetX(TProbParameter* Value);
  void __fastcall Setp(TProbParameter* Value);
  double __fastcall GetCDF();
  double __fastcall GetPDF();
  double __fastcall GetPPF();
  double __fastcall GetCumHazard();
  double __fastcall GetHazard();
  double __fastcall GetSurvival();
public:
  double __fastcall CalculatePDF(double Value);
  double __fastcall CalculateCDF(double Value);
  double __fastcall CalculatePPF(double Value);
  double __fastcall CalculateS(double Value);
  double __fastcall CalculateH(double Value);
  double __fastcall CalculateCumH(double Value);

  void __fastcall InitDistribution();
  void __fastcall InitParameters();

  __property double PDF = { read = GetPDF };
  __property double CDF = { read = GetCDF };
  __property double PPF = { read = GetPPF };
  __property double Survival = { read = GetSurvival };
  __property double Hazard = { read = GetHazard };
  __property double CumHazard = { read = GetCumHazard };
  __property bool Discrete = { read = GetDiscrete };
  __property double Mean = { read = fMean };
  __property double Variance = { read = fVariance };
  __property double Skewness = { read = fSkewness };
  __property double Kurtosis = { read = fKurtosis };

  __property AnsiString Caption = { read = FCaption, write = SetCaption };
  __property TDistribution DistType = { read = FDistType, write = SetDistType };
  __property TProbParameters* DistParams = { read = FDistParams, write = SetDistParams };
  __property TProbParameter* X = { read = FX, write = SetX };
  __property TProbParameter* p = { read = Fp, write = Setp };
  __property double LB = { read = FLB, write = SetLB };
  __property double UB = { read = FUB, write = SetUB };
  __property int NumPoints = { read = FNumPoints, write = SetNumPoints };

  __fastcall TProbDistribution();
  __fastcall virtual ~TProbDistribution();
};

//---------------------------------------------------------------------------
#endif

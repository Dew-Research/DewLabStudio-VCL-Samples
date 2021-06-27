//---------------------------------------------------------------------------

#ifndef DecompWizardH
#define DecompWizardH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Wizard.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Dialogs.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VclTee.TeeGDIPlus.hpp>
#include <VCLTee.Chart.hpp>
#include <Mtxexpr.hpp>
#include <MtxVecTee.hpp>
#include <StatTimeSerAnalysis.hpp>
#include <RegModels.hpp>
//---------------------------------------------------------------------------
class TfrmDecompositionWizard : public TfrmBasicWizard
{
__published:	// IDE-managed Components
	TOpenDialog *OpenDialog;
	TTabSheet *tsInputData;
	TPanel *Panel3;
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label3;
	TGroupBox *GroupBox1;
	TButton *btnLoad;
	TCheckBox *chkCycle;
	TEdit *editSeasons;
	TUpDown *udSeasons;
	TEdit *editForecasts;
	TUpDown *udForecasts;
	TGroupBox *GroupBox2;
	TLabel *Label4;
	TEdit *EditFmtString;
	TEdit *editCycle;
	TChart *chartData;
	TLineSeries *Series2;
	TLineSeries *Series3;
	TLineSeries *Series4;
	TTabSheet *tsTextReport;
	TRichEdit *RichEdit;
	TTabSheet *tsChartReport;
	TChart *reportChart;
	void __fastcall btnLoadClick(TObject *Sender);
	void __fastcall editSeasonsChange(TObject *Sender);
	void __fastcall FormShow(TObject *Sender);
	void __fastcall EditFmtStringChange(TObject *Sender);
	void __fastcall editForecastsChange(TObject *Sender);
	void __fastcall chkCycleClick(TObject *Sender);
private:	// User declarations
	sVector Data;
	sVector Yv,Mv,Tv;
	int L,l2; // MA period
	TSample a,b,dmean; // trend parameters
	sVector Cv,Kv,Sv,Rv;
	sVector Forecasts, Residuals;
	int ForNum;
	TSample ForCycle;
	void __fastcall TransformTimeSeries();
	void __fastcall MovAve();
	void __fastcall Trend();
	void __fastcall Seasonality();
	void __fastcall Randomness();
	void __fastcall DoForecasts();
	void __fastcall DoCalc();
	void __fastcall RefreshChart();
	void __fastcall TextReport();
	void __fastcall ChartReport(int AIndex);
public:		// User declarations
	sVector TimeSeries;
	__fastcall TfrmDecompositionWizard(TComponent* Owner);
protected:
	virtual void __fastcall RefreshWizardControls();
	virtual void __fastcall DoMoveBackward();
	virtual void __fastcall DoMoveForward();
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmDecompositionWizard *frmDecompositionWizard;
//---------------------------------------------------------------------------
#endif

//---------------------------------------------------------------------------

#ifndef ARIMAWizardH
#define ARIMAWizardH
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
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.CandleCh.hpp>
#include <VclTee.TeeGDIPlus.hpp>
#include <MtxVecTee.hpp>
#include <Mtxexpr.hpp>
#include <StatTimeSerAnalysis.hpp>
//---------------------------------------------------------------------------
class TfrmARIMAWizard : public TfrmBasicWizard
{
__published:	// IDE-managed Components
	TOpenDialog *OpenDialog;
	TTabSheet *tsInputData;
	TTabSheet *tsDefineModel;
	TTabSheet *tsDefineReport;
	TTabSheet *tsTextReport;
	TTabSheet *tsChart;
	TPanel *Panel3;
	TGroupBox *GroupBox1;
	TLabel *Label3;
	TButton *btnLoad;
	TCheckBox *chkBoxRemoveMean;
	TEdit *editD;
	TUpDown *udD;
	TGroupBox *GroupBox2;
	TLabel *Label4;
	TLabel *Label8;
	TEdit *EditFmtString;
	TEdit *editAlpha;
	TGroupBox *GroupBox6;
	TLabel *lblLength;
	TLabel *lblMean;
	TLabel *lblStdDev;
	TLabel *lblVariance;
	TGroupBox *GroupBox7;
	TLabel *lblTrSize;
	TLabel *lblTrMean;
	TLabel *lblTrStdDev;
	TLabel *lblTrVar;
	TRadioGroup *rgPlot;
	TChart *chartData;
	TLabel *lblModel;
	TGroupBox *GroupBox3;
	TLabel *Label1;
	TLabel *Label2;
	TEdit *editAROrder;
	TEdit *editMAOrder;
	TUpDown *udAR;
	TUpDown *udMA;
	TRadioGroup *rgARInit;
	TRadioGroup *rgARMAInit;
	TGroupBox *gbPhiThetaEdit;
	TButton *btnEditPhi;
	TButton *btnEditTheta;
	TGroupBox *gbInnovationsLag;
	TLabel *Label5;
	TEdit *EditInnoLag;
	TGroupBox *GroupBox5;
	TCheckBox *chkDoMLE;
	TGroupBox *GroupBox4;
	TLabel *Label6;
	TLabel *Label7;
	TEdit *editForecastNo;
	TEdit *editACFLag;
	TCheckBox *chkAddMean;
	TCheckBox *chkIntegrate;
	TUpDown *udForecastsNo;
	TRichEdit *RichEdit;
	TChart *Chart;
	void __fastcall FormShow(TObject *Sender);
	void __fastcall EditFmtStringChange(TObject *Sender);
	void __fastcall btnLoadClick(TObject *Sender);
	void __fastcall editAROrderChange(TObject *Sender);
	void __fastcall editMAOrderChange(TObject *Sender);
	void __fastcall editDChange(TObject *Sender);
	void __fastcall rgARInitClick(TObject *Sender);
	void __fastcall rgARMAInitClick(TObject *Sender);
	void __fastcall btnEditPhiClick(TObject *Sender);
	void __fastcall btnEditThetaClick(TObject *Sender);
	void __fastcall EditInnoLagChange(TObject *Sender);
	void __fastcall editForecastNoChange(TObject *Sender);
	void __fastcall editACFLagChange(TObject *Sender);
	void __fastcall editAlphaChange(TObject *Sender);
	void __fastcall chkBoxRemoveMeanClick(TObject *Sender);
	void __fastcall rgPlotClick(TObject *Sender);
	void __fastcall chartDataBeforeDrawSeries(TObject *Sender);
	void __fastcall chartDataAfterDraw(TObject *Sender);
private:	// User declarations
	sVector Data,Residuals,Forecasts,FStdDev;
	int p,q,d,MaxLag,ForecastPer,ACFLag;
	TSample dMean;
	sVector phi,theta;
	TcfInitMethod InitM;
	TSample Alpha;
	TSample chartLCL,chartUCL;
	AnsiString __fastcall CoeffReport(TVec *coeff,TVec *cstderrs, AnsiString coefCaption);
	void __fastcall InfoReport();
	void __fastcall RefreshChart();
	void __fastcall UpdateModelInfo();
	AnsiString __fastcall ModelText();
	void __fastcall TextReports();
	void __fastcall InitEstReport();
	void __fastcall CausalReport();
	void __fastcall MLEReport();
	void __fastcall ForecastReport();
	void __fastcall ChartReport(int Ind);
	void __fastcall TransformTimeSeries();
public:		// User declarations
	sVector TimeSeries;
	__fastcall TfrmARIMAWizard(TComponent* Owner);
protected:
	virtual void __fastcall RefreshWizardControls();
	virtual void __fastcall DoMoveBackward();
	virtual void __fastcall DoMoveForward();
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmARIMAWizard *frmARIMAWizard;
//---------------------------------------------------------------------------
#endif

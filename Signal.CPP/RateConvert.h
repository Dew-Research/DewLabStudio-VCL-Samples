//---------------------------------------------------------------------------

#ifndef RateConvertH
#define RateConvertH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include "MtxBaseComp.hpp"
#include "MtxComCtrls.hpp"
#include "MtxDialogs.hpp"
#include "SignalAnalysis.hpp"
#include "SignalProcessing.hpp"
#include "SignalTools.hpp"
#include "SignalToolsDialogs.hpp"
#include "SignalToolsTee.hpp"
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
//---------------------------------------------------------------------------
class TRateConvertForm : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel1;
	TLabel *Label1;
	TButton *Updatebutton;
	TMtxFloatEdit *RateFactorEdit;
	TButton *ResetButton;
	TButton *Button1;
	TRichEdit *RichEdit1;
	TSignalChart *SignalChart;
	TFastLineSeries *ConvertedSignal;
	TFastLineSeries *OriginalSignal;
	TSignalGenerator *SignalGenerator;
	TSignalGeneratorDialog *SignalGeneratorDialog;
	TSignalRateConverter *SignalRateConverter;
	TSignalStoreBuffer *SignalStoreBuffer;
	TSignalStoreBuffer *SignalStoreBuffer1;
	TSpectrumAnalyzer *SpectrumAnalyzer;
	TSpectrumAnalyzer *SpectrumAnalyzer1;
	TSpectrumChart *SpectrumChart;
	TFastLineSeries *ConvertedSpectrum;
	TFastLineSeries *OriginalSpectrum;
	TSplitter *Splitter1;
	void __fastcall Button1Click(TObject *Sender);
	void __fastcall RateFactorEditChange(TObject *Sender);
	void __fastcall ResetButtonClick(TObject *Sender);
	void __fastcall UpdatebuttonClick(TObject *Sender);
	void __fastcall SignalGeneratorParameterUpdate(TObject *Sender);
private:	// User declarations
	void __fastcall Reset();
public:		// User declarations
	__fastcall TRateConvertForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TRateConvertForm *RateConvertForm;
//---------------------------------------------------------------------------
#endif

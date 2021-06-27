//---------------------------------------------------------------------------

#ifndef BufferUnitH
#define BufferUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "MtxBaseComp.hpp"
#include "MtxComCtrls.hpp"
#include "SignalAnalysis.hpp"
#include "SignalProcessing.hpp"
#include "SignalTools.hpp"
#include "SignalToolsTee.hpp"
#include <ExtCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
//---------------------------------------------------------------------------
class TBufferForm : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel1;
	TLabel *BufferSizeLabel;
	TLabel *UnreadBufferDataLabel;
	TLabel *Label3;
	TLabel *SignalUpdateLabel;
	TLabel *ReadCursorLabel;
	TLabel *DataReadLabel;
	TLabel *WriteCursorLabel;
	TLabel *InputBufferSizeLabel;
	TLabel *StoreBufferLabel;
	TLabel *Label1;
	TButton *ButtonUpdate;
	TMtxFloatEdit *BufferSizeEdit;
	TMtxFloatEdit *InputBufferEdit;
	TButton *ResetButton;
	TSignalBuffer *SignalBuffer;
	TSignalChart *SignalChart1;
	TFastLineSeries *Series1;
	TSignalChart *SignalChart2;
	TFastLineSeries *FastLineSeries1;
	TSignalGenerator *SignalGenerator;
	TSignalStoreBuffer *SignalStoreBuffer;
	TSpectrumAnalyzer *SpectrumAnalyzer1;
	TSpectrumAnalyzer *SpectrumAnalyzer2;
	TSpectrumChart *SpectrumChart1;
	TFastLineSeries *Series2;
	TSplitter *Splitter1;
	TSplitter *Splitter2;
	void __fastcall ButtonUpdateClick(TObject *Sender);
	void __fastcall SignalGeneratorAfterUpdate(TObject *Sender);
	void __fastcall SignalBufferAfterUpdate(TObject *Sender);
	void __fastcall BufferSizeEditChange(TObject *Sender);
	void __fastcall SignalBufferBeforeUpdate(TObject *Sender);
	void __fastcall InputBufferEditChange(TObject *Sender);
	void __fastcall ResetButtonClick(TObject *Sender);
private:	// User declarations
	void __fastcall DisplayUpdate();
public:		// User declarations
	__fastcall TBufferForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TBufferForm *BufferForm;
//---------------------------------------------------------------------------
#endif

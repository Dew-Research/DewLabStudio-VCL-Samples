//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "WhatIsNew.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "AsioAudioSignal"
#pragma link "CoreAudioSignal"
#pragma link "MtxBaseComp"
#pragma link "MtxVec"
#pragma link "SignalTools"
#pragma link "MtxVec"
#pragma link "MtxVec"
#pragma link "MtxVec"
#pragma resource "*.dfm"
TWhatIsNewForm *WhatIsNewForm;
//---------------------------------------------------------------------------
__fastcall TWhatIsNewForm::TWhatIsNewForm(TComponent* Owner)
	: TBasicForm3(Owner)
{
		RichEdit1->Lines->Clear();

		RichEdit1->DefAttributes->Size = 11;
		RichEdit1->DefAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
		RichEdit1->SelAttributes->Color = (TColor) RGB(51,51,153);
		RichEdit1->SelAttributes->Size = 12;
		RichEdit1->Lines->Add("New features in version 6.0.5:");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("   Support for RAD Studio 11.0 Alexandria");
		RichEdit1->Lines->Add("   Added support for Android API 25 for TSignalCoreAudioIn/TSignalCoreAudioOut ");
		RichEdit1->Lines->Add("   Added API required to enable low-latency streaming over network with TSignalCoreAudioIn/TSignalCoreAudioOut.");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");


		RichEdit1->DefAttributes->Size = 11;
		RichEdit1->DefAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
		RichEdit1->SelAttributes->Color = (TColor) RGB(51,51,153);
		RichEdit1->SelAttributes->Size = 12;
		RichEdit1->Lines->Add("New features in version 6.0:");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("   Support for RAD Studio 10.4 Sydney");
		RichEdit1->Lines->Add("   TSignalCoreAudioIn/TSignalCoreAudioOut has been upgraded to support iOS and Android "
							  "  next to Windows OS. The use of the same component on both Windows and mobile platforms greatly simplifies development of audio recording/playback applications for mobile devices.");
		RichEdit1->Lines->Add("   On iOS/macOS the audio uses the low level RemoteIO interface.");
		RichEdit1->Lines->Add("   Performance enhancements due to support for Apple Accelerate framework on iOS and macOS.");
		RichEdit1->Lines->Add("   Fix for TSignalCoreAudioIn/TSignalCoreAudioOut for 24bit Exclusive mode. ");
		RichEdit1->Lines->Add("   Fix for TSignalCoreAudioIn OnBufferReady call frequency. Now it triggers as soon as there are InputDataLength samples buffered.");
		RichEdit1->Lines->Add("   Fix for detecting 24 bit recording/playback where WASAPI did not work without having dwChannelMask set to 3.");
		RichEdit1->Lines->Add("   Added TSignalCoreAudio.TVolumeControl property.");
		RichEdit1->Lines->Add("   Added TSignalCoreAudio.Volume property.");
		RichEdit1->Lines->Add("   Added TSignalCoreAudio.LoopbackOutputDevices property and support for recording of playback streams.");
		RichEdit1->Lines->Add("   Added TSignalCoreAudio.Thread Priority boost via Multimedia Class Scheduler Service");
		RichEdit1->Lines->Add("   TSignalBuffer.StrideLength fix. Now TSignalBuffer allows arbitrary input vector length and output vector length and arbitray stride.");
		RichEdit1->Lines->Add("   Modified TSpectrogram.Logarithmic behaviour.");
		RichEdit1->Lines->Add("   Performance improvements for TSpectrogram.");
		RichEdit1->Lines->Add("   TSignalAsio enhanced for compatibility.");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");

		RichEdit1->DefAttributes->Size = 11;
		RichEdit1->DefAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
		RichEdit1->SelAttributes->Color = (TColor) RGB(51,51,153);
		RichEdit1->SelAttributes->Size = 12;
		RichEdit1->Lines->Add("New features in version 5.1:");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("   Support for RAD Studio 10.1 Berlin");
		RichEdit1->Lines->Add("   Cross platform support for FireMonkey on iOS, OS X and Android");
		RichEdit1->Lines->Add("   Updated to Intel IPP v9 from v8. Some API changes were required also.");
		RichEdit1->Lines->Add("   Fixed a bug in Remez filter design, where the Grid size came to be too small for the specs.");
		RichEdit1->Lines->Add("   Fixed a bug in CplxCepstrum and PhaseUnwrap routines. ");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");

		RichEdit1->DefAttributes->Size = 11;
		RichEdit1->DefAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
		RichEdit1->SelAttributes->Color = (TColor) RGB(51,51,153);
		RichEdit1->SelAttributes->Size = 12;
		RichEdit1->Lines->Add("New features in version 5.0:");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("   Updated for MtxVec v5 (compiles also with full source pascal code).");
		RichEdit1->Lines->Add("   Fixed a bug with DC and Notch filter in TSignalFilter.");
		RichEdit1->Lines->Add("   Updates for FireMonkey in XE7.");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");

		RichEdit1->DefAttributes->Size = 11;
		RichEdit1->DefAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
		RichEdit1->SelAttributes->Color = (TColor) RGB(51,51,153);
		RichEdit1->SelAttributes->Size = 12;
		RichEdit1->Lines->Add("New features in version 4.5:");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("   Added WASAPI (Audio Core API) drivers support for playback and recording on Windows OS.");
		RichEdit1->Lines->Add("   TSignalCoreAudioIn and TSignalCoreAudioOut are new components supported from Windows Vista forward.");
		RichEdit1->Lines->Add("   Fixed a bug with top and bottom clipoff colors with TMtxGridSeries. Updated demo for Spectrogram.");
		RichEdit1->Lines->Add("   Fixed a bug with custom palette with TMtxGridSeries.");
		RichEdit1->Lines->Add("   Updated users DSP Master Users Guide.pdf with further examples on Audio Core API components.");
		RichEdit1->Lines->Add("   Included unit for file based signal processing. New routines allow to build processing pipes where source and destination is a file and process data in multiple threads.");
		RichEdit1->Lines->Add("   Updated for Rad Studio XE7.");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");

		RichEdit1->DefAttributes->Size = 11;
		RichEdit1->DefAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
		RichEdit1->SelAttributes->Color = (TColor) RGB(51,51,153);
		RichEdit1->SelAttributes->Size = 12;
		RichEdit1->Lines->Add("New features in version 4.4:");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("   Support for FireMonkey on Windows.");
		RichEdit1->Lines->Add("   Added new overloads for ButterFilter, ChebyshevIFilter, CheybhsevIIFilter and EllipticFilter which can now return filter also in SOS format.");
		RichEdit1->Lines->Add("   Fixed a bug in ZeroPoleToSOS function.");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");

		RichEdit1->DefAttributes->Size = 11;
		RichEdit1->DefAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
		RichEdit1->SelAttributes->Color = (TColor) RGB(51,51,153);
		RichEdit1->SelAttributes->Size = 12;
		RichEdit1->Lines->Add("New features in version 4.3:");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("   Support for FireMonkey on Windows.");
		RichEdit1->Lines->Add("   Added new overloads for ButterFilter, ChebyshevIFilter, CheybhsevIIFilter and EllipticFilter which can now return filter also in SOS format.");
		RichEdit1->Lines->Add("   Fixed a bug for ASIO driver, where data storage is 32bit, but usable bits were less.");
		RichEdit1->Lines->Add("   Fixed a bug TSignalIn/TSignalOut where ChannelCount was 1.");
		RichEdit1->Lines->Add("   TeeChart features updated for GDI+ support.");
		RichEdit1->Lines->Add("   Support for 64bit C++Builder.");
		RichEdit1->Lines->Add("   Improvements and adjustments for TSignalAsioAudio.");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");

		RichEdit1->DefAttributes->Size = 11;
		RichEdit1->DefAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
		RichEdit1->SelAttributes->Color = (TColor) RGB(51,51,153);
		RichEdit1->SelAttributes->Size = 12;
		RichEdit1->Lines->Add("New features in version 4.1:");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("Updated to support Delphi XE2 32 and 64bit and C++Builder XE2.");
		RichEdit1->Lines->Add("Support for TeeChart 2011.");
		RichEdit1->Lines->Add("IIR Filtering based on second order sections now allows filtering with much more extreem filter designs and IIR filters order up to 50.");
		RichEdit1->Lines->Add("New TSignalPolarSeries works with cartesian coordinates and is up to 50x faster than TPolarSeries.");
		RichEdit1->Lines->Add("ASIO driver components.");
		RichEdit1->Lines->Add("Kalman filtering implementation.");
		RichEdit1->Lines->Add("Added pink, gray and violate noise generators.");
		RichEdit1->Lines->Add("Fixed bug for triangular noise generator.");
		RichEdit1->Lines->Add("Added new inverse FFT based FIR filter designer.");
		RichEdit1->Lines->Add("Support for Intel AVX instructions via MtxVec.");
		RichEdit1->Lines->Add("New stand alone alternative native Delphi code for signal processing without Intel SPL.");
		RichEdit1->Lines->Add("Many minor enhancements and bug fixes.");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");

		RichEdit1->DefAttributes->Size = 11;
		RichEdit1->DefAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
		RichEdit1->SelAttributes->Color = (TColor) RGB(51,51,153);
		RichEdit1->SelAttributes->Size = 12;
		RichEdit1->Lines->Add("New features in version 3.5:");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("Updated to support Delphi 2010 and C++Builder 2010.");
		RichEdit1->Lines->Add("Support for TeeChart 8.");
		RichEdit1->Lines->Add("Support for Intel IPP v6 with Core i7 optimized code path.");
		RichEdit1->Lines->Add("HtmlHelp 2 format support added. Now F1 finally works again from code and components in D2007.");
		RichEdit1->Lines->Add("All code examples now also have C++ examples.");
		RichEdit1->Lines->Add("All code examples in the help have been recreated with support for Vector/Matrix expressions.");
		RichEdit1->Lines->Add("Demo updated with Vector/Matrix syntax.");
		RichEdit1->Lines->Add("New C++Builder translation of the DSP Master demo.");
		RichEdit1->Lines->Add("New set (hundreds) of true color 24x24 and 16x16 icons for components to support newer IDE tool palette.");
		RichEdit1->Lines->Add("Many minor enhancements and bug fixes.");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");

		RichEdit1->DefAttributes->Size = 11;
		RichEdit1->DefAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
		RichEdit1->SelAttributes->Color = (TColor) RGB(51,51,153);
		RichEdit1->SelAttributes->Size = 12;
		RichEdit1->Lines->Add("New features in version 2.1:");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("Superfast arbitrary factor rate converter component.");
		RichEdit1->Lines->Add("TSignalBuffer component had some bugs fixed.");
		RichEdit1->Lines->Add("TSignal.Pull methods are completely rewritten. "
			"It is now possible to build much more complex processing pipes with much less code.");
		RichEdit1->Lines->Add("Fixed a bug in Complex Cepstrum, which occured during transition to .NET");
		RichEdit1->Lines->Add("TSignalChart and TSpectrumChart now accept multiple inputs. Same component "
				"can be connected to the same chart more than once or to multiple charts at the "
				"same time with centralized redraw control.");
		RichEdit1->Lines->Add("TSignalRead.RecordPositon now calls TSignal.Update.");
		RichEdit1->Lines->Add("Fixed a bug with TSignalIn for mono signal recordings.");
		RichEdit1->Lines->Add("Fixed onStart and OnStop events for the TSignalIn and TSignalOut.");
		RichEdit1->Lines->Add("Fixed the Report generation for TSpectrumAnalyzer and others."
				"Report interface has also changed to support .NET.");
		RichEdit1->Lines->Add("Fixed Logarithmic property for TSpectrumAnalyzer. It is now possible "
				"to toggle between logarithmic and linear scale for averaged spectrums."
				"without the need to perform the averaging again.");
		RichEdit1->Lines->Add("Fixed a bug for TSignalGeneratorDialog where it did not store the changes made.");
		RichEdit1->Lines->Add("TAnalysisList now has a Continuous property.");
		RichEdit1->Lines->Add("Reset method has been RichEdit1->Lines->Added to all filtering components, and allows "
				"delay lines to be reset to zero.");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");
		RichEdit1->SelAttributes->Color = (TColor) RGB(51,51,153);
		RichEdit1->SelAttributes->Size = 12;
		RichEdit1->Lines->Add("New features in version 2.0:");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
	   RichEdit1->Lines->Add("Arbitrary FFT length for 1D and 2D transforms.");
		RichEdit1->Lines->Add("Support for SSE3 instruction set.");
		RichEdit1->Lines->Add("Intel SPL interface replaced with support for IPP library.");
		RichEdit1->Lines->Add("Substantial increase in number of optimized primitive functions "
				"and methods via MtxVec v2.");
		RichEdit1->Lines->Add("Many new \"multi-channel\" list components.");
		RichEdit1->Lines->Add("Improved TSignalFile with several new properties.");
		RichEdit1->Lines->Add("Support for .NET");
		RichEdit1->Lines->Add("New TSignalStoreBuffer component.");
		RichEdit1->Lines->Add("New TSignalEnvelopeDetector component.");
		RichEdit1->Lines->Add("New connection mechanism for TSpectrumChart and TSignalChart.");
		RichEdit1->Lines->Add("TSignalRead component editor.");
		RichEdit1->Lines->Add("Minor bug fixes.");
		RichEdit1->Lines->Add("Improved piping mechanism for data streaming.");
		RichEdit1->Lines->Add("Substantially improved range checking and programmer safety.");

		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");

}
//---------------------------------------------------------------------------

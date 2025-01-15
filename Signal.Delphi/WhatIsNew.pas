unit WhatIsNew;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TWhatIsNewForm = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WhatIsNewForm: TWhatIsNewForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TWhatIsNewForm.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
	
    Font.Style := [];
    SelAttributes.Size := 11;
    SelAttributes.Color := RGB(51,51,153);
    SelAttributes.Size := 9;
    Add('   New features in version 6.3.0:');
    Add('');
	Add('General:');	
	Add('');			
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('   Updated for Rad Studio Athens 12.2 and MtxVec v6.3.0.');
	Add('   SignalUtils.CZT performance has been improved by a factor of 7x. ');		
    Add('   Added SignalUtils.CZT overload with support for State variable, which gives additional 2.5x speed up allowing for a total of 17.5x faster execution.');
	Add('   Added SignalUtils.MusicalNotePitch and its vectorized variant SignalUtils.MusicalNotePitchInit for pitch (note) detection.');	
	Add('   Enabled block vectorization for SignalUtils.GoertzN algorithm, which leads to additional 5-10x faster execution for large frequency spectrums. When multi-threaded it is expected to achieve linear scaling with thread-count.');
	Add('   New implementation of SignalUtils.GoertzN algorithm, which is 3x, if at least 10 and 10x faster, if at least 100 frequencies are evaluated concurrently.');	
	Add('   Improved accuracy of Bonzanigo Phase correction, especially for large frequency spectrums. Bonzanigo is used by the Goertzal algorithm.');
	Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;	
    Add('');	
	Add('TSpectrumAnalyzer improvements:');
    Add('');		
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
	Add('   Enabled the TSpectrumAnalyzer to use the new faster CZT algorithm. ');		
	Add('   Enabled the TSpectrumAnalyzer numerical peak interpolation to work also while CZT is the selected spectral Method.');    	
	Add('   Vectorized all peak searching and peak processing. Multiple overloads were added that work with vectors. Performance improvements are noticable when working with multiple peaks.');
    Add('   Numerical Peak interpolation is now 16x faster for signals which are zero padded 16x. It is now invariant to zero padding factor.');
	Add('   Numerical Peak interpolation algorithm has been vectorized delivering at least a 6x speed up. The implementation is our first optimization algorithm that runs multiple jobs in parallel using only vectorization on one CPU core. (Without threading).');
	Add('   Numerical Peak interpolation algorithm can in given conditions execute also 96x faster: 6x from interpolation improvements and 16x from zero padding.');		
	Add('   TSpectrumAnalyzer.Peaks.FindLargestPeaks is typcally more than 100x faster when using numerical peak interpolation, which helps all methods that depend on it.');	
	Add('   Added TSpectrumAnalyzer.Peaks.FindFirstHarmonic. Although generic, it can be used to detect pitch frequency of the sound (music).');
	Add('   Added TSpectrumAnalyzer.Peaks.FindFundamentals. Will find all harmonic series in the frequency spectrum and store their fundamentals. The result is sorted in ascending order according to frequency.');
	Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;	
    Add('');	
	Add('TSignalCore Audio improvements:');
    Add('');		
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;	
	Add('Expanded TSignalCoreAudio.ChannelMapping capability allowing arbitrary mix of channels for recording and playback. Each TSignalCoreAudio[i] item now has a Channels: TIntegersList property, which complenents the existng Channel: integer property. ');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');	

    Font.Style := [];
    SelAttributes.Size := 11;
    SelAttributes.Color := RGB(51,51,153);
    SelAttributes.Size := 9;
    Add('   New features in version 6.2.0:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('   Updated for Rad Studio Athens 12.0 and MtxVec v6.2.0.');
    Add('   Enhanced click/pop protection for the TSignalCoreAudioOut.Paused functionality. ');
    Add('   Bug fix for TSignalCoreAudioOut.Paused.');
    Add('   Android 11 tagged pointer support.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    Font.Style := [];
    SelAttributes.Size := 11;
    SelAttributes.Color := RGB(51,51,153);
    SelAttributes.Size := 9;
    Add('   New features in version 6.0.5:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('   Updated for Alexandria 11.0 and MtxVec v6.0.5.');
    Add('   Updated TSignalCoreAudioIn and TSignalCoreAudioOut to support Android v25 and newer.');
    Add('   Enhanced TSignalCoreAudioIn and TSignalCoreAudioOut with new API for low-latency (uncompressed) streaming over network across all platforms.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    Font.Style := [];
    SelAttributes.Size := 11;
    SelAttributes.Color := RGB(51,51,153);
    SelAttributes.Size := 9;
    Add('   New features in version 6.0:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('   Updated for Sydney 10.4 and MtxVec v6.');
    Add('   All the functions/components can work either with double and/or single precision.');
    Add('   Added FloatPrecision property to TSignal/TSignalList and TSpectrum/TSpectrumList and descendants.');
    Add('   FloatPrecision is selectable also at run-time.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    Font.Style := [];
    SelAttributes.Size := 11;
    SelAttributes.Color := RGB(51,51,153);
    SelAttributes.Size := 9;
    Add('   New features in version 5.3:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('   TSignalCoreAudioIn/TSignalCoreAudioOut has been upgraded to support iOS and Android next to Windows OS.'+
        ' The use of the same component on both Windows and mobile platforms greatly simplifies development of audio recording/playback applications for mobile devices.');
    Add('   On iOS/macOS the audio uses the low level RemoteIO interface.');
    Add('   Performance enhancements due to support for Apple Accelerate framework on iOS and macOS. ');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    Font.Style := [];
    SelAttributes.Size := 11;
    SelAttributes.Color := RGB(51,51,153);
    SelAttributes.Size := 9;
    Add('   New features in version 5.1.1:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('   Fix for TSignalCoreAudioIn/TSignalCoreAudioOut for 24bit Exclusive mode.');
    Add('   Fix for TSignalCoreAudioIn OnBufferReady call frequency. Now it triggers as soon as there are InputDataLength samples buffered. ');
    Add('   Fix for detecting 24 bit recording/playback where WASAPI did not work without having dwChannelMask set to 3.');
    Add('   Added TSignalCoreAudio.TVolumeControl property');
    Add('   Added TSignalCoreAudio.Volume property ');
    Add('   Added TSignalCoreAudio.LoopbackOutputDevices property and support for recording of playback streams.');
    Add('   Added TSignalCoreAudio.Thread Priority boost via Multimedia Class Scheduler Service. ');
    Add('   TSignalBuffer.StrideLength fix. Now TSignalBuffer allows arbitrary input vector length and output vector length and arbitray stride. ');
    Add('   Modified TSpectrogram.Logarithmic behaviour. ');
    Add('   Performance improvements for TSpectrogram. ');
    Add('   TSignalAsio enhanced for compatibility.  ');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    Font.Style := [];
    SelAttributes.Size := 11;
    SelAttributes.Color := RGB(51,51,153);
    SelAttributes.Size := 9;
    Add('   New features in version 5.1:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('   Support for RAD Studio 10.1 Berlin.');
    Add('   Cross platform support for FireMonkey on iOS, OS X and Android.');
    Add('   Updated to Intel IPP v9 from v8. Some API changes were required also.');
    Add('   Fixed a bug in Remez filter design, where the Grid size came to be too small for the specs.');
    Add('   Fixed a bug in CplxCepstrum and PhaseUnwrap routines.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    Font.Style := [];
    SelAttributes.Size := 11;
    SelAttributes.Color := RGB(51,51,153);
    SelAttributes.Size := 9;
    Add('   New features in version v5.02:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('   Updated for MtxVec v5.02 (Performance Enhancements, Android support).');
    Add('   Update to DSP demo for FireMonkey to run also on Android tablets. (Currently there is still no support for Playback/Recording on Android).');
    Add('   Support for XE8 and related TeeChart updates.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    Font.Style := [];
    SelAttributes.Size := 11;
    SelAttributes.Color := RGB(51,51,153);
    SelAttributes.Size := 9;
    Add('   New features in version v5.0:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('   Updated for MtxVec v5 (compiles also with full source pascal code).');
    Add('   Fixed a bug with DC and Notch filter in TSignalFilter.');
    Add('   Updates for FireMonkey in XE7.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    Font.Style := [];
    SelAttributes.Size := 11;
    SelAttributes.Color := RGB(51,51,153);
    SelAttributes.Size := 9;
    Add('   New features in version v4.5:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('   Added WASAPI (Audio Core API) drivers support for playback and recording on Windows OS.');
    Add('   TSignalCoreAudioIn and TSignalCoreAudioOut are new components supported from Windows Vista forward.');
    Add('   Fixed a bug with top and bottom clipoff colors with TMtxGridSeries. Updated demo for Spectrogram.');
    Add('   Fixed a bug with custom palette with TMtxGridSeries.');
    Add('   Updated users DSP Master Users Guide.pdf with further examples on Audio Core API components.');
    Add('   Included unit for file based signal processing. New routines allow to build processing ' +
        ' pipes where source and destination is a file and process data in multiple threads.');
    Add('   Updated for Rad Studio XE7.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    Font.Style := [];
    SelAttributes.Size := 11;
    SelAttributes.Color := RGB(51,51,153);
    SelAttributes.Size := 9;
    Add('   New features in version v4.4:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('   Support for FireMonkey on Windows.');
    Add('   Added new overloads for ButterFilter, ChebyshevIFilter, CheybhsevIIFilter and EllipticFilter which can now return filter also in SOS format.');
    Add('   Fixed a bug in ZeroPoleToSOS function.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    Font.Style := [];
    SelAttributes.Size := 11;
    SelAttributes.Color := RGB(51,51,153);
    SelAttributes.Size := 9;
    Add('   New features in version v4.3:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('   Support for FireMonkey on Windows.');
    Add('   Added new overloads for ButterFilter, ChebyshevIFilter, CheybhsevIIFilter and EllipticFilter which can now return filter also in SOS format.');
    Add('   Fixed a bug for ASIO driver, where data storage is 32bit, but usable bits were less.');
    Add('   Fixed a bug TSignalIn/TSignalOut where ChannelCount was 1.');
    Add('   TeeChart features updated for GDI+ support.');
    Add('   Support for 64bit C++Builder.');
    Add('   Improvements and adjustments for TSignalAsioAudio.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    Font.Style := [];
    SelAttributes.Size := 11;
    SelAttributes.Color := RGB(51,51,153);
    SelAttributes.Size := 9;

    Add('New features in version v4.1:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('IIR Filtering based on second order sections now allows filtering with much more extreem filter designs and stability up to order of 50.');
    Add('New functions SignalUtils.IirInitBQ and LinearSystems.ZeroPoleToSOS.');
    Add('TSignalFilter has been updated to make use second order sections for IIR filtering.');
    Add('New TSignalPolarSeries works with cartesian coordinates and is up to 50x faster than TPolarSeries.');
    Add('Support for Delphi XE2 compilers in both 32bit and 64bit variants.');
    Add('Updated for TeeChart 2011.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    Font.Style := [];
    SelAttributes.Size := 11;
    SelAttributes.Color := RGB(51,51,153);
    SelAttributes.Size := 9;

    Add('New features in version v4.0:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('ASIO driver components.');
    Add('Kalman filtering implementation.');
    Add('Added pink, gray and violate noise generators.');
    Add('Fixed bug for triangular noise generator.');
    Add('Added new inverse FFT based FIR filter designer.');
    Add('Support for TeeChart 2010.');
    Add('Support for Intel AVX instructions via MtxVec.');
    Add('New stand alone alternative native Delphi code for signal processing without Intel SPL.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    Font.Style := [];
//    DefAttributes.Style := [fsBold];
    SelAttributes.Size := 11;
    SelAttributes.Color := RGB(51,51,153);
    SelAttributes.Size := 9;

    Add('New features in version v3.52:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Support for Delphi 2010 and C++Builder 2010.');
    Add('Reworked peak ratios calcuation for TSpectrumAnalyzer.');
    Add('Fixes with relation to phase calculation for TSpectrumAnalyzer.');
    Add('Spectrogram calculation example added to demo.');
    Add('Various small improvements and tweaks.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

//    DefAttributes.Style := [fsBold];
    SelAttributes.Size := 11;
    SelAttributes.Color := RGB(51,51,153);
    SelAttributes.Size := 9;


    Add('New features in version v3.5:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Updated to support Delphi 2009 and C++Builder 2009.');
    Add('HtmlHelp 2 format support improved.');
    Add('Support for Intel IPP v6.');
    Add('Multithreading support added to many functions. Most notably FIR filtering functions!');
    Add('TSignalHighLowSeries has many new features.');
    Add('Several new components for rate conversion and modulation.');
    Add('Enhanced TSignalModulator and TSignalDemodulator.');
    Add('Bug fixes for TSignalRead and TSignalWrite.');
    Add('Faster Goertzal algorithm used for single line DFT.');
    Add('Much faster peak interpolation.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');


//    DefAttributes.Style := [fsBold];
    SelAttributes.Size := 11;
    SelAttributes.Color := RGB(51,51,153);
    SelAttributes.Size := 9;

    Add('New features in version v3:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Updated to support Delphi 2007 and C++Builder 2007.');
    Add('Support for TeeChart 8.');
    Add('Support for update Intel IPP v5.2 and consequently Core 2 Duo optimized.');
    Add('HtmlHelp 2 format support added. Now F1 finally works again from code and ' +
        'components in D2007.');
    Add('All code examples now also have C++ examples.');
    Add('All code examples in the help have been recreated with support for Vector/Matrix expressions.');
    Add('Demo updated with Vector/Matrix syntax.');
    Add('New C++Builder translation of the DSP Master demo.');
    Add('New set (hundreds) of true color 24x24 and 16x16 icons for components to support ' +
        'newer IDE tool palette.');
    Add('Many minor enhancements and bug fixes.'); ;
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

//    DefAttributes.Style := [fsBold];
    SelAttributes.Size := 11;
    SelAttributes.Color := RGB(51,51,153);
    SelAttributes.Size := 9;

    Add('New features in version 2.1:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Superfast arbitrary factor rate converter component.');
    Add('TSignalBuffer component had some bugs fixed.');
    Add('TSignal.Pull methods are completely rewritten. It is now possible ' +
        'to build much more complex processing pipes with much less code.');
    Add('Fixed a bug in Complex Cepstrum, which occured during transition to .NET');
    Add('TSignalChart and TSpectrumChart now accept multiple inputs. Same component ' +
        'can be connected to the same chart more than once or to multiple charts at the ' +
        'same time with centralized redraw control.');
    Add('TSignalRead.RecordPositon now calls TSignal.Update.');
    Add('Fixed a bug with TSignalIn for mono signal recordings.');
    Add('Fixed onStart and OnStop events for the TSignalIn and TSignalOut.');
    Add('Fixed the Report generation for TSpectrumAnalyzer and others.' +
        'Report interface has also changed to support .NET.');
    Add('Fixed Logarithmic property for TSpectrumAnalyzer. It is now possible ' +
        'to toggle between logarithmic and linear scale for averaged spectrums.' +
        'without the need to perform the averaging again.');
    Add('Fixed a bug for TSignalGeneratorDialog where it did not store the changes made.');
    Add('TAnalysisList now has a Continuous property.');
    Add('Reset method has been added to all filtering components, and allows ' +
        'delay lines to be reset to zero.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    DefAttributes.Size := 11;
//    DefAttributes.Style := [fsBold];
    SelAttributes.Size := 9;
    SelAttributes.Color := RGB(51,51,153);

    Add('New features in version 2.0:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Arbitrary FFT length for 1D and 2D transforms.');
    Add('Support for SSE3 instruction set.');
    Add('Intel SPL interface replaced with support for IPP library.');
    Add('Substantial increase in number of optimized primitive functions ' +
        'and methods via MtxVec v2.');
    Add('Many new "multi-channel" list components.');
    Add('Improved TSignalFile with several new properties.');
    Add('Support for .NET');
    Add('New TSignalStoreBuffer component.');
    Add('New TSignalEnvelopeDetector component.');
    Add('New connection mechanism for TSpectrumChart and TSignalChart.');
    Add('TSignalRead component editor.');
    Add('Minor bug fixes.');
    Add('Improved piping mechanism for data streaming.');
    Add('Substantially improved range checking and programmer safety.');

    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
  end;
end;

initialization
   RegisterClass(TWhatIsNewForm);


end.

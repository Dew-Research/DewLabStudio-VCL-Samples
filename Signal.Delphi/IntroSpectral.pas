unit IntroSpectral;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroSpectralForm = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IntroSpectralForm: TIntroSpectralForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TIntroSpectralForm.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    DefAttributes.Size := 10;
    DefAttributes.Style := [fsBold];
    SelAttributes.Size := 12;

    SelAttributes.Color := RGB(51,51,153);
    Add('Frequency spectrum analysis features:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Very fast FFT for real and complex signals');
    Add('Chirp-Z Transform for high speed frequency zoom-in');
    Add('4 autoregressive methods for spectral estimation: ' +
        'Yulle-Walker, Burg, Covariance and Modified covariance');
    Add('10 different time signal windows: Hanning, Hamming, FlatTop, ' +
        'Bartlet, Blackman, BlackmanHarris, BlackmanExact, '+
        'Cosine-tappered, Kaiser, Chebyshev and  Exponential');
    Add('THD, THD-N, SNR, NF, RMS, SFDR spectral statistics');
    Add('Integration and differentiation in the frequency domain');
    Add('Amplitude, power, peak-peak and RMS spectrums.');
    Add('Real and complex cepstrum.');

(*  Add('A comprehensive set of averaging methods: linear average, ' +
        'exponential average (= running average), peak hold average and ' +
        'averaging of the complex frequency spectrum.');
    Add('Compute RMS within frequency bands with bands editor.');
    Add('Computes standard deviation of the averaged frequency spectrum.');
    Add('Dedicated TSpectrumAnalyzer component with a component editor.');
    Add('Estimates the transfer function in amplitude and phase.'); *)
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
  end;
end;

initialization
   RegisterClass(TIntroSpectralForm);


end.

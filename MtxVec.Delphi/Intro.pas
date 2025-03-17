unit Intro;

{$I bdsppdefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, jpeg,  ExtCtrls;

type
  TIntroduction = class(TForm)
    RichEdit1: TRichEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Introduction: TIntroduction;

implementation

uses Math387, MtxVec, ippsplTypes
     {$IFDEF IPPDLL_DOUBLE}
     ,ippspl
     {$ENDIF}
     {$IFDEF IPPDLL_SINGLE}
     ,ippsplSingle
     {$ENDIF}
     ;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TIntroduction.FormCreate(Sender: TObject);
{$IFDEF IPPDLL_ANY}
var aMask, bMask: Int64;
{$ENDIF}
begin
  Label1.Caption := 'Welcome to MtxVec v' + FormatSample('0.00',MtxVecVersion/100);
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('Welcome to MtxVec, an object oriented threaded and vectorized numerical library '
      + 'for Delphi and .NET platform');
    Add('');
    Add('MtxVec adds the following capabilities to your development environment:');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Comprehensive set of mathematical and statistical functions');
    Add('Substantial performance improvements of floating point math by exploiting the SSE3, SSE4.x, AVX, AVX2 and AVX512 instruction sets.');
    Add('Support for 64bit applications.');
    Add('Certified support for 4GB address range on 64bit OS for 32bit applications.');
    Add('Open CL support allows high performance cross platform portable code and gives you access to the power of GPUs.');
    Add('Improved compactness and readability of code.');
    Add('Significantly shorter development times by protecting the developer from a wide range of possible errors.');
    Add('Same API interface in Delphi for W32 and in .NET');
    Add('Support for 64bit in .NET');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    Add('Typical performance improvements observed by most users are 4-6 times for ' +
        'vector functions, but speed ups up to 20 times are not rare. The matrix ' +
        'multiplication for example is faster up to 50 times.');
    Add('');
    Add('Navigate through the demo application, to learn '
      + 'more about MtxVec and experience it''s unmatched '
      + 'performance and ease of use.');
    Add('');
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('System info');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('CPU Logical Core Count = ' + IntToStr(Controller.CpuCoresLogical));
    Add('CPU Physical Core Count = ' + IntToStr(Controller.CpuCoresPhysical));
    Add('CPU NUMA Node Count = ' + IntToStr(Controller.CpuNumaNodes));
    Add('CPU L1 Cache size per Core = ' + IntToStr(Controller.CpuCacheL1SizeInBytes div 1024) + ' KB');
    Add('CPU L2 Cache size per Core = ' + IntToStr(Controller.CpuCacheL2SizeInBytes div 1024) + ' KB');
    if Controller.CpuCacheL3SizeInBytes > 0 then Add('CPU L3 Cache Size = ' + IntToStr(Controller.CpuCacheL3SizeInBytes div 1024) + ' KB');
    Add('CPU Vendor: ' + Controller.CPUVendor);

    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('MtxVec config');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('CPU/Thread Count = ' + IntToStr(Controller.CPUCores));
    Add('Thread Dimension = ' + IntToStr(Controller.ThreadDimension));
    Add('Blas internal threads = ' + IntToStr(Controller.BlasThreadCount));
    Add('Lapack internal threads = ' + IntToStr(Controller.LapackThreadCount));
    Add('FFT internal threads = ' + IntToStr(Controller.FFTThreadCount));
    Add('VML internal threads = ' + IntToStr(Controller.VMLThreadCount));
    Add('IPP acceleration (double) = ' +  {$IFDEF IPPDLL_DOUBLE} 'ON' {$ELSE} 'OFF' {$ENDIF});
    Add('IPP acceleration (single) = ' +  {$IFDEF IPPDLL_SINGLE} 'ON' {$ELSE} 'OFF' {$ENDIF});
    Add('LAPACK acceleration (double) = ' +  {$IFDEF MKLDLL_DOUBLE} 'ON' {$ELSE} 'OFF' {$ENDIF});
    Add('LAPACK acceleration (single) = ' +  {$IFDEF MKLDLL_SINGLE} 'ON' {$ELSE} 'OFF' {$ENDIF});
    Add('FFT acceleration (single and double) = ' +  {$IFDEF FFTDLL} 'ON' {$ELSE} 'OFF' {$ENDIF});
    Add('VML acceleration (double) = ' +  {$IFDEF VMLDLL_DOUBLE} 'ON' {$ELSE} 'OFF' {$ENDIF});
    Add('VML acceleration (single) = ' +  {$IFDEF VMLDLL_SINGLE} 'ON' {$ELSE} 'OFF' {$ENDIF});
    Add('Random Gen acceleration (single and double) = ' +  {$IFDEF RNDDLL} 'ON' {$ELSE} 'OFF' {$ENDIF});
    Add('MtxVec Block Size (double) = ' + IntToStr(Math387.MtxVecBlockSize));
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;

    {$IFDEF IPPDLL_ANY}
    Add('');
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('Enabled CPU support');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;

    aMask := ippGetEnabledCpuFeatures;
    if (aMask and ippsplTypes.ippCPUID_MMX) <> 0 then Add('MMX');
    if (aMask and ippsplTypes.ippCPUID_SSE) <> 0 then Add('SSE');
    if (aMask and ippsplTypes.ippCPUID_SSE2) <> 0 then Add('SSE2');
    if (aMask and ippsplTypes.ippCPUID_SSSE3) <> 0 then Add('SSSE3');
    if (aMask and ippsplTypes.ippCPUID_SSE42) <> 0 then Add('SSE42');
    if (aMask and ippsplTypes.ippCPUID_AVX) <> 0 then Add('AVX');
    if (aMask and ippsplTypes.ippCPUID_AVX2) <> 0 then Add('AVX2');
    if (aMask and ippsplTypes.ippCPUID_AVX512F) <> 0 then Add('AVX512F');
    if (aMask and ippsplTypes.ippCPUID_AVX512CD) <> 0 then Add('AVX512CD');
    if (aMask and ippsplTypes.ippCPUID_AVX512BW) <> 0 then Add('AVX512BW');
    if (aMask and ippsplTypes.ippCPUID_AVX512DQ) <> 0 then Add('AVX512DQ');
//    if (aMask and ippsplTypes.ippCPUID_AVX512PF) <> 0 then Add('AVX512PF');
//    if (aMask and ippsplTypes.ippCPUID_AVX512ER) <> 0 then Add('AVX512ER');
//    if (aMask and ippsplTypes.ippCPUID_AVX512VL) <> 0 then Add('AVX512VL');

    ippGetCpuFeatures(bMask, nil);

    if bMask <> aMask then ShowMessage('Warning: The CPU features enabled do not match the CPU features available!');

    {$ENDIF}

    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
  end;
end;

initialization
  RegisterClass(TIntroduction);
end.

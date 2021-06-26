unit IntroOpenCL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TIntroOpenCLForm = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
                                                                     
var
  IntroOpenCLForm: TIntroOpenCLForm;

implementation

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TIntroOpenCLForm.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('Open CL features:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Open CL is a standard designed to make it easier to write ' +
         'high-performance code for GPU/CPU devices and make that ' +
         'code portable across different GPU and CPU devices');
    Add('Cross-platform support. Same code is to run on embedded devices (like mobile phones), desktop PCs and super computers across a wide range of operating systems.');
    Add('Support for both ATI and Nvidia GPUs.');
    Add('Support for CPU devices. There exists a great opportunity that an extended Open CL will become the main target for accelerated code running on CPUs. Both Intel and AMD currently offer their own drivers for Open CL code to run on CPUs.');
    Add('Dynamic code compilation. The compiler is included with the ' +
        'drivers and the code is compiled only for the target device. ' +
        'End users running applications have the possibility to specify expressions which (through the Open CL) can run on GPU or be compiled in to native CPU code.');
    Add('Open CL drivers are free for all supported platforms and included with drivers for the hardware.');
    Add('End user application can be distributed without any dlls.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('Features of Cougar Open CL:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Open CL based numerical library for Delphi and C++Builder users.');
    Add('Uses dynamic Open CL dll loading and can be included in end user applications possibly running on machines without Open CL drivers.');
    Add('Automatically detects all platforms (Intel, AMD, NVidia) and devices and loads their parameters.');
    Add('Provides routines to store encrypted source code in to .res resource files that are embedded in to the final application.');
    Add('Caches binaries compiled on the first run for subsequent faster load times.');
    Add('Automatically detects changes to the hardware or Open CL driver versions and rebuilds the cached binaries.');
    Add('Loads all the kernels (functions) present in the Open CL source code, including their properties.');
    Add('Implements a shared context between CPU and GPU devices for more efficient heterogeneous computing. (one context per platform)');
    Add('Allows build options and source headers to be specified at program load time optionally requesting unconditional recompile.');
    Add('Can automatically detect the fastest device in the system and have the code running on it.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('MtxVec for Open CL:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Implements all standard math functions');
    Add('Support for real and complex numbers across all functions (where applicable)');
    Add('Makes use of object cache concept known from MtxVec for faster memory handling and higher performance.');
    Add('Implements separate kernels for CPU and GPU devices to achieve best performance on both architectures.');
    Add('Can run in single and double precision concurrently.');
    Add('Integrated debugger support for debugger visualizers allows GPU code debugging as if it would be running on the CPU.');
    Add('Delivers over 500 unique kernels. When considering also single/double and CPU/GPU variants, it is well over 2000.');
    Add('Full support for operator overloading.');
    Add('Supports multiple automatic code fall-back scenarios. ' +
        'Even when no Open CL driver is detected, the code will still run. ' +
        'When not using Open CL it can run with Delphi code only without external dlls or with native MtxVec using Intel IPP and MKL performance libraries. When native MtxVec is found to be faster than Open CL, it will automatically default to it.');
    Add('Supports execution of “micro” kernels. Micro kernels are short functions which could normally not be accelerated with Open CL.');
    Add('The performance penalty for micro-kernels is estimated at 50% of peak performance for GPU devices. This comes however with the benefit of utter simplicity of code writing and debugging with programmers productivity matching the work on CPU.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

  end;
end;

initialization
   RegisterClass(TIntroOpenCLForm);

end.

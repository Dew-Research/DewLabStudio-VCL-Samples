unit QuickS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls, MtxExprInt;

type
  TQStart = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure VisualizerTests;
  end;

var
  QStart: TQStart;

implementation

uses MtxExpr, MtxVec, MtxVecInt, Math387, AbstractMtxVec;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}



procedure TQStart.FormCreate(Sender: TObject);
var St: String;
begin
  inherited;

  VisualizerTests;

  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('Quick start: Computing a frequency spectrum.');
    Add('Using MtxVec routines is a peace of cake. Now you can perform complex numeric tasks with only few function calls:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Start a new project.');
    Add('Place one TChart component ("Additional" panel) on the panel and one Button ("Standard" panel)');
    Add('Double click on the TChart component and click the Add button and the select the Fast Line seires. Press Close;');
    Add('Move cursor to the top of the unit and add MtxExpr and MtxVecTee to the uses clause.');
    Add('Double click the Button.');
    Add('Insert the following code:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');
    St := 'procedure TForm1.Button1Click(Sender: TObject);'+#13
      +'var y,x,spec: Vector;'+#13+'begin'+#13
      +'  { Please include the full path of the file.}'+#13
      +'  { The file is included with the MtxVec BasicDemo }'+#13
      +'  { distribution and has 8000 values only. }'+#13
      +'  y.LoadFromFile(''C:\MtxVecDemo\FFTData.vec'');'+#13
      +'  y.Resize(1024);'+#13+'  x.FFT(y);'+#13
      +'  spec.Mag(x);'+#13+'  DrawValues(spec,Series1);'+#13
      +'end;';
    SelAttributes.Name := 'Courier New';
    Add(st);
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('F9 to compile and press Button1.');
    Add('should be looking at the frequency spectra displaying one series of harmonics.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');
    Add('Things to try:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Change the 1024 value to some other values that are power of two. (512 or 2048).');
    Add('Use TAreaSeries chart series.');
    Add('Make the spectra logarithmic in the amplitude (use the Log10 method).');
    Add('Save spectra to a file, then load it and draw to the chart with DrawValues.');
    Add('Replace DrawValues(spec,Series1) with ViewValues(spec) and then try ViewValues(x). Play with the menu options in the displayed form.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');
  end;
end;

procedure TQStart.VisualizerTests;
var a: Vector;
    av: TVec;
    b: Matrix;
    bv: TMtx;
    ai: VectorInt;
    aiv: TVecInt;
    bi: MatrixInt;
    biv: TMtxInt;

    ad: TDoubleArray;
    air: TIntegerArray;
    air16: TSmallIntArray;
    air8: TByteArray;

    a2d: T2DDoubleArray;
begin
    a.Size(10);
    a.Ramp;
    av := a;
    ad := av.Values;
    ad := nil;

    SetLength(a2d, 2);
    SetLength(a2d[0], 3);
    SetLength(a2d[1], 3);

    b.Size(5,2);
    b.Copy(a);
    bv := b;
    bv.SetVal(1);

    ai.Size(10);
    aiv := ai;
    air := aiv.IValues1D;
    air := nil;

    ai.Size(5, prInt16);
    ai.Ramp;
    air16 := aiv.SValues;
    air16 := nil;

    ai.Size(5, prInt8);
    ai.Ramp;
    air8 := aiv.BValues;
    air8 := nil;

    bi.Size(5,1);
    bi.Copy(ai);
    biv := bi;
    biv.SetVal(1);

    bi.Size(5,1, prInt16);
    bi.Copy(ai);

    bi.Size(5,1, prInt8);
    ai.Reverse();
    bi.Copy(ai);
end;

initialization
   RegisterClass(TQStart);

end.

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Series, TeEngine, ExtCtrls, TeeProcs, Chart, SignalToolsTee;

type
  TForm1 = class(TForm)
    SpectrumChart1: TSpectrumChart;
    Series1: TFastLineSeries;
    Series2: TPointSeries;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.

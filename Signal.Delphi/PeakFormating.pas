unit PeakFormating;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SpectrumFormTemplate, TeeEdit, SignalToolsDialogs, SpectrumAna,
  MtxBaseComp, SignalTools, SignalAnalysis, StdCtrls, ComCtrls, ToolWin,
  ExtCtrls, TeEngine, TeeTools, SignalToolsTee, Series, TeeProcs, Chart;

type
  TPeakFormatingForm = class(TSpectrumForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PeakFormatingForm: TPeakFormatingForm;

implementation

{$R *.dfm}

initialization
   RegisterClass(TPeakFormatingForm);

end.

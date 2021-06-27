unit PeakMarking;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SpectrumFormTemplate, TeeEdit, SignalToolsDialogs, SpectrumAna,
  MtxBaseComp, SignalTools, SignalAnalysis, StdCtrls, ComCtrls, ToolWin,
  ExtCtrls, TeEngine, Series, TeeProcs, Chart, SignalToolsTee, FileSignal,
  TeeTools;

type
  TPeakMarkingForm = class(TSpectrumForm)
    SignalRead1: TSignalRead;
    procedure FormCreate(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Loaded; override;  
    { Public declarations }
  end;

var
  PeakMarkingForm: TPeakMarkingForm;

implementation

{$R *.dfm}

procedure TPeakMarkingForm.FormCreate(Sender: TObject);
begin
  inherited;
  SpectrumAnalyzer.Pull;  
  With RichEdit1.Lines, RichEdit1 do
  begin
      Clear;
      Add('To test peak marking features try the following: ');
      Paragraph.FirstIndent := 10;
      Paragraph.Numbering := nsBullet;
      Add('Move cursor left and right.');
      Add('Click with left mouse button on peaks.');
      Add('Double click with left mouse button to delete all marked peaks.');
      Paragraph.FirstIndent := 0;
      Paragraph.Numbering := nsNone;
  end;
end;

procedure TPeakMarkingForm.Loaded;
begin

end;

procedure TPeakMarkingForm.SpectrumAnalyzerParameterUpdate(
  Sender: TObject);
begin
  inherited;
  SpectrumAnalyzer.Update;
end;

end.

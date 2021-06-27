unit Basic_Chart;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_Form, StdCtrls, ExtCtrls, TeeProcs, TeEngine, Chart, TeeTools,
  TeeGDIPlus;

type
  TfrmBasicChart = class(TfrmBasic)
    Chart1: TChart;
    Panel2: TPanel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBasicChart: TfrmBasicChart;

implementation

Uses EditChar;
{$R *.DFM}

procedure TfrmBasicChart.Button1Click(Sender: TObject);
begin
  EditChart(Self,Chart1);
end;

end.

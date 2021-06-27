unit SCC_XBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_Form, TeeProcs, TeEngine, Chart, StdCtrls, ExtCtrls, Grids,
  TeCanvas, TeePenDlg, Series, StatSeries;

type
  TfrmXBarSeries = class(TfrmBasic)
    Chart1: TChart;
    Panel2: TPanel;
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    RadioGroup1: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure RadioGroup1Click(Sender: TObject);
  private
    { Private declarations }
    procedure SetupData(const ARows,ACols: Integer);
  public
    { Public declarations }
  end;

var
  frmXBarSeries: TfrmXBarSeries;

implementation

Uses EditChar, StatSPCSeriesEdit, StatAxisLabelToolEdit;

{$R *.DFM}

procedure TfrmXBarSeries.FormCreate(Sender: TObject);
begin
  inherited;
  With Memo1.Lines do
  begin
    Clear;
    Add('Statistical control charts : XBar plot and S-Plot series');
    Add(chr(13));
    Add('XBar and SPlot series come with a fully customized series editor. '+
        ' Try clicking on "Edit Series" button...');
  end;
  { add sample data }
  SetupData(10,5);
end;

procedure TfrmXBarSeries.Button1Click(Sender: TObject);
begin
  EditSeries(Self,Series1);
end;

procedure TfrmXBarSeries.SetupData(const ARows, ACols: Integer);
begin
  with Series1.Data do
  begin
    Size(ARows,ACols);
    RandGauss(0,0.1);
    StringGrid1.RowCount := Rows + 1;
    StringGrid1.ColCount := Cols + 1;
    ValuesToGrid(StringGrid1,0,0,'0.0000',true);
  end;
  Series1.Recalc;
end;

procedure TfrmXBarSeries.Button2Click(Sender: TObject);
var NRows, NCols: Integer;
    ResString : String;
begin
    ResString := InputBox('Replicates','Number of replicates : ','10');
    try
      NRows := StrToInt(ResString);
    except
      NRows := 10;
    end;
    ResString := InputBox('Points per observation','Number of points per observation: ','5');
    try
      NCols := StrToInt(ResString);
    except
      NCols := 5;
    end;
    SetupData(NRows,NCols);
    Button3.Enabled := false;
end;

procedure TfrmXBarSeries.Button3Click(Sender: TObject);
begin
  Series1.Data.GridToValues(StringGrid1,0,0,true);
  Series1.Recalc;
  Button3.Enabled := false;
end;

procedure TfrmXBarSeries.StringGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  Button3.Enabled := true;
end;

procedure TfrmXBarSeries.RadioGroup1Click(Sender: TObject);
var tmp: TChartSeries;
begin
  tmp := Series1;
  case RadioGroup1.ItemIndex of
    0 : begin
          ChangeSeriesType(tmp,TChartSeriesClass(TStatXBarSeries));
          Chart1.Title.Text.Clear;
          Chart1.Title.Text.Add('XBar plot ');
        end;
    1 : begin
          ChangeSeriesType(tmp,TChartSeriesClass(TStatSSeries));
          Chart1.Title.Text.Clear;
          Chart1.Title.Text.Add('S Chart plot ');
        end;
  end;
  Series1.Recalc;
end;

initialization
  RegisterClass(TfrmXBarSeries);

end.

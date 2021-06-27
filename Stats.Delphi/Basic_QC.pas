unit Basic_QC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_Form, StdCtrls, TeEngine, Series, StatSeries, TeeProcs, Chart,
  ExtCtrls, MtxVec, Math387, ComCtrls, TeeTools;

type
  TfrmBasicQC = class(TfrmBasic)
    Chart1: TChart;
    Panel2: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    GridBandTool1: TGridBandTool;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure Recalculate; virtual;
  public
    Series1: TQCSeries;
    Data : TMtx;
    DrawVec: TVec;
    DeltaInt : double;
    Confidence: double;
    { Public declarations }
  end;

var
  frmBasicQC: TfrmBasicQC;

implementation

Uses EditChar, StatQCSeriesEdit, MtxVecEdit;
{$R *.DFM}

procedure TfrmBasicQC.Button1Click(Sender: TObject);
begin
  EditSeries(Self,Series1);
end;

procedure TfrmBasicQC.Button2Click(Sender: TObject);
begin
  ViewValues(Data,Data.Caption,True,False);
  Recalculate;
end;

procedure TfrmBasicQC.FormCreate(Sender: TObject);
begin
  inherited;
  Data := TMtx.Create;
  DrawVec := TVec.Create;
  Edit1.Text := FormatFloat('0.00',99.8);
  Confidence := 99.8;
  { Setup QC series and it's properties }
  Series1 := TQCSeries.Create(Chart1);
  Series1.SeriesColor := clBlue;
  Series1.ColorEachLine := False;
  Series1.ColorEachPoint := True;
  Series1.LinePen.Width := 2;
  With Series1.Pointer do
  begin
    Style := psTriangle;
    VertSize := 3;
    HorizSize := 3;
  end;
  With Series1.ControlLimitPen do
  begin
    Style := psDash;
    Color := clRed;
  end;
  With Series1.CLPen do
  begin
    Color := clBlue;
    Style := psDash;
  end;
  Series1.ParentChart := Chart1;
end;

procedure TfrmBasicQC.FormDestroy(Sender: TObject);
begin
  Series1.ParentChart := nil;
  Series1.Free;
  Data.Free;
  DrawVec.Free;
  inherited;
end;

procedure TfrmBasicQC.Recalculate;
var i,j: Integer;
begin
  With Chart1 do
  begin
    AutoRepaint := False;
    for i := 0 to SeriesCount-1 do
      if Series[i] is TQCSeries then
      With (Series[i] as TQCSeries) do
        for j := 0 to Count-1 do
          if (YValues[j]<UCL) and (YValues[j]>LCL) then ValueColor[j] := SeriesColor
          else ValueColor[j] := clRed;
    AutoRepaint := True;
    Repaint;
  end;
end;

procedure TfrmBasicQC.Edit1Change(Sender: TObject);
begin
  if (Showing) and (Edit1.Text <> '') then
  begin
    try
      Confidence := StrToFloat(Edit1.Text);
    except
      Confidence := 99.8;
    end;
    Recalculate;
  end;
end;

end.

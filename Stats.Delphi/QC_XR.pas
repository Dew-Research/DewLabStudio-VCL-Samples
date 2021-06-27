unit QC_XR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_QC, StdCtrls, TeEngine, Series, StatSeries, TeeProcs, Chart,
  ExtCtrls, ComCtrls, MtxVec, TeeTools;

type
  TfrmQCXR = class(TfrmBasicQC)
    RadioGroup1: TRadioGroup;
    procedure FormDestroy(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Series1GetMarkText(Sender: TChartSeries; ValueIndex: Integer;
      var MarkText: String);
  private
    { Private declarations }
    tmpVec: TVec;
  protected                                                
    procedure Recalculate; override;
  public
    { Public declarations }
  end;

var
  frmQCXR: TfrmQCXR;

implementation

Uses MtxVecTee, Statistics, Probabilities, Math387, StatControlCharts;
{$R *.DFM}

procedure TfrmQCXR.Recalculate;
var CL, UCL, LCL: double;
begin
  Case RadioGroup1.ItemIndex of
  0:  begin { X Chart }
        QCXChart(Data,DrawVec,CL,UCL,LCL,Confidence*0.01);
        Chart1.Title.Text.Strings[0] := '<X> Chart';
      end;
  1:  begin { R Chart }
        QCRChart(Data,DrawVec,CL,UCL,LCL,Confidence*0.01);
        Chart1.Title.Text.Strings[0] := 'R Chart';
      end;
  2:  begin { S Chart }
        QCSChart(Data,DrawVec,CL,UCL,LCL,Confidence*0.01);
        Chart1.Title.Text.Strings[0] := 'S Chart';
      end;
  end;
  Series1.CL := CL;
  Series1.LCL := LCL;
  Series1.UCL := UCL;
  DrawValues(DrawVec,Series1);
  inherited;
end;

procedure TfrmQCXR.RadioGroup1Click(Sender: TObject);
begin
  Recalculate;
end;

procedure TfrmQCXR.FormCreate(Sender: TObject);
begin
  inherited;
  tmpVec := TVec.Create;
  With Memo1.Lines do
  begin
    Clear;
    Add('By using TQCSeries you can easily plot all Quality Control Charts.');
    Add(' This example shows you how to construct <X>, R and S Variable Control Charts' +
        ' Most TQCSeries properties are fuly customizable. To change them , click on the "Edit Series" button.');
  end;

  { load prepared data }
  try
    Data.LoadFromFile('QC_XR.mtx');
  except
  end;
end;

procedure TfrmQCXR.FormDestroy(Sender: TObject);
begin
  tmpVec.Free;
  inherited;
end;

procedure TfrmQCXR.FormShow(Sender: TObject);
begin
  inherited;
  RadioGroup1Click(RadioGroup1);
end;

procedure TfrmQCXR.Series1GetMarkText(Sender: TChartSeries;
  ValueIndex: Integer; var MarkText: String);
begin
  inherited;
  if (Sender.YValue[ValueIndex]>TQCSeries(Sender).UCL)
  or (Sender.YValue[ValueIndex]<TQCSeries(Sender).LCL) then MarkText := IntToStr(ValueIndex)
  else MarkText := '';
end;

initialization
  RegisterClass(TfrmQCXR);

end.

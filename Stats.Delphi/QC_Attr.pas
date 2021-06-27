unit QC_Attr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_QC, StdCtrls, TeEngine, Series, StatSeries, TeeProcs, Chart,
  ExtCtrls, Math387, MtxVec, TeeTools;

type
  TfrmQCAttr = class(TfrmBasicQC)
    Label2: TLabel;
    RadioGroup1: TRadioGroup;
    Label3: TLabel;
    Edit2: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Series1GetMarkText(Sender: TChartSeries; ValueIndex: Integer;
      var MarkText: String);
  private
    { Private declarations }
    DataVec: TVec;
    SampleSize: Integer;
  protected
    procedure Recalculate; override;
  public
    { Public declarations }
  end;

var
  frmQCAttr: TfrmQCAttr;

implementation

Uses MtxVecEdit, MtxVecTee, StatControlCharts;
{$R *.DFM}

procedure TfrmQCAttr.Button2Click(Sender: TObject);
begin
  ViewValues(DataVec,'Data vector',True,False);
end;

procedure TfrmQCAttr.FormCreate(Sender: TObject);
begin
  inherited;
  DataVec := TVec.Create;
  With Memo1.Lines do
  begin
    Clear;
    Add('By using TQCSeries you can easily plot Attribute Quality Control Charts.');
    Add(' This example shows you how to construct P and U Attribute Control Charts' +
        ' Data comes from 20 samples, each of size 100. Most TQCSeries properties'+
        ' are fuly customizable. To change them , click on the "Edit Series" button.');
  end;

  { load prepared data }
  try
    DataVec.LoadFromFile('QC_Attribute.vec');
  except
  end;
  SampleSize := 100;
end;

procedure TfrmQCAttr.FormDestroy(Sender: TObject);
begin
  DataVec.Destroy;
  inherited;
end;

procedure TfrmQCAttr.Edit2Change(Sender: TObject);
begin
  If Showing and (Edit2.Text <> '') then
  begin
    SampleSize := StrToInt(Edit2.Text);
    Recalculate;
  end;
end;

procedure TfrmQCAttr.Recalculate;
var CL, UCL, LCL : double;
begin
  Case RadioGroup1.ItemIndex of
  0:  begin { P Chart }
        QCPChart(DataVec,SampleSize,DrawVec,CL,UCL,LCL,Confidence*0.01);
        Chart1.Title.Text.Strings[0] := 'P Chart';
      end;
  1:  begin { NP Chart }
        QCNPChart(DataVec,SampleSize,DrawVec,CL,UCL,LCL,Confidence*0.01);
        Chart1.Title.Text.Strings[0] := 'NP Chart';
      end;
  2:  begin { U Chart }
        QCUChart(DataVec,SampleSize,DrawVec,CL,UCL,LCL,Confidence*0.01);
        Chart1.Title.Text.Strings[0] := 'U Chart';
      end;
  3:  begin { C Chart }
        QCCChart(DataVec,DrawVec,CL,UCL,LCL,Confidence*0.01);
        Chart1.Title.Text.Strings[0] := 'C Chart';
      end;
  end;
  Series1.CL := CL;
  Series1.LCL := LCL;
  Series1.UCL := UCL;
  DrawValues(DrawVec,Series1);
  inherited;
end;

procedure TfrmQCAttr.RadioGroup1Click(Sender: TObject);
begin
  Recalculate;
end;

procedure TfrmQCAttr.FormShow(Sender: TObject);
begin
  inherited;
  Edit2.Text := IntToStr(SampleSize);
  RadioGroup1Click(Self);
end;

procedure TfrmQCAttr.Series1GetMarkText(Sender: TChartSeries;
  ValueIndex: Integer; var MarkText: String);
begin
  inherited;
  if (Sender.YValue[ValueIndex]>TQCSeries(Sender).UCL)
  or (Sender.YValue[ValueIndex]<TQCSeries(Sender).LCL) then MarkText := IntToStr(ValueIndex)
  else MarkText := '';
end;

initialization
  RegisterClass(TfrmQCAttr);

end.

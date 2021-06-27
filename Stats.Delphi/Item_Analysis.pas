unit Item_Analysis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Basic_Form, StdCtrls, ExtCtrls, ComCtrls, MtxVec, Math387, Statistics;

type
  TfrmItemAnalysis = class(TfrmBasic)
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Button2: TButton;
    RichEdit1: TRichEdit;
    CheckBox3: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    Data: TMtx;
    m1: TMtx;
    v1: TVec;
    FormatString: String;
    procedure UpdateGUI;
    procedure ReliabilityReport;
    procedure CovReport;
    procedure CorrReport;
    procedure CountDistReport;
    procedure DetailsReport;
    procedure TextReport;
    procedure ItemDetailReport(ItemData: TVec; Vars: TVec; wrk1: TVec);
  public
    { Public declarations }
  end;

var
  frmItemAnalysis: TfrmItemAnalysis;

implementation

{$R *.dfm}

Uses MtxVecEdit, AbstractMtxVec, Types;

procedure TfrmItemAnalysis.Button1Click(Sender: TObject);
begin
    ViewValues(Data,'Item data',true,false,true);
    UpdateGUI;
end;

procedure TfrmItemAnalysis.ReliabilityReport;
var i: Integer;
    st: String;
begin
  RichEdit1.SelAttributes.Style := [fsBold,fsUnderline];
  RichEdit1.Lines.Add('Reliability');
  RichEdit1.Lines.Add('');
  RichEdit1.SelAttributes.Color := clBlue;
  RichEdit1.Lines.Add(#9+#9+#9+'Mean if'+#9+'StdDev if'+#9+'Alpha if');
  RichEdit1.SelAttributes.Color := clBlue;
  RichEdit1.Lines.Add('Column'+#9+'Mean'+#9+'StdDev'+#9+'deleted'+#9+'deleted'+#9+'deleted');
  for i := 0 to Data.Cols -1 do
  begin
    v1.GetCol(Data,i);
    st := IntToStr(i)+#9+FormatSample(FormatString,v1.Mean)+#9+FormatSample(FormatString,v1.StdDev)+#9;
    // Do stats on the remaining data
    RemoveColumn(Data,m1,i);
    // Total sum (without ommited item)
    m1.MeanCols(v1);
    st := st + FormatSample(FormatString,v1.Sum)+#9;
    // Total standard deviation (without ommited item)
    st := st + FormatSample(FormatString,m1.StdDev)+#9;

    st := st + FormatSample(FormatString,CronbachAlpha(m1))+#9;
    RichEdit1.Lines.Add(st);
  end;
  RichEdit1.Lines.Add('');
  // Regular Cronbach Alpha
  RichEdit1.Lines.Add('Cronbach alpha:'+FormatSample(FormatString,CronbachAlpha(Data)));
  // Z-scored Cronbach Alpha
  m1.ZScore(Data);
  RichEdit1.Lines.Add('Standardized Cronbach alpha:'+FormatSample(FormatString,CronbachAlpha(m1)));
  RichEdit1.Lines.Add('');
end;

procedure TfrmItemAnalysis.CovReport;
var cov: TMtx;
begin
  RichEdit1.SelAttributes.Style := [fsBold,fsUnderline];
  RichEdit1.Lines.Add('Covariances');
  CreateIt(cov);
  try
    Covariance(Data,cov,false);
    cov.ValuesToStrings(RichEdit1.Lines,Chr(9),ftaNone,FormatString);
    RichEdit1.Lines.Add(Chr(13));
  finally
    FreeIt(cov);
  end;
  Richedit1.Lines.Add('Cells represent covariances between pairs of items.');
  Richedit1.Lines.Add('');
end;

procedure TfrmItemAnalysis.TextReport;
begin
  RichEdit1.Lines.Clear;
  if (checkBox1.Checked) then ReliabilityReport;
  if (checkBox2.Checked) then CountDistReport;
  if (checkBox3.Checked) then DetailsReport;
  if (checkBox4.Checked) then CorrReport;
  if (checkBox5.Checked) then CovReport;
end;

procedure TfrmItemAnalysis.UpdateGUI;
begin
  Label1.Caption := 'Rows: '+IntToStr(Data.Rows);
  Label2.Caption := 'Items: ' +IntToStr(Data.Cols);
end;

procedure TfrmItemAnalysis.FormCreate(Sender: TObject);
begin
  inherited;
  Data := TMtx.Create;
  m1 := TMtx.Create;
  v1 := TVec.Create;

  FormatString := '0.0000';

  // Pre-define test data, 16 questions with 4 items each
  Data.SetIt(16,4,false,[
	1, 3,	2, 1,
	2, 2, 2, 3,
	1, 3,	2, 2,
	3, 3,	3, 3,
	1, 1, 2, 2,
	3, 3, 3, 1,
	2, 2, 1, 2,
	1, 1, 2, 1,
	1, 3,	1, 2,
	1, 1,	2, 2,
	5, 3,	2, 2,
	1, 1,	2, 1,
	1, 3,	2, 2,
	1, 3,	3, 1,
	1, 3,	2, 1,
	1, 3,	1, 1]);

  With Memo1.Lines do
  begin
    Clear;
    Add('Item Analysis');
    Add('');
    Add('Item analysis studies the internal reliability of a particular object. This object usually consists '
      + 'of several items which are answered by a group of respondents. Issues that arise include whether the '
      + 'object measures what was intended, whether it produces the same results when it is administered '
      + 'repeatedly, whether it contains cultural biases, and so on.');
    Add('');
    Add('This example performs item analysis on collected data. In the example 16 subject answered 4 items questionare.');
  end;
end;

procedure TfrmItemAnalysis.FormDestroy(Sender: TObject);
begin
  Data.Destroy;
  m1.Destroy;
  v1.Destroy;
  inherited;
end;

procedure TfrmItemAnalysis.FormShow(Sender: TObject);
begin
  inherited;
  UpdateGUI;
end;

procedure TfrmItemAnalysis.Button2Click(Sender: TObject);
begin
  TextReport;
end;

procedure TfrmItemAnalysis.CorrReport;
var corr: TMtx;
begin
  RichEdit1.SelAttributes.Style := [fsBold,fsUnderline];
  RichEdit1.Lines.Add('Correlation');
  CreateIt(corr);
  try
    CorrCoef(Data,corr);
    corr.ValuesToStrings(RichEdit1.Lines,Chr(9),ftaNone,FormatString);
    RichEdit1.Lines.Add(Chr(13));
  finally
    FreeIt(corr);
  end;
  Richedit1.Lines.Add('Cells represent correlations between pairs of items.');
  Richedit1.Lines.Add('');
end;

procedure TfrmItemAnalysis.CountDistReport;
var vars,wrk1,wrk2: TVec;
  i,j: Integer;
  st: String;
begin
  RichEdit1.SelAttributes.Style := [fsBold,fsUnderline];
  RichEdit1.Lines.Add('Distribution Count');
  CreateIt(vars,wrk1,wrk2);
  try
    Unique(Data,vars);
    st := 'Variable'+#9;
    for i := 0 to vars.Length -1 do st := st + FormatSample('0.0',vars[i])+#9;
    RichEdit1.SelAttributes.Color := clBlue;
    RichEdit1.Lines.Add(st);

    for i := 0 to Data.Cols -1 do
    begin
      wrk1.GetCol(Data,i);
      st := 'Column '+IntToStr(i)+#9;
      for j := 0 to vars.Length -1 do
      begin
        wrk2.FindAndGather(wrk1,'=',vars[j]);
        st := st + IntToStr(wrk2.Length)+#9;
      end;
      RichEdit1.Lines.Add(st);
    end;
    st := 'Total'+#9;
    for j := 0 to vars.Length -1 do
    begin
      wrk2.FindAndGather(Data,'=',vars[j]);
      st := st + IntToStr(wrk2.Length)+#9;
    end;

    Richedit1.Lines.Add(st);
  finally
    FreeIt(vars,wrk1,wrk2);
  end;
  Richedit1.Lines.Add('');
end;

procedure TfrmItemAnalysis.ItemDetailReport(ItemData, Vars: TVec; wrk1: TVec);
var i: Integer;
  st: String;
  total: Integer;
begin
  total := 0;
  for i := 0 to vars.Length -1 do
  begin
    // wrk1.Length is count
    wrk1.FindAndGather(ItemData,'=',vars[i]);
    total := total + wrk1.Length;
    st := FormatSample('0.0',vars[i])+#9 +IntToStr(wrk1.Length)+#9;
    st := st + FormatSample('0.0%',100*wrk1.Length/ItemData.Length)+#9;
    st := st + FormatSample('0.0%',100*total/ItemData.Length);
    RichEdit1.Lines.Add(st);
  end;
  RichEdit1.Lines.Add('Total'+#9+IntToStr(ItemData.Length));
end;

procedure TfrmItemAnalysis.DetailsReport;
var i: Integer;
  vars,wrk1,wrk2: TVec;
begin
  RichEdit1.SelAttributes.Style := [fsBold,fsUnderline];
  RichEdit1.Lines.Add('Item details');
  CreateIt(wrk1,wrk2,vars);
  try
    Unique(Data,vars); // get unique values for variables

    for i := 0 to Data.Cols -1 do
    begin
      wrk1.GetCol(Data,i);
      RichEdit1.Lines.Add('Details for column '+IntToStr(i));
      RichEdit1.SelAttributes.Color := clBlue;
      RichEdit1.Lines.Add('Value'+#9+'Count'+#9+'Pct.'+#9+'Cumulative pct.');
      ItemDetailReport(wrk1,vars,wrk2);
      RichEdit1.Lines.Add('');
    end;

    RichEdit1.Lines.Add('');
  finally
    FreeIt(wrk1,wrk2,vars);
  end;
end;

initialization
  RegisterClass(TfrmItemAnalysis);

end.

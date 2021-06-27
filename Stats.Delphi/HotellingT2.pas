unit HotellingT2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Basic_Wizard, ComCtrls, StdCtrls, ExtCtrls, MtxVec,
  Statistics, Math387;

type
  TfrmHotellingWizard = class(TfrmBasicWizard)
    tsInputData: TTabSheet;
    tsTextReport: TTabSheet;
    RichEdit: TRichEdit;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    GroupBox1: TGroupBox;
    btnEdit1: TButton;
    lblSamples1: TLabel;
    lblVariables1: TLabel;
    GroupBox2: TGroupBox;
    lblSamples2: TLabel;
    lblVariables2: TLabel;
    btnEdit2: TButton;
    btnEditMeans: TButton;
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEdit1Click(Sender: TObject);
    procedure btnEdit2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure btnEditMeansClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Signif, Alpha: double;
    hRes: THypothesisResult;
    T2Total : double;
    procedure TextReport;
    procedure DescriptiveStat(m1: TMtx; m2: TMtx = nil);
    procedure HT2Test(m1: TMtx; m2: TMtx = nil; vmean: TVec = nil);
    procedure InvidualVars(m1: TMtx; m2: TMtx = nil; vmean: TVec = nil);
    procedure BoxTest(m1,m2: TMtx);
    procedure UpdateDisplay;
  protected
    // These two methods control wizard behavoir
    procedure RefreshWizardControls; override;
    procedure DoMoveForward; override;
  public
    { Public declarations }
    X1,X2: TMtx;
    Means: TVec;
    TwoSampleTest: boolean;
    UseMean: boolean;
  end;

var
  frmHotellingWizard: TfrmHotellingWizard;

implementation

Uses MtxVecEdit, AbstractMtxVec, Types;

{$R *.dfm}

procedure TfrmHotellingWizard.DoMoveForward;
begin
  inherited DoMoveForward;
  if (PageControl.ActivePage = tsTextReport) then TextReport;
end;

procedure TfrmHotellingWizard.RefreshWizardControls;
begin
  inherited RefreshWizardControls;
  if PageControl.ActivePage = tsInputData then btnNext.Enabled := ((X1.Length>0) and (TwoSampleTest=false)) or ((X1.Cols>0) and (X1.Cols=X2.Cols));
end;


procedure RemoveVariable(amtx: TMtx; bmtx: TMtx; ameans, bmeans: TVec; index: Integer);
var j,c: Integer;
    v1: TVec;
begin
  CreateIt(v1);
  try
    bmtx.Size(amtx.Rows,amtx.Cols-1,amtx);
    if Assigned(ameans) then bmeans.Size(ameans.Length-1,amtx);
    c := 0;
    for j := 0 to amtx.Cols -1 do
      if j<>index then
      begin
        v1.GetCol(amtx,j);
        bmtx.SetCol(v1,c);
        if Assigned(ameans) then bmeans[c] := ameans[j];
        c := c + 1;
      end;
  finally
    FreeIt(v1);
  end;
end;

procedure TfrmHotellingWizard.TextReport;
begin
  RichEdit.Lines.Clear;
  if TwoSampleTest then
  begin // Two sample
    DescriptiveStat(X1,X2);
    if UseMean then
    begin
      HT2Test(X1,X2,Means);
      InvidualVars(X1,X2,Means);
    end else
    begin
      HT2Test(X1,X2,nil);
      InvidualVars(X1,X2,nil);
    end;
    BoxTest(X1,X2);
  end else
  begin // One sample
    DescriptiveStat(X1,nil);
    if UseMean then
    begin
      HT2Test(X1,nil,Means);
      InvidualVars(X1,nil,Means);
    end else
    begin
      HT2Test(X1,nil,nil);
      InvidualVars(X1,nil,nil);
    end;
  end;
end;

procedure TfrmHotellingWizard.RadioGroup1Click(Sender: TObject);
begin
  TwoSampleTest := RadioGroup1.ItemIndex = 1;
  GroupBox2.Visible := TwoSampletest;
  RefreshWizardControls;
end;

procedure TfrmHotellingWizard.FormCreate(Sender: TObject);
begin
  inherited;
  X1 := TMtx.Create;
  X2 := TMtx.Create;
  Means := TVec.Create;
  TwoSampleTest := False;
  UseMean := True;
  FormatString := '0.000';
end;

procedure TfrmHotellingWizard.btnEdit1Click(Sender: TObject);
begin
  ViewValues(X1,'First dataset',true,false,true);
  Means.Resize(X1.Cols);
  UpdateDisplay;
end;

procedure TfrmHotellingWizard.btnEdit2Click(Sender: TObject);
begin
  ViewValues(X2,'Second dataset',true,false,true);
  UpdateDisplay;
end;

procedure TfrmHotellingWizard.UpdateDisplay;
begin
  if X1.Length > 0 then
  begin
    lblSamples1.Caption := 'Samples:'+IntToStr(X1.Rows);
    lblVariables1.Caption := 'Variables:'+IntToStr(X1.Cols);
  end;

  if X1.Length > 0 then
  begin
    lblSamples2.Caption := 'Samples:'+IntToStr(X2.Rows);
    lblVariables2.Caption := 'Variables:'+IntToStr(X2.Cols);
  end;

  RefreshWizardControls;
end;

procedure TfrmHotellingWizard.FormDestroy(Sender: TObject);
begin
  X1.Destroy;
  X2.Destroy;
  Means.Destroy;
  inherited;
end;

procedure TfrmHotellingWizard.RadioGroup2Click(Sender: TObject);
begin
  UseMean := RadioGroup2.ItemIndex = 1;
  btnEditMeans.Visible := UseMean;
end;

procedure TfrmHotellingWizard.btnEditMeansClick(Sender: TObject);
begin
  ViewValues(Means,'Variable mean values',true,false,true);
end;

// Descriptive statistic report
procedure TfrmHotellingWizard.DescriptiveStat(m1, m2: TMtx);
var v1: TVec;
  i: Integer;
  p: Integer;
  m,std: double;
  st: String;
begin
  RichEdit.SelAttributes.Style := [fsBold,fsUnderline];
  RichEdit.Lines.Add('Descriptive statistics');
  Richedit.Lines.Add('');
  p := X1.Cols; // number of variables
  if Assigned(m2) then SetupTabs(5,RichEdit) else SetupTabs(3,RichEdit);
  CreateIt(v1);
  try
    RichEdit.SelAttributes.Color := clBlue;
    if Assigned(m2) then RichEdit.Lines.Add('Var.'+#9+'Mean(1)'+#9+'Std(1)'+#9+'Mean(2)'+#9+'Std(2)')
    else RichEdit.Lines.Add('Var.'+#9+'Mean'+#9+'Std');

    for i := 0 to p-1 do
    begin
      St := IntToStr(i)+#9;
      v1.GetCol(X1,i);
      m := v1.Mean;
      std := v1.StdDev;
      St := St + FormatSample(FormatString,m)+#9+FormatSample(FormatString,std);
      if Assigned(m2) then
      begin
        v1.GetCol(X2,i);
        m := v1.Mean;
        std := v1.StdDev;
        St := St + #9 + FormatSample(FormatString,m)+#9+FormatSample(FormatString,std);
      end;
      RichEdit.Lines.Add(St);
    end;
    RichEdit.Lines.Add('');
  finally
    FreeIt(v1);
  end;
end;

procedure TfrmHotellingWizard.FormShow(Sender: TObject);
begin
  inherited;
  UpdateDisplay;
end;

// Hotelling T2 test
procedure TfrmHotellingWizard.HT2Test(m1, m2: TMtx; vmean: TVec);
var st: String;
    T2: double;
    df1,df2: Integer;
    v: double;
    v1: TVec;
begin
    RichEdit.SelAttributes.Style := [fsBold,fsUnderline];
    RichEdit.Lines.Add('Hotelling T2 test');
    Richedit.Lines.Add('');
    CreateIt(v1);
    try
      SetupTabs(7,RichEdit);
      RichEdit.SelAttributes.Color := clBlue;
      RichEdit.Lines.Add('Hypothesis'+#9#9+'T2 value'+#9+'Df1'+#9+'Df2'+#9+'Prob.'+#9+'Hyp.result');

      if Assigned(m2) then
      begin
        st := 'Equal covariance matrices'+#9;
        if UseMean then T2 := Statistics.HotellingT2Two(X1,X2,Signif,hRes,v,Means,true,Alpha)
        else T2 := Statistics.HotellingT2Two(X1,X2,Signif,hRes,v,nil,true,Alpha);
        T2Total := T2;
        df1 := X1.Cols;
        df2 := Trunc(v);
        st := st + FormatSample(FormatString,T2)+#9+IntToStr(df1)+#9+IntToStr(df2)+#9+FormatSample(FormatString,Signif);
        if Hres = hrNotReject then st := st+#9+'Accept' else st := st+#9+'Reject';
        RichEdit.Lines.Add(st);
        st := 'Unequal covariance matrices'+#9;
        if UseMean then T2 := Statistics.HotellingT2Two(X1,X2,Signif,hRes,v,Means,false,Alpha)
        else T2 := Statistics.HotellingT2Two(X1,X2,Signif,hRes,v,nil,false,Alpha);
        df1 := X1.Cols;
        st := st + FormatSample(FormatString,T2)+#9+IntToStr(df1)+#9+FormatSample(FormatString,v)+#9+FormatSample(FormatString,Signif);
        if Hres = hrNotReject then st := st+#9+'Accept' else st := st+#9+'Reject';
        RichEdit.Lines.Add(st);

      end else
      begin
        st := 'Means all equal'+#9#9;
        T2 := Statistics.HotellingT2One(X1,nil,Signif,hRes,Alpha);
        df1 := X1.Cols;
        df2 := X1.Rows - 1;
        st := st + FormatSample(FormatString,T2)+#9+IntToStr(df1)+#9+IntToStr(df2)+#9+FormatSample(FormatString,Signif);
        if Hres = hrNotReject then st := st+#9+'Accept' else st := st+#9+'Reject';
        RichEdit.Lines.Add(st);
        if UseMean then
        begin
          st := 'Means equal to Means'+#9;
          T2 := Statistics.HotellingT2One(X1,Means,Signif,hRes,Alpha);
          df1 := X1.Cols;
          df2 := X1.Rows - 1;
          st := st + FormatSample(FormatString,T2)+#9+IntToStr(df1)+#9+IntToStr(df2)+#9+FormatSample(FormatString,Signif);
          if Hres = hrNotReject then st := st+#9+'Accept' else st := st+#9+'Reject';
        end else
        begin
          st := 'Means All equal to zero'+#9;
          v1.Size(X1.Cols);
          v1.SetZero;
          T2 := Statistics.HotellingT2One(X1,v1,Signif,hRes,Alpha);
          df1 := X1.Cols;
          df2 := X1.Rows - 1;
          st := st + FormatSample(FormatString,T2)+#9+IntToStr(df1)+#9+IntToStr(df2)+#9+FormatSample(FormatString,Signif);
          if Hres = hrNotReject then st := st+#9+'Accept' else st := st+#9+'Reject';
        end;
        T2Total := T2;
        RichEdit.Lines.Add(st);
      end;
      RichEdit.Lines.Add('');
    finally
      FreeIt(v1);
    end;
end;

procedure TfrmHotellingWizard.InvidualVars(m1, m2: TMtx; vmean: TVec);
var v1: TVec;
    m3,m4: TMtx;
    i: Integer;
    st: String;
    T2: double;
    v: double;
begin
  RichEdit.SelAttributes.Style := [fsBold,fsUnderline];
  RichEdit.Lines.Add('Individual variables');
  Richedit.Lines.Add('');
  CreateIt(v1);
  CreateIt(m3,m4);
  try
    SetupTabs(7,RichEdit);
    RichEdit.SelAttributes.Color := clBlue;
    RichEdit.Lines.Add('Omitted'+#9+'T2'+#9+'Prob.'+#9+'T2'+#9+'Prob.'+#9+'T2'+#9+'Prob.');
    RichEdit.SelAttributes.Color := clBlue;
    RichEdit.Lines.Add('variable'+#9+'others'+#9+'level'+#9+'change'+#9+'level'+#9+'alone'+#9+'level');
    for i := 0 to m1.Cols -1 do
    begin
      if Assigned(m2) then  // Two sample test
        if UseMean then
        begin
          RemoveVariable(m1,m3,means,v1,i);
          RemoveVariable(m2,m4,means,v1,i);
          T2 := Statistics.HotellingT2Two(m3,m4,Signif,hRes,v,v1,True,Alpha);
        end else
        begin
          RemoveVariable(m1,m3,nil,nil,i);
          RemoveVariable(m2,m4,nil,nil,i);
          T2 := Statistics.HotellingT2Two(m3,m4,Signif,hRes,v,nil,True,Alpha);
        end
      else // One sample test
        if UseMean then
        begin
          RemoveVariable(m1,m3,Means,v1,i);
          T2 := Statistics.HotellingT2One(m3,v1,Signif,hRes,Alpha);
        end else
        begin
          RemoveVariable(m1,m3,nil,nil,i);
          T2 := Statistics.HotellingT2One(m3,nil,Signif,hRes,Alpha);
        end;
      st := IntToStr(i)+#9+FormatSample(FormatString,T2)+#9+FormatSample(FormatString,Signif)+#9;
      st := st +FormatSample(FormatString,T2Total-T2);
      RichEdit.Lines.Add(st);
    end;
    Richedit.Lines.Add('');
  finally
    FreeIt(m3,m4);
    FreeIt(v1);
  end;
end;

procedure TfrmHotellingWizard.BoxTest(m1, m2: TMtx);
var st: String;
  MB: double;
  v1,v2: Integer;
begin
  MB := Statistics.MBoxTest(m1,m2,Signif,hRes,v1,v2,Alpha);
  RichEdit.SelAttributes.Style := [fsBold,fsUnderline];
  RichEdit.Lines.Add('M-Box test for equal covariance matrices');
  Richedit.Lines.Add('');
  SetupTabs(5,RichEdit);
  RichEdit.SelAttributes.Color := clBlue;
  RichEdit.Lines.Add('Statistics'+#9+'df1'+#9+'df2'+#9+'Signif.'+#9+'Hyp.result');
  st := FormatSample(FormatString,MB)+#9+IntToStr(v1)+#9+IntToStr(v2)+#9
    + FormatSample(FormatString,Signif);
  if Hres = hrNotReject then st := st+#9+'Accept' else st := st+#9+'Reject';
  Richedit.Lines.Add(st);
  Richedit.Lines.Add('');
end;


end.

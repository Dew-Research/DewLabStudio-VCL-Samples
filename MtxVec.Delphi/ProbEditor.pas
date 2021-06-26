unit ProbEditor;

interface

{$FINITEFLOAT OFF}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TeeProcs, TeEngine, Chart, ComCtrls, ActnList,
  StdCtrls, DewProbWrapper, Math387, Probabilities;

type
  TFrameDist = class(TFrame)
    Panel1: TPanel;
    ListViewParams: TListView;
    LabelDec: TLabel;
    RadioGroupOut: TRadioGroup;
    GroupBoxRange: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditNumPoints: TEdit;
    EditLB: TEdit;
    EditUB: TEdit;
    UpDown1: TUpDown;
    Panel2: TPanel;
    ListBoxDist: TListBox;
    Panel3: TPanel;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    procedure ListViewParamsDblClick(Sender: TObject);
    procedure ListBoxDistClick(Sender: TObject);
    procedure RadioGroupOutClick(Sender: TObject);
    procedure EditNumPointsChange(Sender: TObject);
    procedure EditLBChange(Sender: TObject);
    procedure EditUBChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    FDistribution: TProbDistribution;
    FFormatString: String;
    { Private declarations }
    procedure SetDistType(DistType:TDistribution; Caption:String);
    procedure RefreshParListView;
    procedure SetDistribution(const Value: TProbDistribution);
    procedure SetFormatString(const Value: String);
  public
    { Public declarations }
    property Distribution: TProbDistribution read FDistribution write SetDistribution;
    property FormatString: String read FFormatString write SetFormatString;
  end;

implementation


{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TFrameDist.ListViewParamsDblClick(Sender: TObject);
var item: TListItem;
    parstr: String;
    par: TProbParameter;
begin
  Item := listViewParams.Selected;
  if Assigned(Item) then
  begin
    par := TProbParameter(item.Data);

    parstr := InputBox('Set parameter '+Item.Caption,'Valid range: ' + Item.SubItems[1]+', '+Item.SubItems[0],Item.SubItems[2]);
    if par.ParameterType = parInteger then
      try
        par.Value := StrToInt(parstr);
        Item.SubItems[2] := parstr;
      except
        raise
      end
    else
      try
        par.Value := StrToFloat(parstr);
        Item.SubItems[2] := parstr;
      except
        raise
      end
  end;
end;

procedure TFrameDist.SetDistType(DistType:TDistribution; Caption:String);
begin
  Distribution.DistType := DistType;
  EditNumPoints.Text := IntToStr(Distribution.NumPoints);
  EditLB.Text := SampleToStr(Distribution.LB);
  EditUB.Text := SampleToStr(Distribution.UB);
  RefreshParListView;
end;

procedure TFrameDist.RefreshParListView;
var i: Integer;
    lItem: TListItem;
begin
  With ListBoxDist do
  begin
    Button2.Enabled := ItemIndex < Items.Count-1;
    Button1.Enabled := ItemIndex > 0;
  end;
  ListViewParams.Items.Clear;
  // Add x
  lItem := ListViewParams.Items.Add;
  lItem.Caption :=  Distribution.X.Name;
  if Distribution.X.ParameterType = parInteger then lItem.SubItems.Add('integer') else lItem.SubItems.Add('real');
  lItem.SubItems.Add(Distribution.X.Notes);
  lItem.SubItems.Add(SampleToStr(Distribution.X.Value));
  lItem.Data := Distribution.X;
  With Distribution do
  begin
    for i := 0 to DistParams.Count - 1 do
    begin
      lItem := ListViewParams.Items.Add;
      lItem.Caption :=  DistParams[i].Name;
      if DistParams[i].ParameterType = parInteger then lItem.SubItems.Add('integer') else lItem.SubItems.Add('real');
      lItem.SubItems.Add(DistParams[i].Notes);
      lItem.SubItems.Add(SampleToStr(DistParams[i].Value));
      lItem.Data := DistParams[i];
    end;
  end;
end;

procedure TFrameDist.SetDistribution(const Value: TProbDistribution);
begin
  if Value<>FDistribution then
  begin
    FDistribution := Value;
    RefreshParListView;
  end;
end;

procedure TFrameDist.ListBoxDistClick(Sender: TObject);
begin
  With Sender as TListBox do
    SetDistType(TDistribution(ItemIndex),Items[ItemIndex]);
end;

procedure TFrameDist.RadioGroupOutClick(Sender: TObject);
begin
  GroupBoxRange.Visible := RadioGroupOut.ItemIndex = 1;
end;

procedure TFrameDist.EditNumPointsChange(Sender: TObject);
var ival: Integer;
begin
  ival := StrToInt(EditNumPoints.Text);
  Distribution.NumPoints := ival;
end;

procedure TFrameDist.EditLBChange(Sender: TObject);
begin
  Distribution.LB := StrToFloat(EditLB.Text);
end;

procedure TFrameDist.EditUBChange(Sender: TObject);
begin
  Distribution.UB := StrToFloat(EditUB.Text);
end;

procedure TFrameDist.Button2Click(Sender: TObject);
begin
  With ListBoxDist do
  begin
    if ItemIndex < Items.Count -1 then
      ItemIndex := ItemIndex + 1;
    SetDistType(TDistribution(ItemIndex),Items[ItemIndex]);
  end;
end;


procedure TFrameDist.Button1Click(Sender: TObject);
begin
  With ListBoxDist do
  begin
    if ItemIndex > 0 then
      ItemIndex := ItemIndex - 1;
    SetDistType(TDistribution(ItemIndex),Items[ItemIndex]);
  end;
end;

procedure TFrameDist.Edit1Change(Sender: TObject);
begin
  FFormatString := Edit1.Text;
end;

procedure TFrameDist.SetFormatString(const Value: String);
begin
  FFormatString := Value;
end;

end.

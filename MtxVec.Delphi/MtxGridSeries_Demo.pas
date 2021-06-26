unit MtxGridSeries_Demo;
{$I BdsppDefs.inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Basic2, StdCtrls, ComCtrls, ExtCtrls, TeeProcs, TeEngine, Chart,
  MtxVec, MtxVecTee, MtxComCtrls, Sparse, MtxExpr, TeCanvas;

type                                               
  TfrmMtxGridSeries = class(TBasicForm2)
    Chart1: TChart;
    Panel4: TPanel;
    CheckBox2: TCheckBox;
    Timer1: TTimer;
    Button2: TButton;
    RadioGroup1: TRadioGroup;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    PaletteBar: TScrollBar;
    Label2: TLabel;
    ThreeColorBox: TCheckBox;
    PixelResampleBox: TCheckBox;
    ColorChart: TChart;
    SharpContrastBox: TCheckBox;
    Splitter1: TSplitter;
    procedure SharpContrastBoxClick(Sender: TObject);
    procedure Chart1AfterDraw(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Chart1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Chart1GetAxisLabel(Sender: TChartAxis; Series: TChartSeries;
      ValueIndex: Integer; var LabelText: String);
    procedure PaletteBarScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure ThreeColorBoxClick(Sender: TObject);
    procedure PixelResampleBoxClick(Sender: TObject);
  private
    { Private declarations }
    A: Matrix;
    v1,v2: Vector;
    SparseA: TSparseMtx;
    procedure UpdateData;
  public
    GridSeries,LegendSeries : TMtxGridSeries;
    procedure UpdateCharts;    
    { Public declarations }
  end;

var
  frmMtxGridSeries: TfrmMtxGridSeries;

implementation

Uses    {$IFNDEF TEESTD}
        EditChar, TeeEdit,
        {$ENDIF}
        MtxGridSerEdit; { <--- add grid series editor to uses clause }

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TfrmMtxGridSeries.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    Add('TMtxGridSeries which can be used '
      + 'with all TeeChart versions (v4 Standard, v4 Pro, 5,6 and 7). '
      + 'Using TMtxGridSeries you can visualize matrix values. '
      + 'Key properties/methods are:');
    Add('');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('property PaletteSteps : Defines the number of palette steps for legend');
    Add('property BottomColor, TopColor : Defines color for lowest and highest value.');
    Add('property PaletteStyle : Default value is palRange meaning palette '
      + 'colors will be calculated from BottomColor, TopColor and PaletteSteps '
      + 'properties.  If you want to define custom palette levels, set '
      + 'PaletteStyle to palCustom and then define level and it''s color by using '
      + 'AddPalette method.');
    Add('method AddPalette : adds new palette level (works only if PaletteStyle is palCustom).');
    Add('method CreateRangePalette : Recreates range palette values. Call this method if matrix '
      + 'maximum/minimum value changes.');
    Add('method ClearPalette : clears palette.'+#10+#13);

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');
    Add('Some properties are accessible via the MtxGridSeries editor (click on "Edit Grid Series" button).');
  end;
  {$IFDEF TEESTD}
  Button2.Visible := False;
  Chart1.Legend.Visible := False;
  {$ELSE}
  Chart1.Legend.Visible := True;
  Button2.Visible := True;
  {$ENDIF}
  { setup grid series }
  With Chart1.LeftAxis do
  begin
    Title.Caption := 'Index';
    Increment := 1.0;
    RoundFirstLabel := False;
 {    LabelsOnAxis := True; }
  end;
  With Chart1.LeftAxis do
  begin
    Title.Caption := 'Index';
    Increment := 1.0;
    RoundFirstLabel := False;
{    LabelsOnAxis := True; }
  end;
//  Chart1.Canvas := TTeeCanvas3D.Create;
//  ColorChart.Canvas := TTeeCanvas3D.Create;

  GridSeries := TMtxGridSeries.Create(Chart1);
  GridSeries.ValueFormat := '0.00';
  GridSeries.ColorPalette.BottomColor := clWhite;
  GridSeries.ColorPalette.TopColor := RGB(74,127,186);
  GridSeries.HorizAxis := aTopAxis;
  GridSeries.ParentChart := Chart1;


{  GridSeries.PixelResample := True; }
  { now setup sparse matrix }
  SparseA := TSparseMtx.Create;
  { zero count is only estimated zero count. If the value is too small.
    then this will result in many memory reallocations by RandomSparse. }

  A.Size(0,0);
  { Setup legend }
  LegendSeries := TMtxGridSeries.Create(ColorChart);
  LegendSeries.ParentChart := ColorChart;

  UpdateData;
end;

procedure TfrmMtxGridSeries.UpdateData;
begin
  SparseA.Size(2000,2000,100000,False);
  SparseA.RandomSparse(v1,v2,False,1,100000);
  SparseA.PixelDownSample(A,500,TPixelDownSample(RadioGroup1.ItemIndex));
  GridSeries.PixelResampleMethod := TPixelDownSample(RadioGroup1.ItemIndex);

{  SparseA.SparseToDense(a); }

{  B.Size(2000,400,False);
  B.SetZero;
  B.PixelDownSample(A,500,TPixelDownSample(RadioGroup1.ItemIndex));}

  UpdateCharts;
end;

procedure TfrmMtxGridSeries.FormDestroy(Sender: TObject);
begin
  SparseA.Free;
  inherited;
end;

procedure TfrmMtxGridSeries.CheckBox2Click(Sender: TObject);
begin
  Timer1.Enabled := CheckBox2.Checked;
  RadioGroup1.Enabled := Not Timer1.Enabled;
  Button2.Enabled := Not Timer1.Enabled;
  CheckBox1.Checked := Not CheckBox2.Checked;
end;

procedure TfrmMtxGridSeries.Timer1Timer(Sender: TObject);
begin
  UpdateData;
end;

procedure TfrmMtxGridSeries.Button2Click(Sender: TObject);
begin
  {$IFNDEF TEESTD}
  EditSeries(Self,GridSeries);
  ThreeColorBox.Checked := (GridSeries.ColorPalette.MidColor <> clNone);
  UpdateCharts;
  {$ENDIF}
end;

procedure TFrmMtxGridSeries.UpdateCharts;
begin
  ColorChart.Visible := GridSeries.PixelResample;
  Splitter1.Visible := GridSeries.PixelResample;
  DrawValues(A,GridSeries); { showing A }
end;

procedure TfrmMtxGridSeries.RadioGroup1Click(Sender: TObject);
begin
  SparseA.PixelDownSample(A,500,TPixelDownSample(RadioGroup1.ItemIndex));
  GridSeries.PixelResampleMethod := TPixelDownSample(RadioGroup1.ItemIndex);
  UpdateCharts;
end;

procedure TfrmMtxGridSeries.SharpContrastBoxClick(Sender: TObject);
begin
  GridSeries.ColorPalette.SharpContrast := SharpContrastBox.Checked;
end;

procedure TfrmMtxGridSeries.Chart1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var index: Integer;
begin
  inherited;
  if CheckBox1.Checked then
  begin
    Chart1.Title.Text.Clear;
    index := GridSeries.Clicked(X,Y);
    if index <> -1 then
      Chart1.Title.Text.Add('Value at cursor: '+FormatFloat('0.00',GridSeries.Matrix.Values1D[index]))
    else Chart1.Title.Text.Add(' ');
  end;
end;

procedure TfrmMtxGridSeries.Chart1AfterDraw(Sender: TObject);
begin
  LegendSeries.SeriesToLegend(GridSeries,cslVertical);
end;

procedure TfrmMtxGridSeries.Chart1GetAxisLabel(Sender: TChartAxis;
  Series: TChartSeries; ValueIndex: Integer; var LabelText: String);
var tmp : Integer;
begin
  inherited;
  { invert axis labels}
  if (Sender = Chart1.LeftAxis) and (Assigned(GridSeries.Matrix)) then
  begin
    {$IFNDEF D15}
    tmp := Round(StrToFloat(StringReplace(LabelText,ThousandSeparator,'',[rfReplaceAll])));
    {$ELSE}
    tmp := Round(StrToFloat(StringReplace(LabelText,FormatSettings.ThousandSeparator,'',[rfReplaceAll])));
    {$ENDIF}
    tmp := GridSeries.Matrix.Rows - 1 - tmp;
    LabelText := IntToStr(tmp);
  end;
end;

procedure TfrmMtxGridSeries.PaletteBarScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  GridSeries.ColorPalette.ColorBalance := ScrollPos/100;
  UpdateCharts;
end;

procedure TfrmMtxGridSeries.ThreeColorBoxClick(Sender: TObject);
begin
   if ThreeColorBox.Checked then GridSeries.ColorPalette.MidColor := clRed
                            else GridSeries.ColorPalette.MidColor := clNone;

   SharpContrastBox.Enabled := ThreeColorBox.Checked;
end;

procedure TfrmMtxGridSeries.PixelResampleBoxClick(Sender: TObject);
begin
   GridSeries.PixelResample := PixelResampleBox.Checked;
   GridSeries.ShowInLegend := not PixelResampleBox.Checked;
   UpdateCharts;
end;

initialization
  RegisterClass(TfrmMtxGridSeries);

end.

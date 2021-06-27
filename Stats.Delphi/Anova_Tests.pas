unit Anova_Tests;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_Form, StdCtrls, ExtCtrls, StatTools, Grids, Buttons, ComCtrls,
  MtxBaseComp;

type
  TfrmANOVATest = class(TfrmBasic)
    MtxAnova: TMtxAnova;
    Panel2: TPanel;
    Label1: TLabel;
    StringGrid1: TStringGrid;                
    Panel3: TPanel;
    Label2: TLabel;
    ComboBox1: TComboBox;                                  
    SpeedButton1: TSpeedButton;
    RichEdit1: TRichEdit;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure FillData;
  public
    { Public declarations }
  end;

var
  frmANOVATest: TfrmANOVATest;

implementation

{$R *.DFM}

procedure TfrmANOVATest.FillData;
begin
  if ComboBox1.ItemIndex = 0 then
  begin
    MtxANOVA.FmtString := '0.000000E+00';
    MtxANOVA.Data.SetIt(21,9,false,[1.4, 1.3, 1.5, 1.3, 1.5, 1.3, 1.5, 1.3, 1.5,
                                    1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
                                    1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6,
                                    1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
                                    1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6,
                                    1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
                                    1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6,
                                    1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
                                    1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6,
                                    1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
                                    1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6,
                                    1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
                                    1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6,
                                    1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
                                    1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6,
                                    1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
                                    1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6,
                                    1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
                                    1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6,
                                    1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
                                    1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6]);
  end
  else
  if ComboBox1.ItemIndex = 1 then
  begin
    MtxANOVA.FmtString := '0.000000E+00';
    MtxANOVA.Data.SetIt(24,2,false,[107.8681568, 107.8681079,
                                   107.8681465, 107.8681344,
                                   107.8681572, 107.8681513,
                                   107.8681785, 107.8681197,
                                   107.8681446, 107.8681604,
                                   107.8681903, 107.8681385,
                                   107.8681526, 107.8681642,
                                   107.8681494, 107.8681365,
                                   107.8681616, 107.8681151,
                                   107.8681587, 107.8681082,
                                   107.8681519, 107.8681517,
                                   107.8681486, 107.8681448,
                                   107.8681419, 107.8681198,
                                   107.8681569, 107.8681482,
                                   107.8681508, 107.8681334,
                                   107.8681672, 107.8681609,
                                   107.8681385, 107.8681101,
                                   107.8681518, 107.8681512,
                                   107.8681662, 107.8681469,
                                   107.8681424, 107.8681360,
                                   107.8681360, 107.8681254,
                                   107.8681333, 107.8681261,
                                   107.8681610, 107.8681450,
                                   107.8681477, 107.8681368]);
  end else
  if ComboBox1.ItemIndex = 2 then
  begin
    MtxANOVA.FmtString := '0.000000E+00';
    MtxANOVA.Data.SetIt(21,9,false,[1000000000000.4, 1000000000000.3, 1000000000000.5, 1000000000000.3, 1000000000000.5, 1000000000000.3, 1000000000000.5, 1000000000000.3, 1000000000000.5,
                                    1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
                                    1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6,
                                    1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
                                    1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6,
                                    1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
                                    1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6,
                                    1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
                                    1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6,
                                    1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
                                    1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6,
                                    1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
                                    1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6,
                                    1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
                                    1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6,
                                    1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
                                    1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6,
                                    1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
                                    1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6,
                                    1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
                                    1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6]);
  end;
end;

procedure TfrmANOVATest.FormShow(Sender: TObject);
begin
  ComboBox1.ItemIndex := 0;
  ComboBox1Change(Self);
end;

procedure TfrmANOVATest.SpeedButton1Click(Sender: TObject);
begin
  FillData;
  MtxANOVA.Recalc;
end;

procedure TfrmANOVATest.ComboBox1Change(Sender: TObject);
begin
  RichEdit1.Lines.Clear;
  With RichEdit1.Lines do
    if ComboBox1.ItemIndex = 0 then
    begin
      Add('Reference:');
      Add('Simon, Stephen D. and Lesage, James P. (1989)."Assessing the Accuracy"'+
          ' of ANOVA Calculations in Statistical Software".'+
          ' Computational Statistics & Data Analysis, 8, pp. 325-332.');
      Add(chr(13));
      Add('Data:');
      Add('1 Factor');
      Add('9 Treatments');
      Add('21 Replicates/Cell');
      Add('189 Observations');
      Add('1 Constant Leading Digits');
      Add('Lower Level of Difficulty');
      Add('Generated Data');
      Add(chr(13));
      Add('Model:');
      Add('10 Parameters (mu, tau_1, ..., tau_9)');
      Add('y_{ij} = mu + tau_i + epsilon_{ij}');
      Add(chr(13));
      Add('Certified values:');
      with RichEdit1.Paragraph do
      begin
        TabCount := 5;
        Tab[0] := 0;
        Tab[1] := 40;
        Tab[2] := 60;
        Tab[3] := 120;
        Tab[4] := 180;
      end;
      Add('Source of'+chr(9)+' '+ chr(9)+'Sums of'+chr(9)+'Mean');
      Add('Variation'+chr(9)+'df'+chr(9)+'Squares'+chr(9)+'Squares'+chr(9)+'F Statistic');
      Add('Bewteen'+chr(9)+'8'+chr(9)+'1.68'+chr(9)+'2.1E-01'+chr(9)+'2.1E+01');
      Add('Within'+chr(9)+'180'+chr(9)+'1.8'+chr(9)+'1.0E-02');
    end else
    if ComboBox1.ItemIndex = 1 then
    begin
      Add('Reference:');
      Add('Powell, L.J., Murphy, T.J. and Gramlich, J.W. (1982)."The Absolute Isotopic'+
          ' Abundance & Atomic Weight of a Reference Sample of Silver". NBS Journal of Research, 87, pp. 9-19.');
      Add(chr(13));
      Add('Data:');
      Add('1 Factor');
      Add('2 Treatments');
      Add('24 Replicates/Cell');
      Add('48 Observations');
      Add('7 Constant Leading Digits');
      Add('Average Level of Difficulty');
      Add('Observed Data');
      Add(chr(13));
      Add('Model:');
      Add('3 Parameters (mu, tau_1, tau_2)');
      Add('y_{ij} = mu + tau_i + epsilon_{ij}');
      Add(chr(13));
      Add('Certified values:');
      with RichEdit1.Paragraph do
      begin
        TabCount := 5;
        Tab[0] := 0;
        Tab[1] := 40;
        Tab[2] := 60;
        Tab[3] := 160;
        Tab[4] := 260;
      end;
      Add('Source of'+chr(9)+' '+ chr(9)+'Sums of'+chr(9)+'Mean');
      Add('Variation'+chr(9)+'df'+chr(9)+'Squares'+chr(9)+'Squares'+chr(9)+'F Statistic');
      Add('Bewteen'+chr(9)+'1'+chr(9)+'3.63834187500000E-09'+chr(9)+'3.63834187500000E-09'+chr(9)+'1.59467335677930E+01');
      Add('Within'+chr(9)+'46'+chr(9)+'1.04951729166667E-08'+chr(9)+'2.28155932971014E-10');
    end else
    if ComboBox1.ItemIndex = 2 then
    begin
      Add('Reference:');
      Add('Simon, Stephen D. and Lesage, James P. (1989)."Assessing the Accuracy"'+
          ' of ANOVA Calculations in Statistical Software".'+
          ' Computational Statistics & Data Analysis, 8, pp. 325-332.');
      Add(chr(13));
      Add('Data:');
      Add('1 Factor');
      Add('9 Treatments');
      Add('21 Replicates/Cell');
      Add('189 Observations');
      Add('13 Constant Leading Digits');
      Add('Higher Level of Difficulty');
      Add('Generated Data');
      Add(chr(13));
      Add('Model:');
      Add('10 Parameters (mu, tau_1, ..., tau_9)');
      Add('y_{ij} = mu + tau_i + epsilon_{ij}');
      Add(chr(13));
      Add('Certified values:');
      with RichEdit1.Paragraph do
      begin
        TabCount := 5;
        Tab[0] := 0;
        Tab[1] := 40;
        Tab[2] := 60;
        Tab[3] := 120;
        Tab[4] := 180;
      end;
      Add('Source of'+chr(9)+' '+ chr(9)+'Sums of'+chr(9)+'Mean');
      Add('Variation'+chr(9)+'df'+chr(9)+'Squares'+chr(9)+'Squares'+chr(9)+'F Statistic');
      Add('Bewteen'+chr(9)+'8'+chr(9)+'1.68'+chr(9)+'2.1E-01'+chr(9)+'2.1E+01');
      Add('Within'+chr(9)+'180'+chr(9)+'1.8'+chr(9)+'1.0E-02');
    end;
end;

procedure TfrmANOVATest.FormCreate(Sender: TObject);
begin
  inherited;
  With Memo1.Lines do
  begin
    Add('NIST ANOVA tests : ');
    Add(chr(13));
    Add(chr(13));
    Add('SmLs01 : Simon, Stephen D. and Lesage, James P. (1989).'+
        ' "Assessing the Accuracy of ANOVA Calculations in Statistical Software".'+
        ' Computational Statistics & Data Analysis, 8, pp. 325-332.'+
        ' (Lower level of difficulty)');
    Add(chr(13));

    Add('AtmWtAg : Powell, L.J., Murphy, T.J. and Gramlich, J.W. (1982).'+
        ' "The Absolute Isotopic Abundance & Atomic Weight of a Reference'+
        ' Sample of Silver". NBS Journal of Research, 87, pp. 9-19.'+
        ' (Average level of difficulty)');
    Add(chr(13));
    Add('SmLs07 : Simon, Stephen D. and Lesage, James P. (1989).'+
        ' "Assessing the Accuracy of ANOVA Calculations in Statistical Software".'+
        ' Computational Statistics & Data Analysis, 8, pp. 325-332.'+
        ' (Higher level of difficulty)');
    Add(chr(13));
  end;
end;

initialization
  RegisterClass(TfrmANOVATest);
end.

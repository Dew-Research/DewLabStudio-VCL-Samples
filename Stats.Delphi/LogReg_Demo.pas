unit LogReg_Demo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_Form, MtxBaseComp, StatTools, StdCtrls, ExtCtrls;

type
  TfrmLogReg = class(TfrmBasic)
    MtxLogReg: TMtxLogistReg;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo2: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    procedure Report;
  public
    { Public declarations }
  end;

var
  frmLogReg: TfrmLogReg;

implementation

{$R *.DFM}

Uses MtxVecEdit, AbstractMtxVec, Types;

procedure TfrmLogReg.FormCreate(Sender: TObject);
begin
  inherited;
  With Memo1.Lines do
  begin
    Clear;
    Add('Logistic regression is similar to regular multiple regression except that the dependent (Y) variable '
      + 'is integer (can be binary, but it is not obligatory) instead of continuous. '
      + 'Statistics for MtxVec supports ordinary logistic regression (binary dependent variable) and ordinal '
      + '(dependent variables are integers) logistic regression. Example bellow is taken NCSS, another great statistical '
      + 'package.');
    Add('');
    Add('Example: The data below is taken from first few rows of a set of data about leukemia patients published in Lee (1980). '
      + 'The response variable is whether leukemia remission occurred. These values are passed to TMtxLogistReg.Y vector. '
      + 'The independent variables are cellularity of the marrow clot section, smear differential percentage of blasts, percentage '
      + 'of absolute marrow leukemia cell infiltrate, percentage labeling index of the bone marrow leukemia cells, absolute number '
      + 'of blasts in the peripheral blood, and the highest temperature prior to start of treatment. '
      + 'We will estimate only the relationship between remission, cellularity, index of leukemia cells and temperature. Each variable '
      + 'is stored in separate column in TMtxLogistReg.A matrix.');
  end;
  With MtxLogReg do
  begin
    A.SetIt(27,3,false,
          [0.8, 1.9, 0.996,
          0.9, 1.4, 0.992,
          0.8, 0.8, 0.982,
          1, 0.7, 0.986,
          0.9,   1.3, 0.98,
          1,   0.6, 0.982,
          0.95,   1,   0.992,
          0.95,   1.9,   1.02,
          1,   0.8,   0.999,
          0.95,   0.5, 1.038,
          0.85, 0.7, 0.988,
          0.7,   1.2, 0.982,
          0.8,   0.4, 1.006,
          0.2,   0.8, 0.99,
          1,   1.1, 0.99,
          1,   1.9, 1.02,
          0.65, 0.5,   1.014,
          1,   1,   1.004,
          0.5,   0.6, 0.99,
          1,   1.1, 0.986,
          1,   0.4,   1.01,
          0.9,   0.6, 1.02,
          1,   1,   1.002,
          0.95, 1.6, 0.988,
          1,   1.7, 0.99,
          1,   0.9, 0.986,
          1,   0.7, 0.986]);
    Y.SetIt(false,[1,1,0,0,1,0,1,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,1,0,1,1,0]);
  end;
end;

procedure TfrmLogReg.Button1Click(Sender: TObject);
begin
  ViewValues(MtxLogReg.Y,'Grouping variable',True);
end;

procedure TfrmLogReg.Button2Click(Sender: TObject);
begin
  ViewValues(MtxLogReg.A,'Independent variables',True);
end;

procedure TfrmLogReg.Button3Click(Sender: TObject);
begin
  MtxLogReg.Recalc;
  Report;
end;

procedure TfrmLogReg.Report;
var LineText: String;
    i: Integer;
begin
  With Memo2.Lines do
  begin
    Clear;
    Add('Logistic regression report');
    Add('Number of independent variables : ' + IntToStr(MtxLogReg.A.Cols));
    Add('');
    Add('--------------------------------------------------------------------------------');
    Add('Regression coefficients - Theta (constant term):');
    Add('Theta'+chr(9)+chr(9)+'Theta Std.Err');
    for i := 0 to MtxLogReg.Theta.Length - 1 do
    begin
      LineText := FormatFloat('0.00000',MtxLogReg.Theta[i])+chr(9)+chr(9)+FormatFloat('0.00000',MtxLogReg.TBStdErr[i]);
      Add(LineText);
    end;
    Add('Regression coefficients - B:');
    Add('B'+chr(9)+chr(9)+'B Std.Err');
    for i := 0 to MtxLogReg.B.Length - 1 do
    begin
      LineText := FormatFloat('0.00000',MtxLogReg.B[i])+chr(9)+chr(9)+FormatFloat('0.00000',MtxLogReg.TBStdErr[MtxLogReg.Theta.Length+i]);
      Add(LineText);
    end;
    Add('--------------------------------------------------------------------------------');
    Add('Additional parameters returned: ');
    Add('Log-likehood function, evaluated at minimum : '+ FormatFloat('0.00000',MtxLogReg.FMin));
    Add('Number of iterations needed to converge : ' + IntToStr(MtxLogReg.Iterations));
  end;
end;

initialization
  RegisterClass(TfrmLogReg);

end.

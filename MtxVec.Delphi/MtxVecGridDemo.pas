unit MtxVecGridDemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Basic2, StdCtrls, ComCtrls, ExtCtrls, MtxExpr, MtxGrid, Math387, MtxVec;

type
  TfrmGridDemo = class(TBasicForm2)
    Panel4: TPanel;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;                   
    CheckBox4: TCheckBox;
    GroupBox2: TGroupBox;
    CheckBox5: TCheckBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    CheckBox6: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
  private
    { Private declarations }
    Grid: TMtxVecGrid;
    testMatrix: Matrix;
    testVector: Vector;
  public
    { Public declarations }
  end;

var
  frmGridDemo: TfrmGridDemo;

implementation

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TfrmGridDemo.Button1Click(Sender: TObject);
begin
  Grid.Datasource := TVec(testVector);
end;

procedure TfrmGridDemo.Button2Click(Sender: TObject);
begin
  Grid.Datasource := TMtx(testMatrix);
end;

procedure TfrmGridDemo.CheckBox1Click(Sender: TObject);
begin
  Grid.Editable := CheckBox1.Checked;
end;

procedure TfrmGridDemo.CheckBox2Click(Sender: TObject);
begin
  Grid.AllowAppend := CheckBox2.Checked;
end;

procedure TfrmGridDemo.CheckBox3Click(Sender: TObject);
begin
  Grid.AutoSizeColumns := CheckBox3.Checked;
end;

procedure TfrmGridDemo.CheckBox4Click(Sender: TObject);
begin
  Grid.SplitComplexNumbers := CheckBox4.Checked;
end;

procedure TfrmGridDemo.CheckBox5Click(Sender: TObject);
begin
  Grid.Scientific := CheckBox5.Checked;
end;

procedure TfrmGridDemo.CheckBox6Click(Sender: TObject);
begin
  Grid.ShowInfo := CheckBox6.Checked;
end;

procedure TfrmGridDemo.ComboBox1Change(Sender: TObject);
begin
  Grid.TextAlign := TCellTextAlign(ComboBox1.ItemIndex);
end;

procedure TfrmGridDemo.Edit1Change(Sender: TObject);
begin
  Grid.StringFormat := Edit1.Text;
end;

procedure TfrmGridDemo.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines do
  begin
    Clear;
    Add('TMtxVecGrid control allows you easy viewing/editing of real or complex '
      + 'matrices or vectors. The control is derived from TCustomGrid and inherits '
      + 'all it''s properties/methods and introduces some new features: cell text alignment, '
      + 'cell string format, full support for complex numbers, ability to edit, remove or '
      + 'append/insert rows into matrix or vector.');
  end;
  // Create a grid at runtime
  Grid := TMtxVecGrid.Create(Self);
  Grid.Parent := Panel3;
  Grid.Align := alClient;
  Grid.AutoSizeColumns := True;

  // Setup test matrix and vector
  testMatrix.Size(30,30,true);
  testMatrix.RandGauss;
  testVector.Size(50,false);
  testVector.RandUniform(5,12);

  // initially, connect Grid with testmatrix
  Grid.Datasource := TMtx(testmatrix);
end;

procedure TfrmGridDemo.FormShow(Sender: TObject);
begin
  inherited;
  ComboBox1.ItemIndex := Ord(Grid.TextAlign);
  Edit1.Text := Grid.StringFormat;
  CheckBox1.Checked := Grid.Editable;
  CheckBox2.Checked := Grid.AllowAppend;
  CheckBox3.Checked := Grid.AutoSizeColumns;
  CheckBox4.Checked := Grid.SplitComplexNumbers;
  CheckBox6.Checked := Grid.ShowInfo;
end;

initialization
  RegisterClass(TfrmGridDemo);

end.

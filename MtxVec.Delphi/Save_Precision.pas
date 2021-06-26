unit Save_Precision;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic2, StdCtrls, ComCtrls, ExtCtrls, MtxVec, Math387, Grids;

type                             
  TfrmSavePrec = class(TBasicForm2)
    Button1: TButton;
    CBPrecision: TComboBox;
    CBRounding: TComboBox;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblMemSize: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CBPrecisionChange(Sender: TObject);
    procedure CBRoundingChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    m1,m2: TMtx;
    Precision : TPrecision;
    Rounding  : TRounding;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSavePrec: TfrmSavePrec;

implementation

Uses MtxDialogs;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TfrmSavePrec.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines do
  begin
    Clear;
    Add('SaveToStream allows you to specify the precision '
      + 'and rounding method. This enables you to minimize '
      + 'the storage space required for your data and at '
      + 'the same time gives you the ability to process '
      + 'data written in any number format.');
  end;
  m1 := TMtx.Create;
  m2 := TMtx.Create;
  m1.Size(50,50);
  { setup StringGrids }
  StringGrid1.RowCount := 51;
  StringGrid1.ColCount := 51;
  StringGrid2.RowCount := 51;
  StringGrid2.ColCount := 51;
  m1.RandGauss(5,0.5); { generate sample values }
  { visualize }
  ValuesToGrid(m1,StringGrid1,0,0,'0.0000000000',true);
end;

procedure TfrmSavePrec.CBPrecisionChange(Sender: TObject);
begin
     Precision := TPrecision(CBPrecision.ItemIndex);
end;

procedure TfrmSavePrec.CBRoundingChange(Sender: TObject);
begin
  Rounding := TRounding(CBRounding.ItemIndex);
end;

procedure TfrmSavePrec.FormShow(Sender: TObject);
begin
  inherited;
  CBPrecision.ItemIndex := 0;
  CBRounding.ItemIndex := 0;
end;

procedure TfrmSavePrec.FormDestroy(Sender: TObject);
begin
  m1.Free;
  m2.Free;
  inherited;
end;

procedure TfrmSavePrec.Button1Click(Sender: TObject);
var MemStream: TMemoryStream;
begin
  MemStream := TMemoryStream.Create;
  try
    { save from m1 to stream }
    m1.Precision := Precision;
    m1.Rounding := Rounding;
    m1.SaveToStream(MemStream);
    lblMemSize.Caption := IntToStr(MemStream.Size) + ' bytes';
    { load to m2 from stream }
    MemStream.Seek(0,{$IFDEF CLR}soFromBeginning{$ELSE}0{$ENDIF});
    m2.LoadFromStream(MemStream);
    { visualize }
    ValuesToGrid(m2,StringGrid2,0,0,'0.0000000000',true);
  finally
    MemStream.Free;
  end;
end;


initialization
  RegisterClass(TfrmSavePrec);

end.

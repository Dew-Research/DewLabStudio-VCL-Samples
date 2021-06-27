unit Basic1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeeProcs, TeEngine, Chart, ExtCtrls, StdCtrls, MtxVec, Math387, ComCtrls,
  TeeGDIPlus;

type
  TBasicForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    CheckDownSample: TCheckBox;
    RichEdit1: TRichEdit;
    Chart1: TChart;
    procedure CheckDownSampleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FDownSize: boolean;
    procedure SetDownSize(const Value: boolean);
    { Private declarations }
  public
     TimeCheck : DWord;
     TimeElapsed : DWord;
     property DownSize: boolean read FDownSize write SetDownSize;
    { Public declarations }
  end;

var
  BasicForm1: TBasicForm1;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TBasicForm1.SetDownSize(const Value: boolean);
begin
  FDownSize := Value;
end;

procedure TBasicForm1.CheckDownSampleClick(Sender: TObject);
begin
     FDownSize := TCheckBox(Sender).Checked;
     Chart1.AllowZoom := Not(TCheckBox(Sender).Checked);
end;

procedure TBasicForm1.FormCreate(Sender: TObject);
begin
     RichEdit1.Lines.Clear;
end;

end.

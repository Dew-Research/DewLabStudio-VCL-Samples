unit Basic1;

{$I BdsppDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeeProcs, TeEngine, Chart, ExtCtrls, StdCtrls, MtxVec,Math387, ComCtrls;

type
  TBasicForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    CheckDownSample: TCheckBox;
    RichEdit1: TRichEdit;
    Chart1: TChart;
    procedure CheckDownSampleClick(Sender: TObject);
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
{$R *.NFM}
{$ELSE}
{$R *.DFM}
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

end.

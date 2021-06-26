unit FloatEdit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic2, MtxComCtrls, StdCtrls, ComCtrls, ExtCtrls, Math387;

type
  TfrmFloatEdit1 = class(TBasicForm2)
    MtxFloatEdit1: TMtxFloatEdit;
    MtxFloatEdit2: TMtxFloatEdit;
    Label1: TLabel;                                
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Label4: TLabel;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Res: TCplx;
    Z1,Z2: TCplx;
  public
    { Public declarations }
  end;

var
  frmFloatEdit1: TfrmFloatEdit1;

implementation

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}


procedure TfrmFloatEdit1.Button1Click(Sender: TObject);
begin
  Z1 := MtxFloatEdit1.CplxPosition;
  Z2 := MtxFloatEdit2.CplxPosition;
  if Sender = Button1 then Res := Math387.CMul(Z1,Z2)
  else if Sender = Button2 then Res := Math387.CDiv(Z1,Z2)
  else if Sender = Button3 then Res := Math387.CAdd(Z1,Z2)
  else if Sender = Button4 then Res := Math387.CSub(Z1,Z2);
  Edit1.Text := CplxToStr(Res,4);
end;

procedure TfrmFloatEdit1.Button5Click(Sender: TObject);
begin
  MtxFloatEdit1.Execute(true);
end;

procedure TfrmFloatEdit1.Button6Click(Sender: TObject);
begin
  MtxFloatEdit2.Execute(true);
end;

procedure TfrmFloatEdit1.FormCreate(Sender: TObject);
begin
  inherited;

  With RichEdit1.Lines, RichEdit1 do
  begin
    Add('The TMtxFloatEdit component can be used to edit/view/change '
    + 'real or complex number. The control also includes runtime complex '
    + 'number format editor. You can invoke it with :');

    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('holding the CTRL key and double clicking on TMtxFloatEdit control');
    Add('in code by calling TMtxFloatEdit Execute method'+#10+#13);
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
  end;

  MtxFloatEdit1.Value := '2+2i';
  MtxFloatEdit2.Value := '2+5i';
end;

initialization
  RegisterClass(TfrmFloatEdit1);

end.

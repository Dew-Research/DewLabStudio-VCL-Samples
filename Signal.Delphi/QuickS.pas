unit QuickS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic3, StdCtrls, ComCtrls;

type
  TQStart = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  QStart: TQStart;

implementation

{$R *.DFM}

procedure TQStart.FormCreate(Sender: TObject);
begin
  inherited;
  try
     RichEdit1.Lines.LoadFromFile('Texts\QuickStart.rtf');
  except
  end;
  TButton(Self.Owner.FindComponent('btnHelp')).Enabled := false;
end;

initialization
   RegisterClass(TQStart);

end.

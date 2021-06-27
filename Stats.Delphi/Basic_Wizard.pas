unit Basic_Wizard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TfrmBasicWizard = class(TForm)
    Panel1: TPanel;
    btnHelp: TButton;
    btnBack: TButton;
    btnNext: TButton;
    btnCancel: TButton;
    Panel2: TPanel;
    lblHeader: TLabel;
    PageControl: TPageControl;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
  private
    { Private declarations }
    DefTabWidth : Integer;
    FFormatString: string;
    procedure SetFormatString(const Value: string);
  protected
    moveback: boolean;
    moveforward: boolean;
    chartindex: Integer;
    procedure RefreshWizardControls; virtual;
    procedure DoMoveForward; virtual;
    procedure DoMoveBack; virtual;
  public
    { Public declarations }
    procedure SetupTabs(Const NumTabs: Integer; RichEdit: TRichEdit);
    property FormatString: string read FFormatString write SetFormatString;
  end;

var
  frmBasicWizard: TfrmBasicWizard;

implementation

Uses Math387;

{$R *.DFM}

procedure TfrmBasicWizard.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmBasicWizard.SetupTabs(const NumTabs: Integer;
  RichEdit: TRichEdit);
var i : Integer;
begin
  RichEdit.Paragraph.Tab[0] := 0;
  for i := 1 to RichEdit.Paragraph.TabCount - 1 do
    RichEdit.Paragraph.Tab[i] := RichEdit.Paragraph.Tab[i-1]+DefTabWidth;
end;

procedure TfrmBasicWizard.FormShow(Sender: TObject);
begin
  { improve this }
  DefTabWidth := Max(60,Canvas.TextWidth('+'+FormatString)+10);
  RefreshWizardControls;
end;

procedure TfrmBasicWizard.SetFormatString(const Value: string);
begin
  FFormatString := Value;
end;

procedure TfrmBasicWizard.FormCreate(Sender: TObject);
begin
  FFormatString := '0.0000';
  moveback := true;
  moveforward := true;
end;

procedure TfrmBasicWizard.btnNextClick(Sender: TObject);
begin
  DoMoveForward;
  RefreshWizardControls;
end;

procedure TfrmBasicWizard.btnBackClick(Sender: TObject);
begin
  DoMoveBack;
  RefreshWizardControls;
end;

// Refresh wizard controls
procedure TfrmBasicWizard.RefreshWizardControls;
begin
  btnBack.Enabled := PageControl.ActivePage.PageIndex > 0;
  btnNext.Enabled := PageControl.ActivePage.PageIndex < PageControl.PageCount-1;
  lblHeader.Caption := PageControl.ActivePage.Caption;
end;

// Called when Back button is clicked
procedure TfrmBasicWizard.DoMoveBack;
var index: Integer;
begin
  index := PageControl.ActivePageIndex;
  if (index>0) and (moveback) then
  begin
    Dec(index);
    PageControl.ActivePageIndex := index;
  end;
end;

// Called when Next button is clicked
procedure TfrmBasicWizard.DoMoveForward;
var index: Integer;
begin
  index := PageControl.ActivePageIndex;
  if (index<PageControl.PageCount) and (moveforward) then
  begin
    Inc(index);
    PageControl.ActivePageIndex := index;
  end;
end;

end.

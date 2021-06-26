unit ExprToolTipUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Graphics,
  Controls, Forms, Dialogs, ComCtrls, Grids, MtxVec, MtxVecInt,
  MtxGrid, MtxVecBase, DateUtils, Classes;

type
  TExprToolTipForm = class(TForm)
    MtxVecGrid: TMtxVecGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    bName: string;
    mark: TDateTime;
    FData: TMtx;
    procedure SetData(const Value: TMtx);
  protected
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    { Private declarations }
  public
    property Data: TMtx read FData write SetData;
    procedure UpdateGrid(const Src: TMtxVecBase; const aName: string);
    { Public declarations }
  end;

var
  ExprToolTipForm: TExprToolTipForm;

implementation

{$R *.dfm}

procedure TExprToolTipForm.FormCreate(Sender: TObject);
begin
//    FData := TMtx.Create;
//    MtxVecGrid.Datasource := FData;
end;

procedure TExprToolTipForm.FormDestroy(Sender: TObject);
begin
//    FData.Free;
end;

procedure TExprToolTipForm.SetData(const Value: TMtx);
begin
//  FData := Value;
end;

procedure TExprToolTipForm.UpdateGrid(const Src: TMtxVecBase; const aName: string);
begin
    if aName = bName then
    begin
        if (Now - Mark) > (0.25*OneSecond) then
        begin
          {  case Src.MtxVecType of
            mvTVec: begin
                    FData.Size(TVec(Src).Length, 1, TVec(Src).Complex);
                    FData.Copy(TVec(Src));
                    end;
            mvTMtx: FData.Copy(TMtx(Src));
            mvTVecInt: begin
                       FData.Size(TVecInt(Src).Length, 1);
                       FData.Copy(TVecInt(Src));
                       end;
            mvTMtxInt: FData.Copy(TMtxInt(Src))
            end;  }
            MtxVecGrid.Datasource := Src;
            Show;
            Mark := Now;
        end;
    end else
    begin
        Mark := Now;
        bName := aName;
    end;
end;

procedure TExprToolTipForm.WMNCHitTest(var Message: TWMNCHitTest);
const EDGEDETECT = 7; // adjust
var deltaRect: TRect;
begin
  inherited;
  if BorderStyle = bsNone then
    with Message, deltaRect do
    begin
      Left := XPos - BoundsRect.Left;
      Right := BoundsRect.Right - XPos;
      Top := YPos - BoundsRect.Top;
      Bottom := BoundsRect.Bottom - YPos;
      if (Top < EDGEDETECT) and (Left < EDGEDETECT) then
        Result := HTTOPLEFT
      else if (Top < EDGEDETECT) and (Right < EDGEDETECT) then
        Result := HTTOPRIGHT
      else if (Bottom < EDGEDETECT) and (Left < EDGEDETECT) then
        Result := HTBOTTOMLEFT
      else if (Bottom < EDGEDETECT) and (Right < EDGEDETECT) then
        Result := HTBOTTOMRIGHT
      else if (Top < EDGEDETECT) then
        Result := HTTOP
      else if (Left < EDGEDETECT) then
        Result := HTLEFT
      else if (Bottom < EDGEDETECT) then
        Result := HTBOTTOM
      else if (Right < EDGEDETECT) then
        Result := HTRIGHT
    end;
end;

end.

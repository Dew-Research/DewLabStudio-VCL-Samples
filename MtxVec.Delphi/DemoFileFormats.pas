unit DemoFileFormats;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Basic2, StdCtrls, ComCtrls, ExtCtrls, DewImportExport, MtxExpr;

type
  TfrmFileFormats = class(TBasicForm2)
    ButtonExport: TButton;
    RichEdit2: TRichEdit;
    procedure FormCreate(Sender: TObject);
    procedure ButtonExportClick(Sender: TObject);
  private
    { Private declarations }
    wrkMatrix: Matrix;
  public
    { Public declarations }
  end;

var
  frmFileFormats: TfrmFileFormats;

implementation

{$R *.dfm}

uses DewIECSV, DewIEDataPlot, DewIEDBase,
  DewIEParadox, DewIEMatlab, DewIEExcel, DewIEMtxVec;

procedure TfrmFileFormats.ButtonExportClick(Sender: TObject);
var ef: TBaseImportExport;
  SaveFolder: String;
begin
  wrkMatrix.Size(20,4,false);
  wrkMatrix.RandGauss;

  SaveFolder := SysUtils.GetCurrentDir+'\Temp';
  if Not SysUtils.DirectoryExists(SaveFolder) then
    SysUtils.CreateDir(SaveFolder);

  RichEdit2.Lines.Clear;
  RichEdit2.SelAttributes.Color := clBlack;
  RichEdit2.Lines.Add('All files are saved to '+SaveFolder+' folder');
  RichEdit2.Lines.Add('');

  ef := TCSVImportExport.Create;
  try
    with ef as TCSVImportExport do
    begin
      WorkMtx.Copy(wrkMatrix);
      // Comma separated values
      Settings.Delimiter := ';';
      SaveToFile(SaveFolder+'\Export_Comma.csv');
      RichEdit2.SelAttributes.Color := clGreen;
      RichEdit2.Lines.Add('Exported to CSV values format.');
      //   TAB separated values
      Settings.Delimiter := #9;
      SaveToFile(SaveFolder+'\Export_Tab.csv');
      RichEdit2.SelAttributes.Color := clGreen;
      RichEdit2.Lines.Add('Exported to TAB separated values format.');
      // Space separated values
      Settings.Delimiter := ' ';
      SaveToFile(SaveFolder+'\Export_Space.csv');
      RichEdit2.SelAttributes.Color := clGreen;
      RichEdit2.Lines.Add('Exported to SPACE separated values format.');
    end;
  finally
    ef.Free;
  end;

  // Dataplot
  ef := TDataplotImportExport.Create;
  try
    ef.WorkMtx.Copy(wrkMatrix);
    ef.SaveToFile(SaveFolder+'\Export_Dataplot.dat');
    RichEdit2.SelAttributes.Color := clGreen;
    RichEdit2.Lines.Add('Exported to DataPlot file.');
  finally
    ef.Free;
  end;

  // DBase 5.0 for Windows
  ef := TDBaseImportExport.Create;
  try
    ef.WorkMtx.Copy(wrkMatrix);
    ef.SaveToFile(SaveFolder+'\Export_DBase.dbf');
    RichEdit2.SelAttributes.Color := clGreen;
    RichEdit2.Lines.Add('Exported to DBase table.');
  finally
    ef.Free;
  end;

  // Paradox 7.0
  ef := TParadoxImportExport.Create;
  try
    ef.WorkMtx.Copy(wrkMatrix);
    ef.SaveToFile(SaveFolder+'\Export_Paradox.db');
    RichEdit2.SelAttributes.Color := clGreen;
    RichEdit2.Lines.Add('Exported to Paradox table.');
  finally
    ef.Free;
  end;

  // Matlab 7.00
  ef := TMatlabImportExport.Create;
  try
    ef.WorkMtx.Copy(wrkMatrix);
    ef.SaveToFile(SaveFolder+'\Export_Matlab.mat');
    ef.WorkMtx.Clear;
    ef.LoadFromFile(SaveFolder+'\Export_Matlab.mat');

    RichEdit2.SelAttributes.Color := clGreen;
    RichEdit2.Lines.Add('Exported to Matlab v5 file.');
  finally
    ef.Free;
  end;

  // Excel
  ef := TExcelImportExport.Create;
  try
    ef.WorkMtx.Copy(wrkMatrix);
    TExcelImportExport(ef).SaveFileVer := fvExcelXML;
    ef.SaveToFile(SaveFolder+'\Export_Excel.xml'); //no read supported yet
    RichEdit2.SelAttributes.Color := clGreen;
    RichEdit2.Lines.Add('Exported to Excel xml file format.');
    TExcelImportExport(ef).SaveFileVer := fvExcel972003;
    ef.SaveToFile(SaveFolder+'\Export_Excel.xls');
    RichEdit2.SelAttributes.Color := clGreen;
    RichEdit2.Lines.Add('Exported to Excel xls file format.');
  finally
    ef.Free;
  end;

  // MtxVec
  ef := TMtxVecImportExport.Create;
  try
    ef.WorkMtx.Copy(wrkMatrix);
    ef.SaveToFile(SaveFolder+'\Export_MtxVec.mtx');
    RichEdit2.SelAttributes.Color := clGreen;
    RichEdit2.Lines.Add('Exported to MtxVec matrix file.');
    TMtxVecImportExport(ef).SaveToVectors(SaveFolder);
    RichEdit2.SelAttributes.Color := clGreen;
    RichEdit2.Lines.Add('Exported to MtxVec vector files.');
  finally
    ef.Free;
  end

end;

procedure TfrmFileFormats.FormCreate(Sender: TObject);
begin
  inherited;
    inherited;
    With RichEdit1.Lines do
    begin
      Clear;
      Add('New in MtxVec v4: different export formats.');
      Add('Now you can export or import matrix values to/from the '
        + 'following formats: CSV, Tab  or Space delimitered text, '
        + 'Dataplot, Excel, Matlab, MtxVec, DBase and Paradox.'
        + 'With just few lines of code you can, for example, export wrkMatrix values to DataPlot file.');
      Add('');
      RichEdit1.SelAttributes.Name := 'Courier New';
      Add('// Dataplot'+#10+'var ef: TDataplotImportExport;'+#10+ 'begin'+#10+
          'ef := TDataplotImportExport.Create;'+#10
          + 'try'+#10+'  ef.W0rkMtx.Copy(wrkMatrix);'+#10+'  ef.SaveToFile(''c:\Temp\Export_Dataplot.dat'');'+
          #10+'finally'+#10+'  ef.Free;'+#10+'end;');
      Add('');
      Add('In the example below press the "Export" button to export values to all '
        + 'supported formats. "\Temp" folder is created in applicaton folder and all created '
        + 'export files are stored to this folder.');
    end;
end;

initialization
   RegisterClass(TfrmFileFormats);

end.

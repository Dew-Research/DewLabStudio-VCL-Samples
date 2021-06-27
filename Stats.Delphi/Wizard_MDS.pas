unit Wizard_MDS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Basic_Form, StdCtrls, ExtCtrls;

type
  TfrmShowMDSWizard = class(TfrmBasic)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmShowMDSWizard: TfrmShowMDSWizard;

implementation

Uses MDSWizard,StatTools;

{$R *.dfm}

procedure TfrmShowMDSWizard.FormCreate(Sender: TObject);
begin
  inherited;
  With Memo1.Lines do
  begin
    Clear;
    Add('Classical multidimensional scaling (MDS)');
    Add('');
    Add('Multidimensional scaling (MDS) can be considered to be an alternative to factor analysis. '
      + 'In general, the goal of the analysis is to detect meaningful underlying dimensions that allow the researcher to explain '
      + 'observed similarities or dissimilarities (distances) between the investigated objects. In factor analysis, the similarities '
      + 'between objects (e.g., variables) are expressed in the correlation matrix. With MDS one may analyze any kind of similarity '
      + 'or dissimilarity matrix, in addition to correlation matrices.');
    Add('Even though there are similarities in the type of research questions to which these two procedures can be applied, MDS and '
      + 'factor analysis are fundamentally different methods. Factor analysis requires that the underlying data are distributed as '
      + 'multivariate normal, and that the relationships are linear. MDS imposes no such restrictions. As long as the rank-ordering '
      + 'of distances (or similarities) in the matrix is meaningful, MDS can be used. In terms of resultant differences, factor '
      + 'analysis tends to extract more factors (dimensions) than MDS; as a result, MDS often yields more readily, interpretable '
      + 'solutions. Most importantly, however, MDS can be applied to any kind of distances or similarities, while factor analysis '
      + 'requires us to first compute a correlation matrix. MDS can be based on subjects direct assessment of similarities between '
      + 'stimuli, while factor analysis requires subjects to rate those stimuli on some list of attributes (for which the factor '
      + 'analysis is performed).'); 
    Add('In summary, MDS methods are applicable to a wide variety of research designs because distance measures can be obtained '
      + 'in any number of ways (for different examples, refer to the references provided at the beginning of this section).');
    Add('The goal of MDS is to reduce the number of dimensions needed for describing/explaining collected data. '
      + 'In this example a dissimilarity matrix for dataset with 6 variables is already preloaded.'
      + 'We will try to reduce the number of dimensions to 2 or 3 and check if the results are close enough to original'
      + 'data with 6 dimensions.');
    Add('');
    Add('Things to try:');
    Add('+ On the "Config report" page, set minimum number of dimensions to 1 and '
      + 'maximum number of dimensions to 6. These limits define the minimum and maximum'
      + 'dimension for MDS algorithm.');
    Add('+ On the "Config report" page, set the reduced space dimension to to 1,2 or 3.'
      + 'This defines the number of (reduced) dimensions used in calculating estimated '
      + 'coordinates and dissimilarity matrix.');
    Add('+ For 2 or 3 dimensions, a MDS Map plot is generated. It allows you to interpret '
      + ' the dissimilarity matrix on a two or three-dimensional scatter plot.');

    Add('+ Compare the results with Principal Component Analysis routines.');
  end;

  With TfrmMDSWiz.Create(Self) do
  begin
    Align := alClient;
    Parent := Self;
    BorderStyle := bsNone;
    BtnCancel.Visible := false; { in this case hide Cancel button }
    { load prepared data }
    try
      // Distance matrix
      MDScaling.Data.SetIt(6,6,false,
      [0,2,3,4,5,5,
       2,0,3,5,6,5,
       3,3,0,5,4,6,
       4,5,5,0,4,3,
       5,6,4,4,0,2,
       5,5,6,3,2,0
      ]);
      MDScaling.DataFormat := mdFormatDissimilarities;
      MDScaling.Dimensions := 2;
    except
    end;
    Show();
  end;

end;

initialization
  RegisterClass(TfrmShowMDSWizard);

end.

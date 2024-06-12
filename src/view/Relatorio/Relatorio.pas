unit Relatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Vcl.Imaging.pngimage;

type
  TfrmRelatorio = class(TForm)
    relAbastecimento: TRLReport;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLImage1: TRLImage;
    RLDraw1: TRLDraw;
    RLBand2: TRLBand;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLBand3: TRLBand;
    RLBand4: TRLBand;
    RLDBText5: TRLDBText;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDraw2: TRLDraw;
    RLSystemInfo2: TRLSystemInfo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorio: TfrmRelatorio;

implementation

{$R *.dfm}

uses
  View.Relatorio;

procedure TfrmRelatorio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    Action := caFree;
    frmRelatorio := nil;
  except on E: Exception do
    begin
      Exception.Create(e.Message);
    end;
  end;
end;

procedure TfrmRelatorio.FormDestroy(Sender: TObject);
begin
  try
    frmRelatorio := nil;
  except on E: Exception do
    begin
      Exception.Create(e.Message);
    end;
  end;
end;

end.

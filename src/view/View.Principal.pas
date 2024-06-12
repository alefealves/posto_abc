unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, Vcl.Imaging.pngimage;

type
  TViewPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Movimentos1: TMenuItem;
    Relatrios1: TMenuItem;
    Combustivel1: TMenuItem;
    Tanque1: TMenuItem;
    Bomba1: TMenuItem;
    Abastecimento1: TMenuItem;
    Relatriosporbomba1: TMenuItem;
    ConsultaAbastecimentos1: TMenuItem;
    PanelStatus: TPanel;
    LabelStatus: TLabel;
    ConnectionPosto: TFDConnection;
    pnLogo: TPanel;
    imgLogo: TImage;
    pnTelaInicial: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure Combustivel1Click(Sender: TObject);
    procedure Tanque1Click(Sender: TObject);
    procedure Bomba1Click(Sender: TObject);
    procedure ConsultaAbastecimentos1Click(Sender: TObject);
    procedure Abastecimento1Click(Sender: TObject);
    procedure Relatriosporbomba1Click(Sender: TObject);
    procedure pnTelaInicialResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewPrincipal: TViewPrincipal;

implementation

{$R *.dfm}
uses
  View.Combustivel.Buscar,
  View.Tanque.Buscar,
  View.Bomba.Buscar,
  View.Abastecimento.Buscar,
  View.Abastecimento.Cadastrar,
  View.Relatorio,
  Utils;

procedure TViewPrincipal.FormCreate(Sender: TObject);
var
  bancoConectado: string;
begin
  ReportMemoryLeaksOnShutdown := True;
  bancoConectado := '';

  try
    TUtils.SetConnection(ConnectionPosto, bancoConectado);
    LabelStatus.Caption := 'Data: ' + FormatDateTime('dd/mm/yyyy',Date) + ', Conectado a '+bancoConectado;
    LabelStatus.Font.Color := clGreen;
  except on E: Exception do
    begin
      LabelStatus.Caption := 'Desconectado';
      LabelStatus.Font.Color := clRed;
      Exception.Create(e.Message);
      Application.Terminate();
    end;
  end;
end;

procedure TViewPrincipal.pnTelaInicialResize(Sender: TObject);
begin
  // Centralizando o TPanel
  pnLogo.Left := (pnTelaInicial.Width - pnLogo.Width) div 2;
  pnLogo.Top := (pnTelaInicial.Height - pnLogo.Height) div 2;
end;

procedure TViewPrincipal.Combustivel1Click(Sender: TObject);
begin
  ViewCombustivelBuscar := TViewCombustivelBuscar.Create(nil);
  try
    ViewCombustivelBuscar.ShowModal;
  finally
    FreeAndNil(ViewCombustivelBuscar);
  end;
end;

procedure TViewPrincipal.Tanque1Click(Sender: TObject);
begin
  ViewTanqueBuscar := TViewTanqueBuscar.Create(nil);
  try
    ViewTanqueBuscar.ShowModal;
  finally
    FreeAndNil(ViewTanqueBuscar);
  end;
end;

procedure TViewPrincipal.Bomba1Click(Sender: TObject);
begin
  ViewBombaBuscar := TViewBombaBuscar.Create(nil);
  try
    ViewBombaBuscar.ShowModal;
  finally
    FreeAndNil(ViewBombaBuscar);
  end;
end;

procedure TViewPrincipal.Abastecimento1Click(Sender: TObject);
begin
  ViewAbastecimentoCadastrar := TViewAbastecimentoCadastrar.Create(nil);
  try
    ViewAbastecimentoCadastrar.Abastecendo := True;
    ViewAbastecimentoCadastrar.ShowModal;
  finally
    FreeAndNil(ViewAbastecimentoCadastrar);
  end;
end;

procedure TViewPrincipal.ConsultaAbastecimentos1Click(Sender: TObject);
begin
  ViewAbastecimentoBuscar := TViewAbastecimentoBuscar.Create(nil);
  try
    ViewAbastecimentoBuscar.ShowModal;
  finally
    FreeAndNil(ViewAbastecimentoBuscar);
  end;
end;

procedure TViewPrincipal.Relatriosporbomba1Click(Sender: TObject);
begin
  ViewRelatorio := TViewRelatorio.Create(nil);
  try
    ViewRelatorio.ShowModal;
  finally
    FreeAndNil(ViewRelatorio);
  end;
end;

end.

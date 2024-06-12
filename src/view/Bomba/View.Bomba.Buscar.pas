unit View.Bomba.Buscar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Heranca.Buscar, Data.DB, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TViewBombaBuscar = class(TViewHerancaBuscar)
    QListarBombas: TFDQuery;
    QListarBombasID: TIntegerField;
    QListarBombasDESCRICAO: TStringField;
    QListarBombasTANQUE: TStringField;
  private
  protected
    procedure BuscarDados; override;
    procedure ChamarTelaCadastrar(const AId: Integer = 0); override;
    procedure Excluir; override;
  public
    { Public declarations }
  end;

var
  ViewBombaBuscar: TViewBombaBuscar;

implementation

{$R *.dfm}

{ TViewBombaBuscar }

uses
  View.Principal,
  Controller.Bomba,
  View.Bomba.Cadastrar;

procedure TViewBombaBuscar.BuscarDados;
var
  ControllerBomba: TControllerBomba;
  LCampo: string;
begin

  ControllerBomba := TControllerBomba.Create;
  try
    LCampo := '';

    case rdGroupFiltros.ItemIndex of
     0: LCampo := 'ID';
     1: LCampo := 'DESCRICAO';
    end;

    DataSource1.DataSet.Close;
    QListarBombas := ControllerBomba.ListarBombas(LCampo, Trim(edtBuscar.Text));
    DataSource1.DataSet.Open;
  finally
    FreeAndNil(ControllerBomba);
  end;

  inherited;
end;

procedure TViewBombaBuscar.ChamarTelaCadastrar(const AId: Integer);
var
  ViewBombaCadastrar: TViewBombaCadastrar;
begin

  inherited;
  ViewBombaCadastrar := TViewBombaCadastrar.Create(nil);
  try
    ViewBombaCadastrar.IdRegistroAlterar := AId;
    if(ViewBombaCadastrar.ShowModal = mrOk)then
    begin
      inherited UltId := ViewBombaCadastrar.UltId;
      Self.BuscarDados;
    end;
  finally
    ViewBombaCadastrar.Free;
  end;
end;

procedure TViewBombaBuscar.Excluir;
var
  ControllerBomba: TControllerBomba;
  sErro: string;
begin

  inherited;
  ControllerBomba := TControllerBomba.Create;
  try

    if not ControllerBomba.Excluir(IdSelecionado,sErro) then
      raise Exception.Create(sErro)
    else
      Application.MessageBox('Regitro excluído com sucesso', 'Atenção', MB_OK +
        MB_ICONWARNING);

  finally
    FreeAndNil(ControllerBomba);
  end;
end;

end.

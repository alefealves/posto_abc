unit View.Tanque.Buscar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Heranca.Buscar, Data.DB, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TViewTanqueBuscar = class(TViewHerancaBuscar)
    QListarTanques: TFDQuery;
    QListarTanquesID: TIntegerField;
    QListarTanquesDESCRICAO: TStringField;
    QListarTanquesCOMBUSTIVEL: TStringField;
  private
  protected
    procedure BuscarDados; override;
    procedure ChamarTelaCadastrar(const AId: Integer = 0); override;
    procedure Excluir; override;

  public
    { Public declarations }
  end;

var
  ViewTanqueBuscar: TViewTanqueBuscar;

implementation

{$R *.dfm}

{ TViewTanqueBuscar }

uses
  View.Principal,
  Controller.Tanque,
  View.Tanque.Cadastrar;

procedure TViewTanqueBuscar.BuscarDados;
var
  ControllerTanque: TControllerTanque;
  LCampo: string;
begin

  ControllerTanque := TControllerTanque.Create;
  try
    LCampo := '';

    case rdGroupFiltros.ItemIndex of
     0: LCampo := 'ID';
     1: LCampo := 'DESCRICAO';
    end;

    DataSource1.DataSet.Close;
    QListarTanques := ControllerTanque.ListarTanques(LCampo, Trim(edtBuscar.Text));
    DataSource1.DataSet.Open;
  finally
    FreeAndNil(ControllerTanque);
  end;

  inherited;
end;

procedure TViewTanqueBuscar.ChamarTelaCadastrar(const AId: Integer);
var
  ViewTanqueCadastrar: TViewTanqueCadastrar;
begin
  inherited;
  ViewTanqueCadastrar := TViewTanqueCadastrar.Create(nil);
  try
    ViewTanqueCadastrar.IdRegistroAlterar := AId;
    if(ViewTanqueCadastrar.ShowModal = mrOk)then
    begin
      inherited UltId := ViewTanqueCadastrar.UltId;
      Self.BuscarDados;
    end;
  finally
    ViewTanqueCadastrar.Free;
  end;
end;

procedure TViewTanqueBuscar.Excluir;
var
  ControllerTanque: TControllerTanque;
  sErro: string;
begin

  inherited;
  ControllerTanque := TControllerTanque.Create;
  try

    if not ControllerTanque.Excluir(IdSelecionado,sErro) then
      raise Exception.Create(sErro)
    else
      Application.MessageBox('Regitro excluído com sucesso', 'Atenção', MB_OK +
        MB_ICONWARNING);

  finally
    FreeAndNil(ControllerTanque);
  end;
end;

end.

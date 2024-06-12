unit Controller.Bomba;

interface

uses
  System.SysUtils,
  Bomba,
  DAO.Bomba,
  Tanque,
  DAO.Tanque,
  Firedac.Comp.Client;

type
  TControllerBomba = class
  private
  public
    constructor Create;
    destructor Destroy; override;
    function ListarBombas(const LCampo: string; const LStrBuscar: string): TFDQuery;
    procedure CarregarBomba(Bomba: TBomba; AIdBomba: integer);
    function Salvar(Bomba: TBomba; var sErro: string): Boolean;
    function Excluir(AIdBomba: integer; out sErro: string): Boolean;
    function LookTanque(oTanque: TTanque; AIdTanque: integer; var sErro: string): Boolean;
  end;

implementation

{ TControllerBomba }
var
  DAOBomba: TDAOBomba;
  DAOTanque: TDAOTanque;

procedure TControllerBomba.CarregarBomba(Bomba: TBomba; AIdBomba: integer);
begin
  DAOBomba.CarregarBomba(Bomba, AIdBomba);
end;

function TControllerBomba.Excluir(AIdBomba: integer; out sErro: string): Boolean;
begin
  result := DAOBomba.Excluir(AIdBomba, sErro);
end;

function TControllerBomba.ListarBombas(const LCampo, LStrBuscar: string): TFDQuery;
begin
  result := DAOBomba.ListarBombas(LCampo,LStrBuscar);
end;

function TControllerBomba.Salvar(Bomba: TBomba; var sErro: string): Boolean;
begin
  result := DAOBomba.Salvar(Bomba, sErro);
end;

function TControllerBomba.LookTanque(oTanque: TTanque; AIdTanque: integer; var sErro: string): Boolean;
begin
  result := DAOTanque.LookTanque(oTanque, AIdTanque, sErro);
end;

constructor TControllerBomba.Create;
begin
  if (DAOBomba = nil) then
    DAOBomba := TDAOBomba.Create;

  if (DAOTanque = nil) then
    DAOTanque := TDAOTanque.Create;
end;

destructor TControllerBomba.Destroy;
begin
  FreeAndNil(DAOBomba);
  FreeAndNil(DAOTanque);
  inherited;
end;

end.

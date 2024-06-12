unit Controller.Tanque;

interface

uses
  System.SysUtils,
  Tanque,
  DAO.Tanque,
  Combustivel,
  DAO.Combustivel,
  Firedac.Comp.Client;

type
  TControllerTanque = class
  private
  public
    constructor Create;
    destructor Destroy; override;
    function ListarTanques(const LCampo: string; const LStrBuscar: string): TFDQuery;
    procedure CarregarTanque(Tanque: TTanque; AIdTanque: integer);
    function Salvar(Tanque: TTanque; var sErro: string): Boolean;
    function Excluir(AIdTanque: integer; out sErro: string): Boolean;
    function LookCombustivel(oCombustivel: TCombustivel; AIdCombustivel: integer; var sErro: string): Boolean;
  end;

implementation

{ TControllerTanque }

var
  DAOTanque: TDAOTanque;
  DAOCombustivel: TDAOCombustivel;

procedure TControllerTanque.CarregarTanque(Tanque: TTanque; AIdTanque: integer);
begin
  DAOTanque.CarregarTanque(Tanque, AIdTanque);
end;

function TControllerTanque.Excluir(AIdTanque: integer; out sErro: string): Boolean;
begin
  result := DAOTanque.Excluir(AIdTanque, sErro);
end;

function TControllerTanque.ListarTanques(const LCampo, LStrBuscar: string): TFDQuery;
begin
  result := DAOTanque.ListarTanques(LCampo, LStrBuscar);
end;

function TControllerTanque.Salvar(Tanque: TTanque; var sErro: string): Boolean;
begin
  result := DAOTanque.Salvar(Tanque, sErro);
end;

function TControllerTanque.LookCombustivel(oCombustivel: TCombustivel; AIdCombustivel: integer; var sErro: string): Boolean;
begin
  result := DAOCombustivel.LookCombustivel(oCombustivel, AIdCombustivel, sErro);
end;

constructor TControllerTanque.Create;
begin
  if (DAOTanque = nil) then
    DAOTanque := TDAOTanque.Create;

  if (DAOCombustivel = nil) then
    DAOCombustivel := TDAOCombustivel.Create;
end;

destructor TControllerTanque.Destroy;
begin
  FreeAndNil(DAOTanque);
  FreeAndNil(DAOCombustivel);
  inherited;
end;

end.

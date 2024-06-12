unit Controller.Combustivel;

interface

uses
  System.SysUtils,
  Combustivel,
  DAO.Combustivel,
  Firedac.Comp.Client;

type
  TControllerCombustivel = class
  private
  public
    constructor Create;
    destructor Destroy; override;
    function ListarCombustiveis(const LCampo: string; const LStrBuscar: string): TFDQuery;
    procedure CarregarCombustivel(Combustivel: TCombustivel; AIdCombustivel: integer);
    function Salvar(Combustivel: TCombustivel; var sErro: string): Boolean;
    function Excluir(AIdCombustivel: integer; out sErro: string): Boolean;
  end;

implementation

{ TControllerCombustivel }

var
  DAOCombustivel: TDAOCombustivel;

procedure TControllerCombustivel.CarregarCombustivel(Combustivel: TCombustivel; AIdCombustivel: integer);
begin
  DAOCombustivel.CarregarCombustivel(Combustivel, AIdCombustivel);
end;

function TControllerCombustivel.Excluir(AIdCombustivel: integer; out sErro: string): Boolean;
begin
  result := DAOCombustivel.Excluir(AIdCombustivel, sErro);
end;

function TControllerCombustivel.ListarCombustiveis(const LCampo: string; const LStrBuscar: string): TFDQuery;
begin
  result := DAOCombustivel.ListarCombustiveis(LCampo, LStrBuscar);
end;

function TControllerCombustivel.Salvar(Combustivel: TCombustivel; var sErro: string): Boolean;
begin
  result := DAOCombustivel.Salvar(Combustivel, sErro);
end;

constructor TControllerCombustivel.Create;

begin
  if (DAOCombustivel = nil) then
    DAOCombustivel := TDAOCombustivel.Create;
end;

destructor TControllerCombustivel.Destroy;
begin
  FreeAndNil(DAOCombustivel);
  inherited;
end;

end.

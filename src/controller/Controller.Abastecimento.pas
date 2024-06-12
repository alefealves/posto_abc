unit Controller.Abastecimento;

interface

uses
  System.SysUtils,
  Bomba,
  BombaConfig,
  DAO.Bomba,
  Abastecimento,
  DAO.Abastecimento,
  Firedac.Comp.Client;

type
  TControllerAbastecimento = class
  private
  public
    constructor Create;
    destructor Destroy; override;
    function ListarAbastecimentos(const LCampo: string; const LStrBuscar: string): TFDQuery;
    procedure CarregarAbastecimento(Abastecimento: TAbastecimento; AIdAbastecimento: integer);
    function Salvar(Abastecimento: TAbastecimento; var sErro: string): Boolean;
    function Excluir(AIdAbastecimento: integer; out sErro: string): Boolean;
    function LookBomba(oBomba: TBombaConfig; AIdBomba: integer; var sErro: string): Boolean;
  end;

implementation

{ TControllerAbastecimento }

var
  DAOAbastecimento: TDAOAbastecimento;
  DAOBomba: TDAOBomba;

procedure TControllerAbastecimento.CarregarAbastecimento(Abastecimento: TAbastecimento; AIdAbastecimento: integer);
begin
  DAOAbastecimento.CarregarAbastecimento(Abastecimento, AIdAbastecimento);
end;

function TControllerAbastecimento.Excluir(AIdAbastecimento: integer; out sErro: string): Boolean;
begin
  result := DAOAbastecimento.Excluir(AIdAbastecimento, sErro);
end;

function TControllerAbastecimento.ListarAbastecimentos(const LCampo, LStrBuscar: string): TFDQuery;
begin
  result := DAOAbastecimento.ListarAbastecimentos(LCampo,LStrBuscar);
end;

function TControllerAbastecimento.Salvar(Abastecimento: TAbastecimento; var sErro: string): Boolean;
begin
  result := DAOAbastecimento.Salvar(Abastecimento, sErro);
end;

function TControllerAbastecimento.LookBomba(oBomba: TBombaConfig; AIdBomba: integer; var sErro: string): Boolean;
begin
  result := DAOBomba.LookBomba(oBomba, AIdBomba, sErro);
end;

constructor TControllerAbastecimento.Create;
begin

  if (DAOAbastecimento = nil) then
    DAOAbastecimento := TDAOAbastecimento.Create;

  if (DAOBomba = nil) then
    DAOBomba := TDAOBomba.Create;
end;

destructor TControllerAbastecimento.Destroy;
begin
  FreeAndNil(DAOAbastecimento);
  FreeAndNil(DAOBomba);
  inherited;
end;

end.

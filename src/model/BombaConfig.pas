unit BombaConfig;

interface

type
  TBombaConfig = class

  private

    FId: Integer;
    FDescricao: string;
    FTanque: string;
    FCombustivel: string;
    FValor: currency;
    FImposto: currency;

    procedure SetId(const Value: Integer);
    procedure SetDescricao(const Value: String);
    procedure SetTanque(const Value: String);
    procedure SetCombustivel(const Value: String);
    procedure SetValor(const Value: currency);
    procedure SetImposto(const Value: currency);

  public

    property Id: Integer read FId write SetId;
    property Descricao: String read FDescricao write SetDescricao;
    property Tanque: String read FTanque write SetTanque;
    property Combustivel: String read FCombustivel write SetCombustivel;
    property Valor: Currency read FValor write SetValor;
    property Imposto: Currency read FImposto write SetImposto;

  end;

implementation

{ TBombaConfig }

procedure TBombaConfig.SetCombustivel(const Value: String);
begin
  FCombustivel := Value;
end;

procedure TBombaConfig.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TBombaConfig.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TBombaConfig.SetImposto(const Value: currency);
begin
  FImposto := Value;
end;

procedure TBombaConfig.SetTanque(const Value: String);
begin
  FTanque := Value;
end;

procedure TBombaConfig.SetValor(const Value: currency);
begin
 FValor := Value;
end;

end.

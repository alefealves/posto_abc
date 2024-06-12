unit Combustivel;

interface

type
  TCombustivel = class

  private

    FId: Integer;
    FDescricao: string;
    FValor: Currency;
    FImposto: Currency;

    procedure SetId(const Value: Integer);
    procedure SetDescricao(const Value: String);
    procedure SetValor(const Value: Currency);
    procedure SetImposto(const Value: Currency);

  public

    property Id: Integer read FId write SetId;
    property Descricao: String read FDescricao write SetDescricao;
    property Valor: Currency read FValor write SetValor;
    property Imposto: Currency read FImposto write SetImposto;

  end;

implementation

{ TCombustivel }

procedure TCombustivel.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TCombustivel.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TCombustivel.SetImposto(const Value: Currency);
begin
  FImposto := Value;
end;

procedure TCombustivel.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.

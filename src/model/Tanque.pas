unit Tanque;

interface

type
  TTanque = class

  private

    FId: Integer;
    FId_Combustivel: Integer;
    FDescricao: string;

    procedure SetId(const Value: Integer);
    procedure SetId_Combustivel(const Value: Integer);
    procedure SetDescricao(const Value: String);

  public

    property Id: Integer read FId write SetId;
    property Id_Combustivel: Integer read FId_Combustivel write FId_Combustivel;
    property Descricao: String read FDescricao write SetDescricao;

  end;

implementation

{ TTanque }

procedure TTanque.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TTanque.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TTanque.SetId_Combustivel(const Value: Integer);
begin
  FId_Combustivel := Value;
end;

end.
